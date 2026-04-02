From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 2 Apr 2026 14:06:58 +0000
References: <gerrit.1775138817000.I3157e1a228ac7058fca6a88f94076052e33d2e01@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <ffc56e9d8a14e65b663b2fa96383b386fa8e3010-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="d6ZYMNF7Gm0="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--d6ZYMNF7Gm0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1605?usp=3Demail

to review the following change.


Change subject: build: Use info fetched from version.m4
......................................................................

build: Use info fetched from version.m4

Change-Id: I3157e1a228ac7058fca6a88f94076052e33d2e01
Signed-off-by: Luis Cruz <luis.cruz@...3019...>
---
M CMakeLists.txt
M config.h.cmake.in
2 files changed, 7 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/05/1605/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3157e1a228ac7058fca6a88f94076052e33d2e01
Gerrit-Change-Number: 1605
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--d6ZYMNF7Gm0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1605?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">build: Use info fetched from version.m4<br>=
<br>Change-Id: I3157e1a228ac7058fca6a88f94076052e33d2e01<br>Signed-off-by: =
Luis Cruz &lt;luis.cruz@...3019...&gt;<br>---<br>M CMakeLists.txt<br>M conf=
ig.h.cmake.in<br>2 files changed, 7 insertions(+), 3 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/05/1605/1</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><b=
r><span>index 198c98f..72e349c 100644</span><br><span>--- a/CMakeLists.txt<=
/span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -141,6 +141,10 @@</=
span><br><span> set(OPENVPN_VERSION_PATCH ${PRODUCT_VERSION_PATCH})</span><=
br><span> set(OPENVPN_VERSION_RESOURCE ${PRODUCT_VERSION_RESOURCE})</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+set(TAP_W=
IN_COMPONENT_ID &quot;${PRODUCT_TAP_WIN_COMPONENT_ID}&quot;)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+set(TAP_WIN_MIN_MAJOR ${PRODUCT_TA=
P_WIN_MIN_MAJOR})</span><br><span style=3D"color: hsl(120, 100%, 40%);">+se=
t(TAP_WIN_MIN_MINOR ${PRODUCT_TAP_WIN_MIN_MINOR})</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> set(CMAKE_C_STANDARD 11)</s=
pan><br><span> </span><br><span> # Set the various defines for config.h.cma=
ke.in</span><br><span>diff --git a/config.h.cmake.in b/config.h.cmake.in</s=
pan><br><span>index a93fcd5..ae1d264 100644</span><br><span>--- a/config.h.=
cmake.in</span><br><span>+++ b/config.h.cmake.in</span><br><span>@@ -366,13=
 +366,13 @@</span><br><span> #undef SYSTEMD_ASK_PASSWORD_PATH</span><br><sp=
an> </span><br><span> /* The tap-windows id */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define TAP_WIN_COMPONENT_ID &quot;tap0901&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TAP_WIN_COMPO=
NENT_ID &quot;@TAP_WIN_COMPONENT_ID@&quot;</span><br><span> </span><br><spa=
n> /* The tap-windows version number is required for OpenVPN */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define TAP_WIN_MIN_MAJOR 9</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TAP_WIN_MIN_MAJOR=
 @TAP_WIN_MIN_MAJOR@</span><br><span> </span><br><span> /* The tap-windows =
version number is required for OpenVPN */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define TAP_WIN_MIN_MINOR 9</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define TAP_WIN_MIN_MINOR @TAP_WIN_MIN_MINOR@</=
span><br><span> </span><br><span> /* Are we running on Mac OS X? */</span><=
br><span> #cmakedefine TARGET_DARWIN</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1605?usp=3Dem=
ail">change 1605</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1605?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3157e1a228ac7058fca6a88f940=
76052e33d2e01 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1605 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--d6ZYMNF7Gm0=--

