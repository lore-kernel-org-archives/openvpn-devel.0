From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 24 Jul 2025 12:31:44 +0000
References: <gerrit.1753360288000.I0272b709b907545de05bfded03a649b259ce5af6@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <ac050dc1512ff710c7fab49d773c424f26b5be8f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eh2tLo9AuLQ="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: events: Make sure
 rwflags are treated as unsigned
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

--eh2tLo9AuLQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1107?usp=3Demail

to review the following change.


Change subject: events: Make sure rwflags are treated as unsigned
......................................................................

events: Make sure rwflags are treated as unsigned

event_set_return.rwflags is already unsigned, make sure the
flags are as well to avoid spurious conversion warnings.

Change-Id: I0272b709b907545de05bfded03a649b259ce5af6
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/event.h
1 file changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/07/1107/1

diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index 389f80d..eddff4d 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -36,8 +36,8 @@
 #define WRITE_SHIFT     1

 #define EVENT_UNDEF     4
-#define EVENT_READ      (1 << READ_SHIFT)
-#define EVENT_WRITE     (1 << WRITE_SHIFT)
+#define EVENT_READ      (1u << READ_SHIFT)
+#define EVENT_WRITE     (1u << WRITE_SHIFT)

 /* event flags returned by io_wait.
  *

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1107?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0272b709b907545de05bfded03a649b259ce5af6
Gerrit-Change-Number: 1107
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--eh2tLo9AuLQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1107?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">events: Make sure rwflags are treated as unsigned<br><br>eve=
nt_set_return.rwflags is already unsigned, make sure the<br>flags are as we=
ll to avoid spurious conversion warnings.<br><br>Change-Id: I0272b709b90754=
5de05bfded03a649b259ce5af6<br>Signed-off-by: Frank Lichtenheld &lt;frank@...1186...=
.2641...&gt;<br>---<br>M src/openvpn/event.h<br>1 file changed, 2 insertion=
s(+), 2 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/open=
vpn refs/changes/07/1107/1</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/event.h b/src/o=
penvpn/event.h</span><br><span>index 389f80d..eddff4d 100644</span><br><spa=
n>--- a/src/openvpn/event.h</span><br><span>+++ b/src/openvpn/event.h</span=
><br><span>@@ -36,8 +36,8 @@</span><br><span> #define WRITE_SHIFT     1</sp=
an><br><span> </span><br><span> #define EVENT_UNDEF     4</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#define EVENT_READ      (1 &lt;&lt; REA=
D_SHIFT)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define EVENT=
_WRITE     (1 &lt;&lt; WRITE_SHIFT)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define EVENT_READ      (1u &lt;&lt; READ_SHIFT)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define EVENT_WRITE     (1u &l=
t;&lt; WRITE_SHIFT)</span><br><span> </span><br><span> /* event flags retur=
ned by io_wait.</span><br><span>  *</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1107?usp=3Dema=
il">change 1107</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1107?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0272b709b907545de05bfded03a=
649b259ce5af6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1107 </div>
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


--eh2tLo9AuLQ=--

