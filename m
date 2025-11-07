From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 7 Nov 2025 13:49:48 +0000
In-Reply-To: <gerrit.1762430608000.I48c877843d24144450af1282b7524bb3ba18232e@...2715...>
References: <gerrit.1762430608000.I48c877843d24144450af1282b7524bb3ba18232e@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0386cba238cd07dec7f6f5c5bad50ddb0bd6abf3-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OLAddVqddg0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: FreeBSD DCO: repair
 --inactive
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

--OLAddVqddg0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1351?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: FreeBSD DCO: repair --inactive
......................................................................

FreeBSD DCO: repair --inactive

--inactive on DCO requires a working DCO counters query function
(dco_get_peer_stats(), implemented in the previous commit) and
that the DCO implementation in use fills the "tun_{read,write}_bytes"
fields for the peer context.

FreeBSD DCO only fills the "dco_{read,write}_bytes" counters - which is
something we can't fix in OpenVPN, this needs kernel enhancements.

So, to make the feature (mostly) work, check the other set of counters
on FreeBSD.  Caveat: this will count encryption overhead and keepalives,
so it will still not work for `--inactive <n>` without a byte count, or
for byte counts with too tight thresholds.

Adding the #ifdef to forward.c was considered the least bad alternative.

v2: fix rst syntax for manpage addition

Github: OpenVPN/openvpn#898

Change-Id: I48c877843d24144450af1282b7524bb3ba18232e
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/client-options.rst
M src/openvpn/forward.c
2 files changed, 12 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/51/1351/3

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-=
options.rst
index 0aee9e2..e8523d9 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -274,6 +274,11 @@
   counted as traffic, as they are used internally by OpenVPN and are not
   an indication of actual user activity.

+  NOTE: on FreeBSD with DCO, due to platform limits, the previous paragraph
+  is not correct.  In that case, encapsulation overhead and keepalives are
+  counted, so using this feature needs a sufficiently-high ``bytes`` value=
 to
+  take these extra numbers into account.
+
 --proto-force p
   When iterating through connection profiles, only consider profiles using
   protocol ``p`` (:code:`tcp` \| :code:`udp`).
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 5bbac13..c355f66 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -476,13 +476,20 @@
  * and the logic needs to change - we permit the event to trigger and check
  * kernel DCO counters here, returning and rearming the timer if there was
  * sufficient traffic.
+ *
+ * NOTE: FreeBSD DCO does not supply "tun bytes" (=3D decrypted payload) t=
oday,
+ * so "dco bytes" (encrypted bytes, including keepalives) is used instead
  */
 static void
 check_inactivity_timeout(struct context *c)
 {
     if (dco_enabled(&c->options) && dco_get_peer_stats(c, true) =3D=3D 0)
     {
+#ifdef TARGET_FREEBSD
+        int64_t tot_bytes =3D c->c2.dco_read_bytes + c->c2.dco_write_bytes;
+#else
         int64_t tot_bytes =3D c->c2.tun_read_bytes + c->c2.tun_write_bytes;
+#endif
         int64_t new_bytes =3D tot_bytes - c->c2.inactivity_bytes;

         if (new_bytes > c->options.inactivity_minimum_bytes)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1351?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I48c877843d24144450af1282b7524bb3ba18232e
Gerrit-Change-Number: 1351
Gerrit-PatchSet: 3
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--OLAddVqddg0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos. </p>
<p>cron2 <strong>uploaded patch set #3</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1351?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">FreeBSD DCO: repair --inacti=
ve<br><br>--inactive on DCO requires a working DCO counters query function<=
br>(dco_get_peer_stats(), implemented in the previous commit) and<br>that t=
he DCO implementation in use fills the &quot;tun_{read,write}_bytes&quot;<b=
r>fields for the peer context.<br><br>FreeBSD DCO only fills the &quot;dco_=
{read,write}_bytes&quot; counters - which is<br>something we can&#39;t fix =
in OpenVPN, this needs kernel enhancements.<br><br>So, to make the feature =
(mostly) work, check the other set of counters<br>on FreeBSD.  Caveat: this=
 will count encryption overhead and keepalives,<br>so it will still not wor=
k for `--inactive &lt;n&gt;` without a byte count, or<br>for byte counts wi=
th too tight thresholds.<br><br>Adding the #ifdef to forward.c was consider=
ed the least bad alternative.<br><br>v2: fix rst syntax for manpage additio=
n<br><br>Github: OpenVPN/openvpn#898<br><br>Change-Id: I48c877843d24144450a=
f1282b7524bb3ba18232e<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt=
;<br>---<br>M doc/man-sections/client-options.rst<br>M src/openvpn/forward.=
c<br>2 files changed, 12 insertions(+), 0 deletions(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/51/1351=
/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;"><span>diff --git a/doc/man-sections/client-options.rst b/doc/man-secti=
ons/client-options.rst</span><br><span>index 0aee9e2..e8523d9 100644</span>=
<br><span>--- a/doc/man-sections/client-options.rst</span><br><span>+++ b/d=
oc/man-sections/client-options.rst</span><br><span>@@ -274,6 +274,11 @@</sp=
an><br><span>   counted as traffic, as they are used internally by OpenVPN =
and are not</span><br><span>   an indication of actual user activity.</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  NOTE:=
 on FreeBSD with DCO, due to platform limits, the previous paragraph</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  is not correct.  In that=
 case, encapsulation overhead and keepalives are</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  counted, so using this feature needs a suffi=
ciently-high ``bytes`` value to</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  take these extra numbers into account.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --proto-force p</span><=
br><span>   When iterating through connection profiles, only consider profi=
les using</span><br><span>   protocol ``p`` (:code:`tcp` \| :code:`udp`).</=
span><br><span>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</=
span><br><span>index 5bbac13..c355f66 100644</span><br><span>--- a/src/open=
vpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@=
@ -476,13 +476,20 @@</span><br><span>  * and the logic needs to change - we=
 permit the event to trigger and check</span><br><span>  * kernel DCO count=
ers here, returning and rearming the timer if there was</span><br><span>  *=
 sufficient traffic.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * NOTE: FreeBSD=
 DCO does not supply &quot;tun bytes&quot; (=3D decrypted payload) today,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * so &quot;dco bytes=
&quot; (encrypted bytes, including keepalives) is used instead</span><br><s=
pan>  */</span><br><span> static void</span><br><span> check_inactivity_tim=
eout(struct context *c)</span><br><span> {</span><br><span>     if (dco_ena=
bled(&amp;c-&gt;options) &amp;&amp; dco_get_peer_stats(c, true) =3D=3D 0)</=
span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#ifdef TARGET_FREEBSD</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        int64_t tot_bytes =3D c-&gt;c2.dco_read_bytes + c-&gt;c2.dco_wr=
ite_bytes;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</sp=
an><br><span>         int64_t tot_bytes =3D c-&gt;c2.tun_read_bytes + c-&gt=
;c2.tun_write_bytes;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span>         int64_t new_bytes =3D tot_bytes - c-&gt;c2=
.inactivity_bytes;</span><br><span> </span><br><span>         if (new_bytes=
 &gt; c-&gt;options.inactivity_minimum_bytes)</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1351=
?usp=3Demail">change 1351</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">sett=
ings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1351?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I48c877843d24144450af1282b75=
24bb3ba18232e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1351 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--OLAddVqddg0=--

