From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 15 Nov 2023 15:14:35 +0000
In-Reply-To: <gerrit.1699891289000.Ie512544329a91fae15409cb18f29d8be617051a1@...2715...>
References: <gerrit.1699891289000.Ie512544329a91fae15409cb18f29d8be617051a1@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <6548933e23a2a06e7d24c055644a5e5c0827c6df-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1yMjbyUzUjU="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Warn if pushed
 options require DHCP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--1yMjbyUzUjU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/42=
8?usp=3Demail )

Change subject: Warn if pushed options require DHCP
......................................................................

Warn if pushed options require DHCP

Some pushed options (such as DOMAIN-SEARCH) require DHCP server to work.

Warn user that such options will not work if the current driver (such
as dco-win) doesn't support DHCP.

Change-Id: Ie512544329a91fae15409cb18f29d8be617051a1
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20231115120656.6825-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
403.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
M src/openvpn/tun.c
2 files changed, 10 insertions(+), 2 deletions(-)




diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index bd731ff..2594b66 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2476,10 +2476,10 @@

     if (options->tuntap_options.dhcp_options & DHCP_OPTIONS_DHCP_REQUIRED)
     {
-        const char *prefix =3D "Some dhcp-options require DHCP server";
+        const char *prefix =3D "Some --dhcp-option or --dns options requir=
e DHCP server";
         if (options->windows_driver !=3D WINDOWS_DRIVER_TAP_WINDOWS6)
         {
-            msg(M_USAGE, "%s, which is not supported by selected %s driver=
",
+            msg(M_USAGE, "%s, which is not supported by the selected %s dr=
iver",
                 prefix, print_windows_driver(options->windows_driver));
         }
         else if (options->tuntap_options.ip_win32_type !=3D IPW32_SET_DHCP=
_MASQ
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index f857ed1..82ab6c0 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -6826,6 +6826,14 @@
 open_tun(const char *dev, const char *dev_type, const char *dev_node, stru=
ct tuntap *tt,
          openvpn_net_ctx_t *ctx)
 {
+    if ((tt->options.dhcp_options & DHCP_OPTIONS_DHCP_REQUIRED)
+        && tt->windows_driver !=3D WINDOWS_DRIVER_TAP_WINDOWS6)
+    {
+        msg(M_WARN, "Some --dhcp-option or --dns options require DHCP serv=
er,"
+            " which is not supported by the selected %s driver. They will =
be"
+            " ignored.", print_windows_driver(tt->windows_driver));
+    }
+
     /* dco-win already opened the device, which handle we treat as socket =
*/
     if (tuntap_is_dco_win(tt))
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/428?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie512544329a91fae15409cb18f29d8be617051a1
Gerrit-Change-Number: 428
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--1yMjbyUzUjU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/428?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Warn if pushed options require DHCP<br><br>Som=
e pushed options (such as DOMAIN-SEARCH) require DHCP server to work.<br><b=
r>Warn user that such options will not work if the current driver (such<br>=
as dco-win) doesn&#39;t support DHCP.<br><br>Change-Id: Ie512544329a91fae15=
409cb18f29d8be617051a1<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;=
<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt=
;20231115120656.6825-1-gert@...1296...&gt;<br>URL: https://www.mail-archive=
.com/openvpn-devel@lists.sourceforge.net/msg27403.html<br>Signed-off-by: Ge=
rt Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/options.c<br>M s=
rc/openvpn/tun.c<br>2 files changed, 10 insertions(+), 2 deletions(-)<br><b=
r></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><sp=
an>index bd731ff..2594b66 100644</span><br><span>--- a/src/openvpn/options.=
c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -2476,10 +=
2476,10 @@</span><br><span> </span><br><span>     if (options-&gt;tuntap_op=
tions.dhcp_options &amp; DHCP_OPTIONS_DHCP_REQUIRED)</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const char *p=
refix =3D &quot;Some dhcp-options require DHCP server&quot;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        const char *prefix =3D &qu=
ot;Some --dhcp-option or --dns options require DHCP server&quot;;</span><br=
><span>         if (options-&gt;windows_driver !=3D WINDOWS_DRIVER_TAP_WIND=
OWS6)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            msg(M_USAGE, &quot;%s, which is not supported by sel=
ected %s driver&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            msg(M_USAGE, &quot;%s, which is not supported by the selecte=
d %s driver&quot;,</span><br><span>                 prefix, print_windows_d=
river(options-&gt;windows_driver));</span><br><span>         }</span><br><s=
pan>         else if (options-&gt;tuntap_options.ip_win32_type !=3D IPW32_S=
ET_DHCP_MASQ</span><br><span>diff --git a/src/openvpn/tun.c b/src/openvpn/t=
un.c</span><br><span>index f857ed1..82ab6c0 100644</span><br><span>--- a/sr=
c/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ =
-6826,6 +6826,14 @@</span><br><span> open_tun(const char *dev, const char *=
dev_type, const char *dev_node, struct tuntap *tt,</span><br><span>        =
  openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if ((tt-&gt;options.dhcp_options &amp; DHCP_OP=
TIONS_DHCP_REQUIRED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        &amp;&amp; tt-&gt;windows_driver !=3D WINDOWS_DRIVER_TAP_WINDOWS6)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;Some --=
dhcp-option or --dns options require DHCP server,&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            &quot; which is not support=
ed by the selected %s driver. They will be&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            &quot; ignored.&quot;, print_windo=
ws_driver(tt-&gt;windows_driver));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span>     /* dco-win already opened the device, which handle w=
e treat as socket */</span><br><span>     if (tuntap_is_dco_win(tt))</span>=
<br><span>     {</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/428?usp=3Demail">change 428</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/428?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie512544329a91fae15409cb18f2=
9d8be617051a1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 428 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--1yMjbyUzUjU=--

