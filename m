MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Wed, 27 Jan 2021 22:04:49 -0500
Message-ID: <CAKuzo_jUJ58K5VirzjgvP=dJZ_qy+H0gGzNJ4hkiAyjSKQdMUQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000876f0705b9ed2770"
Subject: [Openvpn-devel] rfc: mingw and the interactive service code
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000876f0705b9ed2770
Content-Type: text/plain; charset="UTF-8"

Hi,

Starting version 8, mingw has started automatically setting
__USE_MINGW_ANSI_STDIO
= 1 under some feature-set conditions: for example, when _GNU_SOURCE is
defined or -std=C99, both of which are true in our case.

See: release notes at http://mingw-w64.org/doku.php

This causes several stdio functions to use internal ISO-C compliant
implementations (instead of those in msvcrt), and to break some of our s
wprintf family calls.

I see two options:
(i) force __USE_MINGW_ANSI_STDIO = 0 in configure.
(ii) Change all stdio function calls to be compatible building with and
without this macro defined. AFICT, the only change required would be to
replace %s and %S by %ls and %hs in some places -- mostly in interactive
service, one instance in tun.c

Any thoughts? I'm leaning towards option (ii).

Selva

--000000000000876f0705b9ed2770
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>Starting version 8, <span id=3D"m_4406462382137=
926001m_-1752376786893765744:3gz.1">mingw</span> has started automatically =
setting __USE_<span id=3D"m_4406462382137926001m_-1752376786893765744:3gz.2=
">MINGW</span>_ANSI_STDIO =3D 1 under some feature-set conditions: for exam=
ple, when _GNU_SOURCE is defined or -std=3DC99, both of which are true in o=
ur case. <br><br><div>See: release notes at <a href=3D"http://mingw-w64.org=
/doku.php" target=3D"_blank">http://<span id=3D"m_4406462382137926001m_-175=
2376786893765744:3gz.3">mingw</span>-w64.org/<span id=3D"m_4406462382137926=
001m_-1752376786893765744:3gz.4">doku</span>.<span id=3D"m_4406462382137926=
001m_-1752376786893765744:3gz.5">php</span></a><br><br>This causes several =
stdio functions to use internal ISO-C compliant implementations (instead of=
 those in <span id=3D"m_4406462382137926001m_-1752376786893765744:3gz.6">ms=
vcrt</span>), and to break some of our s<span id=3D"m_4406462382137926001m_=
-1752376786893765744:3gz.7">wprintf</span> family calls.<br><br>I see two o=
ptions:<br>(i) force __USE_<span id=3D"m_4406462382137926001m_-175237678689=
3765744:3gz.8">MINGW</span>_ANSI_STDIO =3D 0 in configure.<br>(ii) Change a=
ll stdio function calls to be compatible building with and without this mac=
ro defined. <span id=3D"m_4406462382137926001m_-1752376786893765744:3gz.9">=
AFICT</span>, the only change required would be to replace %s and %S by %ls=
 and %<span id=3D"m_4406462382137926001m_-1752376786893765744:3gz.10">hs</s=
pan> in some places -- mostly in interactive service, one instance=C2=A0in =
tun.c</div><div><br></div><div>Any thoughts? I&#39;m leaning towards option=
 (ii).</div><div><br><span id=3D"m_4406462382137926001m_-175237678689376574=
4:3gz.11">Selva</span></div></div>

--000000000000876f0705b9ed2770--

