Message-ID: <4FABBA2D.9010206@...515...>
Date: Thu, 10 May 2012 15:53:01 +0300
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <4FABB063.8090704@...515...>
	<CAOazyz1eHU3T+89E0rEy0zrFnPb5BQQiRLw07bgz23J+wkTHQQ@...278...>
In-Reply-To: <CAOazyz1eHU3T+89E0rEy0zrFnPb5BQQiRLw07bgz23J+wkTHQQ@...278...>
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> On Thu, May 10, 2012 at 3:11 PM, Samuli Sepp=C3=A4nen <samuli@...515...> =
wrote:
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
>> bin  etc  include  lib  share
> This is strange, as you referred to dash, which I never tested, I will
> try and see if that is the problem.
>
> Alon.
What I know is that if I work around this problem, I get a shell syntax
error later on... and if I switch #!/bin/sh to #!/bin/bash in
"build-snapshot", that syntax error goes away. To be more precise, the
error occurs at openvpn-build/windows-nsis/build:5, which is

   ROOT=3D"${ROOT:-tmp}"

I don't have full logs at hand right now, unfortunately.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


