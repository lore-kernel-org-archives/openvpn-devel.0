From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 26 Nov 2025 18:33:59 +0000
In-Reply-To: <gerrit.1762517501000.I750a46246c0d2447a6691e5c25c4732e3d335a63@...2715...>
References: <gerrit.1762517501000.I750a46246c0d2447a6691e5c25c4732e3d335a63@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2bcaf87f780146dd3a7b279a0f822cb8a3108920-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fPjuC2e0UMQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: error: Allow status
 argument to check_status to be ssize_t
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--fPjuC2e0UMQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1357?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: error: Allow status argument to check_status to be ssize_t
......................................................................

error: Allow status argument to check_status to be ssize_t

We only check for < 0 so no reason not to allow bigger
signed values. This makes it easier to feed result
values of read/write to it. Fixes a conversion warning
in process_outgoing_tun.

Also changes register_activity to int64_t for similar
reasons.

Change-Id: I750a46246c0d2447a6691e5c25c4732e3d335a63
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1357
Message-Id: <20251126114047.10280-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
701.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/error.c
M src/openvpn/error.h
M src/openvpn/forward.c
M src/openvpn/forward.h
4 files changed, 11 insertions(+), 11 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/57/1357/5

diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index bd588d4..83eb9eb 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -621,14 +621,14 @@
  * from the OS.
  */
 void
