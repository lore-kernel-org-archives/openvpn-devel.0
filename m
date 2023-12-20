From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 20 Dec 2023 17:07:40 +0000
In-Reply-To: <gerrit.1702721837000.Ib14c1161b4b0c9df797b9932ad14739e202cea64@...2715...>
References: <gerrit.1702721837000.Ib14c1161b4b0c9df797b9932ad14739e202cea64@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <26b97a9c8b7ce9d4b63b29f9d5fd9eccc449bebb-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tTZfBTnX52M="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: cmake: create and
 link compile_commands.json file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--tTZfBTnX52M=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 d12fk. ( http://gerrit.openvpn.net/c/openvpn/+/483?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: cmake: create and link compile_commands.json file
......................................................................

cmake: create and link compile_commands.json file

CMake has support to create a json file which contains exact information
how each file in the project is compiled. This file can be consumed by
clangd, which in turn provides precise symbol information to IDEs for
better code navigation and contextual information.

I use it with vscode to be able to quickly switch between native Linux and
mingw builds and have the symbols info change dynamically with it. So
handy that I think it is useful for others as well.

Bump required CMake version for CREATE_LINK.

Change-Id: Ib14c1161b4b0c9df797b9932ad14739e202cea64
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20231220123659.55542-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
840.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .gitignore
M CMakeLists.txt
2 files changed, 7 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/83/483/5

diff --git a/.gitignore b/.gitignore
index a1da366..4153a3e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -40,6 +40,7 @@
 m4/ltversion.m4
 m4/lt~obsolete.m4

+compile_commands.json
 doc/openvpn-examples.5
 doc/openvpn-examples.5.html
 doc/openvpn.8
diff --git a/CMakeLists.txt b/CMakeLists.txt
index d40b213..bc46c27 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -1,4 +1,4 @@
-cmake_minimum_required(VERSION 3.12)
+cmake_minimum_required(VERSION 3.14)
 set(CMAKE_CONFIGURATION_TYPES "Release;Debug;ASAN")
 project(openvpn)

@@ -42,6 +42,11 @@

 set(PLUGIN_DIR /usr/local/lib/openvpn/plugins CACHE FILEPATH "Location of =
the plugin directory")

+# Create machine readable compile commands
+set(CMAKE_EXPORT_COMPILE_COMMANDS 1)
+file(CREATE_LINK ${CMAKE_CURRENT_BINARY_DIR}/compile_commands.json
+                 ${CMAKE_CURRENT_SOURCE_DIR}/compile_commands.json SYMBOLI=
C)
+
 # AddressSanitize - use CXX=3Dclang++ CC=3Dclang cmake -DCMAKE_BUILD_TYPE=
=3Dasan to build with ASAN
 set(CMAKE_C_FLAGS_ASAN
     "-fsanitize=3Daddress,undefined -fno-sanitize-recover=3Dall -fno-optim=
ize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointe=
r -g -O1"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/483?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib14c1161b4b0c9df797b9932ad14739e202cea64
Gerrit-Change-Number: 483
Gerrit-PatchSet: 5
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--tTZfBTnX52M=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #5</strong> to the change originally cr=
eated by d12fk.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/483?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">cmake: create and link compile_commands.json =
file<br><br>CMake has support to create a json file which contains exact in=
formation<br>how each file in the project is compiled. This file can be con=
sumed by<br>clangd, which in turn provides precise symbol information to ID=
Es for<br>better code navigation and contextual information.<br><br>I use i=
t with vscode to be able to quickly switch between native Linux and<br>ming=
w builds and have the symbols info change dynamically with it. So<br>handy =
that I think it is useful for others as well.<br><br>Bump required CMake ve=
rsion for CREATE_LINK.<br><br>Change-Id: Ib14c1161b4b0c9df797b9932ad14739e2=
02cea64<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>Acked-by: =
Frank Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;2023122012365=
9.55542-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn=
-devel@lists.sourceforge.net/msg27840.html<br>Signed-off-by: Gert Doering &=
lt;gert@...1296...&gt;<br>---<br>M .gitignore<br>M CMakeLists.txt<br>2 file=
s changed, 7 insertions(+), 1 deletion(-)<br><br></pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.o=
penvpn.net:29418/openvpn refs/changes/83/483/5</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/.gitign=
ore b/.gitignore</span><br><span>index a1da366..4153a3e 100644</span><br><s=
pan>--- a/.gitignore</span><br><span>+++ b/.gitignore</span><br><span>@@ -4=
0,6 +40,7 @@</span><br><span> m4/ltversion.m4</span><br><span> m4/lt~obsole=
te.m4</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+compile_commands.json</span><br><span> doc/openvpn-examples.5</span><br=
><span> doc/openvpn-examples.5.html</span><br><span> doc/openvpn.8</span><b=
r><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index =
d40b213..bc46c27 100644</span><br><span>--- a/CMakeLists.txt</span><br><spa=
n>+++ b/CMakeLists.txt</span><br><span>@@ -1,4 +1,4 @@</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-cmake_minimum_required(VERSION 3.12)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+cmake_minimum_required(VE=
RSION 3.14)</span><br><span> set(CMAKE_CONFIGURATION_TYPES &quot;Release;De=
bug;ASAN&quot;)</span><br><span> project(openvpn)</span><br><span> </span><=
br><span>@@ -42,6 +42,11 @@</span><br><span> </span><br><span> set(PLUGIN_D=
IR /usr/local/lib/openvpn/plugins CACHE FILEPATH &quot;Location of the plug=
in directory&quot;)</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+# Create machine readable compile commands</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+set(CMAKE_EXPORT_COMPILE_COMMANDS =
1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+file(CREATE_LINK =
${CMAKE_CURRENT_BINARY_DIR}/compile_commands.json</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                 ${CMAKE_CURRENT_SOURCE_DIR}/=
compile_commands.json SYMBOLIC)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> # AddressSanitize - use CXX=3Dclang++ CC=3Dcl=
ang cmake -DCMAKE_BUILD_TYPE=3Dasan to build with ASAN</span><br><span> set=
(CMAKE_C_FLAGS_ASAN</span><br><span>     &quot;-fsanitize=3Daddress,undefin=
ed -fno-sanitize-recover=3Dall -fno-optimize-sibling-calls -fsanitize-addre=
ss-use-after-scope -fno-omit-frame-pointer -g -O1&quot;</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/483?usp=3Demail">change 483</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/483?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib14c1161b4b0c9df797b9932ad1=
4739e202cea64 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 483 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--tTZfBTnX52M=--

