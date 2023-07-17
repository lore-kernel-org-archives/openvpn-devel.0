From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 17 Jul 2023 14:17:17 +0000
In-Reply-To: <gerrit.1679478483000.I465febdf7ee5fe573e88255844f718efb60f8e8a@...2715...>
References: <gerrit.1679478483000.I465febdf7ee5fe573e88255844f718efb60f8e8a@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, lstipakov@...277..., a@...2181...
Message-ID: <f856bfd7f55dc089e0875db077914c6eac398696-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="e+I5FS/VS9c="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: Print DCO
 client stats on SIGUSR2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>

--e+I5FS/VS9c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

flichtenheld has submitted this change. ( http://gerrit.openvpn.net/c/openv=
pn/+/202?usp=3Demail )

Change subject: Print DCO client stats on SIGUSR2
......................................................................

Print DCO client stats on SIGUSR2

Change-Id: I465febdf7ee5fe573e88255844f718efb60f8e8a
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20230322113249.2039-1-lstipakov@...277...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26=
471.html
Signed-off-by: Gert Doering <gert@...1296...>
(cherry picked from commit d5238627e4fab93a6c09816c60eb90e237b626c3)
---
M src/openvpn/sig.c
M src/openvpn/sig.h
2 files changed, 10 insertions(+), 5 deletions(-)




diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 5b89bb4..05c0054 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -300,18 +300,23 @@
  * Triggered by SIGUSR2 or F2 on Windows.
  */
 void
-print_status(const struct context *c, struct status_output *so)
+print_status(struct context *c, struct status_output *so)
 {
     struct gc_arena gc =3D gc_new();

     status_reset(so);

+    if (dco_enabled(&c->options))
+    {
+        dco_get_peer_stats(c);
+    }
+
     status_printf(so, "OpenVPN STATISTICS");
     status_printf(so, "Updated,%s", time_string(0, 0, false, &gc));
     status_printf(so, "TUN/TAP read bytes," counter_format, c->c2.tun_read=
_bytes);
     status_printf(so, "TUN/TAP write bytes," counter_format, c->c2.tun_wri=
te_bytes);
-    status_printf(so, "TCP/UDP read bytes," counter_format, c->c2.link_rea=
d_bytes);
-    status_printf(so, "TCP/UDP write bytes," counter_format, c->c2.link_wr=
ite_bytes);
+    status_printf(so, "TCP/UDP read bytes," counter_format, c->c2.link_rea=
d_bytes + c->c2.dco_read_bytes);
+    status_printf(so, "TCP/UDP write bytes," counter_format, c->c2.link_wr=
ite_bytes + c->c2.dco_write_bytes);
     status_printf(so, "Auth read bytes," counter_format, c->c2.link_read_b=
ytes_auth);
 #ifdef USE_COMP
     if (c->c2.comp_context)
@@ -402,7 +407,7 @@
 }

 static void
