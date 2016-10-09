MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Sun, 9 Oct 2016 11:02:35 -0400
Message-ID: <CAKuzo_i77hGdm3at0EnnmpRZiyT9Vt_8=bUqQfGwiPAHOpqQ+w@...278...>
Content-Type: multipart/alternative; boundary=001a1141b3202ff2e6053e6ff05a
Subject: [Openvpn-devel] strtok on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1141b3202ff2e6053e6ff05a
Content-Type: text/plain; charset=UTF-8

Hi,

As per MSDN, strtok on Windows is thread-safe --- uses thread-local static
for the internal state (though not reentrant). Anyone knows whether this is
true even when mingw is used --- does it use strtok from Microsoft's run
time or some internal implementation?

I have patch for the GUI that uses strtok_r which is not natively available
on Windows. Just realized some older versions of mingw doesn't have an
implementation of strtok_r. For my use-case a thread-safe strtok will work
as reentrancy is not required.

Thanks,

Selva

--001a1141b3202ff2e6053e6ff05a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br><br>As per <span class=3D"" style=3D"" id=3D":=
1r7.1" tabindex=3D"-1">MSDN</span>, <span class=3D"" style=3D"" id=3D":1r7.=
2" tabindex=3D"-1">strtok</span> on Windows is thread-safe --- uses thread-=
local static for the internal state (though not <span class=3D"" style=3D""=
 id=3D":1r7.3" tabindex=3D"-1">reentrant</span>). Anyone knows whether this=
 is true even when <span class=3D"" style=3D"" id=3D":1r7.4" tabindex=3D"-1=
">mingw</span> is used --- does it use <span class=3D"" style=3D"" id=3D":1=
r7.5" tabindex=3D"-1">strtok</span> from Microsoft&#39;s run time or some i=
nternal implementation?<br><br></div><div>I have patch for the GUI that use=
s <span class=3D"" style=3D"" id=3D":1r7.6" tabindex=3D"-1">strtok</span>_r=
 which is not <span class=3D"" style=3D"" id=3D":1r7.7" tabindex=3D"-1">nat=
ively</span> available on Windows. Just realized some older versions of <sp=
an class=3D"" style=3D"" id=3D":1r7.8" tabindex=3D"-1">mingw</span> doesn&#=
39;t have an implementation of <span class=3D"" style=3D"" id=3D":1r7.9" ta=
bindex=3D"-1">strtok</span>_r. For my use-case a thread-safe <span class=3D=
"" style=3D"" id=3D":1r7.10" tabindex=3D"-1">strtok</span> will work as <sp=
an class=3D"" style=3D"" id=3D":1r7.11" tabindex=3D"-1">reentrancy</span> i=
s not required.<br></div><div><br></div><div>Thanks,<br><br></div><div><spa=
n class=3D"" style=3D"" id=3D":1r7.12" tabindex=3D"-1">Selva</span><br></di=
v></div>

--001a1141b3202ff2e6053e6ff05a--

