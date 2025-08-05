// Lean compiler output
// Module: Modal.Logic
// Imports: Init
#include <lean/lean.h>
#if defined(__clang__)
#pragma clang diagnostic ignored "-Wunused-parameter"
#pragma clang diagnostic ignored "-Wunused-label"
#elif defined(__GNUC__) && !defined(__CLANG__)
#pragma GCC diagnostic ignored "-Wunused-parameter"
#pragma GCC diagnostic ignored "-Wunused-label"
#pragma GCC diagnostic ignored "-Wunused-but-set-variable"
#endif
#ifdef __cplusplus
extern "C" {
#endif
static lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__19;
lean_object* l_String_quote(lean_object*);
LEAN_EXPORT lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____boxed(lean_object*, lean_object*);
static lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__23;
static lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__11;
uint8_t lean_string_dec_eq(lean_object*, lean_object*);
static lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__15;
static lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__4;
static lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__20;
static lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__13;
LEAN_EXPORT uint8_t l___private_Modal_Logic_0__Modal_Logic_beqFormula____x40_Modal_Logic___hyg_567_(lean_object*, lean_object*);
lean_object* lean_nat_to_int(lean_object*);
static lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__14;
LEAN_EXPORT lean_object* l_Modal_Logic_instReprFormula;
static lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__2;
static lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__12;
static lean_object* l_Modal_Logic_instReprFormula___closed__1;
static lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__17;
LEAN_EXPORT lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130_(lean_object*, lean_object*);
static lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__26;
static lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__24;
static lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__8;
static lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__5;
static lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__18;
static lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__6;
static lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__25;
static lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__22;
LEAN_EXPORT lean_object* l_Modal_Logic_instBEqFormula;
static lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__21;
static lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__9;
static lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__1;
lean_object* l_Repr_addAppParen(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_Modal_Logic_0__Modal_Logic_beqFormula____x40_Modal_Logic___hyg_567____boxed(lean_object*, lean_object*);
static lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__3;
static lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__7;
static lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__16;
static lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__10;
static lean_object* l_Modal_Logic_instBEqFormula___closed__1;
uint8_t lean_nat_dec_le(lean_object*, lean_object*);
static lean_object* _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__1() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string_unchecked("Modal.Logic.Formula.Var", 23, 23);
return x_1;
}
}
static lean_object* _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__2() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__1;
x_2 = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(x_2, 0, x_1);
return x_2;
}
}
static lean_object* _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__3() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; 
x_1 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__2;
x_2 = lean_box(1);
x_3 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_3, 0, x_1);
lean_ctor_set(x_3, 1, x_2);
return x_3;
}
}
static lean_object* _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__4() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = lean_unsigned_to_nat(2u);
x_2 = lean_nat_to_int(x_1);
return x_2;
}
}
static lean_object* _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__5() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = lean_unsigned_to_nat(1u);
x_2 = lean_nat_to_int(x_1);
return x_2;
}
}
static lean_object* _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__6() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string_unchecked("Modal.Logic.Formula.Not", 23, 23);
return x_1;
}
}
static lean_object* _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__7() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__6;
x_2 = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(x_2, 0, x_1);
return x_2;
}
}
static lean_object* _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__8() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; 
x_1 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__7;
x_2 = lean_box(1);
x_3 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_3, 0, x_1);
lean_ctor_set(x_3, 1, x_2);
return x_3;
}
}
static lean_object* _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__9() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string_unchecked("Modal.Logic.Formula.Box", 23, 23);
return x_1;
}
}
static lean_object* _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__10() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__9;
x_2 = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(x_2, 0, x_1);
return x_2;
}
}
static lean_object* _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__11() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; 
x_1 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__10;
x_2 = lean_box(1);
x_3 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_3, 0, x_1);
lean_ctor_set(x_3, 1, x_2);
return x_3;
}
}
static lean_object* _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__12() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string_unchecked("Modal.Logic.Formula.Diamond", 27, 27);
return x_1;
}
}
static lean_object* _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__13() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__12;
x_2 = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(x_2, 0, x_1);
return x_2;
}
}
static lean_object* _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__14() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; 
x_1 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__13;
x_2 = lean_box(1);
x_3 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_3, 0, x_1);
lean_ctor_set(x_3, 1, x_2);
return x_3;
}
}
static lean_object* _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__15() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string_unchecked("Modal.Logic.Formula.And", 23, 23);
return x_1;
}
}
static lean_object* _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__16() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__15;
x_2 = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(x_2, 0, x_1);
return x_2;
}
}
static lean_object* _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__17() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; 
x_1 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__16;
x_2 = lean_box(1);
x_3 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_3, 0, x_1);
lean_ctor_set(x_3, 1, x_2);
return x_3;
}
}
static lean_object* _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__18() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string_unchecked("Modal.Logic.Formula.Or", 22, 22);
return x_1;
}
}
static lean_object* _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__19() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__18;
x_2 = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(x_2, 0, x_1);
return x_2;
}
}
static lean_object* _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__20() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; 
x_1 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__19;
x_2 = lean_box(1);
x_3 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_3, 0, x_1);
lean_ctor_set(x_3, 1, x_2);
return x_3;
}
}
static lean_object* _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__21() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string_unchecked("Modal.Logic.Formula.Implies", 27, 27);
return x_1;
}
}
static lean_object* _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__22() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__21;
x_2 = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(x_2, 0, x_1);
return x_2;
}
}
static lean_object* _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__23() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; 
x_1 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__22;
x_2 = lean_box(1);
x_3 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_3, 0, x_1);
lean_ctor_set(x_3, 1, x_2);
return x_3;
}
}
static lean_object* _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__24() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string_unchecked("Modal.Logic.Formula.Iff", 23, 23);
return x_1;
}
}
static lean_object* _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__25() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__24;
x_2 = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(x_2, 0, x_1);
return x_2;
}
}
static lean_object* _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__26() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; 
x_1 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__25;
x_2 = lean_box(1);
x_3 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_3, 0, x_1);
lean_ctor_set(x_3, 1, x_2);
return x_3;
}
}
LEAN_EXPORT lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130_(lean_object* x_1, lean_object* x_2) {
_start:
{
switch (lean_obj_tag(x_1)) {
case 0:
{
uint8_t x_3; 
x_3 = !lean_is_exclusive(x_1);
if (x_3 == 0)
{
lean_object* x_4; lean_object* x_5; uint8_t x_6; lean_object* x_7; lean_object* x_8; lean_object* x_9; 
x_4 = lean_ctor_get(x_1, 0);
x_5 = lean_unsigned_to_nat(1024u);
x_6 = lean_nat_dec_le(x_5, x_2);
x_7 = l_String_quote(x_4);
lean_dec(x_4);
lean_ctor_set_tag(x_1, 3);
lean_ctor_set(x_1, 0, x_7);
x_8 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__3;
x_9 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_9, 0, x_8);
lean_ctor_set(x_9, 1, x_1);
if (x_6 == 0)
{
lean_object* x_10; lean_object* x_11; uint8_t x_12; lean_object* x_13; lean_object* x_14; 
x_10 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__4;
x_11 = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(x_11, 0, x_10);
lean_ctor_set(x_11, 1, x_9);
x_12 = 0;
x_13 = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(x_13, 0, x_11);
lean_ctor_set_uint8(x_13, sizeof(void*)*1, x_12);
x_14 = l_Repr_addAppParen(x_13, x_2);
return x_14;
}
else
{
lean_object* x_15; lean_object* x_16; uint8_t x_17; lean_object* x_18; lean_object* x_19; 
x_15 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__5;
x_16 = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(x_16, 0, x_15);
lean_ctor_set(x_16, 1, x_9);
x_17 = 0;
x_18 = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(x_18, 0, x_16);
lean_ctor_set_uint8(x_18, sizeof(void*)*1, x_17);
x_19 = l_Repr_addAppParen(x_18, x_2);
return x_19;
}
}
else
{
lean_object* x_20; lean_object* x_21; uint8_t x_22; lean_object* x_23; lean_object* x_24; lean_object* x_25; lean_object* x_26; 
x_20 = lean_ctor_get(x_1, 0);
lean_inc(x_20);
lean_dec(x_1);
x_21 = lean_unsigned_to_nat(1024u);
x_22 = lean_nat_dec_le(x_21, x_2);
x_23 = l_String_quote(x_20);
lean_dec(x_20);
x_24 = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(x_24, 0, x_23);
x_25 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__3;
x_26 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_26, 0, x_25);
lean_ctor_set(x_26, 1, x_24);
if (x_22 == 0)
{
lean_object* x_27; lean_object* x_28; uint8_t x_29; lean_object* x_30; lean_object* x_31; 
x_27 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__4;
x_28 = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(x_28, 0, x_27);
lean_ctor_set(x_28, 1, x_26);
x_29 = 0;
x_30 = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(x_30, 0, x_28);
lean_ctor_set_uint8(x_30, sizeof(void*)*1, x_29);
x_31 = l_Repr_addAppParen(x_30, x_2);
return x_31;
}
else
{
lean_object* x_32; lean_object* x_33; uint8_t x_34; lean_object* x_35; lean_object* x_36; 
x_32 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__5;
x_33 = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(x_33, 0, x_32);
lean_ctor_set(x_33, 1, x_26);
x_34 = 0;
x_35 = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(x_35, 0, x_33);
lean_ctor_set_uint8(x_35, sizeof(void*)*1, x_34);
x_36 = l_Repr_addAppParen(x_35, x_2);
return x_36;
}
}
}
case 1:
{
lean_object* x_37; lean_object* x_38; uint8_t x_39; lean_object* x_40; lean_object* x_41; lean_object* x_42; 
x_37 = lean_ctor_get(x_1, 0);
lean_inc(x_37);
lean_dec(x_1);
x_38 = lean_unsigned_to_nat(1024u);
x_39 = lean_nat_dec_le(x_38, x_2);
x_40 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130_(x_37, x_38);
x_41 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__8;
x_42 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_42, 0, x_41);
lean_ctor_set(x_42, 1, x_40);
if (x_39 == 0)
{
lean_object* x_43; lean_object* x_44; uint8_t x_45; lean_object* x_46; lean_object* x_47; 
x_43 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__4;
x_44 = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(x_44, 0, x_43);
lean_ctor_set(x_44, 1, x_42);
x_45 = 0;
x_46 = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(x_46, 0, x_44);
lean_ctor_set_uint8(x_46, sizeof(void*)*1, x_45);
x_47 = l_Repr_addAppParen(x_46, x_2);
return x_47;
}
else
{
lean_object* x_48; lean_object* x_49; uint8_t x_50; lean_object* x_51; lean_object* x_52; 
x_48 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__5;
x_49 = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(x_49, 0, x_48);
lean_ctor_set(x_49, 1, x_42);
x_50 = 0;
x_51 = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(x_51, 0, x_49);
lean_ctor_set_uint8(x_51, sizeof(void*)*1, x_50);
x_52 = l_Repr_addAppParen(x_51, x_2);
return x_52;
}
}
case 2:
{
lean_object* x_53; lean_object* x_54; uint8_t x_55; lean_object* x_56; lean_object* x_57; lean_object* x_58; 
x_53 = lean_ctor_get(x_1, 0);
lean_inc(x_53);
lean_dec(x_1);
x_54 = lean_unsigned_to_nat(1024u);
x_55 = lean_nat_dec_le(x_54, x_2);
x_56 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130_(x_53, x_54);
x_57 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__11;
x_58 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_58, 0, x_57);
lean_ctor_set(x_58, 1, x_56);
if (x_55 == 0)
{
lean_object* x_59; lean_object* x_60; uint8_t x_61; lean_object* x_62; lean_object* x_63; 
x_59 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__4;
x_60 = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(x_60, 0, x_59);
lean_ctor_set(x_60, 1, x_58);
x_61 = 0;
x_62 = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(x_62, 0, x_60);
lean_ctor_set_uint8(x_62, sizeof(void*)*1, x_61);
x_63 = l_Repr_addAppParen(x_62, x_2);
return x_63;
}
else
{
lean_object* x_64; lean_object* x_65; uint8_t x_66; lean_object* x_67; lean_object* x_68; 
x_64 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__5;
x_65 = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(x_65, 0, x_64);
lean_ctor_set(x_65, 1, x_58);
x_66 = 0;
x_67 = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(x_67, 0, x_65);
lean_ctor_set_uint8(x_67, sizeof(void*)*1, x_66);
x_68 = l_Repr_addAppParen(x_67, x_2);
return x_68;
}
}
case 3:
{
lean_object* x_69; lean_object* x_70; uint8_t x_71; lean_object* x_72; lean_object* x_73; lean_object* x_74; 
x_69 = lean_ctor_get(x_1, 0);
lean_inc(x_69);
lean_dec(x_1);
x_70 = lean_unsigned_to_nat(1024u);
x_71 = lean_nat_dec_le(x_70, x_2);
x_72 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130_(x_69, x_70);
x_73 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__14;
x_74 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_74, 0, x_73);
lean_ctor_set(x_74, 1, x_72);
if (x_71 == 0)
{
lean_object* x_75; lean_object* x_76; uint8_t x_77; lean_object* x_78; lean_object* x_79; 
x_75 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__4;
x_76 = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(x_76, 0, x_75);
lean_ctor_set(x_76, 1, x_74);
x_77 = 0;
x_78 = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(x_78, 0, x_76);
lean_ctor_set_uint8(x_78, sizeof(void*)*1, x_77);
x_79 = l_Repr_addAppParen(x_78, x_2);
return x_79;
}
else
{
lean_object* x_80; lean_object* x_81; uint8_t x_82; lean_object* x_83; lean_object* x_84; 
x_80 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__5;
x_81 = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(x_81, 0, x_80);
lean_ctor_set(x_81, 1, x_74);
x_82 = 0;
x_83 = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(x_83, 0, x_81);
lean_ctor_set_uint8(x_83, sizeof(void*)*1, x_82);
x_84 = l_Repr_addAppParen(x_83, x_2);
return x_84;
}
}
case 4:
{
uint8_t x_85; 
x_85 = !lean_is_exclusive(x_1);
if (x_85 == 0)
{
lean_object* x_86; lean_object* x_87; lean_object* x_88; uint8_t x_89; lean_object* x_90; lean_object* x_91; lean_object* x_92; lean_object* x_93; lean_object* x_94; lean_object* x_95; 
x_86 = lean_ctor_get(x_1, 0);
x_87 = lean_ctor_get(x_1, 1);
x_88 = lean_unsigned_to_nat(1024u);
x_89 = lean_nat_dec_le(x_88, x_2);
x_90 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130_(x_86, x_88);
x_91 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__17;
lean_ctor_set_tag(x_1, 5);
lean_ctor_set(x_1, 1, x_90);
lean_ctor_set(x_1, 0, x_91);
x_92 = lean_box(1);
x_93 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_93, 0, x_1);
lean_ctor_set(x_93, 1, x_92);
x_94 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130_(x_87, x_88);
x_95 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_95, 0, x_93);
lean_ctor_set(x_95, 1, x_94);
if (x_89 == 0)
{
lean_object* x_96; lean_object* x_97; uint8_t x_98; lean_object* x_99; lean_object* x_100; 
x_96 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__4;
x_97 = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(x_97, 0, x_96);
lean_ctor_set(x_97, 1, x_95);
x_98 = 0;
x_99 = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(x_99, 0, x_97);
lean_ctor_set_uint8(x_99, sizeof(void*)*1, x_98);
x_100 = l_Repr_addAppParen(x_99, x_2);
return x_100;
}
else
{
lean_object* x_101; lean_object* x_102; uint8_t x_103; lean_object* x_104; lean_object* x_105; 
x_101 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__5;
x_102 = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(x_102, 0, x_101);
lean_ctor_set(x_102, 1, x_95);
x_103 = 0;
x_104 = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(x_104, 0, x_102);
lean_ctor_set_uint8(x_104, sizeof(void*)*1, x_103);
x_105 = l_Repr_addAppParen(x_104, x_2);
return x_105;
}
}
else
{
lean_object* x_106; lean_object* x_107; lean_object* x_108; uint8_t x_109; lean_object* x_110; lean_object* x_111; lean_object* x_112; lean_object* x_113; lean_object* x_114; lean_object* x_115; lean_object* x_116; 
x_106 = lean_ctor_get(x_1, 0);
x_107 = lean_ctor_get(x_1, 1);
lean_inc(x_107);
lean_inc(x_106);
lean_dec(x_1);
x_108 = lean_unsigned_to_nat(1024u);
x_109 = lean_nat_dec_le(x_108, x_2);
x_110 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130_(x_106, x_108);
x_111 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__17;
x_112 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_112, 0, x_111);
lean_ctor_set(x_112, 1, x_110);
x_113 = lean_box(1);
x_114 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_114, 0, x_112);
lean_ctor_set(x_114, 1, x_113);
x_115 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130_(x_107, x_108);
x_116 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_116, 0, x_114);
lean_ctor_set(x_116, 1, x_115);
if (x_109 == 0)
{
lean_object* x_117; lean_object* x_118; uint8_t x_119; lean_object* x_120; lean_object* x_121; 
x_117 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__4;
x_118 = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(x_118, 0, x_117);
lean_ctor_set(x_118, 1, x_116);
x_119 = 0;
x_120 = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(x_120, 0, x_118);
lean_ctor_set_uint8(x_120, sizeof(void*)*1, x_119);
x_121 = l_Repr_addAppParen(x_120, x_2);
return x_121;
}
else
{
lean_object* x_122; lean_object* x_123; uint8_t x_124; lean_object* x_125; lean_object* x_126; 
x_122 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__5;
x_123 = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(x_123, 0, x_122);
lean_ctor_set(x_123, 1, x_116);
x_124 = 0;
x_125 = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(x_125, 0, x_123);
lean_ctor_set_uint8(x_125, sizeof(void*)*1, x_124);
x_126 = l_Repr_addAppParen(x_125, x_2);
return x_126;
}
}
}
case 5:
{
uint8_t x_127; 
x_127 = !lean_is_exclusive(x_1);
if (x_127 == 0)
{
lean_object* x_128; lean_object* x_129; lean_object* x_130; uint8_t x_131; lean_object* x_132; lean_object* x_133; lean_object* x_134; lean_object* x_135; lean_object* x_136; lean_object* x_137; 
x_128 = lean_ctor_get(x_1, 0);
x_129 = lean_ctor_get(x_1, 1);
x_130 = lean_unsigned_to_nat(1024u);
x_131 = lean_nat_dec_le(x_130, x_2);
x_132 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130_(x_128, x_130);
x_133 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__20;
lean_ctor_set(x_1, 1, x_132);
lean_ctor_set(x_1, 0, x_133);
x_134 = lean_box(1);
x_135 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_135, 0, x_1);
lean_ctor_set(x_135, 1, x_134);
x_136 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130_(x_129, x_130);
x_137 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_137, 0, x_135);
lean_ctor_set(x_137, 1, x_136);
if (x_131 == 0)
{
lean_object* x_138; lean_object* x_139; uint8_t x_140; lean_object* x_141; lean_object* x_142; 
x_138 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__4;
x_139 = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(x_139, 0, x_138);
lean_ctor_set(x_139, 1, x_137);
x_140 = 0;
x_141 = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(x_141, 0, x_139);
lean_ctor_set_uint8(x_141, sizeof(void*)*1, x_140);
x_142 = l_Repr_addAppParen(x_141, x_2);
return x_142;
}
else
{
lean_object* x_143; lean_object* x_144; uint8_t x_145; lean_object* x_146; lean_object* x_147; 
x_143 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__5;
x_144 = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(x_144, 0, x_143);
lean_ctor_set(x_144, 1, x_137);
x_145 = 0;
x_146 = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(x_146, 0, x_144);
lean_ctor_set_uint8(x_146, sizeof(void*)*1, x_145);
x_147 = l_Repr_addAppParen(x_146, x_2);
return x_147;
}
}
else
{
lean_object* x_148; lean_object* x_149; lean_object* x_150; uint8_t x_151; lean_object* x_152; lean_object* x_153; lean_object* x_154; lean_object* x_155; lean_object* x_156; lean_object* x_157; lean_object* x_158; 
x_148 = lean_ctor_get(x_1, 0);
x_149 = lean_ctor_get(x_1, 1);
lean_inc(x_149);
lean_inc(x_148);
lean_dec(x_1);
x_150 = lean_unsigned_to_nat(1024u);
x_151 = lean_nat_dec_le(x_150, x_2);
x_152 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130_(x_148, x_150);
x_153 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__20;
x_154 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_154, 0, x_153);
lean_ctor_set(x_154, 1, x_152);
x_155 = lean_box(1);
x_156 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_156, 0, x_154);
lean_ctor_set(x_156, 1, x_155);
x_157 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130_(x_149, x_150);
x_158 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_158, 0, x_156);
lean_ctor_set(x_158, 1, x_157);
if (x_151 == 0)
{
lean_object* x_159; lean_object* x_160; uint8_t x_161; lean_object* x_162; lean_object* x_163; 
x_159 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__4;
x_160 = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(x_160, 0, x_159);
lean_ctor_set(x_160, 1, x_158);
x_161 = 0;
x_162 = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(x_162, 0, x_160);
lean_ctor_set_uint8(x_162, sizeof(void*)*1, x_161);
x_163 = l_Repr_addAppParen(x_162, x_2);
return x_163;
}
else
{
lean_object* x_164; lean_object* x_165; uint8_t x_166; lean_object* x_167; lean_object* x_168; 
x_164 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__5;
x_165 = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(x_165, 0, x_164);
lean_ctor_set(x_165, 1, x_158);
x_166 = 0;
x_167 = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(x_167, 0, x_165);
lean_ctor_set_uint8(x_167, sizeof(void*)*1, x_166);
x_168 = l_Repr_addAppParen(x_167, x_2);
return x_168;
}
}
}
case 6:
{
uint8_t x_169; 
x_169 = !lean_is_exclusive(x_1);
if (x_169 == 0)
{
lean_object* x_170; lean_object* x_171; lean_object* x_172; uint8_t x_173; lean_object* x_174; lean_object* x_175; lean_object* x_176; lean_object* x_177; lean_object* x_178; lean_object* x_179; 
x_170 = lean_ctor_get(x_1, 0);
x_171 = lean_ctor_get(x_1, 1);
x_172 = lean_unsigned_to_nat(1024u);
x_173 = lean_nat_dec_le(x_172, x_2);
x_174 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130_(x_170, x_172);
x_175 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__23;
lean_ctor_set_tag(x_1, 5);
lean_ctor_set(x_1, 1, x_174);
lean_ctor_set(x_1, 0, x_175);
x_176 = lean_box(1);
x_177 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_177, 0, x_1);
lean_ctor_set(x_177, 1, x_176);
x_178 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130_(x_171, x_172);
x_179 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_179, 0, x_177);
lean_ctor_set(x_179, 1, x_178);
if (x_173 == 0)
{
lean_object* x_180; lean_object* x_181; uint8_t x_182; lean_object* x_183; lean_object* x_184; 
x_180 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__4;
x_181 = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(x_181, 0, x_180);
lean_ctor_set(x_181, 1, x_179);
x_182 = 0;
x_183 = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(x_183, 0, x_181);
lean_ctor_set_uint8(x_183, sizeof(void*)*1, x_182);
x_184 = l_Repr_addAppParen(x_183, x_2);
return x_184;
}
else
{
lean_object* x_185; lean_object* x_186; uint8_t x_187; lean_object* x_188; lean_object* x_189; 
x_185 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__5;
x_186 = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(x_186, 0, x_185);
lean_ctor_set(x_186, 1, x_179);
x_187 = 0;
x_188 = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(x_188, 0, x_186);
lean_ctor_set_uint8(x_188, sizeof(void*)*1, x_187);
x_189 = l_Repr_addAppParen(x_188, x_2);
return x_189;
}
}
else
{
lean_object* x_190; lean_object* x_191; lean_object* x_192; uint8_t x_193; lean_object* x_194; lean_object* x_195; lean_object* x_196; lean_object* x_197; lean_object* x_198; lean_object* x_199; lean_object* x_200; 
x_190 = lean_ctor_get(x_1, 0);
x_191 = lean_ctor_get(x_1, 1);
lean_inc(x_191);
lean_inc(x_190);
lean_dec(x_1);
x_192 = lean_unsigned_to_nat(1024u);
x_193 = lean_nat_dec_le(x_192, x_2);
x_194 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130_(x_190, x_192);
x_195 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__23;
x_196 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_196, 0, x_195);
lean_ctor_set(x_196, 1, x_194);
x_197 = lean_box(1);
x_198 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_198, 0, x_196);
lean_ctor_set(x_198, 1, x_197);
x_199 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130_(x_191, x_192);
x_200 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_200, 0, x_198);
lean_ctor_set(x_200, 1, x_199);
if (x_193 == 0)
{
lean_object* x_201; lean_object* x_202; uint8_t x_203; lean_object* x_204; lean_object* x_205; 
x_201 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__4;
x_202 = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(x_202, 0, x_201);
lean_ctor_set(x_202, 1, x_200);
x_203 = 0;
x_204 = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(x_204, 0, x_202);
lean_ctor_set_uint8(x_204, sizeof(void*)*1, x_203);
x_205 = l_Repr_addAppParen(x_204, x_2);
return x_205;
}
else
{
lean_object* x_206; lean_object* x_207; uint8_t x_208; lean_object* x_209; lean_object* x_210; 
x_206 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__5;
x_207 = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(x_207, 0, x_206);
lean_ctor_set(x_207, 1, x_200);
x_208 = 0;
x_209 = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(x_209, 0, x_207);
lean_ctor_set_uint8(x_209, sizeof(void*)*1, x_208);
x_210 = l_Repr_addAppParen(x_209, x_2);
return x_210;
}
}
}
default: 
{
uint8_t x_211; 
x_211 = !lean_is_exclusive(x_1);
if (x_211 == 0)
{
lean_object* x_212; lean_object* x_213; lean_object* x_214; uint8_t x_215; lean_object* x_216; lean_object* x_217; lean_object* x_218; lean_object* x_219; lean_object* x_220; lean_object* x_221; 
x_212 = lean_ctor_get(x_1, 0);
x_213 = lean_ctor_get(x_1, 1);
x_214 = lean_unsigned_to_nat(1024u);
x_215 = lean_nat_dec_le(x_214, x_2);
x_216 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130_(x_212, x_214);
x_217 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__26;
lean_ctor_set_tag(x_1, 5);
lean_ctor_set(x_1, 1, x_216);
lean_ctor_set(x_1, 0, x_217);
x_218 = lean_box(1);
x_219 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_219, 0, x_1);
lean_ctor_set(x_219, 1, x_218);
x_220 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130_(x_213, x_214);
x_221 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_221, 0, x_219);
lean_ctor_set(x_221, 1, x_220);
if (x_215 == 0)
{
lean_object* x_222; lean_object* x_223; uint8_t x_224; lean_object* x_225; lean_object* x_226; 
x_222 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__4;
x_223 = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(x_223, 0, x_222);
lean_ctor_set(x_223, 1, x_221);
x_224 = 0;
x_225 = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(x_225, 0, x_223);
lean_ctor_set_uint8(x_225, sizeof(void*)*1, x_224);
x_226 = l_Repr_addAppParen(x_225, x_2);
return x_226;
}
else
{
lean_object* x_227; lean_object* x_228; uint8_t x_229; lean_object* x_230; lean_object* x_231; 
x_227 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__5;
x_228 = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(x_228, 0, x_227);
lean_ctor_set(x_228, 1, x_221);
x_229 = 0;
x_230 = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(x_230, 0, x_228);
lean_ctor_set_uint8(x_230, sizeof(void*)*1, x_229);
x_231 = l_Repr_addAppParen(x_230, x_2);
return x_231;
}
}
else
{
lean_object* x_232; lean_object* x_233; lean_object* x_234; uint8_t x_235; lean_object* x_236; lean_object* x_237; lean_object* x_238; lean_object* x_239; lean_object* x_240; lean_object* x_241; lean_object* x_242; 
x_232 = lean_ctor_get(x_1, 0);
x_233 = lean_ctor_get(x_1, 1);
lean_inc(x_233);
lean_inc(x_232);
lean_dec(x_1);
x_234 = lean_unsigned_to_nat(1024u);
x_235 = lean_nat_dec_le(x_234, x_2);
x_236 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130_(x_232, x_234);
x_237 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__26;
x_238 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_238, 0, x_237);
lean_ctor_set(x_238, 1, x_236);
x_239 = lean_box(1);
x_240 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_240, 0, x_238);
lean_ctor_set(x_240, 1, x_239);
x_241 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130_(x_233, x_234);
x_242 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_242, 0, x_240);
lean_ctor_set(x_242, 1, x_241);
if (x_235 == 0)
{
lean_object* x_243; lean_object* x_244; uint8_t x_245; lean_object* x_246; lean_object* x_247; 
x_243 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__4;
x_244 = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(x_244, 0, x_243);
lean_ctor_set(x_244, 1, x_242);
x_245 = 0;
x_246 = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(x_246, 0, x_244);
lean_ctor_set_uint8(x_246, sizeof(void*)*1, x_245);
x_247 = l_Repr_addAppParen(x_246, x_2);
return x_247;
}
else
{
lean_object* x_248; lean_object* x_249; uint8_t x_250; lean_object* x_251; lean_object* x_252; 
x_248 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__5;
x_249 = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(x_249, 0, x_248);
lean_ctor_set(x_249, 1, x_242);
x_250 = 0;
x_251 = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(x_251, 0, x_249);
lean_ctor_set_uint8(x_251, sizeof(void*)*1, x_250);
x_252 = l_Repr_addAppParen(x_251, x_2);
return x_252;
}
}
}
}
}
}
LEAN_EXPORT lean_object* l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____boxed(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130_(x_1, x_2);
lean_dec(x_2);
return x_3;
}
}
static lean_object* _init_l_Modal_Logic_instReprFormula___closed__1() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____boxed), 2, 0);
return x_1;
}
}
static lean_object* _init_l_Modal_Logic_instReprFormula() {
_start:
{
lean_object* x_1; 
x_1 = l_Modal_Logic_instReprFormula___closed__1;
return x_1;
}
}
LEAN_EXPORT uint8_t l___private_Modal_Logic_0__Modal_Logic_beqFormula____x40_Modal_Logic___hyg_567_(lean_object* x_1, lean_object* x_2) {
_start:
{
switch (lean_obj_tag(x_1)) {
case 0:
{
if (lean_obj_tag(x_2) == 0)
{
lean_object* x_3; lean_object* x_4; uint8_t x_5; 
x_3 = lean_ctor_get(x_1, 0);
x_4 = lean_ctor_get(x_2, 0);
x_5 = lean_string_dec_eq(x_3, x_4);
return x_5;
}
else
{
uint8_t x_6; 
x_6 = 0;
return x_6;
}
}
case 1:
{
if (lean_obj_tag(x_2) == 1)
{
lean_object* x_7; lean_object* x_8; 
x_7 = lean_ctor_get(x_1, 0);
x_8 = lean_ctor_get(x_2, 0);
x_1 = x_7;
x_2 = x_8;
goto _start;
}
else
{
uint8_t x_10; 
x_10 = 0;
return x_10;
}
}
case 2:
{
if (lean_obj_tag(x_2) == 2)
{
lean_object* x_11; lean_object* x_12; 
x_11 = lean_ctor_get(x_1, 0);
x_12 = lean_ctor_get(x_2, 0);
x_1 = x_11;
x_2 = x_12;
goto _start;
}
else
{
uint8_t x_14; 
x_14 = 0;
return x_14;
}
}
case 3:
{
if (lean_obj_tag(x_2) == 3)
{
lean_object* x_15; lean_object* x_16; 
x_15 = lean_ctor_get(x_1, 0);
x_16 = lean_ctor_get(x_2, 0);
x_1 = x_15;
x_2 = x_16;
goto _start;
}
else
{
uint8_t x_18; 
x_18 = 0;
return x_18;
}
}
case 4:
{
if (lean_obj_tag(x_2) == 4)
{
lean_object* x_19; lean_object* x_20; lean_object* x_21; lean_object* x_22; uint8_t x_23; 
x_19 = lean_ctor_get(x_1, 0);
x_20 = lean_ctor_get(x_1, 1);
x_21 = lean_ctor_get(x_2, 0);
x_22 = lean_ctor_get(x_2, 1);
x_23 = l___private_Modal_Logic_0__Modal_Logic_beqFormula____x40_Modal_Logic___hyg_567_(x_19, x_21);
if (x_23 == 0)
{
uint8_t x_24; 
x_24 = 0;
return x_24;
}
else
{
x_1 = x_20;
x_2 = x_22;
goto _start;
}
}
else
{
uint8_t x_26; 
x_26 = 0;
return x_26;
}
}
case 5:
{
if (lean_obj_tag(x_2) == 5)
{
lean_object* x_27; lean_object* x_28; lean_object* x_29; lean_object* x_30; uint8_t x_31; 
x_27 = lean_ctor_get(x_1, 0);
x_28 = lean_ctor_get(x_1, 1);
x_29 = lean_ctor_get(x_2, 0);
x_30 = lean_ctor_get(x_2, 1);
x_31 = l___private_Modal_Logic_0__Modal_Logic_beqFormula____x40_Modal_Logic___hyg_567_(x_27, x_29);
if (x_31 == 0)
{
uint8_t x_32; 
x_32 = 0;
return x_32;
}
else
{
x_1 = x_28;
x_2 = x_30;
goto _start;
}
}
else
{
uint8_t x_34; 
x_34 = 0;
return x_34;
}
}
case 6:
{
if (lean_obj_tag(x_2) == 6)
{
lean_object* x_35; lean_object* x_36; lean_object* x_37; lean_object* x_38; uint8_t x_39; 
x_35 = lean_ctor_get(x_1, 0);
x_36 = lean_ctor_get(x_1, 1);
x_37 = lean_ctor_get(x_2, 0);
x_38 = lean_ctor_get(x_2, 1);
x_39 = l___private_Modal_Logic_0__Modal_Logic_beqFormula____x40_Modal_Logic___hyg_567_(x_35, x_37);
if (x_39 == 0)
{
uint8_t x_40; 
x_40 = 0;
return x_40;
}
else
{
x_1 = x_36;
x_2 = x_38;
goto _start;
}
}
else
{
uint8_t x_42; 
x_42 = 0;
return x_42;
}
}
default: 
{
if (lean_obj_tag(x_2) == 7)
{
lean_object* x_43; lean_object* x_44; lean_object* x_45; lean_object* x_46; uint8_t x_47; 
x_43 = lean_ctor_get(x_1, 0);
x_44 = lean_ctor_get(x_1, 1);
x_45 = lean_ctor_get(x_2, 0);
x_46 = lean_ctor_get(x_2, 1);
x_47 = l___private_Modal_Logic_0__Modal_Logic_beqFormula____x40_Modal_Logic___hyg_567_(x_43, x_45);
if (x_47 == 0)
{
uint8_t x_48; 
x_48 = 0;
return x_48;
}
else
{
x_1 = x_44;
x_2 = x_46;
goto _start;
}
}
else
{
uint8_t x_50; 
x_50 = 0;
return x_50;
}
}
}
}
}
LEAN_EXPORT lean_object* l___private_Modal_Logic_0__Modal_Logic_beqFormula____x40_Modal_Logic___hyg_567____boxed(lean_object* x_1, lean_object* x_2) {
_start:
{
uint8_t x_3; lean_object* x_4; 
x_3 = l___private_Modal_Logic_0__Modal_Logic_beqFormula____x40_Modal_Logic___hyg_567_(x_1, x_2);
lean_dec(x_2);
lean_dec(x_1);
x_4 = lean_box(x_3);
return x_4;
}
}
static lean_object* _init_l_Modal_Logic_instBEqFormula___closed__1() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l___private_Modal_Logic_0__Modal_Logic_beqFormula____x40_Modal_Logic___hyg_567____boxed), 2, 0);
return x_1;
}
}
static lean_object* _init_l_Modal_Logic_instBEqFormula() {
_start:
{
lean_object* x_1; 
x_1 = l_Modal_Logic_instBEqFormula___closed__1;
return x_1;
}
}
lean_object* initialize_Init(uint8_t builtin, lean_object*);
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_Modal_Logic(uint8_t builtin, lean_object* w) {
lean_object * res;
if (_G_initialized) return lean_io_result_mk_ok(lean_box(0));
_G_initialized = true;
res = initialize_Init(builtin, lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__1 = _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__1();
lean_mark_persistent(l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__1);
l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__2 = _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__2();
lean_mark_persistent(l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__2);
l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__3 = _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__3();
lean_mark_persistent(l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__3);
l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__4 = _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__4();
lean_mark_persistent(l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__4);
l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__5 = _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__5();
lean_mark_persistent(l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__5);
l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__6 = _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__6();
lean_mark_persistent(l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__6);
l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__7 = _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__7();
lean_mark_persistent(l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__7);
l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__8 = _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__8();
lean_mark_persistent(l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__8);
l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__9 = _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__9();
lean_mark_persistent(l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__9);
l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__10 = _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__10();
lean_mark_persistent(l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__10);
l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__11 = _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__11();
lean_mark_persistent(l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__11);
l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__12 = _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__12();
lean_mark_persistent(l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__12);
l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__13 = _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__13();
lean_mark_persistent(l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__13);
l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__14 = _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__14();
lean_mark_persistent(l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__14);
l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__15 = _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__15();
lean_mark_persistent(l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__15);
l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__16 = _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__16();
lean_mark_persistent(l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__16);
l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__17 = _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__17();
lean_mark_persistent(l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__17);
l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__18 = _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__18();
lean_mark_persistent(l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__18);
l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__19 = _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__19();
lean_mark_persistent(l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__19);
l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__20 = _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__20();
lean_mark_persistent(l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__20);
l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__21 = _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__21();
lean_mark_persistent(l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__21);
l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__22 = _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__22();
lean_mark_persistent(l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__22);
l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__23 = _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__23();
lean_mark_persistent(l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__23);
l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__24 = _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__24();
lean_mark_persistent(l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__24);
l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__25 = _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__25();
lean_mark_persistent(l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__25);
l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__26 = _init_l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__26();
lean_mark_persistent(l___private_Modal_Logic_0__Modal_Logic_reprFormula____x40_Modal_Logic___hyg_130____closed__26);
l_Modal_Logic_instReprFormula___closed__1 = _init_l_Modal_Logic_instReprFormula___closed__1();
lean_mark_persistent(l_Modal_Logic_instReprFormula___closed__1);
l_Modal_Logic_instReprFormula = _init_l_Modal_Logic_instReprFormula();
lean_mark_persistent(l_Modal_Logic_instReprFormula);
l_Modal_Logic_instBEqFormula___closed__1 = _init_l_Modal_Logic_instBEqFormula___closed__1();
lean_mark_persistent(l_Modal_Logic_instBEqFormula___closed__1);
l_Modal_Logic_instBEqFormula = _init_l_Modal_Logic_instBEqFormula();
lean_mark_persistent(l_Modal_Logic_instBEqFormula);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
