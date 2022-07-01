#include "ruby.h"

static VALUE rb_ary_bsearch_last_index(VALUE ary);


/*
 *  call-seq:
 *    array.bsearch_last {|element| ... } -> object
 *    array.bsearch_last -> new_enumerator
 *
 *  Returns an element from +self+ selected by a binary search.
 *
 *  See {Binary Searching}[rdoc-ref:bsearch.rdoc].
 */

static VALUE
rb_ary_bsearch_last(VALUE ary)
{
	VALUE index_result = rb_ary_bsearch_last_index(ary);

	if (FIXNUM_P(index_result)) {
		return rb_ary_entry(ary, FIX2LONG(index_result));
	}
	return index_result;
}

/*
 *  call-seq:
 *    array.bsearch_last_index {|element| ... } -> integer or nil
 *    array.bsearch_last_index -> new_enumerator
 *
 *  Searches +self+ as described at method #bsearch_last,
 *  but returns the _index_ of the found element instead of the element itself.
 */

static VALUE
rb_ary_bsearch_last_index(VALUE ary)
{
	long low = 0, high = RARRAY_LEN(ary)-1, mid;
	int greater = 0, satisfied = 0;
	VALUE v, val;

	RETURN_ENUMERATOR(ary, 0, 0);
	while (low < high) {
		mid = ((high + low) / 2) + 1;
		val = rb_ary_entry(ary, mid);
		v = rb_yield(val);
		if (FIXNUM_P(v)) {
			if (v == INT2FIX(0)) return INT2FIX(mid);
			greater = (SIGNED_VALUE)v > 0; /* Fixnum preserves its sign-bit */
		}
		else if (v == Qtrue) {
			satisfied = 1;
			greater = 1;
		}
		else if (!RTEST(v)) {
			greater = 0;
		}
		else if (rb_obj_is_kind_of(v, rb_cNumeric)) {
			const VALUE zero = INT2FIX(0);
			switch (rb_cmpint(rb_funcallv(v, rb_intern("<=>"), 1, &zero), v, zero)) {
				case 0: return INT2FIX(mid);
				case 1: greater = 0; break;
				case -1: greater = 1;
			}
		}
		else {
			rb_raise(rb_eTypeError, "wrong argument type %"PRIsVALUE
				" (must be numeric, true, false or nil)",
				rb_obj_class(v));
		}
		if (greater) {
			low = mid;
		}
		else {
			high = mid - 1;
		}
	}
	if (!satisfied) return Qnil;
	return INT2FIX(high);
}

void Init_bsearch_last(void) {
	rb_cArray  = rb_define_class("Array", rb_cObject);
	rb_define_method(rb_cArray, "_bsearch_last", rb_ary_bsearch_last, 0);
	rb_define_method(rb_cArray, "_bsearch_last_index", rb_ary_bsearch_last_index, 0);
}

