From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 13 Aug 2024 06:55:19 +0000
In-Reply-To: <gerrit.1723205005000.Ieb6f3a9d14d76000c1caf8ee1e959c6d0de832bf@...2715...>
References: <gerrit.1723205005000.Ieb6f3a9d14d76000c1caf8ee1e959c6d0de832bf@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <45fabc205c9ac7fb05916ee2e2738e2ccbd67a6c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gIklQw6VHZk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Use a more robust
 way to get dco-win version
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gIklQw6VHZk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/723?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Use a more robust way to get dco-win version
......................................................................

Use a more robust way to get dco-win version

The current way doesn't work if the device is already in use.

Starting from 1.3.0, dco-win creates a non-exclusive
control device \\.\ovpn-dco-ver which can be opened by
multiple apps and supports a single IOCTL to get
a version number.

https://github.com/OpenVPN/ovpn-dco-win/pull/76

This will be expecially handy later when checking which
features driver supports.

Change-Id: Ieb6f3a9d14d76000c1caf8ee1e959c6d0de832bf
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240809192257.24208-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
009.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_win.c
1 file changed, 10 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/723/2

diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index e3ada76..3ec946f 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -389,9 +389,16 @@
     OVPN_VERSION version;
     ZeroMemory(&version, sizeof(OVPN_VERSION));

-    /* try to open device by symbolic name */
-    HANDLE h =3D CreateFile("\\\\.\\ovpn-dco", GENERIC_READ | GENERIC_WRIT=
E,
-                          0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_SYSTEM | =
FILE_FLAG_OVERLAPPED, NULL);
+    /* first, try a non-exclusive control device, available from 1.3.0 */
+    HANDLE h =3D CreateFile("\\\\.\\ovpn-dco-ver", GENERIC_READ,
+                          0, NULL, OPEN_EXISTING, 0, NULL);
+
+    if (h =3D=3D INVALID_HANDLE_VALUE)
+    {
+        /* fallback to a "normal" device, this will fail if device is alre=
ady in use */
+        h =3D CreateFile("\\\\.\\ovpn-dco", GENERIC_READ,
+                       0, NULL, OPEN_EXISTING, 0, NULL);
+    }

     if (h =3D=3D INVALID_HANDLE_VALUE)
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/723?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ieb6f3a9d14d76000c1caf8ee1e959c6d0de832bf
Gerrit-Change-Number: 723
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--gIklQw6VHZk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/723?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Use a more robust way to get dco-win version<br><br>=
The current way doesn&#39;t work if the device is already in use.<br><br>St=
arting from 1.3.0, dco-win creates a non-exclusive<br>control device \\.\ov=
pn-dco-ver which can be opened by<br>multiple apps and supports a single IO=
CTL to get<br>a version number.<br><br>https://github.com/OpenVPN/ovpn-dco-=
win/pull/76<br><br>This will be expecially handy later when checking which<=
br>features driver supports.<br><br>Change-Id: Ieb6f3a9d14d76000c1caf8ee1e9=
59c6d0de832bf<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>Acked=
-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20240809192257=
.24208-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-d=
evel@lists.sourceforge.net/msg29009.html<br>Signed-off-by: Gert Doering &lt=
;gert@...1296...&gt;<br>---<br>M src/openvpn/dco_win.c<br>1 file changed, 1=
0 insertions(+), 3 deletions(-)<br><br></pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net=
:29418/openvpn refs/changes/23/723/2</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco_w=
in.c b/src/openvpn/dco_win.c</span><br><span>index e3ada76..3ec946f 100644<=
/span><br><span>--- a/src/openvpn/dco_win.c</span><br><span>+++ b/src/openv=
pn/dco_win.c</span><br><span>@@ -389,9 +389,16 @@</span><br><span>     OVPN=
_VERSION version;</span><br><span>     ZeroMemory(&amp;version, sizeof(OVPN=
_VERSION));</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    /* try to open device by symbolic name */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    HANDLE h =3D CreateFile(&quot;\\\\.\\ov=
pn-dco&quot;, GENERIC_READ | GENERIC_WRITE,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                          0, NULL, OPEN_EXISTING, FIL=
E_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED, NULL);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* first, try a non-exclusive control dev=
ice, available from 1.3.0 */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    HANDLE h =3D CreateFile(&quot;\\\\.\\ovpn-dco-ver&quot;, GENER=
IC_READ,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
               0, NULL, OPEN_EXISTING, 0, NULL);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (h =3D=3D INVALID_HANDLE_VALUE)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* fallback to a &quot;normal&quot; device, this wil=
l fail if device is already in use */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        h =3D CreateFile(&quot;\\\\.\\ovpn-dco&quot;, GEN=
ERIC_READ,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
              0, NULL, OPEN_EXISTING, 0, NULL);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     if=
 (h =3D=3D INVALID_HANDLE_VALUE)</span><br><span>     {</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/723?usp=3Demail">change 723</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/723?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ieb6f3a9d14d76000c1caf8ee1e9=
59c6d0de832bf </div>
<div style=3D"display:none"> Gerrit-Change-Number: 723 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--gIklQw6VHZk=--

