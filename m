MIME-Version: 1.0
References: <1568724293-5069-1-git-send-email-lstipakov@...277...>
 <CAGyAFMVjqC4mdjy83v+UqgLBnv3yLGwRT5Hg_PAB+_PwEMoDZw@...278...>
 <CAA1Abx+u=ZRaVVfwSfrSJOJYhFdRbX8q-amMt8LV+jL+du+2dw@...278...>
 <CAGyAFMVQy9U09nXkr1Q66qpHrBNoX99b_dF93kd+0w9w4sqC5Q@...278...>
 <CAKuzo_givujmu0hSZzYhooGDgdYTxRtv_6OqzfkvhSGNLq866Q@...278...>
In-Reply-To: <CAKuzo_givujmu0hSZzYhooGDgdYTxRtv_6OqzfkvhSGNLq866Q@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 20 Sep 2019 21:14:36 +0300
Message-ID: <CAGyAFMVr_nYE1h6BhVFRz6Ld4DMKOekDXFcbGmqfuAEQ+dL7VA@...278...>
Content-Type: multipart/alternative; boundary="000000000000a2abb30593000beb"
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
Cc: Steffan Karger <steffan@...1856...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000a2abb30593000beb
Content-Type: text/plain; charset="UTF-8"

Double checked that it was in my original email :)

> * if you have OpenVPN GUI client installed, run under administrative
command prompt:
>          c:\Program Files\TAP-Windows\bin>tapinstall.exe install
c:\Temp\wintun\wintun.inf wintun
> * alternatively you can install driver via windows device manager ->
action ->add legacy hardware -> install manually ->
>          point to wintun.inf in C:\Temp\wintun

If I am not mistaken, tapinstall is a renamed devcon, so same arguments
might work.

You could also patch our own tapctl tool:

diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index e75db354..905fef66 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -41,7 +41,7 @@

 const static GUID GUID_DEVCLASS_NET = { 0x4d36e972L, 0xe325, 0x11ce, {
0xbf, 0xc1, 0x08, 0x00, 0x2b, 0xe1, 0x03, 0x18 } };

-const static TCHAR szzHardwareIDs[] = TEXT("root\\")
TEXT(TAP_WIN_COMPONENT_ID) TEXT("\0");
+const static TCHAR szzHardwareIDs[] = TEXT("wintun") TEXT("\0");

 const static TCHAR szInterfaceRegKeyPathTemplate[] =
TEXT("SYSTEM\\CurrentControlSet\\Control\\Network\\%") TEXT(PRIsLPOLESTR)
TEXT("\\%") TEXT(PRIsLPOLESTR) TEXT("\\Connection");
 #define INTERFACE_REGKEY_PATH_MAX
(_countof(TEXT("SYSTEM\\CurrentControlSet\\Control\\Network\\")) - 1 + 38 +
_countof(TEXT("\\")) - 1 + 38 + _countof(TEXT("\\Connection")))

and then run:

> tapctl.exe create --name openvpn-wintun

-- 
-Lev

--000000000000a2abb30593000beb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Double checked that it was in my original=
 email :)<div><br></div>&gt; * if you have OpenVPN GUI client installed, ru=
n under administrative command prompt:<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 c:\Program Files\TAP-Windows\bin&gt;tapinstall.exe install c:\Temp\w=
intun\wintun.inf wintun<br>&gt; * alternatively you can install driver via =
windows device manager -&gt; action -&gt;add legacy hardware -&gt; install =
manually -&gt;<br><div>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 point to wint=
un.inf in C:\Temp\wintun</div><div><br></div><div>If I am not=C2=A0mistaken=
, tapinstall is a renamed devcon, so same arguments might work.</div><div><=
br></div><div>You could also patch our own tapctl tool:</div><div><br></div=
><div>diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c<br>index e75db354..9=
05fef66 100644<br>--- a/src/tapctl/tap.c<br>+++ b/src/tapctl/tap.c<br>@@ -4=
1,7 +41,7 @@<br><br>=C2=A0const static GUID GUID_DEVCLASS_NET =3D { 0x4d36e=
972L, 0xe325, 0x11ce, { 0xbf, 0xc1, 0x08, 0x00, 0x2b, 0xe1, 0x03, 0x18 } };=
<br><br>-const static TCHAR szzHardwareIDs[] =3D TEXT(&quot;root\\&quot;) T=
EXT(TAP_WIN_COMPONENT_ID) TEXT(&quot;\0&quot;);<br>+const static TCHAR szzH=
ardwareIDs[] =3D TEXT(&quot;wintun&quot;) TEXT(&quot;\0&quot;);<br><br>=C2=
=A0const static TCHAR szInterfaceRegKeyPathTemplate[] =3D TEXT(&quot;SYSTEM=
\\CurrentControlSet\\Control\\Network\\%&quot;) TEXT(PRIsLPOLESTR) TEXT(&qu=
ot;\\%&quot;) TEXT(PRIsLPOLESTR) TEXT(&quot;\\Connection&quot;);<br>=C2=A0#=
define INTERFACE_REGKEY_PATH_MAX (_countof(TEXT(&quot;SYSTEM\\CurrentContro=
lSet\\Control\\Network\\&quot;)) - 1 + 38 + _countof(TEXT(&quot;\\&quot;)) =
- 1 + 38 + _countof(TEXT(&quot;\\Connection&quot;)))<br></div><div><br></di=
v><div>and then run:</div><div><br></div><div>&gt; tapctl.exe create --name=
 openvpn-wintun</div><div><br></div></div>-- <br><div dir=3D"ltr" class=3D"=
gmail_signature">-Lev</div></div>

--000000000000a2abb30593000beb--

