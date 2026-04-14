From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 14 Apr 2026 16:33:52 +0000
In-Reply-To: <gerrit.1775138817000.I3157e1a228ac7058fca6a88f94076052e33d2e01@...2715...>
References: <gerrit.1775138817000.I3157e1a228ac7058fca6a88f94076052e33d2e01@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a196413d21b02ddf5ed5fdebf16e8a0d572ca14b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oP7WbBxLIZk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: build: Use info
 fetched from version.m4
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--oP7WbBxLIZk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/16=
05?usp=3Demail )

Change subject: build: Use info fetched from version.m4
......................................................................

build: Use info fetched from version.m4

Change-Id: I3157e1a228ac7058fca6a88f94076052e33d2e01
Signed-off-by: Luis Cruz <luis.cruz@...3019...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1605
Message-Id: <20260414125637.42082-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
612.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M config.h.cmake.in
2 files changed, 7 insertions(+), 3 deletions(-)




diff --git a/CMakeLists.txt b/CMakeLists.txt
index 198c98f..72e349c 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -141,6 +141,10 @@
 set(OPENVPN_VERSION_PATCH ${PRODUCT_VERSION_PATCH})
 set(OPENVPN_VERSION_RESOURCE ${PRODUCT_VERSION_RESOURCE})

+set(TAP_WIN_COMPONENT_ID "${PRODUCT_TAP_WIN_COMPONENT_ID}")
+set(TAP_WIN_MIN_MAJOR ${PRODUCT_TAP_WIN_MIN_MAJOR})
+set(TAP_WIN_MIN_MINOR ${PRODUCT_TAP_WIN_MIN_MINOR})
+
 set(CMAKE_C_STANDARD 11)

 # Set the various defines for config.h.cmake.in
diff --git a/config.h.cmake.in b/config.h.cmake.in
index a93fcd5..ae1d264 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -366,13 +366,13 @@
 #undef SYSTEMD_ASK_PASSWORD_PATH

 /* The tap-windows id */
-#define TAP_WIN_COMPONENT_ID "tap0901"
+#define TAP_WIN_COMPONENT_ID "@TAP_WIN_COMPONENT_ID@"
=20
 /* The tap-windows version number is required for OpenVPN */
-#define TAP_WIN_MIN_MAJOR 9
+#define TAP_WIN_MIN_MAJOR @TAP_WIN_MIN_MAJOR@

 /* The tap-windows version number is required for OpenVPN */
-#define TAP_WIN_MIN_MINOR 9
+#define TAP_WIN_MIN_MINOR @TAP_WIN_MIN_MINOR@

 /* Are we running on Mac OS X? */
 #cmakedefine TARGET_DARWIN

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1605?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3157e1a228ac7058fca6a88f94076052e33d2e01
Gerrit-Change-Number: 1605
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--oP7WbBxLIZk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1605?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">build: Use info fetched from version.m4<br><br>C=
hange-Id: I3157e1a228ac7058fca6a88f94076052e33d2e01<br>Signed-off-by: Luis =
Cruz &lt;luis.cruz@...3019...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@=
...2641...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1605<b=
r>Message-Id: &lt;20260414125637.42082-1-frank@...2641...&gt;<br>URL: https=
://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36612.html<b=
r>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M CMakeList=
s.txt<br>M config.h.cmake.in<br>2 files changed, 7 insertions(+), 3 deletio=
ns(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index 198c9=
8f..72e349c 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++=
 b/CMakeLists.txt</span><br><span>@@ -141,6 +141,10 @@</span><br><span> set=
(OPENVPN_VERSION_PATCH ${PRODUCT_VERSION_PATCH})</span><br><span> set(OPENV=
PN_VERSION_RESOURCE ${PRODUCT_VERSION_RESOURCE})</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+set(TAP_WIN_COMPONENT_ID &qu=
ot;${PRODUCT_TAP_WIN_COMPONENT_ID}&quot;)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+set(TAP_WIN_MIN_MAJOR ${PRODUCT_TAP_WIN_MIN_MAJOR})</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+set(TAP_WIN_MIN_MINOR=
 ${PRODUCT_TAP_WIN_MIN_MINOR})</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> set(CMAKE_C_STANDARD 11)</span><br><span> </sp=
an><br><span> # Set the various defines for config.h.cmake.in</span><br><sp=
an>diff --git a/config.h.cmake.in b/config.h.cmake.in</span><br><span>index=
 a93fcd5..ae1d264 100644</span><br><span>--- a/config.h.cmake.in</span><br>=
<span>+++ b/config.h.cmake.in</span><br><span>@@ -366,13 +366,13 @@</span><=
br><span> #undef SYSTEMD_ASK_PASSWORD_PATH</span><br><span> </span><br><spa=
n> /* The tap-windows id */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define TAP_WIN_COMPONENT_ID &quot;tap0901&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define TAP_WIN_COMPONENT_ID &quot;@TAP_=
WIN_COMPONENT_ID@&quot;</span><br><span> </span><br><span> /* The tap-windo=
ws version number is required for OpenVPN */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define TAP_WIN_MIN_MAJOR 9</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define TAP_WIN_MIN_MAJOR @TAP_WIN_MIN_MAJOR=
@</span><br><span> </span><br><span> /* The tap-windows version number is r=
equired for OpenVPN */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define TAP_WIN_MIN_MINOR 9</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define TAP_WIN_MIN_MINOR @TAP_WIN_MIN_MINOR@</span><br><span> </s=
pan><br><span> /* Are we running on Mac OS X? */</span><br><span> #cmakedef=
ine TARGET_DARWIN</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1605?usp=3Demail">change 1605</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1605?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3157e1a228ac7058fca6a88f940=
76052e33d2e01 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1605 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--oP7WbBxLIZk=--

