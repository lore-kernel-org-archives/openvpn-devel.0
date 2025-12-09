From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Tue, 9 Dec 2025 11:23:33 +0000
References: <gerrit.1765279409000.I2c0a0b55ad56e704d4bd19f1fbc1c30c83fae14c@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <869810c3eceb8a94aaaa38a299a9151b561c7ee8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6/QIGbXZ7BM="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Deprecate --fast-io
 option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6/QIGbXZ7BM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1425?usp=3Demail

to review the following change.


Change subject: Deprecate --fast-io option
......................................................................

Deprecate --fast-io option

Recent changes to the event loop revealed that
the --fast-io option is now partially broken and
may cause "unroutable control packet" issues.

As agreed during the last hackathon, this patch
turns --fast-io into a no-op and emits a warning
when it is used.

Change-Id: I2c0a0b55ad56e704d4bd19f1fbc1c30c83fae14c
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M doc/man-sections/generic-options.rst
M src/openvpn/forward.c
M src/openvpn/forward.h
M src/openvpn/init.c
M src/openvpn/mudp.c
M src/openvpn/openvpn.h
M src/openvpn/options.c
M src/openvpn/options.h
8 files changed, 11 insertions(+), 109 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/25/1425/1

diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generi=
c-options.rst
index 882cf28..e698d9f 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -212,7 +212,7 @@
   are supported by OpenSSL.

 --fast-io
-  Optimize TUN/TAP/UDP I/O writes by avoiding a call to
+  **DEPRECATED** Optimize TUN/TAP/UDP I/O writes by avoiding a call to
   poll/epoll/select prior to the write operation. The purpose of such a
   call would normally be to block until the device or socket is ready to
   accept the write. Such blocking is unnecessary on some platforms which
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 6f1bc0c..eb77a1d 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2154,13 +2154,12 @@
 }

 /*
- * Wait for I/O events.  Used for both TCP & UDP sockets
- * in point-to-point mode and for UDP sockets in
+ * Wait for I/O events.  Used for UDP sockets in
  * point-to-multipoint mode.
  */

 void
-get_io_flags_dowork_udp(struct context *c, struct multi_io *multi_io, cons=
t unsigned int flags)
+get_io_flags_udp(struct context *c, struct multi_io *multi_io, const unsig=
ned int flags)
 {
     unsigned int out_socket;

@@ -2168,33 +2167,12 @@
     multi_io->udp_flags =3D (out_socket << SOCKET_SHIFT);
 }

+/*
+ * This is the core I/O wait function, used for all I/O waits except
+ * for the top-level server sockets.
+ */
 void
-get_io_flags_udp(struct context *c, struct multi_io *multi_io, const unsig=
ned int flags)
-{
-    multi_io->udp_flags =3D ES_ERROR;
-    if (c->c2.fast_io && (flags & (IOW_TO_TUN | IOW_TO_LINK | IOW_MBUF)))
-    {
-        /* fast path -- only for TUN/TAP/UDP writes */
-        unsigned int ret =3D 0;
-        if (flags & IOW_TO_TUN)
-        {
-            ret |=3D TUN_WRITE;
-        }
-        if (flags & (IOW_TO_LINK | IOW_MBUF))
-        {
-            ret |=3D SOCKET_WRITE;
-        }
-        multi_io->udp_flags =3D ret;
-    }
-    else
-    {
-        /* slow path - delegate to io_wait_dowork_udp to calculate flags */
-        get_io_flags_dowork_udp(c, multi_io, flags);
-    }
-}
-
-void
-io_wait_dowork(struct context *c, const unsigned int flags)
+io_wait(struct context *c, const unsigned int flags)
 {
     unsigned int out_socket;
     unsigned int out_tuntap;
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 06808b9..7f6f666 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -68,12 +68,9 @@

 extern counter_type link_write_bytes_global;

-void get_io_flags_dowork_udp(struct context *c, struct multi_io *multi_io,
-                             const unsigned int flags);
-
 void get_io_flags_udp(struct context *c, struct multi_io *multi_io, const =
unsigned int flags);

-void io_wait_dowork(struct context *c, const unsigned int flags);
+void io_wait(struct context *c, const unsigned int flags);

 void pre_select(struct context *c);

@@ -382,34 +379,6 @@
     return flags;
 }

