class CVerboseObj {
	virtual void foo() {}
};
static_assert(sizeof(CVerboseObj) == 0x4, "CVerboseObj has wrong size");