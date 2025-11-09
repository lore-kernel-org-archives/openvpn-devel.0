From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 9 Nov 2025 11:00:27 +0000
In-Reply-To: <gerrit.1762292654000.I38a040a9bdcb44933d4ca538f746af5c61011d7c@...2715...>
References: <gerrit.1762292654000.I38a040a9bdcb44933d4ca538f746af5c61011d7c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., frank@...2641...
Message-ID: <dc81d63abe9dd2e1e23d68ac10a5a87e48c752c7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KYYYUrqFy/U="; charset=UTF-8
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
Cc: ralf_lici <ralf@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--KYYYUrqFy/U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
50?usp=3Demail )

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

v2:
  on AUTH_FAIL, 'dco' struct is not initialized yet -> SIGSEGV crash,
  verify that dco_peer_id is >=3D 0 before calling dco_get_peer_stats_multi=
()

Github: OpenVPN/openvpn#898

Change-Id: I38a040a9bdcb44933d4ca538f746af5c61011d7c
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Ralf Lici <ralf@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1350
Message-Id: <20251109084130.11463-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
273.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_freebsd.c
1 file changed, 30 insertions(+), 4 deletions(-)




diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index f80b6df..21f0ac0 100644
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
@@ -882,12 +894,26 @@
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
+    if (c->c2.tls_multi->dco_peer_id < 0)
+    {
+        return -EINVAL; /* DCO not active yet */
+    }
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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I38a040a9bdcb44933d4ca538f746af5c61011d7c
Gerrit-Change-Number: 1350
Gerrit-PatchSet: 4
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: ralf_lici <ralf@...2726...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--KYYYUrqFy/U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1350?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">dco_freebsd: implement dco_get_peer_stats()<br><=
br>This is &quot;fetch read/write statistics for a single peer&quot;, compl=
ementing<br>dco_get_peer_stats_multi() &quot;... for all peers&quot;, and i=
t is called in<br>--client mode, and (!) in p2mp mode to check if --inactiv=
e thresholds<br>are reached.<br><br>The FreeBSD DCO module has no &quot;giv=
e me stats for a single peer&quot; call, so<br>we just call dco_get_peer_st=
ats_multi() to get all of them - and that<br>function is modified to handle=
 p2p or p2mp mode by checking mode =3D=3D CM_TOP.<br><br>(dco_linux does ab=
out the same in dco_get_peer*() -&gt; ovpn_handle_peer(),<br>after a few it=
erations, except that it can query for &quot;just one peer&quot;)<br><br>&q=
uot;--inactive&quot; still does not work on FreeBSD, because the code in fo=
rward.c<br>looks at counters that are not set by FreeBSD DCO.<br><br>v2:<br=
>  on AUTH_FAIL, &#39;dco&#39; struct is not initialized yet -&gt; SIGSEGV =
crash,<br>  verify that dco_peer_id is &gt;=3D 0 before calling dco_get_pee=
r_stats_multi()<br><br>Github: OpenVPN/openvpn#898<br><br>Change-Id: I38a04=
0a9bdcb44933d4ca538f746af5c61011d7c<br>Signed-off-by: Gert Doering &lt;gert=
@...1296...&gt;<br>Acked-by: Ralf Lici &lt;ralf@...2726...&gt;<br>Gerrit UR=
L: https://gerrit.openvpn.net/c/openvpn/+/1350<br>Message-Id: &lt;202511090=
84130.11463-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/open=
vpn-devel@lists.sourceforge.net/msg34273.html<br>Signed-off-by: Gert Doerin=
g &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/dco_freebsd.c<br>1 file c=
hanged, 30 insertions(+), 4 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span=
><br><span>index f80b6df..21f0ac0 100644</span><br><span>--- a/src/openvpn/=
dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><sp=
an>@@ -870,8 +870,20 @@</span><br><span>     {</span><br><span>         con=
st nvlist_t *peer =3D nvpeers[i];</span><br><span>         uint32_t peerid =
=3D nvlist_get_number(peer, &quot;peerid&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        const nvlist_t *bytes =3D nvlist_get_n=
vlist(peer, &quot;bytes&quot;);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        dco_update_peer_stat(dco-&gt;c-&gt;mult=
i, peerid, nvlist_get_nvlist(peer, &quot;bytes&quot;));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        /* we can end here in p2mp mode=
, or in p2p mode via</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+         * the call to &quot;dco_get_peer_stat()&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+         */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (dco-&gt;c-&gt;mode =3D=3D CM_TOP)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            dco_update_peer_sta=
t(dco-&gt;c-&gt;multi, peerid, bytes);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    dco-&gt;c-&gt;c2.dco_read_bytes =3D nvlist_get_number(bytes, &quot;in&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            d=
co-&gt;c-&gt;c2.dco_write_bytes =3D nvlist_get_number(bytes, &quot;out&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span>     }</span><br><span> </span><br><span>     nvlist_destroy(nvl)=
;</span><br><span>@@ -882,12 +894,26 @@</span><br><span> #pragma GCC diagno=
stic pop</span><br><span> #endif</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/* get stats for a single peer</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * we can get here for &quot;the =
peer stats&quot; in p2p client mode, or by</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * being queried for a particular peer in p2mp mode,=
 for --inactive</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span> int</span><br><span> dco_get_peer_stats(struct context *c,=
 const bool raise_sigusr1_on_err)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, __func__);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    /* Not implemented. */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    return 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(c-&gt;c2.tls_multi);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &=
quot;%s: peer-id %d&quot;, __func__, c-&gt;c2.tls_multi-&gt;dco_peer_id);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2.tls_multi-&gt;dco_peer_=
id &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return -EINVAL;=
 /* DCO not active yet */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* unfortunately, the F=
reeBSD kernel has no peer-specific query - so</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * we just get all the stats - and if we&#39;=
re there anyway, we can save it</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * for all peers, too...</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return dco_get_peer_stats_multi(&amp;c-&gt;c1.tuntap-&gt;dco, =
raise_sigusr1_on_err);</span><br><span> }</span><br><span> </span><br><span=
> const char *</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1350?usp=3Demail">change 1350</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1350?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I38a040a9bdcb44933d4ca538f74=
6af5c61011d7c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1350 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
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

--KYYYUrqFy/U=--

