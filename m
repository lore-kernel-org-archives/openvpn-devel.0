From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 6 May 2026 21:21:23 +0000
References: <gerrit.1778102459000.If58bb807842b7b95aeffe6849e7a7344e4925762@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <24d651d77f15cfef166f0c31e3316c6fc6633d55-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Kh2WR3kA5OE="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: multi: Remove
 useless checks
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

--Kh2WR3kA5OE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1667?usp=3Demail

to review the following change.


Change subject: multi: Remove useless checks
......................................................................

multi: Remove useless checks

If mi is NULL, the previous code lines already
segfaulted.

Identified by cppcheck.

Change-Id: If58bb807842b7b95aeffe6849e7a7344e4925762
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/multi.c
1 file changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/67/1667/1

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 06e3758..a957fdf 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3054,8 +3054,8 @@

 #ifdef MULTI_DEBUG_EVENT_LOOP
         printf("POST %s[%d] to=3D%d lo=3D%d/%d w=3D%" PRIi64 "/%ld\n", id(=
mi), (int)(mi =3D=3D m->pending),
-               mi ? mi->context.c2.to_tun.len : -1, mi ? mi->context.c2.to=
_link.len : -1,
-               (mi && mi->context.c2.fragment) ? mi->context.c2.fragment->=
outgoing.len : -1,
+               mi->context.c2.to_tun.len, mi->context.c2.to_link.len,
+               mi->context.c2.fragment ? mi->context.c2.fragment->outgoing=
.len : -1,
                (int64_t)mi->context.c2.timeval.tv_sec, (long)mi->context.c=
2.timeval.tv_usec);
 #endif
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1667?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If58bb807842b7b95aeffe6849e7a7344e4925762
Gerrit-Change-Number: 1667
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--Kh2WR3kA5OE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1667?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">multi: Remove useless checks<br><br>If mi i=
s NULL, the previous code lines already<br>segfaulted.<br><br>Identified by=
 cppcheck.<br><br>Change-Id: If58bb807842b7b95aeffe6849e7a7344e4925762<br>S=
igned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/op=
envpn/multi.c<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chang=
es/67/1667/1</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c=
</span><br><span>index 06e3758..a957fdf 100644</span><br><span>--- a/src/op=
envpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ =
-3054,8 +3054,8 @@</span><br><span> </span><br><span> #ifdef MULTI_DEBUG_EV=
ENT_LOOP</span><br><span>         printf(&quot;POST %s[%d] to=3D%d lo=3D%d/=
%d w=3D%&quot; PRIi64 &quot;/%ld\n&quot;, id(mi), (int)(mi =3D=3D m-&gt;pen=
ding),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
mi ? mi-&gt;context.c2.to_tun.len : -1, mi ? mi-&gt;context.c2.to_link.len =
: -1,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               (=
mi &amp;&amp; mi-&gt;context.c2.fragment) ? mi-&gt;context.c2.fragment-&gt;=
outgoing.len : -1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
              mi-&gt;context.c2.to_tun.len, mi-&gt;context.c2.to_link.len,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+               mi-&g=
t;context.c2.fragment ? mi-&gt;context.c2.fragment-&gt;outgoing.len : -1,</=
span><br><span>                (int64_t)mi-&gt;context.c2.timeval.tv_sec, (=
long)mi-&gt;context.c2.timeval.tv_usec);</span><br><span> #endif</span><br>=
<span>     }</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1667?usp=3Demail">change 1667</a>. To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemt=
ype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" i=
temtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1667?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If58bb807842b7b95aeffe6849e7=
a7344e4925762 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1667 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--Kh2WR3kA5OE=--

