From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 5 Apr 2026 10:23:35 +0000
In-Reply-To: <gerrit.1775321000000.I46499ff1f40dbdb94b84d58d17457d0ccdd75288@...2715...>
References: <gerrit.1775321000000.I46499ff1f40dbdb94b84d58d17457d0ccdd75288@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <770d2f72c152c72a8ed8f42ca920aca4361311d4-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WfO0Iu4A7Hc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Remove various
 unused structs
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

--WfO0Iu4A7Hc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1607?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Remove various unused structs
......................................................................

Remove various unused structs

Change-Id: I46499ff1f40dbdb94b84d58d17457d0ccdd75288
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1607
Message-Id: <20260404203615.30863-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
468.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/mtcp.c
M src/openvpn/multi_io.c
M src/openvpn/networking_sitnl.c
M src/openvpn/route.c
4 files changed, 0 insertions(+), 31 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/07/1607/2

diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index b7bef46..2eab7b7 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -37,14 +37,6 @@
 #include <sys/inotify.h>
 #endif

-struct ta_iow_flags
-{
-    unsigned int flags;
-    unsigned int ret;
-    unsigned int tun;
-    unsigned int sock;
-};
-
 struct multi_instance *
 multi_create_instance_tcp(struct multi_context *m, struct link_socket *soc=
k)
 {
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index f484fe2..e6f4e9c 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -46,14 +46,6 @@
 #define MULTI_IO_FILE_CLOSE_WRITE ((void *)5)
 #define MULTI_IO_DCO              ((void *)6)

-struct ta_iow_flags
-{
-    unsigned int flags;
-    unsigned int ret;
-    unsigned int tun;
-    unsigned int sock;
-};
-
 #ifdef ENABLE_DEBUG
 static const char *
 pract(int action)
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index b88f03c..baf6f89 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -124,15 +124,6 @@
 typedef int (*sitnl_parse_reply_cb)(struct nlmsghdr *msg, void *arg);

 /**
- * Object returned by route request operation
- */
-struct sitnl_route_data_cb
-{
-    unsigned int iface;
-    inet_address_t gw;
-};
-
-/**
  * Helper function used to easily add attributes to a rtnl message
  */
 static int
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 1cfbf80..3b18f74 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3257,12 +3257,6 @@
  * netlink(3), netlink(7), rtnetlink(7)
  * https://www.virtualbox.org/svn/vbox/trunk/src/VBox/NetworkServices/NAT/
  */
-struct rtreq
-{
-    struct nlmsghdr nh;
-    struct rtmsg rtm;
-    char attrbuf[512];
-};

 void
 get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6, const struc=
t in6_addr *dest,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1607?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I46499ff1f40dbdb94b84d58d17457d0ccdd75288
Gerrit-Change-Number: 1607
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--WfO0Iu4A7Hc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1607?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Remove various unused structs<br><b=
r>Change-Id: I46499ff1f40dbdb94b84d58d17457d0ccdd75288<br>Signed-off-by: Fr=
ank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert=
@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1607<=
br>Message-Id: &lt;20260404203615.30863-1-gert@...1296...&gt;<br>URL: https=
://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36468.html<b=
r>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openv=
pn/mtcp.c<br>M src/openvpn/multi_io.c<br>M src/openvpn/networking_sitnl.c<b=
r>M src/openvpn/route.c<br>4 files changed, 0 insertions(+), 31 deletions(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvp=
n refs/changes/07/1607/2</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mtcp.c b/src/open=
vpn/mtcp.c</span><br><span>index b7bef46..2eab7b7 100644</span><br><span>--=
- a/src/openvpn/mtcp.c</span><br><span>+++ b/src/openvpn/mtcp.c</span><br><=
span>@@ -37,14 +37,6 @@</span><br><span> #include &lt;sys/inotify.h&gt;</sp=
an><br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-struct ta_iow_flags</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    u=
nsigned int flags;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 unsigned int ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 unsigned int tun;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 unsigned int sock;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> str=
uct multi_instance *</span><br><span> multi_create_instance_tcp(struct mult=
i_context *m, struct link_socket *sock)</span><br><span> {</span><br><span>=
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c</span><br><spa=
n>index f484fe2..e6f4e9c 100644</span><br><span>--- a/src/openvpn/multi_io.=
c</span><br><span>+++ b/src/openvpn/multi_io.c</span><br><span>@@ -46,14 +4=
6,6 @@</span><br><span> #define MULTI_IO_FILE_CLOSE_WRITE ((void *)5)</span=
><br><span> #define MULTI_IO_DCO              ((void *)6)</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct ta_iow_flags</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    unsigned int flags;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    unsigned int ret;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    unsigned int tun;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    unsigned int sock;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span> #ifdef ENABLE_DEBUG</span><br><span> stat=
ic const char *</span><br><span> pract(int action)</span><br><span>diff --g=
it a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c</span>=
<br><span>index b88f03c..baf6f89 100644</span><br><span>--- a/src/openvpn/n=
etworking_sitnl.c</span><br><span>+++ b/src/openvpn/networking_sitnl.c</spa=
n><br><span>@@ -124,15 +124,6 @@</span><br><span> typedef int (*sitnl_parse=
_reply_cb)(struct nlmsghdr *msg, void *arg);</span><br><span> </span><br><s=
pan> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Object ret=
urned by route request operation</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct =
sitnl_route_data_cb</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int iface=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    inet_address_t g=
w;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-/**</span><br><span>  * Helper function used to easily add =
attributes to a rtnl message</span><br><span>  */</span><br><span> static i=
nt</span><br><span>diff --git a/src/openvpn/route.c b/src/openvpn/route.c</=
span><br><span>index 1cfbf80..3b18f74 100644</span><br><span>--- a/src/open=
vpn/route.c</span><br><span>+++ b/src/openvpn/route.c</span><br><span>@@ -3=
257,12 +3257,6 @@</span><br><span>  * netlink(3), netlink(7), rtnetlink(7)<=
/span><br><span>  * https://www.virtualbox.org/svn/vbox/trunk/src/VBox/Netw=
orkServices/NAT/</span><br><span>  */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-struct rtreq</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct nl=
msghdr nh;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct =
rtmsg rtm;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char at=
trbuf[512];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><=
br><span> </span><br><span> void</span><br><span> get_default_gateway_ipv6(=
struct route_ipv6_gateway_info *rgi6, const struct in6_addr *dest,</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1607?usp=3Demail">change 1607</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1607?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I46499ff1f40dbdb94b84d58d174=
57d0ccdd75288 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1607 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--WfO0Iu4A7Hc=--

