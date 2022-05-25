#pragma once
#include <stdint.h>
#include <type_traits>

template <class key_type, class value_type, class pair_type = key_type>
class ZMap
{
public:
	struct PAIR
	{
		uint32_t padding_;
		PAIR* next_;
		key_type key_;
		value_type value_;
	};

	PAIR** ap_table_;
	uint32_t table_size_;
	uint32_t count_;
	uint32_t auto_grow_every128_;
	uint32_t auto_grow_limit_;

	template <typename T>
	uint32_t get_hash(const T& key) const
	{
		static_assert(std::is_integral<key_type>::value, "This func can only calculate the hash for integral types");

		return _rotr(key, 5);
	};

public:
	using pair = PAIR;

	virtual ~ZMap() = default;

	uint32_t count() const
	{
		return count_;
	}

	value_type* get_at(const key_type& key, value_type& value)
	{
		if (ap_table_ != nullptr)
		{
			PAIR* pair = ap_table_[get_hash(key) % table_size_];
			if (pair != nullptr)
			{
				while (pair->key_ != key)
				{
					pair = pair->next_;
					if (pair == nullptr) return nullptr;
				}

				value = pair->value_;
			}
		}
		return &value;
	}

	PAIR* begin()
	{
		auto pos = ap_table_;
		auto end_of_table = &pos[table_size_];

		if (ap_table_ && pos < end_of_table)
		{
			while (!*pos)
			{
				++pos;
				if (pos >= end_of_table) return nullptr;
			}
			return *pos;
		}
		return nullptr;
	}

	key_type& get_next(PAIR*& pos, value_type& value)
	{
		PAIR* pair = pos;

		if (!pair->next_)
		{//next ptr was't set or was deleted, we need to search it manually :-(
			pos = nullptr;
			PAIR** search_start = &ap_table_[get_hash(pair->key_) % table_size_ + 1];
			PAIR** search_end = &ap_table_[table_size_];
			if (search_start >= search_end)
			{
				value = pair->value_;
				return pair->key_;
			}
			while (!*search_start)
			{
				++search_start;
				if (search_start >= search_end)
				{
					value = pair->value_;
					return pair->key_;
				}
			}
			pair->next_ = *search_start;
		}

		pos = pair->next_;
		value = pair->value_;
		return pair->key_;
	}

	template <typename Function>
	void for_each(Function fn)
	{
		PAIR* pos = begin();

		key_type key;
		value_type value;
		do
		{
			key = get_next(pos, value);
			fn(key, value);
		} while (pos);
	}
};
static_assert(sizeof(ZMap<uint32_t, uint32_t, uint32_t>) == 0x18, "ZMap is the wrong size!");
static_assert(sizeof(ZMap<uint32_t, uint32_t, uint32_t>::pair) == 0x10, "ZMap::PAIR is the wrong size!");