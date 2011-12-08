MIME-Version: 1.0
In-Reply-To: <CAOazyz13pmU4=6XOA-2uq0rAwTMRrRYF73sszehxbcPQsa2rmQ@...278...>
References: <1323303229-31079-1-git-send-email-davids@...1347...>
	<CAOazyz1wxUHB27gj0y7L048af-ajfqvZno5KjtFUC9Ad4Uqn3w@...278...>
	<4EE0951E.80900@...1114...>
	<CAOazyz13pmU4=6XOA-2uq0rAwTMRrRYF73sszehxbcPQsa2rmQ@...278...>
Date: Thu, 8 Dec 2011 12:57:48 +0200
Message-ID: <CAOazyz0Q=a6uKKX03MokunME=SD+sy_NDXBi+1w1UBASPTdGpA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Add a wrapper for access() when
 compiling via Visual Studio
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn.list@...1114...>
Cc: David Sommerseth <davids@...1347...>, openvpn-devel@lists.sourceforge.net

On Thu, Dec 8, 2011 at 12:51 PM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> On Thu, Dec 8, 2011 at 12:44 PM, David Sommerseth
> <openvpn.list@...1114...> wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 08/12/11 08:44, Alon Bar-Lev wrote:
>>> On Thu, Dec 8, 2011 at 2:13 AM, David Sommerseth <davids@...1347...>
>>> wrote:
>>>> +/* The POSIX access() function is called via _access() on Windows,
>>>> + * defined in io.h + */ +#define HAVE_ACCESS 1 +#define access
>>>> _access +#pragma warning(disable : 4996) /* Avoid Visual Studio to
>>>> complain about access(), which is redefined */
>>>
>>> Where is it defined? Anyway, won't it better: --- #ifdef access #undef
>>> access #endif #define access _access ---
>>
>> I tried that approach as well, and I still got this warning:
>> - ----------------------------------------------------------------------=
---
>> options.c(2619) : warning C4996: '_access': The POSIX name for this item
>> is deprecated. Instead, use the ISO C++ conformant name: _access. See
>> online help for details.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0c:\Program Files (x86)\Microsoft Visual Studio
>> 9.0\VC\INCLUDE\io.h(185): see declaration of '_access'
>> options.c(2625) : warning C4996: '_access': The POSIX name for this item
>> is deprecated. Instead, use the ISO C++ conformant name: _access. See
>> online help for details.
>
> This is something else!
> Try defining _CRT_NONSTDC_NO_WARNINGS and _CRT_SECURE_NO_WARNINGS.
>
> Alon.

This of course should be only in your vcproj not anywhere in openvpn.

Alon.

