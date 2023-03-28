Message-ID: <f89032d7-523c-d8ba-c67a-b548c5d7317f@...68...>
Date: Tue, 28 Mar 2023 11:41:42 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20230327114937.28246-1-selva.nair@...277...>
 <139d5059-25b8-e968-2996-5b3bc225ba3b@...68...>
 <CAKuzo_iMkMXqvHTSX5ZmcurBhx3GT8rd_dbowmtnjaZORyyH1Q@...278...>
 <bf4dac04-2258-ad3d-4929-fe17f0c2cfe3@...68...>
 <ZCKpjm8t4Rg21WvX@...2685...>
From: Matthias Andree <matthias.andree@...68...>
In-Reply-To: <ZCKpjm8t4Rg21WvX@...2685...>
Subject: Re: [Openvpn-devel] [PATCH] Make cert_data.h and
 test_cryptoapi/pkcs11.c MSVC compliant
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Am 28.03.23 um 10:47 schrieb Frank Lichtenheld:
> On Mon, Mar 27, 2023 at 09:45:53PM +0200, Matthias Andree wrote:
>> Am 27.03.23 um 16:45 schrieb Selva Nair:
>>> Hi,
>>>
>>> On Mon, Mar 27, 2023 at 9:59=E2=80=AFAM Matthias Andree
>>> <matthias.andree@...68...> wrote:
>>>
>>>      Am 27.03.23 um 13:49 schrieb selva.nair@...277...:
>>>      > From: Selva Nair <selva.nair@...277...>
>>>      >
>>>      > - Do not use non-literal initializers for static objects
>>>      > - Replace empty initializer {} by {0}
>>>
>>>      Should we go to a revision, I would suggest to not make something
>>>      compliant to a compiler because that is assigning it way too much
>>>      power
>>>      and control. A terms such as "ready to be compiled with MSVC" or so
>>>      would be in order, or making this code compliant with some wisely
>>>      chosen
>>>      version of the ISO 9899 standard, aka. standard C.
>>>
>>>
>>> In this case "MSVC compliant" was arguably a poor choice of words as
>>> what the change=C2=A0does is to avoid non-C99 constructs. However it ma=
de
>>> sense to refer to MSVC in the context of what prompted this patch.
>>>
>>> That said, in a cross-platform code base one often has to make changes
>>> to please compilers just to get things to build.
>>
>> I don't mind what we're doing here... just that I want to avoid the
>> impression as though MSVC were setting the standards. There's always
>> MinGW-GCC...
>
> GCC doesn't seem to care about any of this. Which doesn't really make
> it easier to write code that adheres to standards.

Which is why it might be the easy route to a Windows executable.  As
long as the calling convention matches and there are no by-extension
exceptions, even GCC and Windows objects should mix.

OTOH I share the pain that I have yet to find that "disallow all
extensions" switch, for portability checks.  -pedantic-errors -std=3Dc99
is going some way, but apparently not all the way.  clang may be a bit
pickier, and it will be really complaining about missing prototypes.

It's still compliance with language standards though, not with compilers.

