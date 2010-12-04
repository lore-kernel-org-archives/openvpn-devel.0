Message-ID: <4CFA1A01.2000602@...515...>
Date: Sat, 04 Dec 2010 12:37:53 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4CF90B25.3010104@...515...>
	<20101204025529.GA3200@...33...>
In-Reply-To: <20101204025529.GA3200@...33...>
Subject: Re: [Openvpn-devel] Error C2010 in openvpnserv.c during VS2008 build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Matthias Andree ha scritto:
> Am 03.12.2010 16:22, schrieb Samuli Sepp=E4nen:
>=20=20=20
>> Hi,
>>
>> I've managed to extend the Python build system so that it now tries to
>> build the Windows service wrapper, "openvpnserv.exe", after building
>> "openvpn.exe". However, the Visual Studio 2008 C compiler gives these
>> errors:
>>
>>    openvpnserv.c(87): error C2010: '.' : unexpected in macro formal
>> parameter list
>>    openvpnserv.c(101): error C2010: '.' : unexpected in macro formal
>> parameter list
>>
>> The offending lines with context (in beta2.2 branch) are these:
>>
>>    #define mysnprintf(out, args...) \
>>    ...
>>    #define MSG(flags, args...) \
>>
>> The C2010 error is described (very briefly) here:
>>
>> <http://msdn.microsoft.com/en-us/library/64sxk83h.aspx>
>>
>> Any ideas how to fix this issue?
>>=20=20=20=20=20
>
> Hi Samuli,
>
> What you see in the offending lines is GCC's old syntax for variadic macr=
os.  If
> Visual Studio 2008 understands C99 sufficiently, you could #ifdef around =
this
> and use the current form in the code for GCC compilers, and the C99 form =
for others.
>
> See http://gcc.gnu.org/onlinedocs/gcc/Variadic-Macros.html#Variadic-Macro=
s for
> an explanation.
>
> Please try the attached patch - note I haven't been able to test this bey=
ond
> making sure it compiles on GCC 4.3.
>
> HTH.
>
> Best regards
> Matthias
>=20=20=20
Hi Matthias,

Your patch fixes the issue.

Thanks!

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


