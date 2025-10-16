From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Thu, 16 Oct 2025 15:49:13 +0000
References: <gerrit.1760629750000.I7b718a14b81e3759398e7a52fe151102494cc821@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5f8794ad34166e1d51d46be366844ecbceedd679-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xq3gf88MqbM="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco: disable DCO
 when using --reneg-bytes/pkts
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

--xq3gf88MqbM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1280?usp=3Demail

to review the following change.


Change subject: dco: disable DCO when using --reneg-bytes/pkts
......................................................................

dco: disable DCO when using --reneg-bytes/pkts

When using --reneg-bytes or --reneg-pkts, openvpn negotiates a new key
upon reaching the specified threshold. This implies the usage of per-key
counters. DCO, on the other hand, provides only global statistics,
making it currently impossible to track when renegotiation should occur.

To avoid introducing unnecessary complexity into DCO, it is disabled
when either of these options is specified. Instead, the automatic key
renegotiation mechanism is preferred, as it provides a more modern and
streamlined approach.

Change-Id: I7b718a14b81e3759398e7a52fe151102494cc821
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M src/openvpn/dco.c
1 file changed, 7 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/80/1280/1

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 8fb4662..59f6f5a 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -424,6 +424,13 @@
         return false;
     }

+    if (o->renegotiate_bytes > 0 || o->renegotiate_packets)
+    {
+        msg(msglevel, "Note: '--reneg-bytes' and '--reneg-pkts' are not su=
pported by DCO, "
+            "disabling data channel offload.");
+        return false;
+    }
+
     /* now that all options have been confirmed to be supported, check
      * if DCO is truly available on the system
      */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1280?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7b718a14b81e3759398e7a52fe151102494cc821
Gerrit-Change-Number: 1280
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--xq3gf88MqbM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>ralf_lici would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1280?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">dco: disable DCO when using --reneg-bytes/p=
kts<br><br>When using --reneg-bytes or --reneg-pkts, openvpn negotiates a n=
ew key<br>upon reaching the specified threshold. This implies the usage of =
per-key<br>counters. DCO, on the other hand, provides only global statistic=
s,<br>making it currently impossible to track when renegotiation should occ=
ur.<br><br>To avoid introducing unnecessary complexity into DCO, it is disa=
bled<br>when either of these options is specified. Instead, the automatic k=
ey<br>renegotiation mechanism is preferred, as it provides a more modern an=
d<br>streamlined approach.<br><br>Change-Id: I7b718a14b81e3759398e7a52fe151=
102494cc821<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br>---<br>M=
 src/openvpn/dco.c<br>1 file changed, 7 insertions(+), 0 deletions(-)<br><b=
r></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/=
changes/80/1280/1</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.=
c</span><br><span>index 8fb4662..59f6f5a 100644</span><br><span>--- a/src/o=
penvpn/dco.c</span><br><span>+++ b/src/openvpn/dco.c</span><br><span>@@ -42=
4,6 +424,13 @@</span><br><span>         return false;</span><br><span>     =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (o-&gt;renegotiate_bytes &gt; 0 || o-&gt;renegotiate_packets)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;Note: &#39;-=
-reneg-bytes&#39; and &#39;--reneg-pkts&#39; are not supported by DCO, &quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot=
;disabling data channel offload.&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return false;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span>     /* now that all options have been confirmed =
to be supported, check</span><br><span>      * if DCO is truly available on=
 the system</span><br><span>      */</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1280?usp=3Dem=
ail">change 1280</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1280?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7b718a14b81e3759398e7a52fe1=
51102494cc821 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1280 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
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

</body></html>=

--xq3gf88MqbM=--

