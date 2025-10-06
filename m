From: "stipa (Code Review)" <gerrit@...515...>
Date: Mon, 6 Oct 2025 11:47:11 +0000
References: <gerrit.1759751230000.I9b099924286f9bccb6833e1e40606abe72714bbb@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3760325fb5282f5510d48b6ed3ac1cb16c2e66b4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CNTJ+ZJlw8c="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CNTJ+ZJlw8c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1248?usp=3Demail

to review the following change.


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

Change-Id: I9b099924286f9bccb6833e1e40606abe72714bbb
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/options.c
M src/openvpn/options.h
2 files changed, 9 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/48/1248/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9b099924286f9bccb6833e1e40606abe72714bbb
Gerrit-Change-Number: 1248
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--CNTJ+ZJlw8c=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1248?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Preserve ifconfig(_ipv6)_local across recon=
nect<br><br>Turns out that ifconfig_(ipv6)_local options are set once<br>an=
d are not reset on a reconnect.<br><br>Consider following scenario:<br><br>=
 - connect first time, server pushes ifconfig-ipv6<br> - add a ipv6 network=
 route because ifconfig_ipv6_local is set<br> - reconnect, server doesn&#39=
;t push ifconfig-ipv6<br><br>Because of ifconfig_ipv6_local is not reset an=
d holds the value<br>set by the first connect, client adds a ipv6 network r=
oute -<br>but this is wrong, since ipv6 wasn&#39;t pushed this time by the =
server.<br><br>Fix by saving/restoring ifconfig(_ipv6)_local in a<br>struct=
 options_pre_connect along with other options which<br>preserves the initia=
l values until --pull modifications<br>are applied.<br><br>Change-Id: I9b09=
9924286f9bccb6833e1e40606abe72714bbb<br>Signed-off-by: Lev Stipakov &lt;lev=
@...515...&gt;<br>---<br>M src/openvpn/options.c<br>M src/openvpn/options.h=
<br>2 files changed, 9 insertions(+), 0 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/48/1248/1=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><=
br><span>index f35738d..d1ce551 100644</span><br><span>--- a/src/openvpn/op=
tions.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -314=
3,6 +3143,9 @@</span><br><span>         o-&gt;pre_connect-&gt;client_nat_de=
fined =3D true;</span><br><span>     }</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    o-&gt;pre_connect-&gt;ifconfig_loc=
al =3D o-&gt;ifconfig_local;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    o-&gt;pre_connect-&gt;ifconfig_ipv6_local =3D o-&gt;ifconfig_i=
pv6_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span>     o-&gt;pre_connect-&gt;route_default_gateway =3D o-&gt;route_de=
fault_gateway;</span><br><span>     o-&gt;pre_connect-&gt;route_ipv6_defaul=
t_gateway =3D o-&gt;route_ipv6_default_gateway;</span><br><span> </span><br=
><span>@@ -3193,6 +3196,9 @@</span><br><span>             o-&gt;routes_ipv6=
 =3D NULL;</span><br><span>         }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        o-&gt;ifconfig_local =3D pp-&gt=
;ifconfig_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     o-&gt;ifconfig_ipv6_local =3D pp-&gt;ifconfig_ipv6_local;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         o-&gt;=
route_default_gateway =3D pp-&gt;route_default_gateway;</span><br><span>   =
      o-&gt;route_ipv6_default_gateway =3D pp-&gt;route_ipv6_default_gatewa=
y;</span><br><span> </span><br><span>diff --git a/src/openvpn/options.h b/s=
rc/openvpn/options.h</span><br><span>index b033068..445fd25 100644</span><b=
r><span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/openvpn/optio=
ns.h</span><br><span>@@ -64,6 +64,9 @@</span><br><span>     bool tuntap_opt=
ions_defined;</span><br><span>     struct tuntap_options tuntap_options;</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const char *ifconfig_local;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const char *ifconfig_ipv6_local;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span>     bool routes_defined;</span><=
br><span>     struct route_option_list *routes;</span><br><span> </span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1248?usp=3Demail">change 1248</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1248?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9b099924286f9bccb6833e1e406=
06abe72714bbb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1248 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
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

</body></html>=

--CNTJ+ZJlw8c=--

