From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 5 Sep 2025 17:55:31 +0000
References: <gerrit.1757094927000.Ib748e726eb84dcbe8a48b297d165dec80c0e578d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., ralf@...2726...
Message-ID: <10f37f463ab311b896662ceb5966c233b8a9e480-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OUQfPoy/5c4="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: dco: backport
 OS-independent part of peer float support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, ralf_lici <ralf@...2726...>

--OUQfPoy/5c4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1169?usp=3Demail

to review the following change.


Change subject: dco: backport OS-independent part of peer float support
......................................................................

dco: backport OS-independent part of peer float support

This is a backport of commit cb8a0f6f5741d102b667d98370ab4d553503d0b5,
which introduces float support for DCO linux, Windows, and the
OS-independent parts.

DCO linux/windows in 2.6 has no float support kernel-side, so this
ignores all OS dependent parts, backporting just enough to add
FreeBSD support in the next patch.

One notable difference in the backport is that 2.6 has no multi-socket
support, so all the "link_sockets[0]" occurances need to be changed back
to "link_socket".

Change-Id: Ib748e726eb84dcbe8a48b297d165dec80c0e578d
Signed-off-by: Ralf Lici <ralf@...2726...>
Signed-off-by: Gert Doering <gert@...1296...>
(cherry picked from commit cb8a0f6f5741d102b667d98370ab4d553503d0b5)
---
M src/openvpn/forward.c
M src/openvpn/forward.h
M src/openvpn/multi.c
3 files changed, 73 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/69/1169/1

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 0f2ec07..ab5ebda 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1234,6 +1234,41 @@
     perf_pop();
 }

+void
+extract_dco_float_peer_addr(const sa_family_t socket_family,
+                            struct openvpn_sockaddr *out_osaddr,
+                            const struct sockaddr *float_sa)
+{
+    if (float_sa->sa_family =3D=3D AF_INET)
+    {
+        struct sockaddr_in *float4 =3D (struct sockaddr_in *)float_sa;
+        /* DCO treats IPv4-mapped IPv6 addresses as pure IPv4. However, on=
 a
+         * dual-stack socket, we need to preserve the mapping otherwise op=
envpn
+         * will not be able to find the peer by its transport address.
+         */
+        if (socket_family =3D=3D AF_INET6)
+        {
+            out_osaddr->addr.in6.sin6_family =3D AF_INET6;
+            out_osaddr->addr.in6.sin6_port =3D float4->sin_port;
+
+            memset(&out_osaddr->addr.in6.sin6_addr.s6_addr, 0, 10);
+            out_osaddr->addr.in6.sin6_addr.s6_addr[10] =3D 0xff;
+            out_osaddr->addr.in6.sin6_addr.s6_addr[11] =3D 0xff;
+            memcpy(&out_osaddr->addr.in6.sin6_addr.s6_addr[12],
+                   &float4->sin_addr.s_addr, sizeof(in_addr_t));
+        }
+        else
+        {
+            memcpy(&out_osaddr->addr.in4, float4, sizeof(struct sockaddr_i=
n));
+        }
+    }
+    else
+    {
+        struct sockaddr_in6 *float6 =3D (struct sockaddr_in6 *)float_sa;
+        memcpy(&out_osaddr->addr.in6, float6, sizeof(struct sockaddr_in6));
+    }
+}
+
 static void
 process_incoming_dco(struct context *c)
 {
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 245a802..3d0abd5 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -189,6 +189,21 @@
 void process_incoming_link_part2(struct context *c, struct link_socket_inf=
o *lsi, const uint8_t *orig_buf);

 /**
+ * Transfers \c float_sa data extracted from an incoming DCO
+ * PEER_FLOAT_NTF to \c out_osaddr for later processing.
+ *
+ * @param socket_family - The address family of the socket
+ * @param out_osaddr - openvpn_sockaddr struct that will be filled the new
+ *      address data
+ * @param float_sa - The sockaddr struct containing the data received from=
 the
+ *      DCO notification
+ */
+void
+extract_dco_float_peer_addr(sa_family_t socket_family,
+                            struct openvpn_sockaddr *out_osaddr,
+                            const struct sockaddr *float_sa);
+
+/**
  * Write a packet to the external network interface.
  * @ingroup external_multiplexer
  *
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 199f655..eb5f932 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3169,6 +3169,18 @@
             goto done;
         }

+        /* It doesn't make sense to let a peer float to the address it alr=
eady
+         * has, so we disallow it. This can happen if a DCO netlink notifi=
cation
+         * gets lost and we miss a floating step.
+         */
+        if (m1->peer_id =3D=3D m2->peer_id)
+        {
+            msg(M_WARN, "disallowing peer %" PRIu32 " (%s) from floating t=
o "
+                "its own address (%s)",
+                m1->peer_id, tls_common_name(mi->context.c2.tls_multi, fal=
se),
+                mroute_addr_print(&mi->real, &gc));
+            goto done;
+        }
         msg(D_MULTI_MEDIUM, "closing instance %s", multi_instance_string(e=
x_mi, false, &gc));
         multi_close_instance(m, ex_mi, false);
     }
