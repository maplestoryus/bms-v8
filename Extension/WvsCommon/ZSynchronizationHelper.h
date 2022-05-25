template <class T>
struct ZSynchronizationHelper {
public:
	ZFatalSection<T> * m_pLock;

	explicit __inline ZSynchronizationHelper(T *lock) {
	
	}

	__inline ~ZSynchronizationHelper() {
		ZFatalSection<T> *v1 = this->m_pLock;
		bool v2 = this->m_pLock->_m_nRef == 1;
		--v1->_m_nRef;
		if (v2)
			v1->_m_pTIB = 0;
	}
};