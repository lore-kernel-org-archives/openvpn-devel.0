From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 15 Nov 2023 14:45:31 +0000
In-Reply-To: <gerrit.1699611717000.I24f43ad319bd1ca530fe17442d02a97412eb75c7@...2715...>
References: <gerrit.1699611717000.I24f43ad319bd1ca530fe17442d02a97412eb75c7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <ba7a7134c6e959f9119fa737d4bfe78052733a19-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="S9PNBhXBkvM="; charset=UTF-8
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
To: stipa <lstipakov@...277...>
Cc: flichtenheld <frank@...2641...>, d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--S9PNBhXBkvM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/42=
3?usp=3Demail )

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
(cherry picked from commit 60def50420b050e628f4388e3c9ff771eb70a549)
---
M src/openvpn/options.c
1 file changed, 2 insertions(+), 0 deletions(-)




diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 895ce83..9502982 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1372,6 +1372,7 @@
         {
             msg(M_WARN, "WARNING: couldn't copy all --dns search-domains t=
o --dhcp-option");
         }
+        tt->dhcp_options |=3D DHCP_OPTIONS_DHCP_REQUIRED;
     }

     if (dns->servers)
@@ -1409,6 +1410,7 @@
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
Gerrit-PatchSet: 4
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--S9PNBhXBkvM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/423?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Make --dns options apply for tap-windows6 driv=
er<br><br>When tap-windows6 driver is used, both --dhcp-option and<br>--dns=
 options are applied with DHCP. When processing --dns options,<br>we don&#3=
9;t set &quot;tuntap_options.dhcp_options&quot; member, which is required<b=
r>for DHCP string to be sent to the driver. As a result, --dns options<br>a=
re not applied at all.<br><br>Fix by adding missing assignment of tuntap_op=
tions.dhcp_options.<br><br>Github: fixes OpenVPN/openvpn#447<br><br>Change-=
Id: I24f43ad319bd1ca530fe17442d02a97412eb75c7<br>Signed-off-by: Lev Stipako=
v &lt;lev@...515...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...=
&gt;<br>Message-Id: &lt;20231115120623.6442-1-gert@...1296...&gt;<br>URL: h=
ttps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27402.ht=
ml<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>(cherry picked=
 from commit 60def50420b050e628f4388e3c9ff771eb70a549)<br>---<br>M src/open=
vpn/options.c<br>1 file changed, 2 insertions(+), 0 deletions(-)<br><br></p=
re>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><sp=
an>index 895ce83..9502982 100644</span><br><span>--- a/src/openvpn/options.=
c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -1372,6 +1=
372,7 @@</span><br><span>         {</span><br><span>             msg(M_WARN=
, &quot;WARNING: couldn&#39;t copy all --dns search-domains to --dhcp-optio=
n&quot;);</span><br><span>         }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        tt-&gt;dhcp_options |=3D DHCP_OPTIONS_DHCP_REQUIRE=
D;</span><br><span>     }</span><br><span> </span><br><span>     if (dns-&g=
t;servers)</span><br><span>@@ -1409,6 +1410,7 @@</span><br><span>         {=
</span><br><span>             msg(M_WARN, &quot;WARNING: couldn&#39;t copy =
all --dns server addresses to --dhcp-option&quot;);</span><br><span>       =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tt-&gt;d=
hcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;</span><br><span>     }</span><=
br><span> }</span><br><span> #else /* if defined(_WIN32) || defined(TARGET_=
ANDROID) */</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/423?usp=3Demail">change 423</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/423?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I24f43ad319bd1ca530fe17442d0=
2a97412eb75c7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 423 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--S9PNBhXBkvM=--

