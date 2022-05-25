#include <string>
#include "ParamDecoder.h"

ParamDecoder::ParamDecoder(char *arg) {
	this->arguments = new char[101];
	strcpy_s(arguments, 100, arg);
	this->offset = 0;
};

ParamDecoder::~ParamDecoder() {
	if (this->arguments) {
		delete[] this->arguments;
	}
};

int indexOf(char * str, char c) {
	int i = 0;
	auto backup = str;
	while (*(backup++) != c) {
		if (i == '\n') {
			return -1;
		}
		i++;
	}
	return i;
}


void ParamDecoder::SkipCommand() {
	this->offset += indexOf(this->arguments, ' ') + 1;
}

bool ParamDecoder::hasMoreCommand() {
	return indexOf(this->arguments, ' ') > 0;
}

int ParamDecoder::DecodeInt() {
	int pos = indexOf(&this->arguments[this->offset], ' ');
	if (pos == -1) {
		pos = strlen(&this->arguments[this->offset]);
	}
	char *buff = new char[pos + 1];
	memcpy(buff, &this->arguments[this->offset], pos);
	int number = atoi(buff);
	delete[] buff;
	return number;
}