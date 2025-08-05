From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 5 Aug 2025 16:00:20 +0000
In-Reply-To: <gerrit.1753360288000.I6d42c67b8dc5512933bed482bd9c2be80c63e993@...2715...>
References: <gerrit.1753360288000.I6d42c67b8dc5512933bed482bd9c2be80c63e993@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e9c2218574fb87febedc3864074b078d2ee6b2dd-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="N+oAikaJGQ8="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--N+oAikaJGQ8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1108?usp=3Demail

to look at the new patch set (#4).


Change subject: forward: Make sure pip flags are treated as unsigned
......................................................................

forward: Make sure pip flags are treated as unsigned

process_ip_header already expects them to be unsigned,
make sure the flags are to avoid spurious conversion warnings.

Change-Id: I6d42c67b8dc5512933bed482bd9c2be80c63e993
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/forward.h
1 file changed, 7 insertions(+), 7 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/08/1108/4

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
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--N+oAikaJGQ8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #4</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1108?usp=3Demail">View C=
hange</a></p><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">forward: Make sure pip flags are treated as unsigned<br><br>proce=
ss_ip_header already expects them to be unsigned,<br>make sure the flags ar=
e to avoid spurious conversion warnings.<br><br>Change-Id: I6d42c67b8dc5512=
933bed482bd9c2be80c63e993<br>Signed-off-by: Frank Lichtenheld &lt;frank@...493...=
2641...&gt;<br>---<br>M src/openvpn/forward.h<br>1 file changed, 7 insertio=
ns(+), 7 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/ope=
nvpn refs/changes/08/1108/4</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/forward.h b/sr=
c/openvpn/forward.h</span><br><span>index d564149..79d0f8b 100644</span><br=
><span>--- a/src/openvpn/forward.h</span><br><span>+++ b/src/openvpn/forwar=
d.h</span><br><span>@@ -314,13 +314,13 @@</span><br><span>  */</span><br><s=
pan> void reschedule_multi_process(struct context *c);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PIPV4_PASSTOS   =
          (1 &lt;&lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define PIP_MSSFIX                (1 &lt;&lt; 1) /* v4 and v6 */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#define PIP_OUTGOING         =
     (1 &lt;&lt; 2)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#d=
efine PIPV4_EXTRACT_DHCP_ROUTER (1 &lt;&lt; 3)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define PIPV4_CLIENT_NAT          (1 &lt;&lt; 4)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PIPV6_ICMP_NOHO=
ST_CLIENT  (1 &lt;&lt; 5)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define PIPV6_ICMP_NOHOST_SERVER  (1 &lt;&lt; 6)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define PIPV4_PASSTOS             (1u &lt=
;&lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PIP=
_MSSFIX                (1u &lt;&lt; 1) /* v4 and v6 */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define PIP_OUTGOING              (1u &l=
t;&lt; 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PI=
PV4_EXTRACT_DHCP_ROUTER (1u &lt;&lt; 3)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define PIPV4_CLIENT_NAT          (1u &lt;&lt; 4)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PIPV6_ICMP_NOHOST=
_CLIENT  (1u &lt;&lt; 5)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#define PIPV6_ICMP_NOHOST_SERVER  (1u &lt;&lt; 6)</span><br><span> </s=
pan><br><span> </span><br><span> void process_ip_header(struct context *c, =
unsigned int flags, struct buffer *buf,</span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1108?usp=
=3Demail">change 1108</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1108?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6d42c67b8dc5512933bed482bd9=
c2be80c63e993 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1108 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--N+oAikaJGQ8=--

