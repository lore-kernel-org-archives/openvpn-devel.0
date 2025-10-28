From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Oct 2025 17:46:45 +0000
In-Reply-To: <gerrit.1760969783000.I82c7c61be07593ecd5bf2f854767dda74ab5170c@...2715...>
References: <gerrit.1760969783000.I82c7c61be07593ecd5bf2f854767dda74ab5170c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <49250f4a504153140b611c72d5ceec913e533a0c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="63A16WFY+dY="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--63A16WFY+dY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1288?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Warn if push is used without --mode server/--server/--serve=
r-bridge
......................................................................

Warn if push is used without --mode server/--server/--server-bridge

This is not a supported configuration and will often work good enough
to get a connection working but will operate more in a weird pre P2P
negotiation compatibility way rather than actually negotiating
protocol features.

While at it, remove an unused macro (PUSH_DEFINED).

Change-Id: I82c7c61be07593ecd5bf2f854767dda74ab5170c
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1288
Message-Id: <20251023155614.20642-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
856.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/server-options.rst
M src/openvpn/options.c
M src/openvpn/options.h
3 files changed, 10 insertions(+), 5 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/88/1288/3

diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-=
options.rst
index ccc1374..347a251 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -497,6 +497,9 @@
   ``--echo``, ``--comp-lzo``, ``--socket-flags``, ``--sndbuf``,
   ``--rcvbuf``, ``--session-timeout``

+  Note: using ``--push`` requires OpenVPN to run in ``--mode server`` (or
+  using of one of `--server`, `--server-bridge` helper directives).
+
 --push-remove opt
   Selectively remove all ``--push`` options matching "opt" from the option
   list for a client. ``opt`` is matched as a substring against the whole
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 65c6b3b..9c02a8c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2690,6 +2690,13 @@
         MUST_BE_UNDEF(vlan_accept, "vlan-accept");
         MUST_BE_UNDEF(vlan_pvid, "vlan-pvid");
         MUST_BE_UNDEF(force_key_material_export, "force-key-material-expor=
t");
+
+        if (options->push_list.head)
+        {
+            msg(M_WARN, "Note: Using --push without --mode server is an "
+                        "unsupported configuration. Negotiation of OpenVPN=
 "
+                        "features is expected to fail.");
+        }
     }

     /*
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I82c7c61be07593ecd5bf2f854767dda74ab5170c
Gerrit-Change-Number: 1288
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--63A16WFY+dY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1288?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Warn if push is used without=
 --mode server/--server/--server-bridge<br><br>This is not a supported conf=
iguration and will often work good enough<br>to get a connection working bu=
t will operate more in a weird pre P2P<br>negotiation compatibility way rat=
her than actually negotiating<br>protocol features.<br><br>While at it, rem=
ove an unused macro (PUSH_DEFINED).<br><br>Change-Id: I82c7c61be07593ecd5bf=
2f854767dda74ab5170c<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;=
<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Gerrit URL: htt=
ps://gerrit.openvpn.net/c/openvpn/+/1288<br>Message-Id: &lt;20251023155614.=
20642-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-de=
vel@lists.sourceforge.net/msg33856.html<br>Signed-off-by: Gert Doering &lt;=
gert@...1296...&gt;<br>---<br>M doc/man-sections/server-options.rst<br>M sr=
c/openvpn/options.c<br>M src/openvpn/options.h<br>3 files changed, 10 inser=
tions(+), 5 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.o=
penvpn.net:29418/openvpn refs/changes/88/1288/3</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/ma=
n-sections/server-options.rst b/doc/man-sections/server-options.rst</span><=
br><span>index ccc1374..347a251 100644</span><br><span>--- a/doc/man-sectio=
ns/server-options.rst</span><br><span>+++ b/doc/man-sections/server-options=
.rst</span><br><span>@@ -497,6 +497,9 @@</span><br><span>   ``--echo``, ``-=
-comp-lzo``, ``--socket-flags``, ``--sndbuf``,</span><br><span>   ``--rcvbu=
f``, ``--session-timeout``</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  Note: using ``--push`` requires OpenVPN to run i=
n ``--mode server`` (or</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  using of one of `--server`, `--server-bridge` helper directives).</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --pus=
h-remove opt</span><br><span>   Selectively remove all ``--push`` options m=
atching &quot;opt&quot; from the option</span><br><span>   list for a clien=
t. ``opt`` is matched as a substring against the whole</span><br><span>diff=
 --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>inde=
x 65c6b3b..9c02a8c 100644</span><br><span>--- a/src/openvpn/options.c</span=
><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -2690,6 +2690,13 =
@@</span><br><span>         MUST_BE_UNDEF(vlan_accept, &quot;vlan-accept&qu=
ot;);</span><br><span>         MUST_BE_UNDEF(vlan_pvid, &quot;vlan-pvid&quo=
t;);</span><br><span>         MUST_BE_UNDEF(force_key_material_export, &quo=
t;force-key-material-export&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (options-&gt;push_list.head)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            msg(M_WARN, &quot;Note: Using --push without --mode serv=
er is an &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                    &quot;unsupported configuration. Negotiation of OpenVPN=
 &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
            &quot;features is expected to fail.&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span>=
<br><span> </span><br><span>     /*</span><br><span>diff --git a/src/openvp=
n/options.h b/src/openvpn/options.h</span><br><span>index 009904a..24253af =
100644</span><br><span>--- a/src/openvpn/options.h</span><br><span>+++ b/sr=
c/openvpn/options.h</span><br><span>@@ -768,16 +768,11 @@</span><br><span> =
#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE))</span><br><span=
> </span><br><span> #define PULL_DEFINED(opt) ((opt)-&gt;pull)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#define PUSH_DEFINED(opt) ((opt)-&=
gt;push_list)</span><br><span> </span><br><span> #ifndef PULL_DEFINED</span=
><br><span> #define PULL_DEFINED(opt) (false)</span><br><span> #endif</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef P=
USH_DEFINED</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PU=
SH_DEFINED(opt) (false)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> #ifdef _WIN32</span><br><span> #define ROUTE_OPTION_FLAGS(o) ((o)-&gt;=
route_method &amp; ROUTE_METHOD_MASK)</span><br><span> #else</span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1288?usp=3Demail">change 1288</a>. To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?us=
p=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1288?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I82c7c61be07593ecd5bf2f85476=
7dda74ab5170c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1288 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--63A16WFY+dY=--

