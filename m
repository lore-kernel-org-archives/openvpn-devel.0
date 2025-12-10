From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Wed, 10 Dec 2025 12:55:37 +0000
In-Reply-To: <gerrit.1765279409000.I2c0a0b55ad56e704d4bd19f1fbc1c30c83fae14c@...2715...>
References: <gerrit.1765279409000.I2c0a0b55ad56e704d4bd19f1fbc1c30c83fae14c@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3b969bc1628d3d3cd70f75a370f87dfb2e48fafb-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Xj8HBX2GwYI="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Xj8HBX2GwYI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1425?usp=3Demail

to look at the new patch set (#5).

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


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
M doc/man-sections/unsupported-options.rst
M src/openvpn/forward.c
M src/openvpn/forward.h
M src/openvpn/init.c
M src/openvpn/mudp.c
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/openvpn.h
M src/openvpn/options.c
M src/openvpn/options.h
11 files changed, 18 insertions(+), 125 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/25/1425/5

diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generi=
c-options.rst
index 882cf28..a9232ce 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -211,18 +211,6 @@
   ``--show-engines`` standalone option to list the crypto engines which
   are supported by OpenSSL.

---fast-io
-  Optimize TUN/TAP/UDP I/O writes by avoiding a call to
-  poll/epoll/select prior to the write operation. The purpose of such a
-  call would normally be to block until the device or socket is ready to
-  accept the write. Such blocking is unnecessary on some platforms which
-  don't support write blocking on UDP sockets or TUN/TAP devices. In such
-  cases, one can optimize the event loop by avoiding the poll/epoll/select
-  call, improving CPU efficiency by 5% to 10%.
-
-  This option can only be used on non-Windows systems, when ``--proto
-  udp`` is specified, and when ``--shaper`` is *NOT* specified.
-
 --group group
   Similar to the ``--user`` option, this option changes the group ID of
   the OpenVPN process to ``group`` after initialization.
diff --git a/doc/man-sections/unsupported-options.rst b/doc/man-sections/un=
supported-options.rst
index b646991..f1332f3 100644
--- a/doc/man-sections/unsupported-options.rst
+++ b/doc/man-sections/unsupported-options.rst
@@ -9,6 +9,10 @@
   Removed in OpenVPN 2.5.  This should be replaced with
   ``--verify-client-cert none``.

+--fast-io
+  Ignored since OpenVPN 2.7. This option became broken due to changes
+  to the event loop.
+
 --http-proxy-retry
   Removed in OpenVPN 2.4.  All retries are controlled by ``--max-connect-r=
etry``.

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 913fb92..492e667 100644
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
index 5de3af6..92d4dda 100644
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
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 153695c..1c42226 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3009,7 +3009,7 @@

     if (!IS_SIG(&mi->context)
         && ((flags & MPP_PRE_SELECT)
-            || ((flags & MPP_CONDITIONAL_PRE_SELECT) && !ANY_OUT(&mi->cont=
ext))))
+            || (!ANY_OUT(&mi->context))))
     {
 #if defined(ENABLE_ASYNC_PUSH)
         bool was_unauthenticated =3D true;
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index a44f9f2..1209dfb 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -271,10 +271,9 @@

 bool multi_process_timeout(struct multi_context *m, const unsigned int mpp=
_flags);

-#define MPP_PRE_SELECT             (1 << 0)
-#define MPP_CONDITIONAL_PRE_SELECT (1 << 1)
-#define MPP_CLOSE_ON_SIGNAL        (1 << 2)
-#define MPP_RECORD_TOUCH           (1 << 3)
+#define MPP_PRE_SELECT      (1 << 0)
+#define MPP_CLOSE_ON_SIGNAL (1 << 1)
+#define MPP_RECORD_TOUCH    (1 << 2)


 /*************************************************************************=
*/
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
index 2d1f740..d01ec47 100644
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

@@ -6592,7 +6589,7 @@
     else if (streq(p[0], "fast-io") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->fast_io =3D true;
+        msg(M_WARN, "DEPRECATED OPTION: --fast-io option ignored.");
     }
     else if (streq(p[0], "inactive") && p[1] && !p[3])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index d331033..555d9dd 100644
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2c0a0b55ad56e704d4bd19f1fbc1c30c83fae14c
Gerrit-Change-Number: 1425
Gerrit-PatchSet: 5
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>

--Xj8HBX2GwYI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>its_Giaan <strong>uploaded patch set #5</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1425?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><p>The change is no longer submittable: Co=
de-Review and checks~ChecksSubmitRule are unsatisfied now.</p><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>Deprecate --fast-io option<br><br>Recent changes to the event loop reveale=
d that<br>the --fast-io option is now partially broken and<br>may cause &qu=
ot;unroutable control packet&quot; issues.<br><br>As agreed during the last=
 hackathon, this patch<br>turns --fast-io into a no-op and emits a warning<=
br>when it is used.<br><br>Change-Id: I2c0a0b55ad56e704d4bd19f1fbc1c30c83fa=
e14c<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...2726...&gt;<br=
>---<br>M doc/man-sections/generic-options.rst<br>M doc/man-sections/unsupp=
orted-options.rst<br>M src/openvpn/forward.c<br>M src/openvpn/forward.h<br>=
M src/openvpn/init.c<br>M src/openvpn/mudp.c<br>M src/openvpn/multi.c<br>M =
src/openvpn/multi.h<br>M src/openvpn/openvpn.h<br>M src/openvpn/options.c<b=
r>M src/openvpn/options.h<br>11 files changed, 18 insertions(+), 125 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/o=
penvpn refs/changes/25/1425/5</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/generic=
-options.rst b/doc/man-sections/generic-options.rst</span><br><span>index 8=
82cf28..a9232ce 100644</span><br><span>--- a/doc/man-sections/generic-optio=
ns.rst</span><br><span>+++ b/doc/man-sections/generic-options.rst</span><br=
><span>@@ -211,18 +211,6 @@</span><br><span>   ``--show-engines`` standalon=
e option to list the crypto engines which</span><br><span>   are supported =
by OpenSSL.</span><br><span> </span><br><span>---fast-io</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  Optimize TUN/TAP/UDP I/O writes by avo=
iding a call to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  poll=
/epoll/select prior to the write operation. The purpose of such a</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-  call would normally be to blo=
ck until the device or socket is ready to</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  accept the write. Such blocking is unnecessary on som=
e platforms which</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  do=
n&#39;t support write blocking on UDP sockets or TUN/TAP devices. In such</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  cases, one can optimi=
ze the event loop by avoiding the poll/epoll/select</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  call, improving CPU efficiency by 5% to 1=
0%.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  This option can only be used on non-W=
indows systems, when ``--proto</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-  udp`` is specified, and when ``--shaper`` is *NOT* specified.</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> --grou=
p group</span><br><span>   Similar to the ``--user`` option, this option ch=
anges the group ID of</span><br><span>   the OpenVPN process to ``group`` a=
fter initialization.</span><br><span>diff --git a/doc/man-sections/unsuppor=
ted-options.rst b/doc/man-sections/unsupported-options.rst</span><br><span>=
index b646991..f1332f3 100644</span><br><span>--- a/doc/man-sections/unsupp=
orted-options.rst</span><br><span>+++ b/doc/man-sections/unsupported-option=
s.rst</span><br><span>@@ -9,6 +9,10 @@</span><br><span>   Removed in OpenVP=
N 2.5.  This should be replaced with</span><br><span>   ``--verify-client-c=
ert none``.</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+--fast-io</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  Ignored since OpenVPN 2.7. This option became broken due to changes</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  to the event loop.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --http=
-proxy-retry</span><br><span>   Removed in OpenVPN 2.4.  All retries are co=
ntrolled by ``--max-connect-retry``.</span><br><span> </span><br><span>diff=
 --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><span>inde=
x 913fb92..492e667 100644</span><br><span>--- a/src/openvpn/forward.c</span=
><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -2154,13 +2154,12=
 @@</span><br><span> }</span><br><span> </span><br><span> /*</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * Wait for I/O events.  Used for bo=
th TCP &amp; UDP sockets</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * in point-to-point mode and for UDP sockets in</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Wait for I/O events.  Used for UDP soc=
kets in</span><br><span>  * point-to-multipoint mode.</span><br><span>  */<=
/span><br><span> </span><br><span> void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-get_io_flags_dowork_udp(struct context *c, struct multi_i=
o *multi_io, const unsigned int flags)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+get_io_flags_udp(struct context *c, struct multi_io *mul=
ti_io, const unsigned int flags)</span><br><span> {</span><br><span>     un=
signed int out_socket;</span><br><span> </span><br><span>@@ -2168,33 +2167,=
12 @@</span><br><span>     multi_io-&gt;udp_flags =3D (out_socket &lt;&lt; =
SOCKET_SHIFT);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * This is the core I/O wait function, used for all I/O wa=
its except</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * for th=
e top-level server sockets.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ */</span><br><span> void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-get_io_flags_udp(struct context *c, struct multi_io *multi_io, =
const unsigned int flags)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi_io-&gt=
;udp_flags =3D ES_ERROR;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (c-&gt;c2.fast_io &amp;&amp; (flags &amp; (IOW_TO_TUN | IOW_TO_LI=
NK | IOW_MBUF)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* fast path =
-- only for TUN/TAP/UDP writes */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        unsigned int ret =3D 0;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        if (flags &amp; IOW_TO_TUN)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            ret |=3D TUN_WRITE;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        if (flags &amp; (IOW_TO_LINK | IOW_MBUF))</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            ret |=3D SOCKET_WRITE;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        multi_io-&gt;udp_flags =3D r=
et;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        /* slow path - delegate to io_wait_dowork_udp to calcul=
ate flags */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        g=
et_io_flags_dowork_udp(c, multi_io, flags);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-io_wait_dowork(struct context *c, const unsigned int=
 flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+io_wait(stru=
ct context *c, const unsigned int flags)</span><br><span> {</span><br><span=
>     unsigned int out_socket;</span><br><span>     unsigned int out_tuntap=
;</span><br><span>diff --git a/src/openvpn/forward.h b/src/openvpn/forward.=
h</span><br><span>index 06808b9..7f6f666 100644</span><br><span>--- a/src/o=
penvpn/forward.h</span><br><span>+++ b/src/openvpn/forward.h</span><br><spa=
n>@@ -68,12 +68,9 @@</span><br><span> </span><br><span> extern counter_type=
 link_write_bytes_global;</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-void get_io_flags_dowork_udp(struct context *c, struc=
t multi_io *multi_io,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                             const unsigned int flags);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void get_io_flags_udp(s=
truct context *c, struct multi_io *multi_io, const unsigned int flags);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void io=
_wait_dowork(struct context *c, const unsigned int flags);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void io_wait(struct context *c, cons=
t unsigned int flags);</span><br><span> </span><br><span> void pre_select(s=
truct context *c);</span><br><span> </span><br><span>@@ -382,34 +379,6 @@</=
span><br><span>     return flags;</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * This is the core I/O wait function, used=
 for all I/O waits except</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * for the top-level server sockets.</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-io=
_wait(struct context *c, const unsigned int flags)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (proto_is_dgram(c-&gt;c2.link_sockets[0]-&gt;info.proto) &a=
mp;&amp; c-&gt;c2.fast_io</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        &amp;&amp; (flags &amp; (IOW_TO_TUN | IOW_TO_LINK | IOW_MBUF)))=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        /* fast path -- only for TUN/=
TAP/UDP writes */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    unsigned int ret =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        if (flags &amp; IOW_TO_TUN)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            ret |=3D TUN_WRITE;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        if (flags &amp; (IOW_TO_LINK | IOW_MBUF))</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            ret |=3D SOCKET_WRITE;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        c-&gt;c2.event_set_status =3D ret;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       /* slow path */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        io_wait_dowork(c, flags);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span> </span><br><span> static inline bool</span><br><span> conne=
ction_established(struct context *c)</span><br><span>diff --git a/src/openv=
pn/init.c b/src/openvpn/init.c</span><br><span>index fc079e1..cd01520 10064=
4</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvp=
n/init.c</span><br><span>@@ -4139,34 +4139,6 @@</span><br><span>     }</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Fast =
I/O setup.  Fast I/O is an optimization which only works</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * if all of the following are true:</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * (1) The platform is not Windows</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * (2) --proto udp is enabled<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * (3) --shaper is dis=
abled</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-do_setup_fast_io(struct context *c)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (c-&gt;options.fast_io)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#ifdef _WIN32</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        msg(M_INFO, &quot;NOTE: --fast-io is disabled since we a=
re running on Windows&quot;);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
if (c-&gt;options.shaper)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    msg(M_INFO, &quot;NOTE: --fast-io is disabled since we are using --shap=
er&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            c-&gt;c2.fast_io =3D true;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an> static void</span><br><span> do_signal_on_tls_errors(struct context *c)=
</span><br><span> {</span><br><span>@@ -4513,12 +4485,6 @@</span><br><span>=
     }</span><br><span> #endif</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    /* should we enable fast I/O? */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;mode =3D=3D CM_P2P =
|| c-&gt;mode =3D=3D CM_TOP)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        d=
o_setup_fast_io(c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
    /* should we throw a signal on TLS errors? */</span><br><span>     do_s=
ignal_on_tls_errors(c);</span><br><span> </span><br><span>diff --git a/src/=
openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>index 5de3af6..92d4dda =
100644</span><br><span>--- a/src/openvpn/mudp.c</span><br><span>+++ b/src/o=
penvpn/mudp.c</span><br><span>@@ -339,9 +339,7 @@</span><br><span> multi_pr=
ocess_io_udp(struct multi_context *m, struct link_socket *sock)</span><br><=
span> {</span><br><span>     const unsigned int status =3D m-&gt;multi_io-&=
gt;udp_flags;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cons=
t unsigned int mpp_flags =3D m-&gt;top.c2.fast_io</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                                       ? (MPP_C=
ONDITIONAL_PRE_SELECT | MPP_CLOSE_ON_SIGNAL)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                                       : (MPP_PRE_SE=
LECT | MPP_CLOSE_ON_SIGNAL);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const unsigned int mpp_flags =3D (MPP_PRE_SELECT | MPP_CLOSE_O=
N_SIGNAL);</span><br><span> </span><br><span>     /* UDP port ready to acce=
pt write */</span><br><span>     if (status &amp; SOCKET_WRITE)</span><br><=
span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span=
>index 153695c..1c42226 100644</span><br><span>--- a/src/openvpn/multi.c</s=
pan><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -3009,7 +3009,7 =
@@</span><br><span> </span><br><span>     if (!IS_SIG(&amp;mi-&gt;context)<=
/span><br><span>         &amp;&amp; ((flags &amp; MPP_PRE_SELECT)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            || ((flags &amp; MP=
P_CONDITIONAL_PRE_SELECT) &amp;&amp; !ANY_OUT(&amp;mi-&gt;context))))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            || (!ANY_OUT(=
&amp;mi-&gt;context))))</span><br><span>     {</span><br><span> #if defined=
(ENABLE_ASYNC_PUSH)</span><br><span>         bool was_unauthenticated =3D t=
rue;</span><br><span>diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h=
</span><br><span>index a44f9f2..1209dfb 100644</span><br><span>--- a/src/op=
envpn/multi.h</span><br><span>+++ b/src/openvpn/multi.h</span><br><span>@@ =
-271,10 +271,9 @@</span><br><span> </span><br><span> bool multi_process_tim=
eout(struct multi_context *m, const unsigned int mpp_flags);</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define MPP_PRE_SE=
LECT             (1 &lt;&lt; 0)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#define MPP_CONDITIONAL_PRE_SELECT (1 &lt;&lt; 1)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define MPP_CLOSE_ON_SIGNAL        (1=
 &lt;&lt; 2)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define M=
PP_RECORD_TOUCH           (1 &lt;&lt; 3)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define MPP_PRE_SELECT      (1 &lt;&lt; 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define MPP_CLOSE_ON_SIGNAL (1 =
&lt;&lt; 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
MPP_RECORD_TOUCH    (1 &lt;&lt; 2)</span><br><span> </span><br><span> </spa=
n><br><span> /*************************************************************=
*************/</span><br><span>diff --git a/src/openvpn/openvpn.h b/src/ope=
nvpn/openvpn.h</span><br><span>index a198fcf..3e1ae78 100644</span><br><spa=
n>--- a/src/openvpn/openvpn.h</span><br><span>+++ b/src/openvpn/openvpn.h</=
span><br><span>@@ -420,9 +420,6 @@</span><br><span>     struct env_set *es;=
</span><br><span>     bool es_owned;</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    /* don&#39;t wait for TUN/TAP/UDP to b=
e ready to accept write */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    bool fast_io;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span>     /* --ifconfig endpoints to be pushed to client */</s=
pan><br><span>     bool push_request_received;</span><br><span>     bool pu=
sh_ifconfig_defined;</span><br><span>diff --git a/src/openvpn/options.c b/s=
rc/openvpn/options.c</span><br><span>index 2d1f740..d01ec47 100644</span><b=
r><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/optio=
ns.c</span><br><span>@@ -285,7 +285,6 @@</span><br><span> #if ENABLE_IP_PKT=
INFO</span><br><span>     &quot;--multihome     : Configure a multi-homed U=
DP server.\n&quot;</span><br><span> #endif</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    &quot;--fast-io       : Optimize TUN/TAP/UDP write=
s.\n&quot;</span><br><span>     &quot;--remap-usr1 s  : On SIGUSR1 signals,=
 remap signal (s=3D&#39;SIGHUP&#39; or &#39;SIGTERM&#39;).\n&quot;</span><b=
r><span>     &quot;--persist-tun   : Keep tun/tap device open across SIGUSR=
1 or --ping-restart.\n&quot;</span><br><span>     &quot;--persist-remote-ip=
 : Keep remote IP address across SIGUSR1 or --ping-restart.\n&quot;</span><=
br><span>@@ -1795,8 +1794,6 @@</span><br><span> #endif</span><br><span>    =
 SHOW_INT(sockflags);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    SHOW_BOOL(fast_io);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span>     SHOW_INT(comp.alg);</span><br><sp=
an>     SHOW_INT(comp.flags);</span><br><span> </span><br><span>@@ -6592,7 =
+6589,7 @@</span><br><span>     else if (streq(p[0], &quot;fast-io&quot;) &=
amp;&amp; !p[1])</span><br><span>     {</span><br><span>         VERIFY_PER=
MISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        options-&gt;fast_io =3D true;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(M_WARN, &quot;DEPRECATED OPTION: --fast-io =
option ignored.&quot;);</span><br><span>     }</span><br><span>     else if=
 (streq(p[0], &quot;inactive&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span=
><br><span>     {</span><br><span>diff --git a/src/openvpn/options.h b/src/=
openvpn/options.h</span><br><span>index d331033..555d9dd 100644</span><br><=
span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/openvpn/options.=
h</span><br><span>@@ -406,9 +406,6 @@</span><br><span>     int status_file_=
version;</span><br><span>     int status_file_update_freq;</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* optimize TUN/=
TAP/UDP writes */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
bool fast_io;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span>     struct compress_options comp;</span><br><span> </span><br><sp=
an>     /* buffer sizes */</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1425?usp=3Demail">chang=
e 1425</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1425?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2c0a0b55ad56e704d4bd19f1fbc=
1c30c83fae14c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1425 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--Xj8HBX2GwYI=--

