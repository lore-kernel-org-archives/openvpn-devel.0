From: "stipa (Code Review)" <gerrit@...515...>
Date: Mon, 13 Nov 2023 16:01:32 +0000
References: <gerrit.1699891289000.I24f43ad319bd1ca530fe17442d02a97412eb75c7@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a6fd9d0d0fdbce8ed2100cead3f6a9b99fc5c23d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3yuJsjUmiWA="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Make --dns options
 apply for tap-windows6 driver
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

--3yuJsjUmiWA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/427?usp=3Demail

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
1 file changed, 3 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/427/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b88fea9..abd2e0c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1364,6 +1364,8 @@
         {
             msg(M_WARN, "WARNING: couldn't copy all --dns search-domains t=
o --dhcp-option");
         }
+
+        tt->dhcp_options |=3D DHCP_OPTIONS_DHCP_REQUIRED;
     }

     if (dns->servers)
@@ -1401,6 +1403,7 @@
         {
             msg(M_WARN, "WARNING: couldn't copy all --dns server addresses=
 to --dhcp-option");
         }
+        tt->dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;
     }
 }
 #else /* if defined(_WIN32) || defined(TARGET_ANDROID) */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/427?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I24f43ad319bd1ca530fe17442d02a97412eb75c7
Gerrit-Change-Number: 427
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--3yuJsjUmiWA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/427?usp=3Demail">Vi=
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
ged, 3 insertions(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvp=
n.net:29418/openvpn refs/changes/27/427/1</pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/=
options.c b/src/openvpn/options.c</span><br><span>index b88fea9..abd2e0c 10=
0644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/=
openvpn/options.c</span><br><span>@@ -1364,6 +1364,8 @@</span><br><span>   =
      {</span><br><span>             msg(M_WARN, &quot;WARNING: couldn&#39;=
t copy all --dns search-domains to --dhcp-option&quot;);</span><br><span>  =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        tt-&gt;dhcp_options |=
=3D DHCP_OPTIONS_DHCP_REQUIRED;</span><br><span>     }</span><br><span> </s=
pan><br><span>     if (dns-&gt;servers)</span><br><span>@@ -1401,6 +1403,7 =
@@</span><br><span>         {</span><br><span>             msg(M_WARN, &quo=
t;WARNING: couldn&#39;t copy all --dns server addresses to --dhcp-option&qu=
ot;);</span><br><span>         }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        tt-&gt;dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;</=
span><br><span>     }</span><br><span> }</span><br><span> #else /* if defin=
ed(_WIN32) || defined(TARGET_ANDROID) */</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/427?usp=
=3Demail">change 427</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/427?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I24f43ad319bd1ca530fe17442d0=
2a97412eb75c7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 427 </div>
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


--3yuJsjUmiWA=--

