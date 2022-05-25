#pragma once
class ParamDecoder {
private:
	char *arguments;
	int offset;
public:
	ParamDecoder(char *arguments);
	~ParamDecoder();
	bool hasMoreCommand();
	void SkipCommand();
	int DecodeInt();
};
