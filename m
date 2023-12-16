From: "d12fk (Code Review)" <gerrit@...515...>
Date: Sat, 16 Dec 2023 10:17:20 +0000
References: <gerrit.1702721837000.I5d835f37d9b75a2eba39504e673597cf7b6f8989@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d3be0bd04b5c6f9f96b139cb50f07b0f38176cab-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xStZuQQW2oc="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: cmake: build native
 binaries with debug info
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

--xStZuQQW2oc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/484?usp=3Demail

to review the following change.


Change subject: cmake: build native binaries with debug info
......................................................................

cmake: build native binaries with debug info

Since the cmake unix builds are not the officially supported way to
build openvpn, it makes sense to always do debug builds for during
development.

Change-Id: I5d835f37d9b75a2eba39504e673597cf7b6f8989
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M CMakePresets.json
1 file changed, 3 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/84/484/1

diff --git a/CMakePresets.json b/CMakePresets.json
index 135b19d..46aeeef 100644
--- a/CMakePresets.json
+++ b/CMakePresets.json
@@ -199,8 +199,9 @@
             "configuration": "Debug"
         },
         {
-            "name": "unix-native",
-            "configurePreset": "unix-native"
+            "name": "unix-native-debug",
+            "configurePreset": "unix-native",
+            "configuration": "Debug"
         }
     ],
     "testPresets": [

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/484?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5d835f37d9b75a2eba39504e673597cf7b6f8989
Gerrit-Change-Number: 484
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--xStZuQQW2oc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/484?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">cmake: build native binaries with debug info<br><br>Since the=
 cmake unix builds are not the officially supported way to<br>build openvpn=
, it makes sense to always do debug builds for during<br>development.<br><b=
r>Change-Id: I5d835f37d9b75a2eba39504e673597cf7b6f8989<br>Signed-off-by: He=
iko Hund &lt;heiko@...2662...&gt;<br>---<br>M CMakePresets.json<br>1 file c=
hanged, 3 insertions(+), 2 deletions(-)<br><br></pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.ope=
nvpn.net:29418/openvpn refs/changes/84/484/1</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakePres=
ets.json b/CMakePresets.json</span><br><span>index 135b19d..46aeeef 100644<=
/span><br><span>--- a/CMakePresets.json</span><br><span>+++ b/CMakePresets.=
json</span><br><span>@@ -199,8 +199,9 @@</span><br><span>             &quot=
;configuration&quot;: &quot;Debug&quot;</span><br><span>         },</span><=
br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          &quot;name&quot;: &quot;unix-native&quot;,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            &quot;configurePreset&quot;: &q=
uot;unix-native&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            &quot;name&quot;: &quot;unix-native-debug&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            &quot;configurePrese=
t&quot;: &quot;unix-native&quot;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            &quot;configuration&quot;: &quot;Debug&quot;</spa=
n><br><span>         }</span><br><span>     ],</span><br><span>     &quot;t=
estPresets&quot;: [</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/484?usp=3Demail">change 484</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/484?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5d835f37d9b75a2eba39504e673=
597cf7b6f8989 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 484 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--xStZuQQW2oc=--

