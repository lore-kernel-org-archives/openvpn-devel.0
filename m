From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Tue, 7 Jan 2025 09:51:15 +0000
In-Reply-To: <gerrit.1734714757000.I806757a8c6f9a589665624f176391b5f7b87f581@...2715...>
References: <gerrit.1734714757000.I806757a8c6f9a589665624f176391b5f7b87f581@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <40bc1d3454e4c415c1f162c67dffc45085f4b7b6-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="D/Y1D+yJpDg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix float support in
 P2P topology
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: cron2 <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--D/Y1D+yJpDg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/844?usp=3Demail

to look at the new patch set (#2).


Change subject: Fix float support in P2P topology
......................................................................

Fix float support in P2P topology

Fix the handling of floating operations in P2P topology, where new UDP
endpoints were previously ignored. When floating occurs, this update
processes the new endpoints and updates the address if the `--float`
option is specified or `--remote` is omitted.

Since the same code path is used for clients in MP topology, this change
also enables processing of server floating operations from the client
perspective.

Change-Id: I806757a8c6f9a589665624f176391b5f7b87f581
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M src/openvpn/forward.c
1 file changed, 25 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/44/844/2

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 2c72001..0aa5b6a 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1227,10 +1227,34 @@
 {
     perf_push(PERF_PROC_IN_LINK);

+    bool floated =3D false;
     struct link_socket_info *lsi =3D &sock->info;
     const uint8_t *orig_buf =3D c->c2.buf.data;
+    const struct link_socket_actual *incoming =3D &c->c2.from;
+    struct link_socket_actual *remote =3D c->c2.to_link_addr;
=20
-    process_incoming_link_part1(c, lsi, false);
+    if (remote)
+    {
+        floated =3D !link_socket_actual_match(incoming, remote);
+    }
+
+    process_incoming_link_part1(c, lsi, floated);
+    if (floated && c->c2.buf.len > 0)
+    {
+        struct gc_arena gc =3D gc_new();
+
+        msg(D_LOW, "peer floated from %s to %s",
+            print_link_socket_actual(remote, &gc),
+            print_link_socket_actual(incoming, &gc));
+
+        link_socket_set_outgoing_addr(lsi, &c->c2.from, NULL, c->c2.es);
+        if (TLS_MODE(c))
+        {
+            tls_update_remote_addr(c->c2.tls_multi, incoming);
+        }
+
+        gc_free(&gc);
+    }
     process_incoming_link_part2(c, lsi, orig_buf);

     perf_pop();

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/844?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I806757a8c6f9a589665624f176391b5f7b87f581
Gerrit-Change-Number: 844
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--D/Y1D+yJpDg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p>ralf_lici <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/844?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Fix float support in P2P topology<br><br>Fix the handling of floating=
 operations in P2P topology, where new UDP<br>endpoints were previously ign=
ored. When floating occurs, this update<br>processes the new endpoints and =
updates the address if the `--float`<br>option is specified or `--remote` i=
s omitted.<br><br>Since the same code path is used for clients in MP topolo=
gy, this change<br>also enables processing of server floating operations fr=
om the client<br>perspective.<br><br>Change-Id: I806757a8c6f9a589665624f176=
391b5f7b87f581<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br>---<b=
r>M src/openvpn/forward.c<br>1 file changed, 25 insertions(+), 1 deletion(-=
)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/44=
/844/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</=
span><br><span>index 2c72001..0aa5b6a 100644</span><br><span>--- a/src/open=
vpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@=
@ -1227,10 +1227,34 @@</span><br><span> {</span><br><span>     perf_push(PE=
RF_PROC_IN_LINK);</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    bool floated =3D false;</span><br><span>     struct lin=
k_socket_info *lsi =3D &amp;sock-&gt;info;</span><br><span>     const uint8=
_t *orig_buf =3D c-&gt;c2.buf.data;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const struct link_socket_actual *incoming =3D &amp;c-&g=
t;c2.from;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t link_socket_actual *remote =3D c-&gt;c2.to_link_addr;</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    process_incoming_li=
nk_part1(c, lsi, false);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (remote)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        float=
ed =3D !link_socket_actual_match(incoming, remote);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    process_incoming_link_part1(c, lsi, floated);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (floated &amp;&amp; c-&gt;c2.buf.len =
&gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        struct gc_arena gc=
 =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot=
;peer floated from %s to %s&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            print_link_socket_actual(remote, &amp;gc),</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            print_link_so=
cket_actual(incoming, &amp;gc));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  link_socket_set_outgoing_addr(lsi, &amp;c-&gt;c2.from, NULL, c-&gt;c2.es)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (TLS_MO=
DE(c))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            tls_update_=
remote_addr(c-&gt;c2.tls_multi, incoming);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span>     process_incoming_link_part2(c, lsi, orig_buf);</=
span><br><span> </span><br><span>     perf_pop();</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
844?usp=3Demail">change 844</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/844?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I806757a8c6f9a589665624f1763=
91b5f7b87f581 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 844 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--D/Y1D+yJpDg=--

