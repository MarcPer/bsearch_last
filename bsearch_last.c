#include "ruby.h"

static VALUE rb_ary_bsearch_last_index(VALUE ary, VALUE target) {
	long min = 0, max = RARRAY_LEN(ary)-1, mid;
	long v, tgt;
	VALUE val;

	Check_Type(target, T_FIXNUM);

	tgt = FIX2LONG(target);
	while (min < max) {
		mid = (max+min)/2+1;
		val = rb_ary_entry(ary, mid);
		Check_Type(val, T_FIXNUM);

		v = FIX2LONG(val);
		if (v <= tgt) {
			min = mid;
		} else {
			max = mid-1;
		}
	}

	val = rb_ary_entry(ary, max);
	v = FIX2LONG(val);
	if (v==tgt) {
		return INT2FIX(max);
	} else {
		return Qnil;

	}
}

void Init_bsearch_last(void) {
	rb_cArray  = rb_define_class("Array", rb_cObject);
	rb_define_method(rb_cArray, "_bsearch_last_index", rb_ary_bsearch_last_index, 1);
}

