From: "stipa (Code Review)" <gerrit@...515...>
Date: Fri, 9 Aug 2024 12:03:28 +0000
References: <gerrit.1723205005000.Ieb6f3a9d14d76000c1caf8ee1e959c6d0de832bf@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d3686dbfd1dc7146290ba833711675f3b974a97c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XZNHAau4+hg="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--XZNHAau4+hg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/723?usp=3Demail

to review the following change.


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
---
M src/openvpn/dco_win.c
1 file changed, 10 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/723/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--XZNHAau4+hg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/723?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Use a more robust way to get dco-win version<br><br>The curre=
nt way doesn&#39;t work if the device is already in use.<br><br>Starting fr=
om 1.3.0, dco-win creates a non-exclusive<br>control device \\.\ovpn-dco-ve=
r which can be opened by<br>multiple apps and supports a single IOCTL to ge=
t<br>a version number.<br><br>https://github.com/OpenVPN/ovpn-dco-win/pull/=
76<br><br>This will be expecially handy later when checking which<br>featur=
es driver supports.<br><br>Change-Id: Ieb6f3a9d14d76000c1caf8ee1e959c6d0de8=
32bf<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>M src/o=
penvpn/dco_win.c<br>1 file changed, 10 insertions(+), 3 deletions(-)<br><br=
></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/723/1</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c</span><br=
><span>index e3ada76..3ec946f 100644</span><br><span>--- a/src/openvpn/dco_=
win.c</span><br><span>+++ b/src/openvpn/dco_win.c</span><br><span>@@ -389,9=
 +389,16 @@</span><br><span>     OVPN_VERSION version;</span><br><span>    =
 ZeroMemory(&amp;version, sizeof(OVPN_VERSION));</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    /* try to open device by s=
ymbolic name */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    HA=
NDLE h =3D CreateFile(&quot;\\\\.\\ovpn-dco&quot;, GENERIC_READ | GENERIC_W=
RITE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
          0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAP=
PED, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* f=
irst, try a non-exclusive control device, available from 1.3.0 */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    HANDLE h =3D CreateFile(&=
quot;\\\\.\\ovpn-dco-ver&quot;, GENERIC_READ,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                          0, NULL, OPEN_EXISTING,=
 0, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (h =3D=3D INVALID_HAN=
DLE_VALUE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* fallback to =
a &quot;normal&quot; device, this will fail if device is already in use */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        h =3D Create=
File(&quot;\\\\.\\ovpn-dco&quot;, GENERIC_READ,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                       0, NULL, OPEN_EXISTING, =
0, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span> </span><br><span>     if (h =3D=3D INVALID_HANDLE_VALUE)</span=
><br><span>     {</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/723?usp=3Demail">change 723</a>.=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/723?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ieb6f3a9d14d76000c1caf8ee1e9=
59c6d0de832bf </div>
<div style=3D"display:none"> Gerrit-Change-Number: 723 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--XZNHAau4+hg=--

