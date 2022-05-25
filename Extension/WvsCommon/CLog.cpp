#include "CLog.h"
#include <time.h>
#include <cstdarg>
#include <iostream>
#include <fstream>
#pragma warning(disable:4996)
void CLog::Log(string format, ...) {
	char buf[1024] = { 0 };
	va_list args;
	va_start(args, format);

	time_t rawtime;
	struct tm * timeinfo;
	char buffer[80];
	time(&rawtime);
	timeinfo = localtime(&rawtime);

	strftime(buffer, sizeof(buffer), "%d-%m-%Y %H:%M:%S", timeinfo);
	std::string str(buffer);

	vsprintf(buf, format.c_str(), args);
	ofstream os;
	os.open(filePath->c_str(), ios::app);
	os << buffer;
	os << " - ";
	os << buf;
	os << "\n";

	va_end(args);
}