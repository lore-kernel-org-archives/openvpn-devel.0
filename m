MIME-Version: 1.0
References: <1568724293-5069-1-git-send-email-lstipakov@...277...>
 <CAKuzo_jdwhEhy6f2N0uXcQOyjoCMQ41Ja3Pg0LwBww7UYmY2zA@...278...>
 <CAGyAFMVr5=bbF3GA9i+i3=rNJtMMcUPgvG6r-PnW8xVmgvMUFg@...278...>
In-Reply-To: <CAGyAFMVr5=bbF3GA9i+i3=rNJtMMcUPgvG6r-PnW8xVmgvMUFg@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 19 Sep 2019 17:32:10 +0300
Message-ID: <CAGyAFMXK3jJ=5VoxJQhwy2phXtb0WzX6sTfMVUNS4zpiTGGQaA@...278...>
Content-Type: multipart/alternative; boundary="0000000000004e93f80592e8d2fe"
Subject: Re: [Openvpn-devel] [PATCH 1/7] Visual Studio: upgrade project
 files to VS2019
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000004e93f80592e8d2fe
Content-Type: text/plain; charset="UTF-8"

Hello,

> Does the VS build target a more
> recent Windows runtime than the legacy one (msvcrt.dll) that mingw
> would link against?

Yes, VS build targets Universal CRT, while mingw targets "classis",
pre-Visual Studio 2015 CRT.

Answering to Gert's question in IRC - CPU load was 25% on 4-core machine,
so I assume that
client is CPU-bound.

I enabled optimization (-O2 -flto) for mingw builds

https://github.com/OpenVPN/openvpn-build/pull/153/commits/570bbbb27ec33f06995400b19da5db2af8b0d58a

and problem seems to be fixed, I see no big difference with Visual Studio
anymore.

I performed series of tests - for each configuration I ran

> iperf3.exe -c 10.8.0.1 -t 60 -V

five times and used average download bandwidth value.

Results below (don't know why they're bit lower comparison to previous
runs, probably AWS datacenter has a bad day today):

Server - openvpn 2.4.4, client tun driver - tap-windows6
mingw, no optimization   - 334Mbit/s (that's what we have in windows
release now)
mingw, optimized            - 390Mbit/s
VS2019 release              - 394Mbit/s

Server - openvpn 2.4.4, client tun driver - wintun
mingw, no optimization   - 650Mbit/s
mingw, optimized            - 731Mbit/s
VS2019 release              - 721Mbit/s

Server - openvpn3 with kernel module, client tun driver - wintun
mingw, no optimization   - 772Mbit/s
mingw, optimized            - 924Mbit/s
VS2019 release              - 901Mbit/s

As you can see, using wintun and mingw optimization increases
download bandwidth more than twice (334Mbit/s -> 731Mbit)

So for the next release we need to build client with optimization enabled
and
it would be nice to have wintun support in 2.5 (see
https://patchwork.openvpn.net/project/openvpn2/list/?series=545)

-- 
-Lev

--0000000000004e93f80592e8d2fe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hello,</div><div><br></div><div>&gt;=
 Does the VS build target a more<br></div><div>&gt; recent Windows runtime =
than the legacy one (msvcrt.dll) that mingw<br>&gt; would link against?=C2=
=A0=C2=A0<br></div><div><br></div><div>Yes, VS build targets Universal CRT,=
 while mingw targets &quot;classis&quot;, pre-Visual Studio 2015 CRT.</div>=
<div><br></div><div>Answering to Gert&#39;s question in IRC - CPU load was =
25% on 4-core machine, so I assume that=C2=A0</div><div>client is CPU-bound=
.</div><div><br></div><div>I enabled optimization (-O2 -flto) for mingw bui=
lds</div><div><br></div><div><a href=3D"https://github.com/OpenVPN/openvpn-=
build/pull/153/commits/570bbbb27ec33f06995400b19da5db2af8b0d58a">https://gi=
thub.com/OpenVPN/openvpn-build/pull/153/commits/570bbbb27ec33f06995400b19da=
5db2af8b0d58a</a></div><div><br></div><div>and problem seems to be fixed, I=
 see no big difference with Visual Studio anymore.</div><div><br></div></di=
v><div>I performed series=C2=A0of tests - for each configuration I ran=C2=
=A0</div><div><br></div><div>&gt; iperf3.exe -c 10.8.0.1 -t 60 -V</div><div=
><br></div><div>five times and used average=C2=A0download bandwidth value.<=
/div><div><br></div><div>Results below (don&#39;t know why they&#39;re bit =
lower comparison to previous runs, probably AWS datacenter has a bad day to=
day):</div><div><br></div><div>Server - openvpn 2.4.4, client tun driver - =
tap-windows6</div><div>mingw, no optimization=C2=A0 =C2=A0- 334Mbit/s (that=
&#39;s what=C2=A0we have in windows release now)</div><div>mingw, optimized=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - 390Mbit/s</div><div>VS2019 rele=
ase=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - 394Mbit/s</div><div><=
br></div><div>Server - openvpn 2.4.4,=20

client=20

tun driver - wintun</div><div><div>mingw, no optimization=C2=A0 =C2=A0- 650=
Mbit/s</div><div>mingw, optimized=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
- 731Mbit/s</div><div>VS2019 release=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 - 721Mbit/s</div><div></div></div><div><br></div><div>Server - o=
penvpn3 with kernel module, client tun driver - wintun</div><div><div>mingw=
, no optimization=C2=A0 =C2=A0- 772Mbit/s</div><div>mingw, optimized=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - 924Mbit/s</div><div>VS2019 release=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - 901Mbit/s</div></div><div><=
br></div><div>As you can see, using wintun and mingw optimization increases=
</div><div>download bandwidth more than twice (334Mbit/s -&gt; 731Mbit)</di=
v><div><br></div><div>So for the next release we need to build client with =
optimization enabled and</div><div>it would be nice to have wintun support =
in 2.5 (see=C2=A0<a href=3D"https://patchwork.openvpn.net/project/openvpn2/=
list/?series=3D545">https://patchwork.openvpn.net/project/openvpn2/list/?se=
ries=3D545</a>)</div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_=
signature">-Lev</div></div>

--0000000000004e93f80592e8d2fe--

