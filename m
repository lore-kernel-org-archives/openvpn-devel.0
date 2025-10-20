From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 20 Oct 2025 14:16:25 +0000
References: <gerrit.1760969783000.I82c7c61be07593ecd5bf2f854767dda74ab5170c@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <7cafef0cebe059318d2ea2b25c8648abd2c08aaf-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="L+624pHvLXs="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Warn if push is used
 without --mode server/--server/--server-bridge
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--L+624pHvLXs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1288?usp=3Demail

to review the following change.


Change subject: Warn if push is used without --mode server/--server/--serve=
r-bridge
......................................................................

Warn if push is used without --mode server/--server/--server-bridge

This is not a supported configuration and will often work good enough
to get a connection working but will operate more in a weird pre P2P
negotiation compatibility way rather than actually negotiating
protocol features.

Also remove an used macro.

Change-Id: I82c7c61be07593ecd5bf2f854767dda74ab5170c
---
M src/openvpn/options.c
M src/openvpn/options.h
2 files changed, 6 insertions(+), 5 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/88/1288/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 65c6b3b..6cfe62f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3334,6 +3334,12 @@
                         "Ignoring these options.");
         }
     }
+
+    if (o->push_list.head && o->mode !=3D MODE_SERVER)
+    {
+        msg(M_WARN, "Note: Using --push without --mode server is an unsupp=
orted"
+                    " configuration. Negotiation of OpenVPN features is ex=
pected to fail.");
+    }
 }

 static void
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 009904a..24253af 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -768,16 +768,11 @@
 #define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE))

 #define PULL_DEFINED(opt) ((opt)->pull)
-#define PUSH_DEFINED(opt) ((opt)->push_list)

 #ifndef PULL_DEFINED
 #define PULL_DEFINED(opt) (false)
 #endif

-#ifndef PUSH_DEFINED
-#define PUSH_DEFINED(opt) (false)
-#endif
-
 #ifdef _WIN32
 #define ROUTE_OPTION_FLAGS(o) ((o)->route_method & ROUTE_METHOD_MASK)
 #else

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1288?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I82c7c61be07593ecd5bf2f854767dda74ab5170c
Gerrit-Change-Number: 1288
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>

--L+624pHvLXs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1288?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Warn if push is used without --mode server/=
--server/--server-bridge<br><br>This is not a supported configuration and w=
ill often work good enough<br>to get a connection working but will operate =
more in a weird pre P2P<br>negotiation compatibility way rather than actual=
ly negotiating<br>protocol features.<br><br>Also remove an used macro.<br><=
br>Change-Id: I82c7c61be07593ecd5bf2f854767dda74ab5170c<br>---<br>M src/ope=
nvpn/options.c<br>M src/openvpn/options.h<br>2 files changed, 6 insertions(=
+), 5 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn=
.net:29418/openvpn refs/changes/88/1288/1</pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/=
options.c b/src/openvpn/options.c</span><br><span>index 65c6b3b..6cfe62f 10=
0644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/=
openvpn/options.c</span><br><span>@@ -3334,6 +3334,12 @@</span><br><span>  =
                       &quot;Ignoring these options.&quot;);</span><br><spa=
n>         }</span><br><span>     }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (o-&gt;push_list.head &amp;&amp; o-&gt;mode !=3D MODE_SERVER)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;Note: Using -=
-push without --mode server is an unsupported&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    &quot; configuration.=
 Negotiation of OpenVPN features is expected to fail.&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> }</span><b=
r><span> </span><br><span> static void</span><br><span>diff --git a/src/ope=
nvpn/options.h b/src/openvpn/options.h</span><br><span>index 009904a..24253=
af 100644</span><br><span>--- a/src/openvpn/options.h</span><br><span>+++ b=
/src/openvpn/options.h</span><br><span>@@ -768,16 +768,11 @@</span><br><spa=
n> #define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE))</span><br><s=
pan> </span><br><span> #define PULL_DEFINED(opt) ((opt)-&gt;pull)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define PUSH_DEFINED(opt) ((opt=
)-&gt;push_list)</span><br><span> </span><br><span> #ifndef PULL_DEFINED</s=
pan><br><span> #define PULL_DEFINED(opt) (false)</span><br><span> #endif</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifnde=
f PUSH_DEFINED</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 PUSH_DEFINED(opt) (false)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span> #ifdef _WIN32</span><br><span> #define ROUTE_OPTION_FLAGS(o) ((o)-&=
gt;route_method &amp; ROUTE_METHOD_MASK)</span><br><span> #else</span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1288?usp=3Demail">change 1288</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1288?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I82c7c61be07593ecd5bf2f85476=
7dda74ab5170c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1288 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--L+624pHvLXs=--

