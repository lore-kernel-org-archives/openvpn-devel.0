From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 15 Nov 2023 15:14:31 +0000
In-Reply-To: <gerrit.1699611717000.Ie512544329a91fae15409cb18f29d8be617051a1@...2715...>
References: <gerrit.1699611717000.Ie512544329a91fae15409cb18f29d8be617051a1@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <5bd78b6e9ae942403f8b4c2c610a6989ab3b9b65-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="U32bQBlOlCg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: Warn if pushed
 options require DHCP
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

--U32bQBlOlCg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/424?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


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
(cherry picked from commit 85fc834b0229b87e466b4f60bd2618b2ecd27a5f)
---
M src/openvpn/options.c
M src/openvpn/tun.c
2 files changed, 10 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/424/5

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9502982..7ca77a8 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2485,10 +2485,10 @@

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
To view, visit http://gerrit.openvpn.net/c/openvpn/+/424?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: Ie512544329a91fae15409cb18f29d8be617051a1
Gerrit-Change-Number: 424
Gerrit-PatchSet: 5
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--U32bQBlOlCg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #5</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/424?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Warn if pushed options require DHCP<br><br>So=
me pushed options (such as DOMAIN-SEARCH) require DHCP server to work.<br><=
br>Warn user that such options will not work if the current driver (such<br=
>as dco-win) doesn&#39;t support DHCP.<br><br>Change-Id: Ie512544329a91fae1=
5409cb18f29d8be617051a1<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt=
;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &l=
t;20231115120656.6825-1-gert@...1296...&gt;<br>URL: https://www.mail-archiv=
e.com/openvpn-devel@lists.sourceforge.net/msg27403.html<br>Signed-off-by: G=
ert Doering &lt;gert@...1296...&gt;<br>(cherry picked from commit 85fc834b0=
229b87e466b4f60bd2618b2ecd27a5f)<br>---<br>M src/openvpn/options.c<br>M src=
/openvpn/tun.c<br>2 files changed, 10 insertions(+), 2 deletions(-)<br><br>=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/424/5</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br>=
<span>index 9502982..7ca77a8 100644</span><br><span>--- a/src/openvpn/optio=
ns.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -2485,1=
0 +2485,10 @@</span><br><span> </span><br><span>     if (options-&gt;tuntap=
_options.dhcp_options &amp; DHCP_OPTIONS_DHCP_REQUIRED)</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const char=
 *prefix =3D &quot;Some dhcp-options require DHCP server&quot;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        const char *prefix =3D =
&quot;Some --dhcp-option or --dns options require DHCP server&quot;;</span>=
<br><span>         if (options-&gt;windows_driver !=3D WINDOWS_DRIVER_TAP_W=
INDOWS6)</span><br><span>         {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            msg(M_USAGE, &quot;%s, which is not supported by =
selected %s driver&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            msg(M_USAGE, &quot;%s, which is not supported by the sele=
cted %s driver&quot;,</span><br><span>                 prefix, print_window=
s_driver(options-&gt;windows_driver));</span><br><span>         }</span><br=
><span>         else if (options-&gt;tuntap_options.ip_win32_type !=3D IPW3=
2_SET_DHCP_MASQ</span><br><span>diff --git a/src/openvpn/tun.c b/src/openvp=
n/tun.c</span><br><span>index f857ed1..82ab6c0 100644</span><br><span>--- a=
/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</span><br><span>=
@@ -6826,6 +6826,14 @@</span><br><span> open_tun(const char *dev, const cha=
r *dev_type, const char *dev_node, struct tuntap *tt,</span><br><span>     =
     openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if ((tt-&gt;options.dhcp_options &amp; DHCP=
_OPTIONS_DHCP_REQUIRED)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        &amp;&amp; tt-&gt;windows_driver !=3D WINDOWS_DRIVER_TAP_WINDOW=
S6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;Some=
 --dhcp-option or --dns options require DHCP server,&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            &quot; which is not supp=
orted by the selected %s driver. They will be&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &quot; ignored.&quot;, print_=
windows_driver(tt-&gt;windows_driver));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span>     /* dco-win already opened the device, which han=
dle we treat as socket */</span><br><span>     if (tuntap_is_dco_win(tt))</=
span><br><span>     {</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/424?usp=3Demail">change 424<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/424?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie512544329a91fae15409cb18f2=
9d8be617051a1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 424 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--U32bQBlOlCg=--

