From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Fri, 20 Dec 2024 17:12:38 +0000
References: <gerrit.1734714757000.I806757a8c6f9a589665624f176391b5f7b87f581@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <190e4fc84e79b0c54644bfc981daf36b5995a079-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5JT/kLUiP/4="; charset=UTF-8
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5JT/kLUiP/4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/844?usp=3Demail

to review the following change.


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
1 file changed, 23 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/44/844/1

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 2c72001..5feffba 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1227,12 +1227,33 @@
 {
     perf_push(PERF_PROC_IN_LINK);

+    struct gc_arena gc =3D gc_new();
+    bool floated =3D false;
     struct link_socket_info *lsi =3D &sock->info;
     const uint8_t *orig_buf =3D c->c2.buf.data;
+    const struct link_socket_actual *incoming =3D &c->c2.from;
+    struct link_socket_actual *remote =3D c->c2.to_link_addr;
+    const sa_family_t family =3D incoming->dest.addr.sa.sa_family;

-    process_incoming_link_part1(c, lsi, false);
-    process_incoming_link_part2(c, lsi, orig_buf);
+    if (remote && (family =3D=3D AF_INET || family =3D=3D AF_INET6))
+    {
+        floated =3D !link_socket_actual_match(incoming, remote);
+    }

+    if (process_incoming_link_part1(c, lsi, floated))
+    {
+        if (floated && c->c2.buf.len > 0)
+        {
+            msg(D_LOW, "peer floated from %s to %s",
+                print_link_socket_actual(remote, &gc),
+                print_link_socket_actual(incoming, &gc));
+            link_socket_set_outgoing_addr(lsi, &c->c2.from, NULL, c->c2.es=
);
+            tls_update_remote_addr(c->c2.tls_multi, incoming);
+        }
+        process_incoming_link_part2(c, lsi, orig_buf);
+    }
+
+    gc_free(&gc);
     perf_pop();
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/844?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I806757a8c6f9a589665624f176391b5f7b87f581
Gerrit-Change-Number: 844
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--5JT/kLUiP/4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ralf_lici would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/844?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Fix float support in P2P topology<br><br>Fix the handling of =
floating operations in P2P topology, where new UDP<br>endpoints were previo=
usly ignored. When floating occurs, this update<br>processes the new endpoi=
nts and updates the address if the `--float`<br>option is specified or `--r=
emote` is omitted.<br><br>Since the same code path is used for clients in M=
P topology, this change<br>also enables processing of server floating opera=
tions from the client<br>perspective.<br><br>Change-Id: I806757a8c6f9a58966=
5624f176391b5f7b87f581<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt;<=
br>---<br>M src/openvpn/forward.c<br>1 file changed, 23 insertions(+), 2 de=
letions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/c=
hanges/44/844/1</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/src/openvpn/forward.c b/src/openvpn/fo=
rward.c</span><br><span>index 2c72001..5feffba 100644</span><br><span>--- a=
/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</span><b=
r><span>@@ -1227,12 +1227,33 @@</span><br><span> {</span><br><span>     per=
f_push(PERF_PROC_IN_LINK);</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    bool floated =3D false;</span=
><br><span>     struct link_socket_info *lsi =3D &amp;sock-&gt;info;</span>=
<br><span>     const uint8_t *orig_buf =3D c-&gt;c2.buf.data;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const struct link_socket_actu=
al *incoming =3D &amp;c-&gt;c2.from;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct link_socket_actual *remote =3D c-&gt;c2.to_link=
_addr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const sa_=
family_t family =3D incoming-&gt;dest.addr.sa.sa_family;</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    process_incoming_l=
ink_part1(c, lsi, false);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    process_incoming_link_part2(c, lsi, orig_buf);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (remote &amp;&amp; (family =3D=3D=
 AF_INET || family =3D=3D AF_INET6))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        floated =3D !link_socket_actual_match(incoming, remote);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (process_incomin=
g_link_part1(c, lsi, floated))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (floated &amp;&amp; c-&gt;c2.buf.len &gt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;peer floated from %s t=
o %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        print_link_socket_actual(remote, &amp;gc),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                print_link_socket_actual(inc=
oming, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          link_socket_set_outgoing_addr(lsi, &amp;c-&gt;c2.from, NULL, c-&g=
t;c2.es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  tls_update_remote_addr(c-&gt;c2.tls_multi, incoming);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        process_incoming_link_part2(c, lsi, orig_=
buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span>     perf=
_pop();</span><br><span> }</span><br><span> </span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/844?u=
sp=3Demail">change 844</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><d=
iv itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/844?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I806757a8c6f9a589665624f1763=
91b5f7b87f581 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 844 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--5JT/kLUiP/4=--