@@ -3301,6 +3313,17 @@
         {
             process_incoming_del_peer(m, mi, dco);
         }
+#if 0
+        else if (dco->dco_message_type =3D=3D OVPN_CMD_FLOAT_PEER)
+        {
+            ASSERT(mi->context.c2.link_socket);
+            extract_dco_float_peer_addr(mi->context.c2.link_socket->info.a=
f,
+                                        &m->top.c2.from.dest,
+                                        (struct sockaddr *)&dco->dco_float=
_peer_ss);
+            multi_process_float(m, mi);
+            CLEAR(dco->dco_float_peer_ss);
+        }
+#endif /* if defined(TARGET_LINUX) || defined(TARGET_WIN32) */
         else if (dco->dco_message_type =3D=3D OVPN_CMD_SWAP_KEYS)
         {
             tls_session_soft_reset(mi->context.c2.tls_multi);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1169?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: Ib748e726eb84dcbe8a48b297d165dec80c0e578d
Gerrit-Change-Number: 1169
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: ralf_lici <ralf@...2726...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-MessageType: newchange

--OUQfPoy/5c4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, ralf_lic=
i. </p>
<p>cron2 would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1169?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">dco: backport OS-independent part of peer float support<br><=
br>This is a backport of commit cb8a0f6f5741d102b667d98370ab4d553503d0b5,<b=
r>which introduces float support for DCO linux, Windows, and the<br>OS-inde=
pendent parts.<br><br>DCO linux/windows in 2.6 has no float support kernel-=
side, so this<br>ignores all OS dependent parts, backporting just enough to=
 add<br>FreeBSD support in the next patch.<br><br>One notable difference in=
 the backport is that 2.6 has no multi-socket<br>support, so all the &quot;=
link_sockets[0]&quot; occurances need to be changed back<br>to &quot;link_s=
ocket&quot;.<br><br>Change-Id: Ib748e726eb84dcbe8a48b297d165dec80c0e578d<br=
>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br>Signed-off-by: Gert Do=
ering &lt;gert@...1296...&gt;<br>(cherry picked from commit cb8a0f6f5741d10=
2b667d98370ab4d553503d0b5)<br>---<br>M src/openvpn/forward.c<br>M src/openv=
pn/forward.h<br>M src/openvpn/multi.c<br>3 files changed, 73 insertions(+),=
 0 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn r=
efs/changes/69/1169/1</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/src/openvpn/forward.c b/src/open=
vpn/forward.c</span><br><span>index 0f2ec07..ab5ebda 100644</span><br><span=
>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</s=
pan><br><span>@@ -1234,6 +1234,41 @@</span><br><span>     perf_pop();</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ext=
ract_dco_float_peer_addr(const sa_family_t socket_family,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                            struct op=
envpn_sockaddr *out_osaddr,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                            const struct sockaddr *float_sa)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (float_sa-&gt;sa_family =3D=3D AF_INE=
T)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        struct sockaddr_in *flo=
at4 =3D (struct sockaddr_in *)float_sa;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* DCO treats IPv4-mapped IPv6 addresses as pur=
e IPv4. However, on a</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+         * dual-stack socket, we need to preserve the mapping otherwise o=
penvpn</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * wi=
ll not be able to find the peer by its transport address.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+         */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (socket_family =3D=3D AF_INET6)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            out_osaddr-&gt;addr.=
in6.sin6_family =3D AF_INET6;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            out_osaddr-&gt;addr.in6.sin6_port =3D float4-&gt;sin_=
port;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            memset(&amp;out_osadd=
r-&gt;addr.in6.sin6_addr.s6_addr, 0, 10);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            out_osaddr-&gt;addr.in6.sin6_addr.s6_addr=
[10] =3D 0xff;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       out_osaddr-&gt;addr.in6.sin6_addr.s6_addr[11] =3D 0xff;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            memcpy(&amp;out_osad=
dr-&gt;addr.in6.sin6_addr.s6_addr[12],</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                   &amp;float4-&gt;sin_addr.s_addr, size=
of(in_addr_t));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            memcpy(&amp;out_osa=
ddr-&gt;addr.in4, float4, sizeof(struct sockaddr_in));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct=
 sockaddr_in6 *float6 =3D (struct sockaddr_in6 *)float_sa;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        memcpy(&amp;out_osaddr-&gt;a=
ddr.in6, float6, sizeof(struct sockaddr_in6));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> static void</span><br><span> process_incoming_dco(struct conte=
xt *c)</span><br><span> {</span><br><span>diff --git a/src/openvpn/forward.=
h b/src/openvpn/forward.h</span><br><span>index 245a802..3d0abd5 100644</sp=
an><br><span>--- a/src/openvpn/forward.h</span><br><span>+++ b/src/openvpn/=
forward.h</span><br><span>@@ -189,6 +189,21 @@</span><br><span> void proces=
s_incoming_link_part2(struct context *c, struct link_socket_info *lsi, cons=
t uint8_t *orig_buf);</span><br><span> </span><br><span> /**</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Transfers \c float_sa data extr=
acted from an incoming DCO</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * PEER_FLOAT_NTF to \c out_osaddr for later processing.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param socket_family - The address family of =
the socket</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 out_osaddr - openvpn_sockaddr struct that will be filled the new</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *      address data</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param float_sa - The soc=
kaddr struct containing the data received from the</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *      DCO notification</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+extract_dco_float_peer_addr(sa_family_t socket_family,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                            struct =
openvpn_sockaddr *out_osaddr,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                            const struct sockaddr *float_sa);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Write a packet to=
 the external network interface.</span><br><span>  * @ingroup external_mult=
iplexer</span><br><span>  *</span><br><span>diff --git a/src/openvpn/multi.=
c b/src/openvpn/multi.c</span><br><span>index 199f655..eb5f932 100644</span=
><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/mult=
i.c</span><br><span>@@ -3169,6 +3169,18 @@</span><br><span>             got=
o done;</span><br><span>         }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* It doesn&#39;t make sense to l=
et a peer float to the address it already</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+         * has, so we disallow it. This can happen if=
 a DCO netlink notification</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+         * gets lost and we miss a floating step.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+         */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (m1-&gt;peer_id =3D=3D m2-&gt;peer=
_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &=
quot;disallowing peer %&quot; PRIu32 &quot; (%s) from floating to &quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;=
its own address (%s)&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                m1-&gt;peer_id, tls_common_name(mi-&gt;context.c2.t=
ls_multi, false),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              mroute_addr_print(&amp;mi-&gt;real, &amp;gc));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            goto done;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     =
    msg(D_MULTI_MEDIUM, &quot;closing instance %s&quot;, multi_instance_str=
ing(ex_mi, false, &amp;gc));</span><br><span>         multi_close_instance(=
m, ex_mi, false);</span><br><span>     }</span><br><span>@@ -3301,6 +3313,1=
7 @@</span><br><span>         {</span><br><span>             process_incomi=
ng_del_peer(m, mi, dco);</span><br><span>         }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if 0</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        else if (dco-&gt;dco_message_type =3D=3D OVPN_C=
MD_FLOAT_PEER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ASS=
ERT(mi-&gt;context.c2.link_socket);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            extract_dco_float_peer_addr(mi-&gt;context.c2.l=
ink_socket-&gt;info.af,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                        &amp;m-&gt;top.c2.from.dest,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
                  (struct sockaddr *)&amp;dco-&gt;dco_float_peer_ss);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            multi_process=
_float(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       CLEAR(dco-&gt;dco_float_peer_ss);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif /* if defined(TARGET_LINUX) || defined(TARGET_WIN32) */</=
span><br><span>         else if (dco-&gt;dco_message_type =3D=3D OVPN_CMD_S=
WAP_KEYS)</span><br><span>         {</span><br><span>             tls_sessi=
on_soft_reset(mi-&gt;context.c2.tls_multi);</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1169?u=
sp=3Demail">change 1169</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1169?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib748e726eb84dcbe8a48b297d16=
5dec80c0e578d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1169 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--OUQfPoy/5c4=--

