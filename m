From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 15 Nov 2023 14:45:30 +0000
In-Reply-To: <gerrit.1699891289000.I24f43ad319bd1ca530fe17442d02a97412eb75c7@...2715...>
References: <gerrit.1699891289000.I24f43ad319bd1ca530fe17442d02a97412eb75c7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <627afdb781df4b1009cb63332b0d297ddcbc3e81-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="696HFUE0lLw="; charset=UTF-8
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
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--696HFUE0lLw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/427?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Make --dns options apply for tap-windows6 driver
......................................................................

Make --dns options apply for tap-windows6 driver

When tap-windows6 driver is used, both --dhcp-option and
--dns options are applied with DHCP. When processing --dns options,
we don't set "tuntap_options.dhcp_options" member, which is required
for DHCP string to be sent to the driver. As a result, --dns options
are not applied at all.

Fix by adding missing assignment of tuntap_options.dhcp_options.

Github: fixes OpenVPN/openvpn#447

Change-Id: I24f43ad319bd1ca530fe17442d02a97412eb75c7
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20231115120623.6442-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
402.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
1 file changed, 2 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/427/2

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b88fea9..bd731ff 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1364,6 +1364,7 @@
         {
             msg(M_WARN, "WARNING: couldn't copy all --dns search-domains t=
o --dhcp-option");
         }
+        tt->dhcp_options |=3D DHCP_OPTIONS_DHCP_REQUIRED;
     }

     if (dns->servers)
@@ -1401,6 +1402,7 @@
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
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--696HFUE0lLw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/427?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Make --dns options apply for tap-windows6 dri=
ver<br><br>When tap-windows6 driver is used, both --dhcp-option and<br>--dn=
s options are applied with DHCP. When processing --dns options,<br>we don&#=
39;t set &quot;tuntap_options.dhcp_options&quot; member, which is required<=
br>for DHCP string to be sent to the driver. As a result, --dns options<br>=
are not applied at all.<br><br>Fix by adding missing assignment of tuntap_o=
ptions.dhcp_options.<br><br>Github: fixes OpenVPN/openvpn#447<br><br>Change=
-Id: I24f43ad319bd1ca530fe17442d02a97412eb75c7<br>Signed-off-by: Lev Stipak=
ov &lt;lev@...515...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2723...=
.&gt;<br>Message-Id: &lt;20231115120623.6442-1-gert@...1296...&gt;<br>URL: =
https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27402.h=
tml<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/=
openvpn/options.c<br>1 file changed, 2 insertions(+), 0 deletions(-)<br><br=
></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/427/2</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br=
><span>index b88fea9..bd731ff 100644</span><br><span>--- a/src/openvpn/opti=
ons.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -1364,=
6 +1364,7 @@</span><br><span>         {</span><br><span>             msg(M_=
WARN, &quot;WARNING: couldn&#39;t copy all --dns search-domains to --dhcp-o=
ption&quot;);</span><br><span>         }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        tt-&gt;dhcp_options |=3D DHCP_OPTIONS_DHCP_REQ=
UIRED;</span><br><span>     }</span><br><span> </span><br><span>     if (dn=
s-&gt;servers)</span><br><span>@@ -1401,6 +1402,7 @@</span><br><span>      =
   {</span><br><span>             msg(M_WARN, &quot;WARNING: couldn&#39;t c=
opy all --dns server addresses to --dhcp-option&quot;);</span><br><span>   =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tt-&=
gt;dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;</span><br><span>     }</sp=
an><br><span> }</span><br><span> #else /* if defined(_WIN32) || defined(TAR=
GET_ANDROID) */</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/427?usp=3Demail">change 427</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/427?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I24f43ad319bd1ca530fe17442d0=
2a97412eb75c7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 427 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--696HFUE0lLw=--

