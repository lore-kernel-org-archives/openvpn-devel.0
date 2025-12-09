From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Tue, 9 Dec 2025 12:47:51 +0000
In-Reply-To: <gerrit.1765279409000.I2c0a0b55ad56e704d4bd19f1fbc1c30c83fae14c@...2715...>
References: <gerrit.1765279409000.I2c0a0b55ad56e704d4bd19f1fbc1c30c83fae14c@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <118ba260deff9498882b0ad6efe8553043987bd7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gb4Vij90Nq0="; charset=UTF-8
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

--gb4Vij90Nq0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1425?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


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
M src/openvpn/openvpn.h
M src/openvpn/options.c
M src/openvpn/options.h
9 files changed, 14 insertions(+), 120 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/25/1425/3

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
index e8e76eb..2533236 100644
--- a/doc/man-sections/unsupported-options.rst
+++ b/doc/man-sections/unsupported-options.rst
@@ -49,3 +49,7 @@
 --opt-verify
   Removed in OpenVPN 2.7.  This option does not make sense anymore as opti=
on
   strings may not match due to the introduction of parameters negotiation.
+
+--fast-io
+  Ignored since OpenVPN 2.7. This option became broken with latest changes
+  to the event loop.
\ No newline at end of file
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 6f1bc0c..eb77a1d 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2154,13 +2154,12 @@
 }
