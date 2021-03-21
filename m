References: <20210321144627.1621-1-simon@...2293...>
 <20210321144627.1621-4-simon@...2293...>
 <5bc735d5-32f6-6baf-97a9-149c27adda17@...1227...>
 <5c89a5825dad4af19c4934bbd78ff260@...2293...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <a002b6f5-3201-cb8c-c05c-26d919dd8696@...1227...>
Date: Sun, 21 Mar 2021 17:49:58 +0100
MIME-Version: 1.0
In-Reply-To: <5c89a5825dad4af19c4934bbd78ff260@...2293...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 4/5] tapctl: Resolve MSVC C4996 warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Simon Rozman <simon@...2293...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 21.03.21 um 17:37 schrieb Simon Rozman:
> Hi,
> 
>>> -73,14 +73,13 @@ find_function(const WCHAR *libname, const char
>> *funcname, HMODULE *m)
>>>         return NULL;
>>>      }
>>>
>>> -    size_t len = _countof(libpath) - wcslen(libpath) - 1;
>>> -    if (len < wcslen(libname) + 1)
>>> +    if (wcslen(libpath) + 1 /*\*/ + wcslen(libname) >=
>>> + _countof(libpath))
>>
>> This random inline comment feels extremely weird.
> 
> It's trying to describe the "+ 1" amounts for a backslash \ being strcat-ed in the process below.
> 
> Regards, Simon
> 

I totally didn't get that. I was actually wondering why that is valid
code and why the \* doesn't escape the end of comment. I would prefer it
be either a longer inline comment or even better use a variable with a
normal comment like

/* +1 for the path seperator '\' */
size_t pathlenght = wcslen(libpath) + 1 +  wcslen(libname);

Arne

