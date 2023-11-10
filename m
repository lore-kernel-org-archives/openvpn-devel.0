From: "stipa (Code Review)" <gerrit@...515...>
Date: Fri, 10 Nov 2023 17:29:03 +0000
In-Reply-To: <gerrit.1699611717000.I24f43ad319bd1ca530fe17442d02a97412eb75c7@...2715...>
References: <gerrit.1699611717000.I24f43ad319bd1ca530fe17442d02a97412eb75c7@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b22a642013c4b4899a4267eafe8bf62c550833c8-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="on8knyEOu+c="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, d12fk <heiko@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--on8knyEOu+c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos, stipa.

Hello d12fk, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/423?usp=3Demail

to look at the new patch set (#2).


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
1 file changed, 3 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/423/2

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 631ac73..f8d0b2e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1372,6 +1372,8 @@
         {
             msg(M_WARN, "WARNING: couldn't copy all --dns search-domains t=
o --dhcp-option");
         }
+
+        tt->dhcp_options |=3D DHCP_OPTIONS_DHCP_REQUIRED;
     }

     if (dns->servers)
@@ -1409,6 +1411,7 @@
         {
             msg(M_WARN, "WARNING: couldn't copy all --dns server addresses=
 to --dhcp-option");
         }
+        tt->dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;
     }
 }
 #else /* if defined(_WIN32) || defined(TARGET_ANDROID) */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/423?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I24f43ad319bd1ca530fe17442d02a97412eb75c7
Gerrit-Change-Number: 423
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--on8knyEOu+c=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, plaisthos, stipa. </p>
<p>stipa <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/423?usp=3Demail">View Change</a=
></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">Make --dns options apply for tap-windows6 driver<br><br>When tap-windows6=
 driver is used, both --dhcp-option and<br>--dns options are applied with D=
HCP. When processing --dns options,<br>we don&#39;t set &quot;tuntap_option=
s.dhcp_options&quot; member, which is required<br>for DHCP string to be sen=
t to the driver. As a result, --dns options<br>are not applied at all.<br><=
br>Fix by adding missing assignment of tuntap_options.dhcp_options.<br><br>=
Fixes https://github.com/OpenVPN/openvpn/issues/447<br><br>Change-Id: I24f4=
3ad319bd1ca530fe17442d02a97412eb75c7<br>Signed-off-by: Lev Stipakov &lt;lev=
@...515...&gt;<br>---<br>M src/openvpn/options.c<br>1 file changed, 3 inser=
tions(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/=
openvpn refs/changes/23/423/2</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/options.c b/=
src/openvpn/options.c</span><br><span>index 631ac73..f8d0b2e 100644</span><=
br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/opti=
ons.c</span><br><span>@@ -1372,6 +1372,8 @@</span><br><span>         {</spa=
n><br><span>             msg(M_WARN, &quot;WARNING: couldn&#39;t copy all -=
-dns search-domains to --dhcp-option&quot;);</span><br><span>         }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tt-&gt;dhcp_options |=3D DHCP_OPT=
IONS_DHCP_REQUIRED;</span><br><span>     }</span><br><span> </span><br><spa=
n>     if (dns-&gt;servers)</span><br><span>@@ -1409,6 +1411,7 @@</span><br=
><span>         {</span><br><span>             msg(M_WARN, &quot;WARNING: c=
ouldn&#39;t copy all --dns server addresses to --dhcp-option&quot;);</span>=
<br><span>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        tt-&gt;dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;</span><br><sp=
an>     }</span><br><span> }</span><br><span> #else /* if defined(_WIN32) |=
| defined(TARGET_ANDROID) */</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/423?usp=3Demail">chan=
ge 423</a>. To unsubscribe, or for help writing mail filters, visit <a href=
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
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--on8knyEOu+c=--

