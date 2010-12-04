Message-ID: <4CF9B098.2070807@...68...>
Date: Sat, 04 Dec 2010 04:08:08 +0100
From: Matthias Andree <matthias.andree@...68...>
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Am 04.12.2010 03:55, schrieb Matthias Andree:
> Am 03.12.2010 16:22, schrieb Samuli Sepp=E4nen:
>> Hi,
>>=20
>> I've managed to extend the Python build system so that it now tries to
>> build the Windows service wrapper, "openvpnserv.exe", after building
>> "openvpn.exe". However, the Visual Studio 2008 C compiler gives these
>> errors:
>>=20
>>    openvpnserv.c(87): error C2010: '.' : unexpected in macro formal
>> parameter list
>>    openvpnserv.c(101): error C2010: '.' : unexpected in macro formal
>> parameter list
>>=20
>> The offending lines with context (in beta2.2 branch) are these:
>>=20
>>    #define mysnprintf(out, args...) \
>>    ...
>>    #define MSG(flags, args...) \
>>=20
>> The C2010 error is described (very briefly) here:
>>=20
>> <http://msdn.microsoft.com/en-us/library/64sxk83h.aspx>
>>=20
>> Any ideas how to fix this issue?
>=20
> Hi Samuli,
>=20
> What you see in the offending lines is GCC's old syntax for variadic macr=
os.  If
> Visual Studio 2008 understands C99 sufficiently, you could #ifdef around =
this
> and use the current form in the code for GCC compilers, and the C99 form =
for others.
>=20
> See http://gcc.gnu.org/onlinedocs/gcc/Variadic-Macros.html#Variadic-Macro=
s for
> an explanation.
>=20
> Please try the attached patch - note I haven't been able to test this bey=
ond
> making sure it compiles on GCC 4.3.

Huh, something broke my GnuPG signature.  It is OK in my "Sent" folder.

Note that the patch shouldn't be committed with the original message, but is
meant for testing.  If it keeps working with whatever is normally used to b=
uild
the Windows release of OpenVPN (GCC, and Visual Studio), feel free to commit
with an updated comment though.

--=20
Matthias Andree

