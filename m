MIME-Version: 1.0
In-Reply-To: <4FABB33C.3020604@...515...>
References: <4FABB063.8090704@...515...>
	<4FABB33C.3020604@...515...>
Date: Thu, 10 May 2012 15:35:07 +0300
Message-ID: <CAOazyz1sXu1kyfbrbno-NUGY5z13Rq+7grmB=-bwO26gKMJAGw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Some issues with openvpn-build/windows-nsis
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
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Thu, May 10, 2012 at 3:23 PM, Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:
> Il 10.05.2012 15:11, Samuli Sepp=C3=A4nen ha scritto:
>> Hi,
>>
>> I tried to generate a Windows installer on Ubuntu 11.10 amd64, but ran
>> into some issues:
>>
>> $ cd openvpn-build/windows-nsis
>> $ ./build-snapshot
>> --- snip ---
>>
>> make[3]: Leaving directory
>> `/home/samuli/opt/openvpn-build/windows-nsis/tmp/build-i686/pkcs11-helpe=
r-1.10'
>> make[2]: Leaving directory
>> `/home/samuli/opt/openvpn-build/windows-nsis/tmp/build-i686/pkcs11-helpe=
r-1.10'
>> make[1]: Leaving directory
>> `/home/samuli/opt/openvpn-build/windows-nsis/tmp/build-i686/pkcs11-helpe=
r-1.10'
>> tap-windows
>> Fixup libtool files
>> Restore libtool files
>> ls: cannot access tmp/image-i686/openvpn-i686-*-bin.*: No such file or
>> directory
>>
>> The error message seems clear enough, but I'm wondering why the binaries
>> are not where it looks for them:
>>
>> $ ls tmp/image-i686
>> openvpn
>> $ ls tmp/image-i686/openvpn
>> bin =C2=A0etc =C2=A0include =C2=A0lib =C2=A0share
>
> Oh, forgot to ask... is there a clean way to resume the build near the
> failure point? Rebuilding everything every time is very time-consuming.

No.... sorry, I didn't think it worth the effort as dependencies build
is one time and you can use regular openvpn configure && make against
the dependencies while developing.

But once you have the binary images you can use the windows-nsis/build
script to only create installer out of them.

Alon.

