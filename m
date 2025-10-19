From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Sun, 19 Oct 2025 12:05:57 +0000
In-Reply-To: <gerrit.1760513121000.I53dd40fabdeacb9dca843e28fdd3b357711c5a84@...2715...>
References: <gerrit.1760513121000.I53dd40fabdeacb9dca843e28fdd3b357711c5a84@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726..., gert@...1296...
Message-ID: <c87308709c7cecdb2ad5e4fa1f246f196cdfa3be-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Tve249g0UFo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco-freebsd: store
 peer stats directly in c2
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

--Tve249g0UFo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, ordex, plaisthos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1275?usp=3Demail

to look at the new patch set (#4).


Change subject: dco-freebsd: store peer stats directly in c2
......................................................................

dco-freebsd: store peer stats directly in c2

The dco_context_t structure includes a reference to the general context
structure c, which allows us to store dco_read_bytes and dco_write_bytes
directly as c2 fields. This aligns the FreeBSD implementation with how
we handle DCO peer stats on Linux and Windows.

Change-Id: I53dd40fabdeacb9dca843e28fdd3b357711c5a84
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M src/openvpn/dco_freebsd.c
1 file changed, 16 insertions(+), 19 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/75/1275/4

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 947a769..e51f8dd 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -564,6 +564,21 @@
     return ret;
 }

+static void
+dco_update_peer_stat(struct multi_context *m, uint32_t peerid, const nvlis=
t_t *nvl)
+{
+    if (peerid >=3D m->max_clients || !m->instances[peerid])
+    {
+        msg(M_WARN, "dco_update_peer_stat: invalid peer ID %d returned by =
kernel", peerid);
+        return;
+    }
+
+    struct multi_instance *mi =3D m->instances[peerid];
+
+    mi->context.c2.dco_read_bytes =3D nvlist_get_number(nvl, "in");
+    mi->context.c2.dco_write_bytes =3D nvlist_get_number(nvl, "out");
+}
+
 int
 dco_do_read(dco_context_t *dco)
 {
@@ -619,10 +634,7 @@

             if (nvlist_exists_nvlist(nvl, "bytes"))
             {
-                const nvlist_t *bytes =3D nvlist_get_nvlist(nvl, "bytes");
-
-                dco->dco_read_bytes =3D nvlist_get_number(bytes, "in");
-                dco->dco_write_bytes =3D nvlist_get_number(bytes, "out");
+                dco_update_peer_stat(dco->c->multi, dco->dco_message_peer_=
id, nvlist_get_nvlist(nvl, "bytes"));
             }

             dco->dco_message_type =3D OVPN_CMD_DEL_PEER;
@@ -777,21 +789,6 @@
     nvlist_destroy(nvl);
 }

-static void
-dco_update_peer_stat(struct multi_context *m, uint32_t peerid, const nvlis=
t_t *nvl)
-{
-    if (peerid >=3D m->max_clients || !m->instances[peerid])
-    {
-        msg(M_WARN, "dco_update_peer_stat: invalid peer ID %d returned by =
kernel", peerid);
-        return;
-    }
-
-    struct multi_instance *mi =3D m->instances[peerid];
-
-    mi->context.c2.dco_read_bytes =3D nvlist_get_number(nvl, "in");
-    mi->context.c2.dco_write_bytes =3D nvlist_get_number(nvl, "out");
-}
-
 int
 dco_get_peer_stats_multi(dco_context_t *dco, const bool raise_sigusr1_on_e=
rr)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1275?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I53dd40fabdeacb9dca843e28fdd3b357711c5a84
Gerrit-Change-Number: 1275
Gerrit-PatchSet: 4
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <antonio@...2726...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>

--Tve249g0UFo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, ordex, plaisthos. </p>
<p>ralf_lici <strong>uploaded patch set #4</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1275?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">dco-freebsd: store peer stats directly in c2<br><br=
>The dco_context_t structure includes a reference to the general context<br=
>structure c, which allows us to store dco_read_bytes and dco_write_bytes<b=
r>directly as c2 fields. This aligns the FreeBSD implementation with how<br=
>we handle DCO peer stats on Linux and Windows.<br><br>Change-Id: I53dd40fa=
bdeacb9dca843e28fdd3b357711c5a84<br>Signed-off-by: Ralf Lici &lt;ralf@...1664...=
26...&gt;<br>---<br>M src/openvpn/dco_freebsd.c<br>1 file changed, 16 inser=
tions(+), 19 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.=
openvpn.net:29418/openvpn refs/changes/75/1275/4</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span><br><span>index 947a=
769..e51f8dd 100644</span><br><span>--- a/src/openvpn/dco_freebsd.c</span><=
br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><span>@@ -564,6 +564,21 =
@@</span><br><span>     return ret;</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+dco_update_peer_stat(struct mu=
lti_context *m, uint32_t peerid, const nvlist_t *nvl)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (peerid &gt;=3D m-&gt;max_clients || !m-&gt;instance=
s[peerid])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &qu=
ot;dco_update_peer_stat: invalid peer ID %d returned by kernel&quot;, peeri=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct multi_instance *mi =3D m-&gt;instances[pee=
rid];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;context.c2.dco_read_by=
tes =3D nvlist_get_number(nvl, &quot;in&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    mi-&gt;context.c2.dco_write_bytes =3D nvlis=
t_get_number(nvl, &quot;out&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> int</span><br><span> dco_do_read(dco_context_t *dco)</span>=
<br><span> {</span><br><span>@@ -619,10 +634,7 @@</span><br><span> </span><=
br><span>             if (nvlist_exists_nvlist(nvl, &quot;bytes&quot;))</sp=
an><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                const nvlist_t *bytes =3D nvlist_get_nvlist(nvl, &quo=
t;bytes&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                dco-&gt;dco=
_read_bytes =3D nvlist_get_number(bytes, &quot;in&quot;);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                dco-&gt;dco_write_bytes=
 =3D nvlist_get_number(bytes, &quot;out&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                dco_update_peer_stat(dco-&gt;c-=
&gt;multi, dco-&gt;dco_message_peer_id, nvlist_get_nvlist(nvl, &quot;bytes&=
quot;));</span><br><span>             }</span><br><span> </span><br><span> =
            dco-&gt;dco_message_type =3D OVPN_CMD_DEL_PEER;</span><br><span=
>@@ -777,21 +789,6 @@</span><br><span>     nvlist_destroy(nvl);</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_up=
date_peer_stat(struct multi_context *m, uint32_t peerid, const nvlist_t *nv=
l)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (peerid &gt;=3D m-&gt;max_client=
s || !m-&gt;instances[peerid])</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 msg(M_WARN, &quot;dco_update_peer_stat: invalid peer ID %d returned by ker=
nel&quot;, peerid);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct multi_instance *mi =3D m-&gt;ins=
tances[peerid];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    mi-&gt;context.c2.dco_r=
ead_bytes =3D nvlist_get_number(nvl, &quot;in&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    mi-&gt;context.c2.dco_write_bytes =3D n=
vlist_get_number(nvl, &quot;out&quot;);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span> int</span><br><span> dco_get_peer_stats_multi(dco_context_t=
 *dco, const bool raise_sigusr1_on_err)</span><br><span> {</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1275?usp=3Demail">change 1275</a>. To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1275?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I53dd40fabdeacb9dca843e28fdd=
3b357711c5a84 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1275 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@...2726...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>

</body></html>=

--Tve249g0UFo=--

