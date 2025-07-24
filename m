From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 24 Jul 2025 12:31:45 +0000
References: <gerrit.1753360288000.I6d42c67b8dc5512933bed482bd9c2be80c63e993@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e25040b9ef73b11f538d51870ca55c5cc75d383f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Z1knFkH8GmM="; charset=UTF-8
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

--Z1knFkH8GmM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1108?usp=3Demail

to review the following change.


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



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/08/1108/1

diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 2818fd1..b3e424c 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -318,13 +318,13 @@
  */
 void reschedule_multi_process(struct context *c);

-#define PIPV4_PASSTOS                   (1<<0)
-#define PIP_MSSFIX                      (1<<1)         /* v4 and v6 */
-#define PIP_OUTGOING                    (1<<2)
-#define PIPV4_EXTRACT_DHCP_ROUTER       (1<<3)
-#define PIPV4_CLIENT_NAT                (1<<4)
-#define PIPV6_ICMP_NOHOST_CLIENT        (1<<5)
-#define PIPV6_ICMP_NOHOST_SERVER        (1<<6)
+#define PIPV4_PASSTOS                   (1u<<0)
+#define PIP_MSSFIX                      (1u<<1)         /* v4 and v6 */
+#define PIP_OUTGOING                    (1u<<2)
+#define PIPV4_EXTRACT_DHCP_ROUTER       (1u<<3)
+#define PIPV4_CLIENT_NAT                (1u<<4)
+#define PIPV6_ICMP_NOHOST_CLIENT        (1u<<5)
+#define PIPV6_ICMP_NOHOST_SERVER        (1u<<6)


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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--Z1knFkH8GmM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1108?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">forward: Make sure pip flags are treated as unsigned<br><br>=
process_ip_header already expects them to be unsigned,<br>make sure the fla=
gs are to avoid spurious conversion warnings.<br><br>Change-Id: I6d42c67b8d=
c5512933bed482bd9c2be80c63e993<br>Signed-off-by: Frank Lichtenheld &lt;fran=
k@...2641...&gt;<br>---<br>M src/openvpn/forward.h<br>1 file changed, 7 ins=
ertions(+), 7 deletions(-)<br><br></pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2941=
8/openvpn refs/changes/08/1108/1</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/forward.h=
 b/src/openvpn/forward.h</span><br><span>index 2818fd1..b3e424c 100644</spa=
n><br><span>--- a/src/openvpn/forward.h</span><br><span>+++ b/src/openvpn/f=
orward.h</span><br><span>@@ -318,13 +318,13 @@</span><br><span>  */</span><=
br><span> void reschedule_multi_process(struct context *c);</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PIPV4_PASST=
OS                   (1&lt;&lt;0)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#define PIP_MSSFIX                      (1&lt;&lt;1)         /*=
 v4 and v6 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
PIP_OUTGOING                    (1&lt;&lt;2)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define PIPV4_EXTRACT_DHCP_ROUTER       (1&lt;&lt;3)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PIPV4_CLIENT_=
NAT                (1&lt;&lt;4)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#define PIPV6_ICMP_NOHOST_CLIENT        (1&lt;&lt;5)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#define PIPV6_ICMP_NOHOST_SERVER  =
      (1&lt;&lt;6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define PIPV4_PASSTOS                   (1u&lt;&lt;0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define PIP_MSSFIX                      (=
1u&lt;&lt;1)         /* v4 and v6 */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define PIP_OUTGOING                    (1u&lt;&lt;2)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PIPV4_EXTRACT_DH=
CP_ROUTER       (1u&lt;&lt;3)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define PIPV4_CLIENT_NAT                (1u&lt;&lt;4)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define PIPV6_ICMP_NOHOST_CLIEN=
T        (1u&lt;&lt;5)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define PIPV6_ICMP_NOHOST_SERVER        (1u&lt;&lt;6)</span><br><span> <=
/span><br><span> </span><br><span> void process_ip_header(struct context *c=
, unsigned int flags, struct buffer *buf,</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1108?usp=
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
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--Z1knFkH8GmM=--

