#include <cstdlib>
#include <iostream>

size_t my_strlen(char const* str)
{
    char const* p = str;
    while (*p != '\0')
        ++p;
    return p - str;
}

void my_memcpy(char* dst, char const* src, size_t size)
{
    for (size_t i = 0; i != size; ++i)
        dst[i] = src[i];
}

struct string
{
    string()
    {
        char* tmp = new char[1];
        tmp[0] = '\0';
        data_ = tmp;
        size_ = 0;
    }

    string(char const* str)
    {
        size_ = my_strlen(str);
        data_ = new char[size_ +  1];
        my_memcpy(data_, str, size_ + 1);
    }

    string(string const& other)
    {
        size_ = other.size_;
        char* tmp = new char[size_ + 1];
        my_memcpy(tmp, other.data_, size_ + 1);
        data_ = tmp;
    }

    ~string()
    {
        delete[] data_;
    }

    string& operator=(string const& rhs)
    {
        char* tmp = new char[rhs.size_ + 1];
        my_memcpy(tmp, rhs.data_, rhs.size_ + 1);
        delete[] data_;
        size_ = rhs.size_;
        data_ = tmp;

        return *this;
    }

    char& operator[](size_t i)
    {
        return data_[i];
    }

    char const& operator[](size_t i) const
    {
        return data_[i];
    }

    char const* data() const
    {
        return data_;
    }

    size_t size() const
    {
        return size_;
    }

private:
    string(char* buf, size_t size)
    {
        data_ = buf;
        size_ = size;
    }

private:
    char* data_;
    size_t size_;

    friend string operator+(string const& a, string const& b);
};


std::ostream& operator<<(std::ostream& stream,
                         string const& str)
{
    stream << str.data();
    return stream;
}

string operator+(string const& a, string const& b)
{
    char* tmp = new char[a.size() + b.size() + 1];
    my_memcpy(tmp, a.data(), a.size());
    my_memcpy(tmp + a.size(), b.data(), b.size() + 1);

    return string(tmp, a.size() + b.size());
}

bool operator==(string const& a, string const& b)
{
    if (a.size() != b.size())
        return false;

    for (size_t i = 0; i != a.size(); ++i)
        if (a[i] != b[i])
            return false;

    return true;
}

bool operator!=(string const& a, string const& b)
{
    return !(a == b);
}
