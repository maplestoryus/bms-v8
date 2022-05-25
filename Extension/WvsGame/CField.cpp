#include "CField.h"

unsigned int CField::GetForcedReturnFieldId() {
	if (this->m_dwForcedReturn == 999999999) {
		return this->m_dwFieldReturn;
	}
	return this->m_dwForcedReturn;
}