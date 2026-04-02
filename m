From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 2 Apr 2026 11:43:57 +0000
References: <gerrit.1775130235000.I355760e43c3e2da0dda0cdec6e4253c028cefe38@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <62da6929bb99434122e56f2c6d0045f428ee70f5-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="D0U/YJTYszA="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix building
 wolfSSL with CMake
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--D0U/YJTYszA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/1604?usp=3Demail )


Change subject: Fix building wolfSSL with CMake
......................................................................

Fix building wolfSSL with CMake

This fixes not finding the includes and add the define that our
autoconf script also adds.

Change-Id: I355760e43c3e2da0dda0cdec6e4253c028cefe38
---
M CMakeLists.txt
1 file changed, 2 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/04/1604/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 198c98f..c3473fb 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -323,7 +323,9 @@
     elseif (${WOLFSSL})
         pkg_search_module(wolfssl wolfssl REQUIRED)
         target_link_libraries(${target} PUBLIC ${wolfssl_LINK_LIBRARIES})
+        target_include_directories(${target} PRIVATE ${wolfssl_INCLUDE_DIR=
S})
         target_include_directories(${target} PRIVATE ${wolfssl_INCLUDE_DIR=
S}/wolfssl)
+        target_compile_definitions(${target} PRIVATE EXTERNAL_OPTS_OPENVPN)
     else ()
         find_package(OpenSSL REQUIRED)
         target_link_libraries(${target} PUBLIC OpenSSL::SSL OpenSSL::Crypt=
o)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1604?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I355760e43c3e2da0dda0cdec6e4253c028cefe38
Gerrit-Change-Number: 1604
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--D0U/YJTYszA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>.</p><p><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1604?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Fix building wolfSSL with CMake<br><br>This fixes not finding the inclu=
des and add the define that our<br>autoconf script also adds.<br><br>Change=
-Id: I355760e43c3e2da0dda0cdec6e4253c028cefe38<br>---<br>M CMakeLists.txt<b=
r>1 file changed, 2 insertions(+), 0 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/04/1604/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index =
198c98f..c3473fb 100644</span><br><span>--- a/CMakeLists.txt</span><br><spa=
n>+++ b/CMakeLists.txt</span><br><span>@@ -323,7 +323,9 @@</span><br><span>=
     elseif (${WOLFSSL})</span><br><span>         pkg_search_module(wolfssl=
 wolfssl REQUIRED)</span><br><span>         target_link_libraries(${target}=
 PUBLIC ${wolfssl_LINK_LIBRARIES})</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        target_include_directories(${target} PRIVATE ${wolfs=
sl_INCLUDE_DIRS})</span><br><span>         target_include_directories(${tar=
get} PRIVATE ${wolfssl_INCLUDE_DIRS}/wolfssl)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        target_compile_definitions(${target} PRIV=
ATE EXTERNAL_OPTS_OPENVPN)</span><br><span>     else ()</span><br><span>   =
      find_package(OpenSSL REQUIRED)</span><br><span>         target_link_l=
ibraries(${target} PUBLIC OpenSSL::SSL OpenSSL::Crypto)</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1604?usp=3Demail">change 1604</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3De=
mail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1604?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I355760e43c3e2da0dda0cdec6e4=
253c028cefe38 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1604 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--D0U/YJTYszA=--

