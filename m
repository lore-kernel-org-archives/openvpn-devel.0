From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 19 Oct 2025 17:07:53 +0000
In-Reply-To: <gerrit.1760513121000.I53dd40fabdeacb9dca843e28fdd3b357711c5a84@...2715...>
References: <gerrit.1760513121000.I53dd40fabdeacb9dca843e28fdd3b357711c5a84@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., frank@...2641...,
 antonio@...2726...
Message-ID: <2807b7c4e2ee73c80902be3a1b2b0dcfe97eab07-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YZvsWJsmpzc="; charset=UTF-8
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
To: ralf_lici <ralf@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YZvsWJsmpzc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
75?usp=3Demail )

Change subject: dco-freebsd: store peer stats directly in c2
......................................................................

dco-freebsd: store peer stats directly in c2

The dco_context_t structure includes a reference to the general context
structure c, which allows us to store dco_read_bytes and dco_write_bytes
directly as c2 fields. This aligns the FreeBSD implementation with how
we handle DCO peer stats on Linux and Windows.

Change-Id: I53dd40fabdeacb9dca843e28fdd3b357711c5a84
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1275
Message-Id: <20251019170249.30942-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
791.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_freebsd.c
1 file changed, 16 insertions(+), 19 deletions(-)




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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I53dd40fabdeacb9dca843e28fdd3b357711c5a84
Gerrit-Change-Number: 1275
Gerrit-PatchSet: 5
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <antonio@...2726...>

--YZvsWJsmpzc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1275?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">dco-freebsd: store peer stats directly in c2<br>=
<br>The dco_context_t structure includes a reference to the general context=
<br>structure c, which allows us to store dco_read_bytes and dco_write_byte=
s<br>directly as c2 fields. This aligns the FreeBSD implementation with how=
<br>we handle DCO peer stats on Linux and Windows.<br><br>Change-Id: I53dd4=
0fabdeacb9dca843e28fdd3b357711c5a84<br>Signed-off-by: Ralf Lici &lt;ralf@...1186...=
.2726...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit UR=
L: https://gerrit.openvpn.net/c/openvpn/+/1275<br>Message-Id: &lt;202510191=
70249.30942-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/open=
vpn-devel@lists.sourceforge.net/msg33791.html<br>Signed-off-by: Gert Doerin=
g &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/dco_freebsd.c<br>1 file c=
hanged, 16 insertions(+), 19 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span=
><br><span>index 947a769..e51f8dd 100644</span><br><span>--- a/src/openvpn/=
dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><sp=
an>@@ -564,6 +564,21 @@</span><br><span>     return ret;</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_updat=
e_peer_stat(struct multi_context *m, uint32_t peerid, const nvlist_t *nvl)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (peerid &gt;=3D m-&gt;max_clien=
ts || !m-&gt;instances[peerid])</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      msg(M_WARN, &quot;dco_update_peer_stat: invalid peer ID %d returned b=
y kernel&quot;, peerid);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance *mi =
=3D m-&gt;instances[peerid];</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt=
;context.c2.dco_read_bytes =3D nvlist_get_number(nvl, &quot;in&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;context.c2.dc=
o_write_bytes =3D nvlist_get_number(nvl, &quot;out&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> int</span><br><span> dco_do_read(dco=
_context_t *dco)</span><br><span> {</span><br><span>@@ -619,10 +634,7 @@</s=
pan><br><span> </span><br><span>             if (nvlist_exists_nvlist(nvl, =
&quot;bytes&quot;))</span><br><span>             {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                const nvlist_t *bytes =3D nvli=
st_get_nvlist(nvl, &quot;bytes&quot;);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            dco-&gt;dco_read_bytes =3D nvlist_get_number(bytes, &quot;in&qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
dco-&gt;dco_write_bytes =3D nvlist_get_number(bytes, &quot;out&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                dco_upda=
te_peer_stat(dco-&gt;c-&gt;multi, dco-&gt;dco_message_peer_id, nvlist_get_n=
vlist(nvl, &quot;bytes&quot;));</span><br><span>             }</span><br><s=
pan> </span><br><span>             dco-&gt;dco_message_type =3D OVPN_CMD_DE=
L_PEER;</span><br><span>@@ -777,21 +789,6 @@</span><br><span>     nvlist_de=
stroy(nvl);</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-dco_update_peer_stat(struct multi_context *m, uint32_t pee=
rid, const nvlist_t *nvl)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (peerid &=
gt;=3D m-&gt;max_clients || !m-&gt;instances[peerid])</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        msg(M_WARN, &quot;dco_update_peer_stat: invalid pee=
r ID %d returned by kernel&quot;, peerid);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        return;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct multi_insta=
nce *mi =3D m-&gt;instances[peerid];</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mi=
-&gt;context.c2.dco_read_bytes =3D nvlist_get_number(nvl, &quot;in&quot;);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mi-&gt;context.c2.=
dco_write_bytes =3D nvlist_get_number(nvl, &quot;out&quot;);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span> int</span><br><span> dco_get_peer_stat=
s_multi(dco_context_t *dco, const bool raise_sigusr1_on_err)</span><br><spa=
n> {</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/1275?usp=3Demail">change 1275</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1275?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I53dd40fabdeacb9dca843e28fdd=
3b357711c5a84 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1275 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
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

</body></html>=

--YZvsWJsmpzc=--

