From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 1 Sep 2025 21:17:25 +0000
In-Reply-To: <gerrit.1753360288000.I6d42c67b8dc5512933bed482bd9c2be80c63e993@...2715...>
References: <gerrit.1753360288000.I6d42c67b8dc5512933bed482bd9c2be80c63e993@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0a834456e52444ef59467bba7fb2290ed12447a6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZRVEELTXSd4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: forward: Make sure
 pip flags are treated as unsigned
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZRVEELTXSd4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
08?usp=3Demail )

Change subject: forward: Make sure pip flags are treated as unsigned
......................................................................

forward: Make sure pip flags are treated as unsigned

process_ip_header already expects them to be unsigned,
make sure the flags are to avoid spurious conversion warnings.

Change-Id: I6d42c67b8dc5512933bed482bd9c2be80c63e993
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250901194531.13683-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
740.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/forward.h
1 file changed, 7 insertions(+), 7 deletions(-)




diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index d564149..79d0f8b 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -314,13 +314,13 @@
  */
 void reschedule_multi_process(struct context *c);

-#define PIPV4_PASSTOS             (1 << 0)
-#define PIP_MSSFIX                (1 << 1) /* v4 and v6 */
-#define PIP_OUTGOING              (1 << 2)
-#define PIPV4_EXTRACT_DHCP_ROUTER (1 << 3)
-#define PIPV4_CLIENT_NAT          (1 << 4)
-#define PIPV6_ICMP_NOHOST_CLIENT  (1 << 5)
-#define PIPV6_ICMP_NOHOST_SERVER  (1 << 6)
+#define PIPV4_PASSTOS             (1u << 0)
+#define PIP_MSSFIX                (1u << 1) /* v4 and v6 */
+#define PIP_OUTGOING              (1u << 2)
+#define PIPV4_EXTRACT_DHCP_ROUTER (1u << 3)
+#define PIPV4_CLIENT_NAT          (1u << 4)
+#define PIPV6_ICMP_NOHOST_CLIENT  (1u << 5)
+#define PIPV6_ICMP_NOHOST_SERVER  (1u << 6)


 void process_ip_header(struct context *c, unsigned int flags, struct buffe=
r *buf,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1108?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6d42c67b8dc5512933bed482bd9c2be80c63e993
Gerrit-Change-Number: 1108
Gerrit-PatchSet: 11
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--ZRVEELTXSd4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1108?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">forward: Make sure pip flags are treated as u=
nsigned<br><br>process_ip_header already expects them to be unsigned,<br>ma=
ke sure the flags are to avoid spurious conversion warnings.<br><br>Change-=
Id: I6d42c67b8dc5512933bed482bd9c2be80c63e993<br>Signed-off-by: Frank Licht=
enheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1725...=
..&gt;<br>Message-Id: &lt;20250901194531.13683-1-gert@...1296...&gt;<br>URL=
: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32740=
.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M sr=
c/openvpn/forward.h<br>1 file changed, 7 insertions(+), 7 deletions(-)<br><=
br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h</span><br><sp=
an>index d564149..79d0f8b 100644</span><br><span>--- a/src/openvpn/forward.=
h</span><br><span>+++ b/src/openvpn/forward.h</span><br><span>@@ -314,13 +3=
14,13 @@</span><br><span>  */</span><br><span> void reschedule_multi_proces=
s(struct context *c);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#define PIPV4_PASSTOS             (1 &lt;&lt; 0)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define PIP_MSSFIX            =
    (1 &lt;&lt; 1) /* v4 and v6 */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#define PIP_OUTGOING              (1 &lt;&lt; 2)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#define PIPV4_EXTRACT_DHCP_ROUTER (=
1 &lt;&lt; 3)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
PIPV4_CLIENT_NAT          (1 &lt;&lt; 4)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#define PIPV6_ICMP_NOHOST_CLIENT  (1 &lt;&lt; 5)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#define PIPV6_ICMP_NOHOST_SER=
VER  (1 &lt;&lt; 6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define PIPV4_PASSTOS             (1u &lt;&lt; 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define PIP_MSSFIX                (1u &lt;&lt=
; 1) /* v4 and v6 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define PIP_OUTGOING              (1u &lt;&lt; 2)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define PIPV4_EXTRACT_DHCP_ROUTER (1u &lt;&l=
t; 3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PIPV4_=
CLIENT_NAT          (1u &lt;&lt; 4)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define PIPV6_ICMP_NOHOST_CLIENT  (1u &lt;&lt; 5)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define PIPV6_ICMP_NOHOST_SER=
VER  (1u &lt;&lt; 6)</span><br><span> </span><br><span> </span><br><span> v=
oid process_ip_header(struct context *c, unsigned int flags, struct buffer =
*buf,</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/1108?usp=3Demail">change 1108</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1108?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6d42c67b8dc5512933bed482bd9=
c2be80c63e993 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1108 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--ZRVEELTXSd4=--

