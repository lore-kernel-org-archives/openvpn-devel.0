From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 24 Jul 2025 12:31:46 +0000
References: <gerrit.1753360288000.Ib7f78abbcd52c00a32afdea36ef635681ac8e127@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <71b0024a5a88209dcbac0f3d010df509d4d182c8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Feu14/6BnYM="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Feu14/6BnYM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1109?usp=3Demail

to review the following change.


Change subject: route: Make sure various route flags are treated as unsigned
......................................................................

route: Make sure various route flags are treated as unsigned

The variables that hold them are already unsigned, make sure
the flags are as well to avoid spurious conversion warnings.

Change-Id: Ib7f78abbcd52c00a32afdea36ef635681ac8e127
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/route.h
1 file changed, 14 insertions(+), 14 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/09/1109/1

diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 237375c..f015a12 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -83,14 +83,14 @@
 };

 /* redirect-gateway flags */
-#define RG_ENABLE         (1<<0)
-#define RG_LOCAL          (1<<1)
-#define RG_DEF1           (1<<2)
-#define RG_BYPASS_DHCP    (1<<3)
-#define RG_BYPASS_DNS     (1<<4)
-#define RG_REROUTE_GW     (1<<5)
-#define RG_AUTO_LOCAL     (1<<6)
-#define RG_BLOCK_LOCAL    (1<<7)
+#define RG_ENABLE         (1u<<0)
+#define RG_LOCAL          (1u<<1)
+#define RG_DEF1           (1u<<2)
+#define RG_BYPASS_DHCP    (1u<<3)
+#define RG_BYPASS_DNS     (1u<<4)
+#define RG_REROUTE_GW     (1u<<5)
+#define RG_AUTO_LOCAL     (1u<<6)
+#define RG_BLOCK_LOCAL    (1u<<7)
=20
 struct route_option_list {
     unsigned int flags; /* RG_x flags */
@@ -113,9 +113,9 @@
 };

 struct route_ipv4 {
-#define RT_DEFINED        (1<<0)
-#define RT_ADDED          (1<<1)
-#define RT_METRIC_DEFINED (1<<2)
+#define RT_DEFINED        (1u<<0)
+#define RT_ADDED          (1u<<1)
+#define RT_METRIC_DEFINED (1u<<2)
     struct route_ipv4 *next;
     unsigned int flags;
     const struct route_option *option;
@@ -216,9 +216,9 @@
 };

 struct route_list {
-#define RL_DID_REDIRECT_DEFAULT_GATEWAY (1<<0)
-#define RL_DID_LOCAL                    (1<<1)
-#define RL_ROUTES_ADDED                 (1<<2)
+#define RL_DID_REDIRECT_DEFAULT_GATEWAY (1u<<0)
+#define RL_DID_LOCAL                    (1u<<1)
+#define RL_ROUTES_ADDED                 (1u<<2)
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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--Feu14/6BnYM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1109?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">route: Make sure various route flags are treated as unsigned=
<br><br>The variables that hold them are already unsigned, make sure<br>the=
 flags are as well to avoid spurious conversion warnings.<br><br>Change-Id:=
 Ib7f78abbcd52c00a32afdea36ef635681ac8e127<br>Signed-off-by: Frank Lichtenh=
eld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/route.h<br>1 file chan=
ged, 14 insertions(+), 14 deletions(-)<br><br></pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.open=
vpn.net:29418/openvpn refs/changes/09/1109/1</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/route.h b/src/openvpn/route.h</span><br><span>index 237375c..f015a12 100=
644</span><br><span>--- a/src/openvpn/route.h</span><br><span>+++ b/src/ope=
nvpn/route.h</span><br><span>@@ -83,14 +83,14 @@</span><br><span> };</span>=
<br><span> </span><br><span> /* redirect-gateway flags */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#define RG_ENABLE         (1&lt;&lt;0)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define RG_LOCAL      =
    (1&lt;&lt;1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defi=
ne RG_DEF1           (1&lt;&lt;2)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#define RG_BYPASS_DHCP    (1&lt;&lt;3)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define RG_BYPASS_DNS     (1&lt;&lt;4)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#define RG_REROUTE_GW     (1&=
lt;&lt;5)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define RG_A=
UTO_LOCAL     (1&lt;&lt;6)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#define RG_BLOCK_LOCAL    (1&lt;&lt;7)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define RG_ENABLE         (1u&lt;&lt;0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define RG_LOCAL          (1u&l=
t;&lt;1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define RG_=
DEF1           (1u&lt;&lt;2)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define RG_BYPASS_DHCP    (1u&lt;&lt;3)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define RG_BYPASS_DNS     (1u&lt;&lt;4)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define RG_REROUTE_GW     =
(1u&lt;&lt;5)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e RG_AUTO_LOCAL     (1u&lt;&lt;6)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define RG_BLOCK_LOCAL    (1u&lt;&lt;7)</span><br><span> </sp=
an><br><span> struct route_option_list {</span><br><span>     unsigned int =
flags; /* RG_x flags */</span><br><span>@@ -113,9 +113,9 @@</span><br><span=
> };</span><br><span> </span><br><span> struct route_ipv4 {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define RT_DEFINED        (1&lt;&lt;0=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define RT_ADDED    =
      (1&lt;&lt;1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#de=
fine RT_METRIC_DEFINED (1&lt;&lt;2)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define RT_DEFINED        (1u&lt;&lt;0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define RT_ADDED          (1u&lt;&lt;1)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define RT_METRIC_D=
EFINED (1u&lt;&lt;2)</span><br><span>     struct route_ipv4 *next;</span><b=
r><span>     unsigned int flags;</span><br><span>     const struct route_op=
tion *option;</span><br><span>@@ -216,9 +216,9 @@</span><br><span> };</span=
><br><span> </span><br><span> struct route_list {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define RL_DID_REDIRECT_DEFAULT_GATEWAY (1&lt;&=
lt;0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define RL_DID_L=
OCAL                    (1&lt;&lt;1)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define RL_ROUTES_ADDED                 (1&lt;&lt;2)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define RL_DID_REDIRECT_DEF=
AULT_GATEWAY (1u&lt;&lt;0)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define RL_DID_LOCAL                    (1u&lt;&lt;1)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define RL_ROUTES_ADDED           =
      (1u&lt;&lt;2)</span><br><span>     unsigned int iflags;</span><br><sp=
an> </span><br><span>     struct route_special_addr spec;</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1109?usp=3Demail">change 1109</a>. To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">sett=
ings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1109?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib7f78abbcd52c00a32afdea36ef=
635681ac8e127 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1109 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--Feu14/6BnYM=--

