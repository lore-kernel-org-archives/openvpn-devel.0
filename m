MIME-Version: 1.0
In-Reply-To: <4FABBA2D.9010206@...515...>
References: <4FABB063.8090704@...515...>
	<CAOazyz1eHU3T+89E0rEy0zrFnPb5BQQiRLw07bgz23J+wkTHQQ@...278...>
	<4FABBA2D.9010206@...515...>
Date: Thu, 10 May 2012 18:18:04 +0300
Message-ID: <CAOazyz3LokL2uizvW-6WpAJD=7G4i2qfczKSTrUwpwQ_uBxuLQ@...278...>
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

On Thu, May 10, 2012 at 3:53 PM, Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:
>
>> On Thu, May 10, 2012 at 3:11 PM, Samuli Sepp=C3=A4nen <samuli@...515...>=
 wrote:
>>> Hi,
>>>
>>> I tried to generate a Windows installer on Ubuntu 11.10 amd64, but ran
>>> into some issues:
>>>
>>> $ cd openvpn-build/windows-nsis
>>> $ ./build-snapshot
>>> --- snip ---
>>>
>>> make[3]: Leaving directory
>>> `/home/samuli/opt/openvpn-build/windows-nsis/tmp/build-i686/pkcs11-help=
er-1.10'
>>> make[2]: Leaving directory
>>> `/home/samuli/opt/openvpn-build/windows-nsis/tmp/build-i686/pkcs11-help=
er-1.10'
>>> make[1]: Leaving directory
>>> `/home/samuli/opt/openvpn-build/windows-nsis/tmp/build-i686/pkcs11-help=
er-1.10'
>>> tap-windows
>>> Fixup libtool files
>>> Restore libtool files
>>> ls: cannot access tmp/image-i686/openvpn-i686-*-bin.*: No such file or
>>> directory
>>>
>>> The error message seems clear enough, but I'm wondering why the binaries
>>> are not where it looks for them:
>>>
>>> $ ls tmp/image-i686
>>> openvpn
>>> $ ls tmp/image-i686/openvpn
>>> bin =C2=A0etc =C2=A0include =C2=A0lib =C2=A0share
>> This is strange, as you referred to dash, which I never tested, I will
>> try and see if that is the problem.
>>
>> Alon.
> What I know is that if I work around this problem, I get a shell syntax
> error later on... and if I switch #!/bin/sh to #!/bin/bash in
> "build-snapshot", that syntax error goes away. To be more precise, the
> error occurs at openvpn-build/windows-nsis/build:5, which is
>
> =C2=A0 ROOT=3D"${ROOT:-tmp}"
>
> I don't have full logs at hand right now, unfortunately.

No the problem was in much later phase... dash does not support ${XXX//} sy=
ntax.
Fixed now.
Can you please try again?

Thanks!
Alon.

