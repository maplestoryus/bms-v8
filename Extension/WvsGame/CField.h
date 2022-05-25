#pragma once
#include "../WvsCommon/ZRefCounted.h"
#include "../WvsCommon/ZXString.h"
class CField : ZRefCounted {
public:
  int m_dwField;
  int m_dwFieldReturn;
  int m_dwForcedReturn;
  ZXString<char> m_sStreetName;
  ZXString<char> m_sMapName;

  unsigned int CField::GetForcedReturnFieldId();

};