=20
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
index a3fc19d..55bec57 100644
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
+        msg(M_WARN, "DEPRECATED OPTION: --fast-io option ignored. ");
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2c0a0b55ad56e704d4bd19f1fbc1c30c83fae14c
Gerrit-Change-Number: 1425
Gerrit-PatchSet: 3
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--gb4Vij90Nq0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, its_Giaan, plaisthos. </p>
<p>its_Giaan <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1425?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Deprecate --fast-io option<b=
r><br>Recent changes to the event loop revealed that<br>the --fast-io optio=
n is now partially broken and<br>may cause &quot;unroutable control packet&=
quot; issues.<br><br>As agreed during the last hackathon, this patch<br>tur=
ns --fast-io into a no-op and emits a warning<br>when it is used.<br><br>Ch=
ange-Id: I2c0a0b55ad56e704d4bd19f1fbc1c30c83fae14c<br>Signed-off-by: Gianma=
rco De Gregori &lt;gianmarco@...2726...&gt;<br>---<br>M doc/man-sections/ge=
neric-options.rst<br>M doc/man-sections/unsupported-options.rst<br>M src/op=
envpn/forward.c<br>M src/openvpn/forward.h<br>M src/openvpn/init.c<br>M src=
/openvpn/mudp.c<br>M src/openvpn/openvpn.h<br>M src/openvpn/options.c<br>M =
src/openvpn/options.h<br>9 files changed, 14 insertions(+), 120 deletions(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvp=
n refs/changes/25/1425/3</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/generic-opti=
ons.rst b/doc/man-sections/generic-options.rst</span><br><span>index 882cf2=
8..a9232ce 100644</span><br><span>--- a/doc/man-sections/generic-options.rs=
t</span><br><span>+++ b/doc/man-sections/generic-options.rst</span><br><spa=
n>@@ -211,18 +211,6 @@</span><br><span>   ``--show-engines`` standalone opt=
ion to list the crypto engines which</span><br><span>   are supported by Op=
enSSL.</span><br><span> </span><br><span>---fast-io</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  Optimize TUN/TAP/UDP I/O writes by avoidi=
ng a call to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  poll/ep=
oll/select prior to the write operation. The purpose of such a</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-  call would normally be to block =
until the device or socket is ready to</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  accept the write. Such blocking is unnecessary on some p=
latforms which</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  don&#=
39;t support write blocking on UDP sockets or TUN/TAP devices. In such</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-  cases, one can optimize =
the event loop by avoiding the poll/epoll/select</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-  call, improving CPU efficiency by 5% to 10%.</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  This option can only be used on non-Windo=
ws systems, when ``--proto</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-  udp`` is specified, and when ``--shaper`` is *NOT* specified.</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> --group gr=
oup</span><br><span>   Similar to the ``--user`` option, this option change=
s the group ID of</span><br><span>   the OpenVPN process to ``group`` after=
 initialization.</span><br><span>diff --git a/doc/man-sections/unsupported-=
options.rst b/doc/man-sections/unsupported-options.rst</span><br><span>inde=
x e8e76eb..2533236 100644</span><br><span>--- a/doc/man-sections/unsupporte=
d-options.rst</span><br><span>+++ b/doc/man-sections/unsupported-options.rs=
t</span><br><span>@@ -49,3 +49,7 @@</span><br><span> --opt-verify</span><br=
><span>   Removed in OpenVPN 2.7.  This option does not make sense anymore =
as option</span><br><span>   strings may not match due to the introduction =
of parameters negotiation.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+--fast-io</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  Ignored since OpenVP=
N 2.7. This option became broken with latest changes</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  to the event loop.</span><br><span>\ No=
 newline at end of file</span><br><span>diff --git a/src/openvpn/forward.c =
b/src/openvpn/forward.c</span><br><span>index 6f1bc0c..eb77a1d 100644</span=
><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/fo=
rward.c</span><br><span>@@ -2154,13 +2154,12 @@</span><br><span> }</span><b=
r><span> </span><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * Wait for I/O events.  Used for both TCP &amp; UDP sockets</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * in point-to-point mode an=
d for UDP sockets in</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Wait for I/O events.  Used for UDP sockets in</span><br><span>  * point=
-to-multipoint mode.</span><br><span>  */</span><br><span> </span><br><span=
> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_io_flags_do=
work_udp(struct context *c, struct multi_io *multi_io, const unsigned int f=
lags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_io_flags_u=
dp(struct context *c, struct multi_io *multi_io, const unsigned int flags)<=
/span><br><span> {</span><br><span>     unsigned int out_socket;</span><br>=
<span> </span><br><span>@@ -2168,33 +2167,12 @@</span><br><span>     multi_=
io-&gt;udp_flags =3D (out_socket &lt;&lt; SOCKET_SHIFT);</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This is the cor=
e I/O wait function, used for all I/O waits except</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * for the top-level server sockets.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> void</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_io_flags_udp(struct=
 context *c, struct multi_io *multi_io, const unsigned int flags)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    multi_io-&gt;udp_flags =3D ES_ERROR;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;c2.fast_io &amp;&a=
mp; (flags &amp; (IOW_TO_TUN | IOW_TO_LINK | IOW_MBUF)))</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        /* fast path -- only for TUN/TAP/UDP writes */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        unsigned int re=
t =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (f=
lags &amp; IOW_TO_TUN)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 ret |=3D TUN_WRITE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (f=
lags &amp; (IOW_TO_LINK | IOW_MBUF))</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            ret |=3D SOCKET_WRITE;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        multi_io-&gt;udp_flags =3D ret;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* slow path - =
delegate to io_wait_dowork_udp to calculate flags */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        get_io_flags_dowork_udp(c, multi_io=
, flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-io_wait_dow=
ork(struct context *c, const unsigned int flags)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+io_wait(struct context *c, const unsigned int =
flags)</span><br><span> {</span><br><span>     unsigned int out_socket;</sp=
an><br><span>     unsigned int out_tuntap;</span><br><span>diff --git a/src=
/openvpn/forward.h b/src/openvpn/forward.h</span><br><span>index 06808b9..7=
f6f666 100644</span><br><span>--- a/src/openvpn/forward.h</span><br><span>+=
++ b/src/openvpn/forward.h</span><br><span>@@ -68,12 +68,9 @@</span><br><sp=
an> </span><br><span> extern counter_type link_write_bytes_global;</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void get_io_=
flags_dowork_udp(struct context *c, struct multi_io *multi_io,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                             const=
 unsigned int flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span> void get_io_flags_udp(struct context *c, struct multi_io =
*multi_io, const unsigned int flags);</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-void io_wait_dowork(struct context *c, co=
nst unsigned int flags);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void io_wait(struct context *c, const unsigned int flags);</span><br><=
span> </span><br><span> void pre_select(struct context *c);</span><br><span=
> </span><br><span>@@ -382,34 +379,6 @@</span><br><span>     return flags;<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * T=
his is the core I/O wait function, used for all I/O waits except</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * for the top-level server sock=
ets.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-static inline void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-io_wait(struct context *c, const unsig=
ned int flags)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (proto_is_dgram(c-&g=
t;c2.link_sockets[0]-&gt;info.proto) &amp;&amp; c-&gt;c2.fast_io</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; (flags &amp; =
(IOW_TO_TUN | IOW_TO_LINK | IOW_MBUF)))</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        /* fast path -- only for TUN/TAP/UDP writes */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        unsigned int ret =3D 0;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        if (flags &amp; IOW_TO=
_TUN)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            ret |=3D TUN_WRI=
TE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        if (flags &amp; (IOW_T=
O_LINK | IOW_MBUF))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            re=
t |=3D SOCKET_WRITE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c-&gt=
;c2.event_set_status =3D ret;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        /* slow path */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        io_wait_dowork(c, flags);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span> </span><br><span> st=
atic inline bool</span><br><span> connection_established(struct context *c)=
</span><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span=
><br><span>index fc079e1..cd01520 100644</span><br><span>--- a/src/openvpn/=
init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -4139,34=
 +4139,6 @@</span><br><span>     }</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * Fast I/O setup.  Fast I/O is an optimiza=
tion which only works</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * if all of the following are true:</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * (=
1) The platform is not Windows</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * (2) --proto udp is enabled</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * (3) --shaper is disabled</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do_se=
tup_fast_io(struct context *c)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&=
gt;options.fast_io)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef _WIN32</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_INFO, &quot;=
NOTE: --fast-io is disabled since we are running on Windows&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (c-&gt;options.shaper)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            msg(M_INFO, &quot;NOTE: --fast-=
io is disabled since we are using --shaper&quot;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        c-&gt;c2.fast_io =3D true;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span> static void</span><br><span> do_=
signal_on_tls_errors(struct context *c)</span><br><span> {</span><br><span>=
@@ -4513,12 +4485,6 @@</span><br><span>     }</span><br><span> #endif</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* sh=
ould we enable fast I/O? */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (c-&gt;mode =3D=3D CM_P2P || c-&gt;mode =3D=3D CM_TOP)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        do_setup_fast_io(c);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span>     /* should we throw a signal on=
 TLS errors? */</span><br><span>     do_signal_on_tls_errors(c);</span><br>=
<span> </span><br><span>diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.=
c</span><br><span>index b03e165..bf115e6 100644</span><br><span>--- a/src/o=
penvpn/mudp.c</span><br><span>+++ b/src/openvpn/mudp.c</span><br><span>@@ -=
339,9 +339,7 @@</span><br><span> multi_process_io_udp(struct multi_context =
*m, struct link_socket *sock)</span><br><span> {</span><br><span>     const=
 unsigned int status =3D m-&gt;multi_io-&gt;udp_flags;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    const unsigned int mpp_flags =3D m-&gt=
;top.c2.fast_io</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                                 ? (MPP_CONDITIONAL_PRE_SELECT | MPP_CLOSE_=
ON_SIGNAL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
                            : (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const unsigned int mp=
p_flags =3D (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);</span><br><span> </span=
><br><span>     /* UDP port ready to accept write */</span><br><span>     i=
f (status &amp; SOCKET_WRITE)</span><br><span>diff --git a/src/openvpn/open=
vpn.h b/src/openvpn/openvpn.h</span><br><span>index a198fcf..3e1ae78 100644=
</span><br><span>--- a/src/openvpn/openvpn.h</span><br><span>+++ b/src/open=
vpn/openvpn.h</span><br><span>@@ -420,9 +420,6 @@</span><br><span>     stru=
ct env_set *es;</span><br><span>     bool es_owned;</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* don&#39;t wait for T=
UN/TAP/UDP to be ready to accept write */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    bool fast_io;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span>     /* --ifconfig endpoints to be pushed =
to client */</span><br><span>     bool push_request_received;</span><br><sp=
an>     bool push_ifconfig_defined;</span><br><span>diff --git a/src/openvp=
n/options.c b/src/openvpn/options.c</span><br><span>index a3fc19d..55bec57 =
100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/sr=
c/openvpn/options.c</span><br><span>@@ -285,7 +285,6 @@</span><br><span> #i=
f ENABLE_IP_PKTINFO</span><br><span>     &quot;--multihome     : Configure =
a multi-homed UDP server.\n&quot;</span><br><span> #endif</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    &quot;--fast-io       : Optimize TU=
N/TAP/UDP writes.\n&quot;</span><br><span>     &quot;--remap-usr1 s  : On S=
IGUSR1 signals, remap signal (s=3D&#39;SIGHUP&#39; or &#39;SIGTERM&#39;).\n=
&quot;</span><br><span>     &quot;--persist-tun   : Keep tun/tap device ope=
n across SIGUSR1 or --ping-restart.\n&quot;</span><br><span>     &quot;--pe=
rsist-remote-ip : Keep remote IP address across SIGUSR1 or --ping-restart.\=
n&quot;</span><br><span>@@ -1795,8 +1794,6 @@</span><br><span> #endif</span=
><br><span>     SHOW_INT(sockflags);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(fast_io);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     SHOW_INT(comp.alg)=
;</span><br><span>     SHOW_INT(comp.flags);</span><br><span> </span><br><s=
pan>@@ -6600,7 +6597,7 @@</span><br><span>     else if (streq(p[0], &quot;f=
ast-io&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>    =
     VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        options-&gt;fast_io =3D true;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;DEPRECATED OPT=
ION: --fast-io option ignored. &quot;);</span><br><span>     }</span><br><s=
pan>     else if (streq(p[0], &quot;inactive&quot;) &amp;&amp; p[1] &amp;&a=
mp; !p[3])</span><br><span>     {</span><br><span>diff --git a/src/openvpn/=
options.h b/src/openvpn/options.h</span><br><span>index 42db9ca..41212fb 10=
0644</span><br><span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/=
openvpn/options.h</span><br><span>@@ -406,9 +406,6 @@</span><br><span>     =
int status_file_version;</span><br><span>     int status_file_update_freq;<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
/* optimize TUN/TAP/UDP writes */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    bool fast_io;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span>     struct compress_options comp;</span><br><span=
> </span><br><span>     /* buffer sizes */</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1425?us=
p=3Demail">change 1425</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1425?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2c0a0b55ad56e704d4bd19f1fbc=
1c30c83fae14c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1425 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--gb4Vij90Nq0=--

