From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 9 Nov 2025 11:04:02 +0000
In-Reply-To: <gerrit.1762430608000.I48c877843d24144450af1282b7524bb3ba18232e@...2715...>
References: <gerrit.1762430608000.I48c877843d24144450af1282b7524bb3ba18232e@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., ralf@...2726...
Message-ID: <0cc6cc3af4c0436454d844afa725a19c7c50eb92-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PeOlQrubZzg="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, ralf_lici <ralf@...2726...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--PeOlQrubZzg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello flichtenheld, plaisthos, ralf_lici,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1351?usp=3Demail

to look at the new patch set (#5).

The following approvals got outdated and were removed:
Code-Review+2 by ralf_lici


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
Acked-by: Ralf Lici <ralf@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1351
Message-Id: <20251109084238.11581-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
274.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/client-options.rst
M src/openvpn/forward.c
2 files changed, 12 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/51/1351/5

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
Gerrit-PatchSet: 5
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: ralf_lici <ralf@...2726...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--PeOlQrubZzg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #5</strong> to this change.</p><p><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1351?usp=3Demail">View Change</a></p><p>The followi=
ng approvals got outdated and were removed:
Code-Review+2 by ralf_lici</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">FreeBSD DCO: repair --inactive<=
br><br>--inactive on DCO requires a working DCO counters query function<br>=
(dco_get_peer_stats(), implemented in the previous commit) and<br>that the =
DCO implementation in use fills the &quot;tun_{read,write}_bytes&quot;<br>f=
ields for the peer context.<br><br>FreeBSD DCO only fills the &quot;dco_{re=
ad,write}_bytes&quot; counters - which is<br>something we can&#39;t fix in =
OpenVPN, this needs kernel enhancements.<br><br>So, to make the feature (mo=
stly) work, check the other set of counters<br>on FreeBSD.  Caveat: this wi=
ll count encryption overhead and keepalives,<br>so it will still not work f=
or `--inactive &lt;n&gt;` without a byte count, or<br>for byte counts with =
too tight thresholds.<br><br>Adding the #ifdef to forward.c was considered =
the least bad alternative.<br><br>v2: fix rst syntax for manpage addition<b=
r><br>Github: OpenVPN/openvpn#898<br><br>Change-Id: I48c877843d24144450af12=
82b7524bb3ba18232e<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<b=
r>Acked-by: Ralf Lici &lt;ralf@...2726...&gt;<br>Gerrit URL: https://gerrit=
.openvpn.net/c/openvpn/+/1351<br>Message-Id: &lt;20251109084238.11581-1-ger=
t@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1096...=
ourceforge.net/msg34274.html<br>Signed-off-by: Gert Doering &lt;gert@...1826...=
6...&gt;<br>---<br>M doc/man-sections/client-options.rst<br>M src/openvpn/f=
orward.c<br>2 files changed, 12 insertions(+), 0 deletions(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/=
51/1351/5</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/doc/man-sections/client-options.rst b/doc/ma=
n-sections/client-options.rst</span><br><span>index 0aee9e2..e8523d9 100644=
</span><br><span>--- a/doc/man-sections/client-options.rst</span><br><span>=
+++ b/doc/man-sections/client-options.rst</span><br><span>@@ -274,6 +274,11=
 @@</span><br><span>   counted as traffic, as they are used internally by O=
penVPN and are not</span><br><span>   an indication of actual user activity=
.</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  NOTE: on FreeBSD with DCO, due to platform limits, the previous paragraph=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  is not correct.  =
In that case, encapsulation overhead and keepalives are</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  counted, so using this feature needs =
a sufficiently-high ``bytes`` value to</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  take these extra numbers into account.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --proto-force p</=
span><br><span>   When iterating through connection profiles, only consider=
 profiles using</span><br><span>   protocol ``p`` (:code:`tcp` \| :code:`ud=
p`).</span><br><span>diff --git a/src/openvpn/forward.c b/src/openvpn/forwa=
rd.c</span><br><span>index 5bbac13..c355f66 100644</span><br><span>--- a/sr=
c/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><=
span>@@ -476,13 +476,20 @@</span><br><span>  * and the logic needs to chang=
e - we permit the event to trigger and check</span><br><span>  * kernel DCO=
 counters here, returning and rearming the timer if there was</span><br><sp=
an>  * sufficient traffic.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * NOTE: F=
reeBSD DCO does not supply &quot;tun bytes&quot; (=3D decrypted payload) to=
day,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * so &quot;dco=
 bytes&quot; (encrypted bytes, including keepalives) is used instead</span>=
<br><span>  */</span><br><span> static void</span><br><span> check_inactivi=
ty_timeout(struct context *c)</span><br><span> {</span><br><span>     if (d=
co_enabled(&amp;c-&gt;options) &amp;&amp; dco_get_peer_stats(c, true) =3D=
=3D 0)</span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#ifdef TARGET_FREEBSD</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        int64_t tot_bytes =3D c-&gt;c2.dco_read_bytes + c-&gt;c=
2.dco_write_bytes;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
else</span><br><span>         int64_t tot_bytes =3D c-&gt;c2.tun_read_bytes=
 + c-&gt;c2.tun_write_bytes;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#endif</span><br><span>         int64_t new_bytes =3D tot_bytes - =
c-&gt;c2.inactivity_bytes;</span><br><span> </span><br><span>         if (n=
ew_bytes &gt; c-&gt;options.inactivity_minimum_bytes)</span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1351?usp=3Demail">change 1351</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Dema=
il">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1351?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I48c877843d24144450af1282b75=
24bb3ba18232e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1351 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--PeOlQrubZzg=--

