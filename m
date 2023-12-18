From: "d12fk (Code Review)" <gerrit@...515...>
Date: Mon, 18 Dec 2023 11:47:11 +0000
In-Reply-To: <gerrit.1702721837000.Ib14c1161b4b0c9df797b9932ad14739e202cea64@...2715...>
References: <gerrit.1702721837000.Ib14c1161b4b0c9df797b9932ad14739e202cea64@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6c6950dda16d17596092b276edaea53f304eb20f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KtTSqAAiEP0="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--KtTSqAAiEP0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/483?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


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
---
M CMakeLists.txt
1 file changed, 6 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/83/483/3

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

--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/483?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib14c1161b4b0c9df797b9932ad14739e202cea64
Gerrit-Change-Number: 483
Gerrit-PatchSet: 3
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-MessageType: newpatchset

--KtTSqAAiEP0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, flichtenheld, plaisthos. <=
/p>
<p>d12fk <strong>uploaded patch set #3</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/483?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">cmake: create and link compile_commands.json =
file<br><br>CMake has support to create a json file which contains exact in=
formation<br>how each file in the project is compiled. This file can be con=
sumed by<br>clangd, which in turn provides precise symbol information to ID=
Es for<br>better code navigation and contextual information.<br><br>I use i=
t with vscode to be able to quickly switch between native Linux and<br>ming=
w builds and have the symbols info change dynamically with it. So<br>handy =
that I think it is useful for others as well.<br><br>Bump required CMake ve=
rsion for CREATE_LINK.<br><br>Change-Id: Ib14c1161b4b0c9df797b9932ad14739e2=
02cea64<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>---<br>M C=
MakeLists.txt<br>1 file changed, 6 insertions(+), 1 deletion(-)<br><br></pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/83/483/3</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index d40b21=
3..bc46c27 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++ =
b/CMakeLists.txt</span><br><span>@@ -1,4 +1,4 @@</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-cmake_minimum_required(VERSION 3.12)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+cmake_minimum_required(VERSION =
3.14)</span><br><span> set(CMAKE_CONFIGURATION_TYPES &quot;Release;Debug;AS=
AN&quot;)</span><br><span> project(openvpn)</span><br><span> </span><br><sp=
an>@@ -42,6 +42,11 @@</span><br><span> </span><br><span> set(PLUGIN_DIR /us=
r/local/lib/openvpn/plugins CACHE FILEPATH &quot;Location of the plugin dir=
ectory&quot;)</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# Create machine readable compile commands</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+set(CMAKE_EXPORT_COMPILE_COMMANDS 1)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+file(CREATE_LINK ${CMAK=
E_CURRENT_BINARY_DIR}/compile_commands.json</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                 ${CMAKE_CURRENT_SOURCE_DIR}/compil=
e_commands.json SYMBOLIC)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> # AddressSanitize - use CXX=3Dclang++ CC=3Dclang cm=
ake -DCMAKE_BUILD_TYPE=3Dasan to build with ASAN</span><br><span> set(CMAKE=
_C_FLAGS_ASAN</span><br><span>     &quot;-fsanitize=3Daddress,undefined -fn=
o-sanitize-recover=3Dall -fno-optimize-sibling-calls -fsanitize-address-use=
-after-scope -fno-omit-frame-pointer -g -O1&quot;</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
483?usp=3Demail">change 483</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/483?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib14c1161b4b0c9df797b9932ad1=
4739e202cea64 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 483 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
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
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--KtTSqAAiEP0=--

