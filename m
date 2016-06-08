MIME-Version: 1.0
In-Reply-To: <CAFHpkQFNHWNWZsw+vN=HUQA_MgMEAX9LMa3FMKfoCpTps2k2AQ@...278...>
References: <CAFHpkQFNHWNWZsw+vN=HUQA_MgMEAX9LMa3FMKfoCpTps2k2AQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 8 Jun 2016 12:49:13 -0400
Message-ID: <CAKuzo_isuFn2dC6hZ-bqP2aMF8j_mxgStXctAzC-RayEkBUTbw@...278...>
Content-Type: multipart/alternative; boundary=001a11394470005f200534c7174b
Subject: Re: [Openvpn-devel] how snapshot installers are built ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11394470005f200534c7174b
Content-Type: text/plain; charset=UTF-8

Hi,


> I see daily builds like
>
>
>
> http://build.openvpn.net/downloads/snapshots/openvpn-install-master-20160607214911-63b3e000c9-x86_64.exe
>
>
> I used to think they are built with "build-snapshot":
> https://github.com/OpenVPN/openvpn-build/blob/master/windows-nsis/build-snapshot
>
> however, when I run it,
>
>
> ....
> tap-windows
> Fixup libtool files
> Restore libtool files
> Fixup libtool files
> Build openvpn
> ../generic/build: line 284: cd:
> /home/ilia/openvpn-build/windows-nsis/tmp/build-i686/openvpn-2.3.11: No
> such file or directory
> FATAL: cd openvpn
> FATAL: build i686 >&2
> FATAL: build-complete >&2
> [ilia@...23... windows-nsis]$
>
>
> somehow it tries to find openvpn-2.3.11 instead of master.
>
>
> how am I supposed to run that script ?
>

Samuli had posted a link to
https://github.com/mattock/openvpn-windows-buildtest which, I think, has
the necessary scripts to use with openvpn-build for daily snapshot
building..

Selva

--001a11394470005f200534c7174b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br><div class=3D"gmail_extra"><div class=3D"gmail=
_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-style=
:solid;padding-left:1ex"><div dir=3D"ltr"><div><div><div><div><div><div><di=
v><br></div>I see daily builds like <br><br><br><a href=3D"http://build.ope=
nvpn.net/downloads/snapshots/openvpn-install-master-20160607214911-63b3e000=
c9-x86_64.exe" target=3D"_blank">http://build.openvpn.net/downloads/snapsho=
ts/openvpn-install-master-20160607214911-63b3e000c9-x86_64.exe</a><br><br><=
br></div>I used to think they are built with &quot;build-snapshot&quot;: <a=
 href=3D"https://github.com/OpenVPN/openvpn-build/blob/master/windows-nsis/=
build-snapshot" target=3D"_blank">https://github.com/OpenVPN/openvpn-build/=
blob/master/windows-nsis/build-snapshot</a><br><br></div>however, when I ru=
n it, <br><br><br>....<br>tap-windows<br>Fixup libtool files<br>Restore lib=
tool files<br>Fixup libtool files<br>Build openvpn<br>../generic/build: lin=
e 284: cd: /home/ilia/openvpn-build/windows-nsis/tmp/build-i686/openvpn-2.3=
.11: No such file or directory<br>FATAL: cd openvpn<br>FATAL: build i686 &g=
t;&amp;2<br>FATAL: build-complete &gt;&amp;2<br>[ilia@...23... windows-nsis=
]$ <br><br><br></div>somehow it tries to find openvpn-2.3.11 instead of mas=
ter.<br><br><br></div>how am I supposed to run that script ?</div></div></d=
iv></blockquote><div><br></div><div>Samuli had posted a link to =C2=A0<a hr=
ef=3D"https://github.com/mattock/openvpn-windows-buildtest" target=3D"_blan=
k">https://github.com/mattock/openvpn-windows-buildtest</a> which, I think,=
 has the necessary scripts to use with openvpn-build for daily snapshot bui=
lding..</div><div><br></div><div>Selva</div></div><br></div></div></div>

--001a11394470005f200534c7174b--

