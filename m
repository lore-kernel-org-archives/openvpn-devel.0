From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 4 Nov 2025 21:44:19 +0000
References: <gerrit.1762292654000.I38a040a9bdcb44933d4ca538f746af5c61011d7c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2de24554593d96b8364ce1590e7e4083f4b00abc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sm6JFSPzITo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco_freebsd:
 implement dco_get_peer_stats()
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

--sm6JFSPzITo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1350?usp=3Demail

to review the following change.


Change subject: dco_freebsd: implement dco_get_peer_stats()
......................................................................

dco_freebsd: implement dco_get_peer_stats()

This is "fetch read/write statistics for a single peer", complementing
dco_get_peer_stats_multi() "... for all peers", and it is called in
--client mode, and (!) in p2mp mode to check if --inactive thresholds
are reached.

The FreeBSD DCO module has no "give me stats for a single peer" call, so
we just call dco_get_peer_stats_multi() to get all of them - and that
function is modified to handle p2p or p2mp mode by checking mode =3D=3D CM_=
TOP.

(dco_linux does about the same in dco_get_peer*() -> ovpn_handle_peer(),
after a few iterations, except that it can query for "just one peer")

"--inactive" still does not work on FreeBSD, because the code in forward.c
looks at counters that are not set by FreeBSD DCO.

Github: OpenVPN/openvpn#898

Change-Id: I38a040a9bdcb44933d4ca538f746af5c61011d7c
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_freebsd.c
1 file changed, 25 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/50/1350/1

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index e4cb71a..2131d9c 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -870,8 +870,20 @@
     {
         const nvlist_t *peer =3D nvpeers[i];
         uint32_t peerid =3D nvlist_get_number(peer, "peerid");
+        const nvlist_t *bytes =3D nvlist_get_nvlist(peer, "bytes");

-        dco_update_peer_stat(dco->c->multi, peerid, nvlist_get_nvlist(peer=
, "bytes"));
+        /* we can end here in p2mp mode, or in p2p mode via
+         * the call to "dco_get_peer_stat()"
+         */
+        if (dco->c->mode =3D=3D CM_TOP)
+        {
+            dco_update_peer_stat(dco->c->multi, peerid, bytes);
+        }
+        else
+        {
+            dco->c->c2.dco_read_bytes =3D nvlist_get_number(bytes, "in");
+            dco->c->c2.dco_write_bytes =3D nvlist_get_number(bytes, "out");
+        }
     }

     nvlist_destroy(nvl);
@@ -882,12 +894,21 @@
 #pragma GCC diagnostic pop
 #endif

+/* get stats for a single peer
+ * we can get here for "the peer stats" in p2p client mode, or by
+ * being queried for a particular peer in p2mp mode, for --inactive
+ */
 int
 dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
 {
-    msg(D_DCO_DEBUG, __func__);
-    /* Not implemented. */
-    return 0;
+    ASSERT(c->c2.tls_multi);
+    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, c->c2.tls_multi->dco_peer=
_id);
+
+    /* unfortunately, the FreeBSD kernel has no peer-specific query - so
+     * we just get all the stats - and if we're there anyway, we can save =
it
+     * for all peers, too...
+     */
+    return dco_get_peer_stats_multi(&c->c1.tuntap->dco, raise_sigusr1_on_e=
rr);
 }

 const char *

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1350?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I38a040a9bdcb44933d4ca538f746af5c61011d7c
Gerrit-Change-Number: 1350
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--sm6JFSPzITo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>cron2 would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1350?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">dco_freebsd: implement dco_get_peer_stats()=
<br><br>This is &quot;fetch read/write statistics for a single peer&quot;, =
complementing<br>dco_get_peer_stats_multi() &quot;... for all peers&quot;, =
and it is called in<br>--client mode, and (!) in p2mp mode to check if --in=
active thresholds<br>are reached.<br><br>The FreeBSD DCO module has no &quo=
t;give me stats for a single peer&quot; call, so<br>we just call dco_get_pe=
er_stats_multi() to get all of them - and that<br>function is modified to h=
andle p2p or p2mp mode by checking mode =3D=3D CM_TOP.<br><br>(dco_linux do=
es about the same in dco_get_peer*() -&gt; ovpn_handle_peer(),<br>after a f=
ew iterations, except that it can query for &quot;just one peer&quot;)<br><=
br>&quot;--inactive&quot; still does not work on FreeBSD, because the code =
in forward.c<br>looks at counters that are not set by FreeBSD DCO.<br><br>G=
ithub: OpenVPN/openvpn#898<br><br>Change-Id: I38a040a9bdcb44933d4ca538f746a=
f5c61011d7c<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<b=
r>M src/openvpn/dco_freebsd.c<br>1 file changed, 25 insertions(+), 4 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/o=
penvpn refs/changes/50/1350/1</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco_freebsd.=
c b/src/openvpn/dco_freebsd.c</span><br><span>index e4cb71a..2131d9c 100644=
</span><br><span>--- a/src/openvpn/dco_freebsd.c</span><br><span>+++ b/src/=
openvpn/dco_freebsd.c</span><br><span>@@ -870,8 +870,20 @@</span><br><span>=
     {</span><br><span>         const nvlist_t *peer =3D nvpeers[i];</span>=
<br><span>         uint32_t peerid =3D nvlist_get_number(peer, &quot;peerid=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        con=
st nvlist_t *bytes =3D nvlist_get_nvlist(peer, &quot;bytes&quot;);</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dco_=
update_peer_stat(dco-&gt;c-&gt;multi, peerid, nvlist_get_nvlist(peer, &quot=
;bytes&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* we can end here in p2mp mode, or in p2p mode via</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+         * the call to &quot;dco_get_pe=
er_stat()&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
dco-&gt;c-&gt;mode =3D=3D CM_TOP)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            dco_update_peer_stat(dco-&gt;c-&gt;multi, peerid, bytes);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            dco-&gt;c-&gt;c2.dco_read_bytes =3D =
nvlist_get_number(bytes, &quot;in&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            dco-&gt;c-&gt;c2.dco_write_bytes =3D nvli=
st_get_number(bytes, &quot;out&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span>     }</span><br><span> </span=
><br><span>     nvlist_destroy(nvl);</span><br><span>@@ -882,12 +894,21 @@<=
/span><br><span> #pragma GCC diagnostic pop</span><br><span> #endif</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* get st=
ats for a single peer</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * we can get here for &quot;the peer stats&quot; in p2p client mode, or =
by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * being queried =
for a particular peer in p2mp mode, for --inactive</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span> int</span><br><span> dc=
o_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)</span>=
<br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D=
_DCO_DEBUG, __func__);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    /* Not implemented. */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    ASSERT(c-&gt;c2.tls_multi);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: peer-id %d&quot;, __func__, c-&g=
t;c2.tls_multi-&gt;dco_peer_id);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 unfortunately, the FreeBSD kernel has no peer-specific query - so</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * we just get all the s=
tats - and if we&#39;re there anyway, we can save it</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * for all peers, too...</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return dco_get_peer_stats_multi(&amp;c-&=
gt;c1.tuntap-&gt;dco, raise_sigusr1_on_err);</span><br><span> }</span><br><=
span> </span><br><span> const char *</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1350?usp=3Dem=
ail">change 1350</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1350?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I38a040a9bdcb44933d4ca538f74=
6af5c61011d7c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1350 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--sm6JFSPzITo=--

