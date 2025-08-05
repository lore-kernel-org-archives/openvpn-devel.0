From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 5 Aug 2025 16:00:20 +0000
In-Reply-To: <gerrit.1753360288000.I0272b709b907545de05bfded03a649b259ce5af6@...2715...>
References: <gerrit.1753360288000.I0272b709b907545de05bfded03a649b259ce5af6@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <17dfd9f10676ff8163fdb54e20f79d83c7704dee-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="x9iN2XqW0Ho="; charset=UTF-8
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

--x9iN2XqW0Ho=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1107?usp=3Demail

to look at the new patch set (#4).


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/07/1107/4

diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index 8422996..8a89a25 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -35,8 +35,8 @@
 #define WRITE_SHIFT 1

 #define EVENT_UNDEF 4
-#define EVENT_READ  (1 << READ_SHIFT)
-#define EVENT_WRITE (1 << WRITE_SHIFT)
+#define EVENT_READ  (1u << READ_SHIFT)
+#define EVENT_WRITE (1u << WRITE_SHIFT)

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
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--x9iN2XqW0Ho=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #4</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1107?usp=3Demail">View C=
hange</a></p><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">events: Make sure rwflags are treated as unsigned<br><br>event_se=
t_return.rwflags is already unsigned, make sure the<br>flags are as well to=
 avoid spurious conversion warnings.<br><br>Change-Id: I0272b709b907545de05=
bfded03a649b259ce5af6<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2746...=
...&gt;<br>---<br>M src/openvpn/event.h<br>1 file changed, 2 insertions(+),=
 2 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn r=
efs/changes/07/1107/4</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/src/openvpn/event.h b/src/openvp=
n/event.h</span><br><span>index 8422996..8a89a25 100644</span><br><span>---=
 a/src/openvpn/event.h</span><br><span>+++ b/src/openvpn/event.h</span><br>=
<span>@@ -35,8 +35,8 @@</span><br><span> #define WRITE_SHIFT 1</span><br><s=
pan> </span><br><span> #define EVENT_UNDEF 4</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define EVENT_READ  (1 &lt;&lt; READ_SHIFT)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define EVENT_WRITE (1 &lt;&lt=
; WRITE_SHIFT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne EVENT_READ  (1u &lt;&lt; READ_SHIFT)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define EVENT_WRITE (1u &lt;&lt; WRITE_SHIFT)</span><br=
><span> </span><br><span> /* event flags returned by io_wait.</span><br><sp=
an>  *</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1107?usp=3Demail">change 1107</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1107?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0272b709b907545de05bfded03a=
649b259ce5af6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1107 </div>
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


--x9iN2XqW0Ho=--

