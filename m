From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 9 Oct 2025 17:19:01 +0000
In-Reply-To: <gerrit.1759751230000.I9b099924286f9bccb6833e1e40606abe72714bbb@...2715...>
References: <gerrit.1759751230000.I9b099924286f9bccb6833e1e40606abe72714bbb@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <ade6bf3de4ce60c69826c0406a876c70ebf3d389-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hfGD/xE69PA="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Preserve
 ifconfig(_ipv6)_local across reconnect
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hfGD/xE69PA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos, stipa.

cron2 has uploaded a new patch set (#2) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/1248?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


Change subject: Preserve ifconfig(_ipv6)_local across reconnect
......................................................................

Preserve ifconfig(_ipv6)_local across reconnect

Turns out that ifconfig_(ipv6)_local options are set once
and are not reset on a reconnect.

Consider following scenario:

 - connect first time, server pushes ifconfig-ipv6
 - add a ipv6 network route because ifconfig_ipv6_local is set
 - reconnect, server doesn't push ifconfig-ipv6

Because of ifconfig_ipv6_local is not reset and holds the value
set by the first connect, client adds a ipv6 network route -
but this is wrong, since ipv6 wasn't pushed this time by the server.

Fix by saving/restoring ifconfig(_ipv6)_local in a
struct options_pre_connect along with other options which
preserves the initial values until --pull modifications
are applied.

Github: OpenVPN/openvpn#850
Change-Id: I9b099924286f9bccb6833e1e40606abe72714bbb
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/options.c
M src/openvpn/options.h
2 files changed, 9 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/48/1248/2

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f35738d..d1ce551 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3143,6 +3143,9 @@
         o->pre_connect->client_nat_defined =3D true;
     }

+    o->pre_connect->ifconfig_local =3D o->ifconfig_local;
+    o->pre_connect->ifconfig_ipv6_local =3D o->ifconfig_ipv6_local;
+
     o->pre_connect->route_default_gateway =3D o->route_default_gateway;
     o->pre_connect->route_ipv6_default_gateway =3D o->route_ipv6_default_g=
ateway;

@@ -3193,6 +3196,9 @@
             o->routes_ipv6 =3D NULL;
         }

+        o->ifconfig_local =3D pp->ifconfig_local;
+        o->ifconfig_ipv6_local =3D pp->ifconfig_ipv6_local;
+
         o->route_default_gateway =3D pp->route_default_gateway;
         o->route_ipv6_default_gateway =3D pp->route_ipv6_default_gateway;

diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index b033068..445fd25 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -64,6 +64,9 @@
     bool tuntap_options_defined;
     struct tuntap_options tuntap_options;

+    const char *ifconfig_local;
+    const char *ifconfig_ipv6_local;
+
     bool routes_defined;
     struct route_option_list *routes;


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1248?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9b099924286f9bccb6833e1e40606abe72714bbb
Gerrit-Change-Number: 1248
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>

--hfGD/xE69PA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos, stipa. </p>
<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1248=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by cron2</p><p>The change is no longer submittable: Code-Revi=
ew and checks~ChecksSubmitRule are unsatisfied now.</p><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Preser=
ve ifconfig(_ipv6)_local across reconnect<br><br>Turns out that ifconfig_(i=
pv6)_local options are set once<br>and are not reset on a reconnect.<br><br=
>Consider following scenario:<br><br> - connect first time, server pushes i=
fconfig-ipv6<br> - add a ipv6 network route because ifconfig_ipv6_local is =
set<br> - reconnect, server doesn&#39;t push ifconfig-ipv6<br><br>Because o=
f ifconfig_ipv6_local is not reset and holds the value<br>set by the first =
connect, client adds a ipv6 network route -<br>but this is wrong, since ipv=
6 wasn&#39;t pushed this time by the server.<br><br>Fix by saving/restoring=
 ifconfig(_ipv6)_local in a<br>struct options_pre_connect along with other =
options which<br>preserves the initial values until --pull modifications<br=
>are applied.<br><br>Github: OpenVPN/openvpn#850<br>Change-Id: I9b099924286=
f9bccb6833e1e40606abe72714bbb<br>Signed-off-by: Lev Stipakov &lt;lev@...2146...=
...&gt;<br>---<br>M src/openvpn/options.c<br>M src/openvpn/options.h<br>2 f=
iles changed, 9 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/48/1248/2</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><spa=
n>index f35738d..d1ce551 100644</span><br><span>--- a/src/openvpn/options.c=
</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -3143,6 +31=
43,9 @@</span><br><span>         o-&gt;pre_connect-&gt;client_nat_defined =
=3D true;</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    o-&gt;pre_connect-&gt;ifconfig_local =3D=
 o-&gt;ifconfig_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    o-&gt;pre_connect-&gt;ifconfig_ipv6_local =3D o-&gt;ifconfig_ipv6_lo=
cal;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n>     o-&gt;pre_connect-&gt;route_default_gateway =3D o-&gt;route_default_=
gateway;</span><br><span>     o-&gt;pre_connect-&gt;route_ipv6_default_gate=
way =3D o-&gt;route_ipv6_default_gateway;</span><br><span> </span><br><span=
>@@ -3193,6 +3196,9 @@</span><br><span>             o-&gt;routes_ipv6 =3D N=
ULL;</span><br><span>         }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        o-&gt;ifconfig_local =3D pp-&gt;ifcon=
fig_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o=
-&gt;ifconfig_ipv6_local =3D pp-&gt;ifconfig_ipv6_local;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         o-&gt;route_=
default_gateway =3D pp-&gt;route_default_gateway;</span><br><span>         =
o-&gt;route_ipv6_default_gateway =3D pp-&gt;route_ipv6_default_gateway;</sp=
an><br><span> </span><br><span>diff --git a/src/openvpn/options.h b/src/ope=
nvpn/options.h</span><br><span>index b033068..445fd25 100644</span><br><spa=
n>--- a/src/openvpn/options.h</span><br><span>+++ b/src/openvpn/options.h</=
span><br><span>@@ -64,6 +64,9 @@</span><br><span>     bool tuntap_options_d=
efined;</span><br><span>     struct tuntap_options tuntap_options;</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
char *ifconfig_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const char *ifconfig_ipv6_local;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span>     bool routes_defined;</span><br><sp=
an>     struct route_option_list *routes;</span><br><span> </span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1248?usp=3Demail">change 1248</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1248?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9b099924286f9bccb6833e1e406=
06abe72714bbb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1248 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>

</body></html>=

--hfGD/xE69PA=--

