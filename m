From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 13 Feb 2026 18:44:57 +0000
References: <gerrit.1771008284000.I701452496bb47c58b9728b08104dd5cb7823a94f@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <c48ad33dd68539c996d447a2229f9216f17b2519-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EFc5GI84hY4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: Avoid
 sign-compare warning in should_trigger_renegotiation
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

--EFc5GI84hY4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1526?usp=3Demail

to review the following change.


Change subject: ssl: Avoid sign-compare warning in should_trigger_renegotia=
tion
......................................................................

ssl: Avoid sign-compare warning in should_trigger_renegotiation

Check that the value is positive and then cast it
to counter_type.

Change-Id: I701452496bb47c58b9728b08104dd5cb7823a94f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/ssl.c
1 file changed, 2 insertions(+), 11 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/26/1526/1

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index aac31c2..b053dbf 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2909,11 +2909,6 @@
     return true;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 /**
  * Determines if a renegotiation should be triggerred based on the various
  * factors that can trigger one
@@ -2929,13 +2924,13 @@
     }

     /* Byte limit */
-    if (session->opt->renegotiate_bytes > 0 && ks->n_bytes >=3D session->o=
pt->renegotiate_bytes)
+    if (session->opt->renegotiate_bytes > 0 && ks->n_bytes >=3D (counter_t=
ype)session->opt->renegotiate_bytes)
     {
         return true;
     }

     /* Packet limit */
-    if (session->opt->renegotiate_packets && ks->n_packets >=3D session->o=
pt->renegotiate_packets)
+    if (session->opt->renegotiate_packets > 0 && ks->n_packets >=3D (count=
er_type)session->opt->renegotiate_packets)
     {
         return true;
     }
@@ -2993,10 +2988,6 @@
     return false;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * This is the primary routine for processing TLS stuff inside the
  * the main event loop.  When this routine exits

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1526?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I701452496bb47c58b9728b08104dd5cb7823a94f
Gerrit-Change-Number: 1526
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--EFc5GI84hY4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1526?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">ssl: Avoid sign-compare warning in should_t=
rigger_renegotiation<br><br>Check that the value is positive and then cast =
it<br>to counter_type.<br><br>Change-Id: I701452496bb47c58b9728b08104dd5cb7=
823a94f<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---=
<br>M src/openvpn/ssl.c<br>1 file changed, 2 insertions(+), 11 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn=
 refs/changes/26/1526/1</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl.c b/src/openvp=
n/ssl.c</span><br><span>index aac31c2..b053dbf 100644</span><br><span>--- a=
/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>=
@@ -2909,11 +2909,6 @@</span><br><span>     return true;</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if=
 defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-compar=
e&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><=
br><span>  * Determines if a renegotiation should be triggerred based on th=
e various</span><br><span>  * factors that can trigger one</span><br><span>=
@@ -2929,13 +2924,13 @@</span><br><span>     }</span><br><span> </span><br>=
<span>     /* Byte limit */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (session-&gt;opt-&gt;renegotiate_bytes &gt; 0 &amp;&amp; ks-&g=
t;n_bytes &gt;=3D session-&gt;opt-&gt;renegotiate_bytes)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (session-&gt;opt-&gt;renegotiat=
e_bytes &gt; 0 &amp;&amp; ks-&gt;n_bytes &gt;=3D (counter_type)session-&gt;=
opt-&gt;renegotiate_bytes)</span><br><span>     {</span><br><span>         =
return true;</span><br><span>     }</span><br><span> </span><br><span>     =
/* Packet limit */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (session-&gt;opt-&gt;renegotiate_packets &amp;&amp; ks-&gt;n_packets &g=
t;=3D session-&gt;opt-&gt;renegotiate_packets)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (session-&gt;opt-&gt;renegotiate_packets =
&gt; 0 &amp;&amp; ks-&gt;n_packets &gt;=3D (counter_type)session-&gt;opt-&g=
t;renegotiate_packets)</span><br><span>     {</span><br><span>         retu=
rn true;</span><br><span>     }</span><br><span>@@ -2993,10 +2988,6 @@</spa=
n><br><span>     return false;</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defi=
ned(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma=
 GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
ndif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
 /*</span><br><span>  * This is the primary routine for processing TLS stuf=
f inside the</span><br><span>  * the main event loop.  When this routine ex=
its</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1526?usp=3Demail">change 1526</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1526?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I701452496bb47c58b9728b08104=
dd5cb7823a94f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1526 </div>
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

--EFc5GI84hY4=--

