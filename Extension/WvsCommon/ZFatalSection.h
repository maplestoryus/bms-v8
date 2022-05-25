template <class T> class ZFatalSectionData {
public:
	T * _m_pTIB;
	int _m_nRef;
};

template <class T> 
class ZFatalSection : public ZFatalSectionData<T> {
	
};

static_assert(sizeof(ZFatalSectionData<void*>) == 0x8, "ZFatalSectionData has wrong size");
static_assert(sizeof(ZFatalSection<void*>) == 0x08, "ZFatalSection has wrong size");