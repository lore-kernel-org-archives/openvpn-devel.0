From: "stipa (Code Review)" <gerrit@...515...>
Date: Fri, 10 Nov 2023 10:22:01 +0000
References: <gerrit.1699611717000.I24f43ad319bd1ca530fe17442d02a97412eb75c7@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0cc2f4aee0de22a0a54cf7c9761de5de4cf1c819-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0yJGPxC43Qc="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]: Make --dns
 options apply for tap-windows6 driver
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

--0yJGPxC43Qc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/423?usp=3Demail

to review the following change.


Change subject: Make --dns options apply for tap-windows6 driver
......................................................................

Make --dns options apply for tap-windows6 driver

When tap-windows6 driver is used, both --dhcp-option and
--dns options are applied with DHCP. When processing --dns options,
we don't set "tuntap_options.dhcp_options" member, which is required
for DHCP string to be sent to the driver. As a result, --dns options
are not applied at all.

Fix by adding missing assignment of tuntap_options.dhcp_options.

Fixes https://github.com/OpenVPN/openvpn/issues/447

Change-Id: I24f43ad319bd1ca530fe17442d02a97412eb75c7
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/options.c
1 file changed, 6 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/423/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 631ac73..e793a96 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8014,6 +8014,9 @@
         if (streq(p[1], "search-domains") && p[2])
         {
             dns_domain_list_append(&options->dns_options.search_domains, &=
p[2], &options->dns_options.gc);
+#ifdef _WIN32
+            options->tuntap_options.dhcp_options |=3D DHCP_OPTIONS_DHCP_RE=
QUIRED;
+#endif
         }
         else if (streq(p[1], "server") && p[2] && p[3] && p[4])
         {
@@ -8090,6 +8093,9 @@
                 msg(msglevel, "--dns server %ld: unknown option type '%s' =
or missing or unknown parameter", priority, p[3]);
                 goto err;
             }
+#ifdef _WIN32
+            options->tuntap_options.dhcp_options |=3D DHCP_OPTIONS_DHCP_OP=
TIONAL;
+#endif
         }
         else
         {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/423?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I24f43ad319bd1ca530fe17442d02a97412eb75c7
Gerrit-Change-Number: 423
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--0yJGPxC43Qc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/423?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Make --dns options apply for tap-windows6 driver<br><br>When =
tap-windows6 driver is used, both --dhcp-option and<br>--dns options are ap=
plied with DHCP. When processing --dns options,<br>we don&#39;t set &quot;t=
untap_options.dhcp_options&quot; member, which is required<br>for DHCP stri=
ng to be sent to the driver. As a result, --dns options<br>are not applied =
at all.<br><br>Fix by adding missing assignment of tuntap_options.dhcp_opti=
ons.<br><br>Fixes https://github.com/OpenVPN/openvpn/issues/447<br><br>Chan=
ge-Id: I24f43ad319bd1ca530fe17442d02a97412eb75c7<br>Signed-off-by: Lev Stip=
akov &lt;lev@...515...&gt;<br>---<br>M src/openvpn/options.c<br>1 file chan=
ged, 6 insertions(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvp=
n.net:29418/openvpn refs/changes/23/423/1</pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/=
options.c b/src/openvpn/options.c</span><br><span>index 631ac73..e793a96 10=
0644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/=
openvpn/options.c</span><br><span>@@ -8014,6 +8014,9 @@</span><br><span>   =
      if (streq(p[1], &quot;search-domains&quot;) &amp;&amp; p[2])</span><b=
r><span>         {</span><br><span>             dns_domain_list_append(&amp=
;options-&gt;dns_options.search_domains, &amp;p[2], &amp;options-&gt;dns_op=
tions.gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef _W=
IN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            opt=
ions-&gt;tuntap_options.dhcp_options |=3D DHCP_OPTIONS_DHCP_REQUIRED;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>  =
       }</span><br><span>         else if (streq(p[1], &quot;server&quot;) =
&amp;&amp; p[2] &amp;&amp; p[3] &amp;&amp; p[4])</span><br><span>         {=
</span><br><span>@@ -8090,6 +8093,9 @@</span><br><span>                 msg=
(msglevel, &quot;--dns server %ld: unknown option type &#39;%s&#39; or miss=
ing or unknown parameter&quot;, priority, p[3]);</span><br><span>          =
       goto err;</span><br><span>             }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            options-&gt;tuntap_options.dhcp_options |=
=3D DHCP_OPTIONS_DHCP_OPTIONAL;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span>         }</span><br><span>         else=
</span><br><span>         {</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/423?usp=3Demail">chang=
e 423</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/423?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I24f43ad319bd1ca530fe17442d0=
2a97412eb75c7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 423 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--0yJGPxC43Qc=--