-x_check_status(int status, const char *description, struct link_socket *so=
ck, struct tuntap *tt)
+x_check_status(ssize_t status, const char *description, struct link_socket=
 *sock, struct tuntap *tt)
 {
     const char *extended_msg =3D NULL;

     bool crt_error =3D false;
     int my_errno =3D openvpn_errno_maybe_crt(&crt_error);

-    msg(x_cs_verbose_level, "%s %s returned %d",
+    msg(x_cs_verbose_level, "%s %s returned %zd",
         sock ? proto2ascii(sock->info.proto, sock->info.af, true) : "", de=
scription, status);

     if (status < 0)
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 2913498..3088dbb 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -307,11 +307,11 @@

 void set_check_status(unsigned int info_level, unsigned int verbose_level);

-void x_check_status(int status, const char *description, struct link_socke=
t *sock,
+void x_check_status(ssize_t status, const char *description, struct link_s=
ocket *sock,
                     struct tuntap *tt);

 static inline void
-check_status(int status, const char *description, struct link_socket *sock=
, struct tuntap *tt)
+check_status(ssize_t status, const char *description, struct link_socket *=
sock, struct tuntap *tt)
 {
     if (status < 0 || check_debug_level(x_cs_verbose_level))
     {
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index ccb8404..bc600d6 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1673,6 +1673,10 @@
 #undef MAX_ICMPV6LEN
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 process_ip_header(struct context *c, unsigned int flags, struct buffer *bu=
f,
                   struct link_socket *sock)
@@ -1915,7 +1919,7 @@
         /*
          * Write to TUN/TAP device.
          */
-        int size;
+        ssize_t size;

 #ifdef LOG_RW
         if (c->c2.log_rw)
@@ -1956,7 +1960,7 @@
             if (size !=3D BLEN(&c->c2.to_tun))
             {
                 msg(D_LINK_ERRORS,
-                    "TUN/TAP packet was destructively fragmented on write =
to %s (tried=3D%d,actual=3D%d)",
+                    "TUN/TAP packet was destructively fragmented on write =
to %s (tried=3D%d,actual=3D%zd)",
                     c->c1.tuntap->actual_name, BLEN(&c->c2.to_tun), size);
             }

@@ -1977,10 +1981,6 @@
     buf_reset(&c->c2.to_tun);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 pre_select(struct context *c)
 {
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index a575faf..3cd710e 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -343,7 +343,7 @@
 }

 static inline void
-register_activity(struct context *c, const int size)
+register_activity(struct context *c, const int64_t size)
 {
     if (c->options.inactivity_timeout)
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1357?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I750a46246c0d2447a6691e5c25c4732e3d335a63
Gerrit-Change-Number: 1357
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--fPjuC2e0UMQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #5</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1357?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">error: Allow status argument to che=
ck_status to be ssize_t<br><br>We only check for &lt; 0 so no reason not to=
 allow bigger<br>signed values. This makes it easier to feed result<br>valu=
es of read/write to it. Fixes a conversion warning<br>in process_outgoing_t=
un.<br><br>Also changes register_activity to int64_t for similar<br>reasons=
.<br><br>Change-Id: I750a46246c0d2447a6691e5c25c4732e3d335a63<br>Signed-off=
-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &=
lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/=
+/1357<br>Message-Id: &lt;20251126114047.10280-1-gert@...1296...&gt;<br>URL=
: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34701=
.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M sr=
c/openvpn/error.c<br>M src/openvpn/error.h<br>M src/openvpn/forward.c<br>M =
src/openvpn/forward.h<br>4 files changed, 11 insertions(+), 11 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn=
 refs/changes/57/1357/5</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/error.c b/src/open=
vpn/error.c</span><br><span>index bd588d4..83eb9eb 100644</span><br><span>-=
-- a/src/openvpn/error.c</span><br><span>+++ b/src/openvpn/error.c</span><b=
r><span>@@ -621,14 +621,14 @@</span><br><span>  * from the OS.</span><br><s=
pan>  */</span><br><span> void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-x_check_status(int status, const char *description, struct link_so=
cket *sock, struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+x_check_status(ssize_t status, const char *description, struct l=
ink_socket *sock, struct tuntap *tt)</span><br><span> {</span><br><span>   =
  const char *extended_msg =3D NULL;</span><br><span> </span><br><span>    =
 bool crt_error =3D false;</span><br><span>     int my_errno =3D openvpn_er=
rno_maybe_crt(&amp;crt_error);</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    msg(x_cs_verbose_level, &quot;%s %s returned=
 %d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(x=
_cs_verbose_level, &quot;%s %s returned %zd&quot;,</span><br><span>        =
 sock ? proto2ascii(sock-&gt;info.proto, sock-&gt;info.af, true) : &quot;&q=
uot;, description, status);</span><br><span> </span><br><span>     if (stat=
us &lt; 0)</span><br><span>diff --git a/src/openvpn/error.h b/src/openvpn/e=
rror.h</span><br><span>index 2913498..3088dbb 100644</span><br><span>--- a/=
src/openvpn/error.h</span><br><span>+++ b/src/openvpn/error.h</span><br><sp=
an>@@ -307,11 +307,11 @@</span><br><span> </span><br><span> void set_check_=
status(unsigned int info_level, unsigned int verbose_level);</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void x_check_statu=
s(int status, const char *description, struct link_socket *sock,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void x_check_status(ssize_t st=
atus, const char *description, struct link_socket *sock,</span><br><span>  =
                   struct tuntap *tt);</span><br><span> </span><br><span> s=
tatic inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-chec=
k_status(int status, const char *description, struct link_socket *sock, str=
uct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+chec=
k_status(ssize_t status, const char *description, struct link_socket *sock,=
 struct tuntap *tt)</span><br><span> {</span><br><span>     if (status &lt;=
 0 || check_debug_level(x_cs_verbose_level))</span><br><span>     {</span><=
br><span>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><=
br><span>index ccb8404..bc600d6 100644</span><br><span>--- a/src/openvpn/fo=
rward.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -167=
3,6 +1673,10 @@</span><br><span> #undef MAX_ICMPV6LEN</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if =
defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> void</span><br><span> process_ip_header(str=
uct context *c, unsigned int flags, struct buffer *buf,</span><br><span>   =
                struct link_socket *sock)</span><br><span>@@ -1915,7 +1919,=
7 @@</span><br><span>         /*</span><br><span>          * Write to TUN/T=
AP device.</span><br><span>          */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        int size;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        ssize_t size;</span><br><span> </span><br><span> #i=
fdef LOG_RW</span><br><span>         if (c-&gt;c2.log_rw)</span><br><span>@=
@ -1956,7 +1960,7 @@</span><br><span>             if (size !=3D BLEN(&amp;c=
-&gt;c2.to_tun))</span><br><span>             {</span><br><span>           =
      msg(D_LINK_ERRORS,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    &quot;TUN/TAP packet was destructively fragmented on=
 write to %s (tried=3D%d,actual=3D%d)&quot;,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                    &quot;TUN/TAP packet was destr=
uctively fragmented on write to %s (tried=3D%d,actual=3D%zd)&quot;,</span><=
br><span>                     c-&gt;c1.tuntap-&gt;actual_name, BLEN(&amp;c-=
&gt;c2.to_tun), size);</span><br><span>             }</span><br><span> </sp=
an><br><span>@@ -1977,10 +1981,6 @@</span><br><span>     buf_reset(&amp;c-&=
gt;c2.to_tun);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span><b=
r><span> pre_select(struct context *c)</span><br><span> {</span><br><span>d=
iff --git a/src/openvpn/forward.h b/src/openvpn/forward.h</span><br><span>i=
ndex a575faf..3cd710e 100644</span><br><span>--- a/src/openvpn/forward.h</s=
pan><br><span>+++ b/src/openvpn/forward.h</span><br><span>@@ -343,7 +343,7 =
@@</span><br><span> }</span><br><span> </span><br><span> static inline void=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-register_activity(str=
uct context *c, const int size)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+register_activity(struct context *c, const int64_t size)</span>=
<br><span> {</span><br><span>     if (c-&gt;options.inactivity_timeout)</sp=
an><br><span>     {</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1357?usp=3Demail">change 1357<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1357?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I750a46246c0d2447a6691e5c25c=
4732e3d335a63 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1357 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--fPjuC2e0UMQ=--