-process_sigusr2(const struct context *c)
+process_sigusr2(struct context *c)
 {
     struct status_output *so =3D status_open(NULL, 0, M_INFO, NULL, 0);
     print_status(c, so);
diff --git a/src/openvpn/sig.h b/src/openvpn/sig.h
index 4858eb9..b09dfab 100644
--- a/src/openvpn/sig.h
+++ b/src/openvpn/sig.h
@@ -69,7 +69,7 @@

 void print_signal(const struct signal_info *si, const char *title, int msg=
level);

-void print_status(const struct context *c, struct status_output *so);
+void print_status(struct context *c, struct status_output *so);

 void remap_signal(struct context *c);


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/202?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I465febdf7ee5fe573e88255844f718efb60f8e8a
Gerrit-Change-Number: 202
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2
Gerrit-Reviewer: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--e+I5FS/VS9c=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>flichtenheld <strong>submitted</strong> this change.</p><p><a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/202?usp=3Demail">View Change</a></p><di=
v style=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">Print DCO client stats on SIGUSR2<br><b=
r>Change-Id: I465febdf7ee5fe573e88255844f718efb60f8e8a<br>Signed-off-by: Le=
v Stipakov &lt;lev@...515...&gt;<br>Acked-by: Gert Doering &lt;gert@...1726...=
...&gt;<br>Message-Id: &lt;20230322113249.2039-1-lstipakov@...277...&gt;<br=
>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg2=
6471.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>(cherry=
 picked from commit d5238627e4fab93a6c09816c60eb90e237b626c3)<br>---<br>M s=
rc/openvpn/sig.c<br>M src/openvpn/sig.h<br>2 files changed, 10 insertions(+=
), 5 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c</span><br><span>index=
 5b89bb4..05c0054 100644</span><br><span>--- a/src/openvpn/sig.c</span><br>=
<span>+++ b/src/openvpn/sig.c</span><br><span>@@ -300,18 +300,23 @@</span><=
br><span>  * Triggered by SIGUSR2 or F2 on Windows.</span><br><span>  */</s=
pan><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pr=
int_status(const struct context *c, struct status_output *so)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+print_status(struct context *c, s=
truct status_output *so)</span><br><span> {</span><br><span>     struct gc_=
arena gc =3D gc_new();</span><br><span> </span><br><span>     status_reset(=
so);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (dco_enabled(&amp;c-&gt;options))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        dco_get_peer_stats(c);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span>     status_printf(so, &quot;OpenVPN STATISTICS&quo=
t;);</span><br><span>     status_printf(so, &quot;Updated,%s&quot;, time_st=
ring(0, 0, false, &amp;gc));</span><br><span>     status_printf(so, &quot;T=
UN/TAP read bytes,&quot; counter_format, c-&gt;c2.tun_read_bytes);</span><b=
r><span>     status_printf(so, &quot;TUN/TAP write bytes,&quot; counter_for=
mat, c-&gt;c2.tun_write_bytes);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    status_printf(so, &quot;TCP/UDP read bytes,&quot; counter_for=
mat, c-&gt;c2.link_read_bytes);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    status_printf(so, &quot;TCP/UDP write bytes,&quot; counter_fo=
rmat, c-&gt;c2.link_write_bytes);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    status_printf(so, &quot;TCP/UDP read bytes,&quot; counter=
_format, c-&gt;c2.link_read_bytes + c-&gt;c2.dco_read_bytes);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    status_printf(so, &quot;TCP/U=
DP write bytes,&quot; counter_format, c-&gt;c2.link_write_bytes + c-&gt;c2.=
dco_write_bytes);</span><br><span>     status_printf(so, &quot;Auth read by=
tes,&quot; counter_format, c-&gt;c2.link_read_bytes_auth);</span><br><span>=
 #ifdef USE_COMP</span><br><span>     if (c-&gt;c2.comp_context)</span><br>=
<span>@@ -402,7 +407,7 @@</span><br><span> }</span><br><span> </span><br><s=
pan> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-proce=
ss_sigusr2(const struct context *c)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+process_sigusr2(struct context *c)</span><br><span> {</span=
><br><span>     struct status_output *so =3D status_open(NULL, 0, M_INFO, N=
ULL, 0);</span><br><span>     print_status(c, so);</span><br><span>diff --g=
it a/src/openvpn/sig.h b/src/openvpn/sig.h</span><br><span>index 4858eb9..b=
09dfab 100644</span><br><span>--- a/src/openvpn/sig.h</span><br><span>+++ b=
/src/openvpn/sig.h</span><br><span>@@ -69,7 +69,7 @@</span><br><span> </spa=
n><br><span> void print_signal(const struct signal_info *si, const char *ti=
tle, int msglevel);</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-void print_status(const struct context *c, struct status_ou=
tput *so);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void prin=
t_status(struct context *c, struct status_output *so);</span><br><span> </s=
pan><br><span> void remap_signal(struct context *c);</span><br><span> </spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/202?usp=3Demail">change 202</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/202?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I465febdf7ee5fe573e88255844f=
718efb60f8e8a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 202 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--e+I5FS/VS9c=--