-/*
- * This is the core I/O wait function, used for all I/O waits except
- * for the top-level server sockets.
- */
-static inline void
-io_wait(struct context *c, const unsigned int flags)
-{
-    if (proto_is_dgram(c->c2.link_sockets[0]->info.proto) && c->c2.fast_io
-        && (flags & (IOW_TO_TUN | IOW_TO_LINK | IOW_MBUF)))
-    {
-        /* fast path -- only for TUN/TAP/UDP writes */
-        unsigned int ret =3D 0;
-        if (flags & IOW_TO_TUN)
-        {
-            ret |=3D TUN_WRITE;
-        }
-        if (flags & (IOW_TO_LINK | IOW_MBUF))
-        {
-            ret |=3D SOCKET_WRITE;
-        }
-        c->c2.event_set_status =3D ret;
-    }
-    else
-    {
-        /* slow path */
-        io_wait_dowork(c, flags);
-    }
-}

 static inline bool
 connection_established(struct context *c)
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index fc079e1..cd01520 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -4139,34 +4139,6 @@
     }
 }

-/*
- * Fast I/O setup.  Fast I/O is an optimization which only works
- * if all of the following are true:
- *
- * (1) The platform is not Windows
- * (2) --proto udp is enabled
- * (3) --shaper is disabled
- */
-static void
-do_setup_fast_io(struct context *c)
-{
-    if (c->options.fast_io)
-    {
-#ifdef _WIN32
-        msg(M_INFO, "NOTE: --fast-io is disabled since we are running on W=
indows");
-#else
-        if (c->options.shaper)
-        {
-            msg(M_INFO, "NOTE: --fast-io is disabled since we are using --=
shaper");
-        }
-        else
-        {
-            c->c2.fast_io =3D true;
-        }
-#endif
-    }
-}
-
 static void
 do_signal_on_tls_errors(struct context *c)
 {
@@ -4513,12 +4485,6 @@
     }
 #endif

-    /* should we enable fast I/O? */
-    if (c->mode =3D=3D CM_P2P || c->mode =3D=3D CM_TOP)
-    {
-        do_setup_fast_io(c);
-    }
-
     /* should we throw a signal on TLS errors? */
     do_signal_on_tls_errors(c);

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index b03e165..bf115e6 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -339,9 +339,7 @@
 multi_process_io_udp(struct multi_context *m, struct link_socket *sock)
 {
     const unsigned int status =3D m->multi_io->udp_flags;
-    const unsigned int mpp_flags =3D m->top.c2.fast_io
-                                       ? (MPP_CONDITIONAL_PRE_SELECT | MPP=
_CLOSE_ON_SIGNAL)
-                                       : (MPP_PRE_SELECT | MPP_CLOSE_ON_SI=
GNAL);
+    const unsigned int mpp_flags =3D (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL=
);

     /* UDP port ready to accept write */
     if (status & SOCKET_WRITE)
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index a198fcf..3e1ae78 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -420,9 +420,6 @@
     struct env_set *es;
     bool es_owned;

-    /* don't wait for TUN/TAP/UDP to be ready to accept write */
-    bool fast_io;
-
     /* --ifconfig endpoints to be pushed to client */
     bool push_request_received;
     bool push_ifconfig_defined;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index a3fc19d..41b45cf 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -285,7 +285,6 @@
 #if ENABLE_IP_PKTINFO
     "--multihome     : Configure a multi-homed UDP server.\n"
 #endif
-    "--fast-io       : Optimize TUN/TAP/UDP writes.\n"
     "--remap-usr1 s  : On SIGUSR1 signals, remap signal (s=3D'SIGHUP' or '=
SIGTERM').\n"
     "--persist-tun   : Keep tun/tap device open across SIGUSR1 or --ping-r=
estart.\n"
     "--persist-remote-ip : Keep remote IP address across SIGUSR1 or --ping=
-restart.\n"
@@ -1795,8 +1794,6 @@
 #endif
     SHOW_INT(sockflags);

-    SHOW_BOOL(fast_io);
-
     SHOW_INT(comp.alg);
     SHOW_INT(comp.flags);

@@ -6600,7 +6597,7 @@
     else if (streq(p[0], "fast-io") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->fast_io =3D true;
+        msg(M_WARN, "DEPRECATED: --fast-io option ignored. ");
     }
     else if (streq(p[0], "inactive") && p[1] && !p[3])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 42db9ca..41212fb 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -406,9 +406,6 @@
     int status_file_version;
     int status_file_update_freq;

-    /* optimize TUN/TAP/UDP writes */
-    bool fast_io;
-
     struct compress_options comp;

     /* buffer sizes */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1425?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2c0a0b55ad56e704d4bd19f1fbc1c30c83fae14c
Gerrit-Change-Number: 1425
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--6/QIGbXZ7BM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>its_Giaan would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1425?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Deprecate --fast-io option<br><br>Recent ch=
anges to the event loop revealed that<br>the --fast-io option is now partia=
lly broken and<br>may cause &quot;unroutable control packet&quot; issues.<b=
r><br>As agreed during the last hackathon, this patch<br>turns --fast-io in=
to a no-op and emits a warning<br>when it is used.<br><br>Change-Id: I2c0a0=
b55ad56e704d4bd19f1fbc1c30c83fae14c<br>Signed-off-by: Gianmarco De Gregori =
&lt;gianmarco@...2726...&gt;<br>---<br>M doc/man-sections/generic-options.r=
st<br>M src/openvpn/forward.c<br>M src/openvpn/forward.h<br>M src/openvpn/i=
nit.c<br>M src/openvpn/mudp.c<br>M src/openvpn/openvpn.h<br>M src/openvpn/o=
ptions.c<br>M src/openvpn/options.h<br>8 files changed, 11 insertions(+), 1=
09 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.ne=
t:29418/openvpn refs/changes/25/1425/1</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-section=
s/generic-options.rst b/doc/man-sections/generic-options.rst</span><br><spa=
n>index 882cf28..e698d9f 100644</span><br><span>--- a/doc/man-sections/gene=
ric-options.rst</span><br><span>+++ b/doc/man-sections/generic-options.rst<=
/span><br><span>@@ -212,7 +212,7 @@</span><br><span>   are supported by Ope=
nSSL.</span><br><span> </span><br><span> --fast-io</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-  Optimize TUN/TAP/UDP I/O writes by avoiding =
a call to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  **DEPREC=
ATED** Optimize TUN/TAP/UDP I/O writes by avoiding a call to</span><br><spa=
n>   poll/epoll/select prior to the write operation. The purpose of such a<=
/span><br><span>   call would normally be to block until the device or sock=
et is ready to</span><br><span>   accept the write. Such blocking is unnece=
ssary on some platforms which</span><br><span>diff --git a/src/openvpn/forw=
ard.c b/src/openvpn/forward.c</span><br><span>index 6f1bc0c..eb77a1d 100644=
</span><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/open=
vpn/forward.c</span><br><span>@@ -2154,13 +2154,12 @@</span><br><span> }</s=
pan><br><span> </span><br><span> /*</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * Wait for I/O events.  Used for both TCP &amp; UDP sockets<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * in point-to-point m=
ode and for UDP sockets in</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Wait for I/O events.  Used for UDP sockets in</span><br><span>  *=
 point-to-multipoint mode.</span><br><span>  */</span><br><span> </span><br=
><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_io_fl=
ags_dowork_udp(struct context *c, struct multi_io *multi_io, const unsigned=
 int flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_io_f=
lags_udp(struct context *c, struct multi_io *multi_io, const unsigned int f=
lags)</span><br><span> {</span><br><span>     unsigned int out_socket;</spa=
n><br><span> </span><br><span>@@ -2168,33 +2167,12 @@</span><br><span>     =
multi_io-&gt;udp_flags =3D (out_socket &lt;&lt; SOCKET_SHIFT);</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This is t=
he core I/O wait function, used for all I/O waits except</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * for the top-level server sockets.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_io_flags_udp(=
struct context *c, struct multi_io *multi_io, const unsigned int flags)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    multi_io-&gt;udp_flags =3D ES_ERROR;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;c2.fast_io=
 &amp;&amp; (flags &amp; (IOW_TO_TUN | IOW_TO_LINK | IOW_MBUF)))</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        /* fast path -- only for TUN/TAP/UDP wri=
tes */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        unsigne=
d int ret =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if (flags &amp; IOW_TO_TUN)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         ret |=3D TUN_WRITE;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if (flags &amp; (IOW_TO_LINK | IOW_MBUF))</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            ret |=3D SOCKET_WRITE;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        multi_io-&gt;udp_flags =3D ret;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* sl=
ow path - delegate to io_wait_dowork_udp to calculate flags */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        get_io_flags_dowork_udp(c,=
 multi_io, flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-io=
_wait_dowork(struct context *c, const unsigned int flags)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+io_wait(struct context *c, const unsi=
gned int flags)</span><br><span> {</span><br><span>     unsigned int out_so=
cket;</span><br><span>     unsigned int out_tuntap;</span><br><span>diff --=
git a/src/openvpn/forward.h b/src/openvpn/forward.h</span><br><span>index 0=
6808b9..7f6f666 100644</span><br><span>--- a/src/openvpn/forward.h</span><b=
r><span>+++ b/src/openvpn/forward.h</span><br><span>@@ -68,12 +68,9 @@</spa=
n><br><span> </span><br><span> extern counter_type link_write_bytes_global;=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-voi=
d get_io_flags_dowork_udp(struct context *c, struct multi_io *multi_io,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
    const unsigned int flags);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> void get_io_flags_udp(struct context *c, struct =
multi_io *multi_io, const unsigned int flags);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-void io_wait_dowork(struct conte=
xt *c, const unsigned int flags);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+void io_wait(struct context *c, const unsigned int flags);</s=
pan><br><span> </span><br><span> void pre_select(struct context *c);</span>=
<br><span> </span><br><span>@@ -382,34 +379,6 @@</span><br><span>     retur=
n flags;</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * This is the core I/O wait function, used for all I/O waits except</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * for the top-level se=
rver sockets.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline void</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-io_wait(struct context *c, co=
nst unsigned int flags)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (proto_is_d=
gram(c-&gt;c2.link_sockets[0]-&gt;info.proto) &amp;&amp; c-&gt;c2.fast_io</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; (fla=
gs &amp; (IOW_TO_TUN | IOW_TO_LINK | IOW_MBUF)))</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        /* fast path -- only for TUN/TAP/UDP writes */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        unsigned int ret =3D 0;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (flags &am=
p; IOW_TO_TUN)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ret |=
=3D TUN_WRITE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (flags &=
amp; (IOW_TO_LINK | IOW_MBUF))</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         ret |=3D SOCKET_WRITE;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      c-&gt;c2.event_set_status =3D ret;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* slow path */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        io_wait_dowork(c=
, flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span> </span><b=
r><span> static inline bool</span><br><span> connection_established(struct =
context *c)</span><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/i=
nit.c</span><br><span>index fc079e1..cd01520 100644</span><br><span>--- a/s=
rc/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>=
@@ -4139,34 +4139,6 @@</span><br><span>     }</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * Fast I/O setup.  Fast I/O is a=
n optimization which only works</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * if all of the following are true:</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * (1) The platform is not Windows</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * (2) --proto udp is enabled</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * (3) --shaper is disabled</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-do_setup_fast_io(struct context *c)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (c-&gt;options.fast_io)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef _=
WIN32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_IN=
FO, &quot;NOTE: --fast-io is disabled since we are running on Windows&quot;=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        if (c-&gt;options.shaper)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            msg(M_INFO, &quot;NOTE:=
 --fast-io is disabled since we are using --shaper&quot;);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            c-&gt;c2.fast_io =3D true;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void</span><br><s=
pan> do_signal_on_tls_errors(struct context *c)</span><br><span> {</span><b=
r><span>@@ -4513,12 +4485,6 @@</span><br><span>     }</span><br><span> #end=
if</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   /* should we enable fast I/O? */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (c-&gt;mode =3D=3D CM_P2P || c-&gt;mode =3D=3D CM_TOP)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        do_setup_fast_io(c);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span>     /* should we throw a sig=
nal on TLS errors? */</span><br><span>     do_signal_on_tls_errors(c);</spa=
n><br><span> </span><br><span>diff --git a/src/openvpn/mudp.c b/src/openvpn=
/mudp.c</span><br><span>index b03e165..bf115e6 100644</span><br><span>--- a=
/src/openvpn/mudp.c</span><br><span>+++ b/src/openvpn/mudp.c</span><br><spa=
n>@@ -339,9 +339,7 @@</span><br><span> multi_process_io_udp(struct multi_co=
ntext *m, struct link_socket *sock)</span><br><span> {</span><br><span>    =
 const unsigned int status =3D m-&gt;multi_io-&gt;udp_flags;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    const unsigned int mpp_flags =3D=
 m-&gt;top.c2.fast_io</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                                       ? (MPP_CONDITIONAL_PRE_SELECT | MPP_=
CLOSE_ON_SIGNAL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                                  : (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const unsigned =
int mpp_flags =3D (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);</span><br><span> =
</span><br><span>     /* UDP port ready to accept write */</span><br><span>=
     if (status &amp; SOCKET_WRITE)</span><br><span>diff --git a/src/openvp=
n/openvpn.h b/src/openvpn/openvpn.h</span><br><span>index a198fcf..3e1ae78 =
100644</span><br><span>--- a/src/openvpn/openvpn.h</span><br><span>+++ b/sr=
c/openvpn/openvpn.h</span><br><span>@@ -420,9 +420,6 @@</span><br><span>   =
  struct env_set *es;</span><br><span>     bool es_owned;</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* don&#39;t wait=
 for TUN/TAP/UDP to be ready to accept write */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    bool fast_io;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span>     /* --ifconfig endpoints to be p=
ushed to client */</span><br><span>     bool push_request_received;</span><=
br><span>     bool push_ifconfig_defined;</span><br><span>diff --git a/src/=
openvpn/options.c b/src/openvpn/options.c</span><br><span>index a3fc19d..41=
b45cf 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>++=
+ b/src/openvpn/options.c</span><br><span>@@ -285,7 +285,6 @@</span><br><sp=
an> #if ENABLE_IP_PKTINFO</span><br><span>     &quot;--multihome     : Conf=
igure a multi-homed UDP server.\n&quot;</span><br><span> #endif</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    &quot;--fast-io       : Optim=
ize TUN/TAP/UDP writes.\n&quot;</span><br><span>     &quot;--remap-usr1 s  =
: On SIGUSR1 signals, remap signal (s=3D&#39;SIGHUP&#39; or &#39;SIGTERM&#3=
9;).\n&quot;</span><br><span>     &quot;--persist-tun   : Keep tun/tap devi=
ce open across SIGUSR1 or --ping-restart.\n&quot;</span><br><span>     &quo=
t;--persist-remote-ip : Keep remote IP address across SIGUSR1 or --ping-res=
tart.\n&quot;</span><br><span>@@ -1795,8 +1794,6 @@</span><br><span> #endif=
</span><br><span>     SHOW_INT(sockflags);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(fast_io);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     SHOW_INT(com=
p.alg);</span><br><span>     SHOW_INT(comp.flags);</span><br><span> </span>=
<br><span>@@ -6600,7 +6597,7 @@</span><br><span>     else if (streq(p[0], &=
quot;fast-io&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><spa=
n>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        options-&gt;fast_io =3D true;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;DEPRECAT=
ED: --fast-io option ignored. &quot;);</span><br><span>     }</span><br><sp=
an>     else if (streq(p[0], &quot;inactive&quot;) &amp;&amp; p[1] &amp;&am=
p; !p[3])</span><br><span>     {</span><br><span>diff --git a/src/openvpn/o=
ptions.h b/src/openvpn/options.h</span><br><span>index 42db9ca..41212fb 100=
644</span><br><span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/o=
penvpn/options.h</span><br><span>@@ -406,9 +406,6 @@</span><br><span>     i=
nt status_file_version;</span><br><span>     int status_file_update_freq;</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /=
* optimize TUN/TAP/UDP writes */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    bool fast_io;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span>     struct compress_options comp;</span><br><span>=
 </span><br><span>     /* buffer sizes */</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1425?usp=
=3Demail">change 1425</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1425?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2c0a0b55ad56e704d4bd19f1fbc=
1c30c83fae14c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1425 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--6/QIGbXZ7BM=--

