From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 27 Aug 2025 19:00:10 +0000
In-Reply-To: <gerrit.1753360288000.Ib7f78abbcd52c00a32afdea36ef635681ac8e127@...2715...>
References: <gerrit.1753360288000.Ib7f78abbcd52c00a32afdea36ef635681ac8e127@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5af193483956386acc914019d3fac99face9d6e2-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DgRmrw0vvvo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: route: Make sure
 various route flags are treated as unsigned
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DgRmrw0vvvo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#10) to the change originally created b=
y flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1109?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: route: Make sure various route flags are treated as unsigned
......................................................................

route: Make sure various route flags are treated as unsigned

The variables that hold them are already unsigned, make sure
the flags are as well to avoid spurious conversion warnings.

Change-Id: Ib7f78abbcd52c00a32afdea36ef635681ac8e127
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20250826183902.21252-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
684.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/route.h
1 file changed, 14 insertions(+), 14 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/09/1109/10

diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index ea8b767..9b6a47e 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -83,14 +83,14 @@
 };
=20
 /* redirect-gateway flags */
-#define RG_ENABLE      (1 << 0)
-#define RG_LOCAL       (1 << 1)
-#define RG_DEF1        (1 << 2)
-#define RG_BYPASS_DHCP (1 << 3)
-#define RG_BYPASS_DNS  (1 << 4)
-#define RG_REROUTE_GW  (1 << 5)
-#define RG_AUTO_LOCAL  (1 << 6)
-#define RG_BLOCK_LOCAL (1 << 7)
+#define RG_ENABLE      (1u << 0)
+#define RG_LOCAL       (1u << 1)
+#define RG_DEF1        (1u << 2)
+#define RG_BYPASS_DHCP (1u << 3)
+#define RG_BYPASS_DNS  (1u << 4)
+#define RG_REROUTE_GW  (1u << 5)
+#define RG_AUTO_LOCAL  (1u << 6)
+#define RG_BLOCK_LOCAL (1u << 7)

 struct route_option_list
 {
@@ -117,9 +117,9 @@

 struct route_ipv4
 {
-#define RT_DEFINED        (1 << 0)
-#define RT_ADDED          (1 << 1)
-#define RT_METRIC_DEFINED (1 << 2)
+#define RT_DEFINED        (1u << 0)
+#define RT_ADDED          (1u << 1)
+#define RT_METRIC_DEFINED (1u << 2)
     struct route_ipv4 *next;
     unsigned int flags;
     const struct route_option *option;
@@ -227,9 +227,9 @@

 struct route_list
 {
-#define RL_DID_REDIRECT_DEFAULT_GATEWAY (1 << 0)
-#define RL_DID_LOCAL                    (1 << 1)
-#define RL_ROUTES_ADDED                 (1 << 2)
+#define RL_DID_REDIRECT_DEFAULT_GATEWAY (1u << 0)
+#define RL_DID_LOCAL                    (1u << 1)
+#define RL_ROUTES_ADDED                 (1u << 2)
     unsigned int iflags;

     struct route_special_addr spec;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1109?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib7f78abbcd52c00a32afdea36ef635681ac8e127
Gerrit-Change-Number: 1109
Gerrit-PatchSet: 10
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--DgRmrw0vvvo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #10</strong> to the change originally c=
reated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1109?usp=3Demail">View Change</a></p><p>The following approvals got out=
dated and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">route: Make sure various route flags are treated=
 as unsigned<br><br>The variables that hold them are already unsigned, make=
 sure<br>the flags are as well to avoid spurious conversion warnings.<br><b=
r>Change-Id: Ib7f78abbcd52c00a32afdea36ef635681ac8e127<br>Signed-off-by: Fr=
ank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne=
-openvpn@...1227...&gt;<br>Message-Id: &lt;20250826183902.21252-1-gert@...1386...=
296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1535...=
orge.net/msg32684.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&g=
t;<br>---<br>M src/openvpn/route.h<br>1 file changed, 14 insertions(+), 14 =
deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs=
/changes/09/1109/10</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/route.h b/src/openvpn/=
route.h</span><br><span>index ea8b767..9b6a47e 100644</span><br><span>--- a=
/src/openvpn/route.h</span><br><span>+++ b/src/openvpn/route.h</span><br><s=
pan>@@ -83,14 +83,14 @@</span><br><span> };</span><br><span> </span><br><sp=
an> /* redirect-gateway flags */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define RG_ENABLE      (1 &lt;&lt; 0)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#define RG_LOCAL       (1 &lt;&lt; 1)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#define RG_DEF1        (1 &lt;&l=
t; 2)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define RG_BYPAS=
S_DHCP (1 &lt;&lt; 3)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define RG_BYPASS_DNS  (1 &lt;&lt; 4)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define RG_REROUTE_GW  (1 &lt;&lt; 5)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define RG_AUTO_LOCAL  (1 &lt;&lt; 6)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define RG_BLOCK_LOCAL (1 &=
lt;&lt; 7)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define R=
G_ENABLE      (1u &lt;&lt; 0)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define RG_LOCAL       (1u &lt;&lt; 1)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define RG_DEF1        (1u &lt;&lt; 2)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define RG_BYPASS_DHCP (1u =
&lt;&lt; 3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
RG_BYPASS_DNS  (1u &lt;&lt; 4)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define RG_REROUTE_GW  (1u &lt;&lt; 5)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define RG_AUTO_LOCAL  (1u &lt;&lt; 6)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define RG_BLOCK_LOCAL (1u=
 &lt;&lt; 7)</span><br><span> </span><br><span> struct route_option_list</s=
pan><br><span> {</span><br><span>@@ -117,9 +117,9 @@</span><br><span> </spa=
n><br><span> struct route_ipv4</span><br><span> {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define RT_DEFINED        (1 &lt;&lt; 0)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define RT_ADDED          (1=
 &lt;&lt; 1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define R=
T_METRIC_DEFINED (1 &lt;&lt; 2)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define RT_DEFINED        (1u &lt;&lt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define RT_ADDED          (1u &lt;&lt; 1)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define RT_METRIC_D=
EFINED (1u &lt;&lt; 2)</span><br><span>     struct route_ipv4 *next;</span>=
<br><span>     unsigned int flags;</span><br><span>     const struct route_=
option *option;</span><br><span>@@ -227,9 +227,9 @@</span><br><span> </span=
><br><span> struct route_list</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#define RL_DID_REDIRECT_DEFAULT_GATEWAY (1 &lt;&=
lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define RL_DID_=
LOCAL                    (1 &lt;&lt; 1)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#define RL_ROUTES_ADDED                 (1 &lt;&lt; 2)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define RL_DID_REDIREC=
T_DEFAULT_GATEWAY (1u &lt;&lt; 0)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define RL_DID_LOCAL                    (1u &lt;&lt; 1)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define RL_ROUTES_ADDED  =
               (1u &lt;&lt; 2)</span><br><span>     unsigned int iflags;</s=
pan><br><span> </span><br><span>     struct route_special_addr spec;</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1109?usp=3Demail">change 1109</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1109?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib7f78abbcd52c00a32afdea36ef=
635681ac8e127 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1109 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--DgRmrw0vvvo=--

