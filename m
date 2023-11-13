From: "stipa (Code Review)" <gerrit@...515...>
Date: Mon, 13 Nov 2023 12:12:57 +0000
In-Reply-To: <gerrit.1699611717000.Ie512544329a91fae15409cb18f29d8be617051a1@...2715...>
References: <gerrit.1699611717000.Ie512544329a91fae15409cb18f29d8be617051a1@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <8bf97b9686659f11a41ff259ffdad7076dc99543-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hWE+GUlkAY0="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hWE+GUlkAY0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/424?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: Warn if pushed options require DHCP
......................................................................

Warn if pushed options require DHCP

Some pushed options (such as DOMAIN-SEARCH) require
DHCP server to work. Warn user that some options
will not work if the current driver (such as dco-win)
doesn't support DHCP.

Change-Id: Ie512544329a91fae15409cb18f29d8be617051a1
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/options.c
M src/openvpn/tun.c
2 files changed, 9 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/424/3

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f8d0b2e..82b4f3e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2486,10 +2486,10 @@

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
index f857ed1..1b79d42 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -6826,6 +6826,13 @@
 open_tun(const char *dev, const char *dev_type, const char *dev_node, stru=
ct tuntap *tt,
          openvpn_net_ctx_t *ctx)
 {
+    if ((tt->options.dhcp_options & DHCP_OPTIONS_DHCP_REQUIRED)
+        && tt->windows_driver !=3D WINDOWS_DRIVER_TAP_WINDOWS6)
+    {
+        msg(M_WARN, "Some --dhcp-option or --dns options require DHCP serv=
er, which is not supported by the selected %s driver. They will be ignored.=
",
+            print_windows_driver(tt->windows_driver));
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
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--hWE+GUlkAY0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, stipa. <=
/p>
<p>stipa <strong>uploaded patch set #3</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/424?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Warn if pushed options require DHCP<br><br>So=
me pushed options (such as DOMAIN-SEARCH) require<br>DHCP server to work. W=
arn user that some options<br>will not work if the current driver (such as =
dco-win)<br>doesn&#39;t support DHCP.<br><br>Change-Id: Ie512544329a91fae15=
409cb18f29d8be617051a1<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;=
<br>---<br>M src/openvpn/options.c<br>M src/openvpn/tun.c<br>2 files change=
d, 9 insertions(+), 2 deletions(-)<br><br></pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.=
net:29418/openvpn refs/changes/24/424/3</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/op=
tions.c b/src/openvpn/options.c</span><br><span>index f8d0b2e..82b4f3e 1006=
44</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/op=
envpn/options.c</span><br><span>@@ -2486,10 +2486,10 @@</span><br><span> </=
span><br><span>     if (options-&gt;tuntap_options.dhcp_options &amp; DHCP_=
OPTIONS_DHCP_REQUIRED)</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        const char *prefix =3D &quot;Some dhcp-opti=
ons require DHCP server&quot;;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        const char *prefix =3D &quot;Some --dhcp-option or --dns=
 options require DHCP server&quot;;</span><br><span>         if (options-&g=
t;windows_driver !=3D WINDOWS_DRIVER_TAP_WINDOWS6)</span><br><span>        =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_U=
SAGE, &quot;%s, which is not supported by selected %s driver&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_USAGE, &q=
uot;%s, which is not supported by the selected %s driver&quot;,</span><br><=
span>                 prefix, print_windows_driver(options-&gt;windows_driv=
er));</span><br><span>         }</span><br><span>         else if (options-=
&gt;tuntap_options.ip_win32_type !=3D IPW32_SET_DHCP_MASQ</span><br><span>d=
iff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index f85=
7ed1..1b79d42 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><spa=
n>+++ b/src/openvpn/tun.c</span><br><span>@@ -6826,6 +6826,13 @@</span><br>=
<span> open_tun(const char *dev, const char *dev_type, const char *dev_node=
, struct tuntap *tt,</span><br><span>          openvpn_net_ctx_t *ctx)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f ((tt-&gt;options.dhcp_options &amp; DHCP_OPTIONS_DHCP_REQUIRED)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; tt-&gt;win=
dows_driver !=3D WINDOWS_DRIVER_TAP_WINDOWS6)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        msg(M_WARN, &quot;Some --dhcp-option or --dns options r=
equire DHCP server, which is not supported by the selected %s driver. They =
will be ignored.&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            print_windows_driver(tt-&gt;windows_driver));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span>     /* dco-win already opened=
 the device, which handle we treat as socket */</span><br><span>     if (tu=
ntap_is_dco_win(tt))</span><br><span>     {</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/424?us=
p=3Demail">change 424</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/424?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie512544329a91fae15409cb18f2=
9d8be617051a1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 424 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--hWE+GUlkAY0=--

