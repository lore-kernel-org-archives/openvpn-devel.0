From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 7 Mar 2024 16:29:46 +0000
In-Reply-To: <gerrit.1708351044000.I57f1c2ed42bd9dfd43577238749a9b7f4c1419ff@...2715...>
References: <gerrit.1708351044000.I57f1c2ed42bd9dfd43577238749a9b7f4c1419ff@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <255de2c72765fecfc9faf8ee30856f54828e01f0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ghzBJZ4f+Hg="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Persist-key: enable
 persist-key option by default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ghzBJZ4f+Hg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/52=
9?usp=3Demail )

Change subject: Persist-key: enable persist-key option by default
......................................................................

Persist-key: enable persist-key option by default

Change the default behavior of the OpenVPN configuration
by enabling the persist-key option by default.

This means that all the keys will be kept in memory
across restart.

Trac: #1405
Change-Id: I57f1c2ed42bd9dfd43577238749a9b7f4c1419ff
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Message-Id: <20240307140355.32644-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
347.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M Changes.rst
M doc/man-sections/connection-profiles.rst
M doc/man-sections/generic-options.rst
M doc/man-sections/link-options.rst
M doc/man-sections/server-options.rst
M doc/man-sections/signals.rst
M doc/man-sections/unsupported-options.rst
M sample/sample-config-files/client.conf
M sample/sample-config-files/server.conf
M sample/sample-windows/sample.ovpn
M src/openvpn/init.c
M src/openvpn/openvpn.h
M src/openvpn/options.c
M src/openvpn/options.h
14 files changed, 24 insertions(+), 47 deletions(-)




diff --git a/Changes.rst b/Changes.rst
index 58cb3db..4cded98 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -20,6 +20,8 @@
     When configured to authenticate with NTLMv1 (``ntlm`` keyword in
     ``--http-proxy``) OpenVPN will try NTLMv2 instead.

+``persist-key`` option has been enabled by default.
+    All the keys will be kept in memory across restart.

 Overview of changes in 2.6
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
diff --git a/doc/man-sections/connection-profiles.rst b/doc/man-sections/co=
nnection-profiles.rst
index c8816e1..520bbef 100644
--- a/doc/man-sections/connection-profiles.rst
+++ b/doc/man-sections/connection-profiles.rst
@@ -39,7 +39,6 @@
    http-proxy 192.168.0.8 8080
    </connection>

-   persist-key
    persist-tun
    pkcs12 client.p12
    remote-cert-tls server
diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generi=
c-options.rst
index 30c990d..f8a0f48 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -302,17 +302,6 @@
   Change process priority after initialization (``n`` greater than 0 is
   lower priority, ``n`` less than zero is higher priority).

---persist-key
-  Don't re-read key files across :code:`SIGUSR1` or ``--ping-restart``.
-
-  This option can be combined with ``--user`` to allow restarts
-  triggered by the :code:`SIGUSR1` signal. Normally if you drop root
-  privileges in OpenVPN, the daemon cannot be restarted since it will now
-  be unable to re-read protected key files.
-
-  This option solves the problem by persisting keys across :code:`SIGUSR1`
-  resets, so they don't need to be re-read.
-
 --providers providers
   Load the list of (OpenSSL) providers. This is mainly useful for using an
   external provider for key management like tpm2-openssl or to load the
@@ -402,7 +391,7 @@

   Like with chroot, complications can result when scripts or restarts are
   executed after the setcon operation, which is why you should really
-  consider using the ``--persist-key`` and ``--persist-tun`` options.
+  consider using the ``--persist-tun`` option.

 --status args
   Write operational status to ``file`` every ``n`` seconds. ``n`` defaults
diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-opti=
ons.rst
index ca26bfe..ca192c3 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -283,7 +283,7 @@
   See the signals section below for more information on :code:`SIGUSR1`.

   Note that the behavior of ``SIGUSR1`` can be modified by the
-  ``--persist-tun``, ``--persist-key``, ``--persist-local-ip`` and
+  ``--persist-tun``, ``--persist-local-ip`` and
   ``--persist-remote-ip`` options.

   Also note that ``--ping-exit`` and ``--ping-restart`` are mutually
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-=
options.rst
index 98f5340..0632e31 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -452,7 +452,7 @@
   ``--route``, ``--route-gateway``, ``--route-delay``,
   ``--redirect-gateway``, ``--ip-win32``, ``--dhcp-option``, ``--dns``,
   ``--inactive``, ``--ping``, ``--ping-exit``, ``--ping-restart``,
-  ``--setenv``, ``--auth-token``, ``--persist-key``, ``--persist-tun``,
+  ``--setenv``, ``--auth-token``, ``--persist-tun``,
   ``--echo``, ``--comp-lzo``, ``--socket-flags``, ``--sndbuf``,
   ``--rcvbuf``, ``--session-timeout``

diff --git a/doc/man-sections/signals.rst b/doc/man-sections/signals.rst
index 63611b3..01e8e5b 100644
--- a/doc/man-sections/signals.rst
+++ b/doc/man-sections/signals.rst
@@ -10,9 +10,8 @@
     Like :code:`SIGHUP``, except don't re-read configuration file, and
     possibly don't close and reopen TUN/TAP device, re-read key files,
     preserve local IP address/port, or preserve most recently authenticated
-    remote IP address/port based on ``--persist-tun``, ``--persist-key``,
-    ``--persist-local-ip`` and ``--persist-remote-ip`` options respectively
-    (see above).
+    remote IP address/port based on ``--persist-tun``, ``--persist-local-i=
p``
+    and ``--persist-remote-ip`` options respectively (see above).

     This signal may also be internally generated by a timeout condition,
     governed by the ``--ping-restart`` option.
diff --git a/doc/man-sections/unsupported-options.rst b/doc/man-sections/un=
supported-options.rst
index a0c1232..11467ca 100644
--- a/doc/man-sections/unsupported-options.rst
+++ b/doc/man-sections/unsupported-options.rst
@@ -42,3 +42,6 @@

 --prng
   Removed in OpenVPN 2.6.  We now always use the PRNG of the SSL library.
+
+--persist-key
+  Ignored since OpenVPN 2.7. Keys are now always persisted across restarts.
\ No newline at end of file
diff --git a/sample/sample-config-files/client.conf b/sample/sample-config-=
files/client.conf
index 15cb1b3..f51e017 100644
--- a/sample/sample-config-files/client.conf
+++ b/sample/sample-config-files/client.conf
@@ -62,7 +62,6 @@
 ;group openvpn

 # Try to preserve some state across restarts.
-persist-key
 persist-tun

 # If you are connecting through an
diff --git a/sample/sample-config-files/server.conf b/sample/sample-config-=
files/server.conf
index d9345b6..009fe56 100644
--- a/sample/sample-config-files/server.conf
+++ b/sample/sample-config-files/server.conf
@@ -274,11 +274,10 @@
 ;user openvpn
 ;group openvpn

-# The persist options will try to avoid
+# The persist option will try to avoid
 # accessing certain resources on restart
 # that may no longer be accessible because
 # of the privilege downgrade.
-persist-key
 persist-tun

 # Output a short status file showing
diff --git a/sample/sample-windows/sample.ovpn b/sample/sample-windows/samp=
le.ovpn
index 51e3274..be24faa 100755
--- a/sample/sample-windows/sample.ovpn
+++ b/sample/sample-windows/sample.ovpn
@@ -89,7 +89,6 @@
 ; ping-restart 60
 ; ping-timer-rem
 ; persist-tun
-; persist-key
 ; resolv-retry 86400

 # keep-alive ping
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 52b4308..52b3931 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3559,14 +3559,6 @@
         {
             msg(M_WARN, "WARNING: you are using user/group/chroot/setcon w=
ithout persist-tun -- this may cause restarts to fail");
         }
-        if (!o->persist_key
-#ifdef ENABLE_PKCS11
-            && !o->pkcs11_id
-#endif
-            )
-        {
-            msg(M_WARN, "WARNING: you are using user/group/chroot/setcon w=
ithout persist-key -- this may cause restarts to fail");
-        }
     }

     if (o->chroot_dir && !(o->username && o->groupname))
@@ -3857,7 +3849,7 @@
 do_close_free_key_schedule(struct context *c, bool free_ssl_ctx)
 {
     /*
-     * always free the tls_auth/crypt key. If persist_key is true, the key=
 will
+     * always free the tls_auth/crypt key. The key will
      * be reloaded from memory (pre-cached)
      */
     free_key_ctx(&c->c1.ks.tls_crypt_v2_server_key);
@@ -3866,7 +3858,7 @@
     buf_clear(&c->c1.ks.tls_crypt_v2_wkc);
     free_buf(&c->c1.ks.tls_crypt_v2_wkc);

-    if (!(c->sig->signal_received =3D=3D SIGUSR1 && c->options.persist_key=
))
+    if (!(c->sig->signal_received =3D=3D SIGUSR1))
     {
         key_schedule_free(&c->c1.ks, free_ssl_ctx);
     }
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index dabc5be..df93b0e 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -48,7 +48,7 @@

 /*
  * Our global key schedules, packaged thusly
- * to facilitate --persist-key.
+ * to facilitate key persistence.
  */

 struct key_schedule
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2c79a1e..94a88f9 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -273,7 +273,6 @@
     "--persist-tun   : Keep tun/tap device open across SIGUSR1 or --ping-r=
estart.\n"
     "--persist-remote-ip : Keep remote IP address across SIGUSR1 or --ping=
-restart.\n"
     "--persist-local-ip  : Keep local IP address across SIGUSR1 or --ping-=
restart.\n"
-    "--persist-key   : Don't re-read key files across SIGUSR1 or --ping-re=
start.\n"
 #if PASSTOS_CAPABILITY
     "--passtos       : TOS passthrough (applies to IPv4 only).\n"
 #endif
@@ -1857,7 +1856,6 @@
     SHOW_BOOL(persist_tun);
     SHOW_BOOL(persist_local_ip);
     SHOW_BOOL(persist_remote_ip);
-    SHOW_BOOL(persist_key);

 #if PASSTOS_CAPABILITY
     SHOW_BOOL(passtos);
@@ -3240,18 +3238,16 @@
         ce->tls_crypt_v2_file_inline =3D o->tls_crypt_v2_file_inline;
     }

-    /* Pre-cache tls-auth/crypt(-v2) key file if persist-key was specified=
 and
+    /* Pre-cache tls-auth/crypt(-v2) key file if
      * keys were not already embedded in the config file.
      */
-    if (o->persist_key)
-    {
-        connection_entry_preload_key(&ce->tls_auth_file,
-                                     &ce->tls_auth_file_inline, &o->gc);
-        connection_entry_preload_key(&ce->tls_crypt_file,
-                                     &ce->tls_crypt_file_inline, &o->gc);
-        connection_entry_preload_key(&ce->tls_crypt_v2_file,
-                                     &ce->tls_crypt_v2_file_inline, &o->gc=
);
-    }
+    connection_entry_preload_key(&ce->tls_auth_file,
+                                 &ce->tls_auth_file_inline, &o->gc);
+    connection_entry_preload_key(&ce->tls_crypt_file,
+                                 &ce->tls_crypt_file_inline, &o->gc);
+    connection_entry_preload_key(&ce->tls_crypt_v2_file,
+                                 &ce->tls_crypt_v2_file_inline, &o->gc);
+

     if (!proto_is_udp(ce->proto) && ce->explicit_exit_notification)
     {
@@ -6963,7 +6959,8 @@
     else if (streq(p[0], "persist-key") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_PERSIST);
-        options->persist_key =3D true;
+        msg(M_WARN, "DEPRECATED: --persist-key option ignored. "
+            "Keys are now always persisted across restarts. ");
     }
     else if (streq(p[0], "persist-local-ip") && !p[1])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 85de887..2b37d1f 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -344,7 +344,6 @@
     bool persist_tun;           /* Don't close/reopen TUN/TAP dev on SIGUS=
R1 or PING_RESTART */
     bool persist_local_ip;      /* Don't re-resolve local address on SIGUS=
R1 or PING_RESTART */
     bool persist_remote_ip;     /* Don't re-resolve remote address on SIGU=
SR1 or PING_RESTART */
-    bool persist_key;           /* Don't re-read key files on SIGUSR1 or P=
ING_RESTART */

 #if PASSTOS_CAPABILITY
     bool passtos;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/529?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I57f1c2ed42bd9dfd43577238749a9b7f4c1419ff
Gerrit-Change-Number: 529
Gerrit-PatchSet: 6
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--ghzBJZ4f+Hg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/529?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Persist-key: enable persist-key option by defa=
ult<br><br>Change the default behavior of the OpenVPN configuration<br>by e=
nabling the persist-key option by default.<br><br>This means that all the k=
eys will be kept in memory<br>across restart.<br><br>Trac: #1405<br>Change-=
Id: I57f1c2ed42bd9dfd43577238749a9b7f4c1419ff<br>Signed-off-by: Gianmarco D=
e Gregori &lt;gianmarco@...2726...&gt;<br>Message-Id: &lt;20240307140355.32=
644-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-deve=
l@lists.sourceforge.net/msg28347.html<br>Signed-off-by: Gert Doering &lt;ge=
rt@...1296...&gt;<br>---<br>M Changes.rst<br>M doc/man-sections/connection-=
profiles.rst<br>M doc/man-sections/generic-options.rst<br>M doc/man-section=
s/link-options.rst<br>M doc/man-sections/server-options.rst<br>M doc/man-se=
ctions/signals.rst<br>M doc/man-sections/unsupported-options.rst<br>M sampl=
e/sample-config-files/client.conf<br>M sample/sample-config-files/server.co=
nf<br>M sample/sample-windows/sample.ovpn<br>M src/openvpn/init.c<br>M src/=
openvpn/openvpn.h<br>M src/openvpn/options.c<br>M src/openvpn/options.h<br>=
14 files changed, 24 insertions(+), 47 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/Changes.rst b/Changes.rst</span><br><span>index 58cb3db..4c=
ded98 100644</span><br><span>--- a/Changes.rst</span><br><span>+++ b/Change=
s.rst</span><br><span>@@ -20,6 +20,8 @@</span><br><span>     When configure=
d to authenticate with NTLMv1 (``ntlm`` keyword in</span><br><span>     ``-=
-http-proxy``) OpenVPN will try NTLMv2 instead.</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+``persist-key`` option has be=
en enabled by default.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    All the keys will be kept in memory across restart.</span><br><span>=
 </span><br><span> Overview of changes in 2.6</span><br><span> =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><b=
r><span>diff --git a/doc/man-sections/connection-profiles.rst b/doc/man-sec=
tions/connection-profiles.rst</span><br><span>index c8816e1..520bbef 100644=
</span><br><span>--- a/doc/man-sections/connection-profiles.rst</span><br><=
span>+++ b/doc/man-sections/connection-profiles.rst</span><br><span>@@ -39,=
7 +39,6 @@</span><br><span>    http-proxy 192.168.0.8 8080</span><br><span>=
    &lt;/connection&gt;</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-   persist-key</span><br><span>    persist-tun</span><b=
r><span>    pkcs12 client.p12</span><br><span>    remote-cert-tls server</s=
pan><br><span>diff --git a/doc/man-sections/generic-options.rst b/doc/man-s=
ections/generic-options.rst</span><br><span>index 30c990d..f8a0f48 100644</=
span><br><span>--- a/doc/man-sections/generic-options.rst</span><br><span>+=
++ b/doc/man-sections/generic-options.rst</span><br><span>@@ -302,17 +302,6=
 @@</span><br><span>   Change process priority after initialization (``n`` =
greater than 0 is</span><br><span>   lower priority, ``n`` less than zero i=
s higher priority).</span><br><span> </span><br><span>---persist-key</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-  Don&#39;t re-read key file=
s across :code:`SIGUSR1` or ``--ping-restart``.</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-  This option can be combined with ``--user`` to allow restarts</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-  triggered by the :code:`SI=
GUSR1` signal. Normally if you drop root</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  privileges in OpenVPN, the daemon cannot be restarted =
since it will now</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  be=
 unable to re-read protected key files.</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  T=
his option solves the problem by persisting keys across :code:`SIGUSR1`</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  resets, so they don&#39=
;t need to be re-read.</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> --providers providers</span><br><span>   Load the list o=
f (OpenSSL) providers. This is mainly useful for using an</span><br><span> =
  external provider for key management like tpm2-openssl or to load the</sp=
an><br><span>@@ -402,7 +391,7 @@</span><br><span> </span><br><span>   Like =
with chroot, complications can result when scripts or restarts are</span><b=
r><span>   executed after the setcon operation, which is why you should rea=
lly</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  consider using t=
he ``--persist-key`` and ``--persist-tun`` options.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  consider using the ``--persist-tun`` op=
tion.</span><br><span> </span><br><span> --status args</span><br><span>   W=
rite operational status to ``file`` every ``n`` seconds. ``n`` defaults</sp=
an><br><span>diff --git a/doc/man-sections/link-options.rst b/doc/man-secti=
ons/link-options.rst</span><br><span>index ca26bfe..ca192c3 100644</span><b=
r><span>--- a/doc/man-sections/link-options.rst</span><br><span>+++ b/doc/m=
an-sections/link-options.rst</span><br><span>@@ -283,7 +283,7 @@</span><br>=
<span>   See the signals section below for more information on :code:`SIGUS=
R1`.</span><br><span> </span><br><span>   Note that the behavior of ``SIGUS=
R1`` can be modified by the</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  ``--persist-tun``, ``--persist-key``, ``--persist-local-ip`` and</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--persist-tun``, `=
`--persist-local-ip`` and</span><br><span>   ``--persist-remote-ip`` option=
s.</span><br><span> </span><br><span>   Also note that ``--ping-exit`` and =
``--ping-restart`` are mutually</span><br><span>diff --git a/doc/man-sectio=
ns/server-options.rst b/doc/man-sections/server-options.rst</span><br><span=
>index 98f5340..0632e31 100644</span><br><span>--- a/doc/man-sections/serve=
r-options.rst</span><br><span>+++ b/doc/man-sections/server-options.rst</sp=
an><br><span>@@ -452,7 +452,7 @@</span><br><span>   ``--route``, ``--route-=
gateway``, ``--route-delay``,</span><br><span>   ``--redirect-gateway``, ``=
--ip-win32``, ``--dhcp-option``, ``--dns``,</span><br><span>   ``--inactive=
``, ``--ping``, ``--ping-exit``, ``--ping-restart``,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  ``--setenv``, ``--auth-token``, ``--persi=
st-key``, ``--persist-tun``,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  ``--setenv``, ``--auth-token``, ``--persist-tun``,</span><br><sp=
an>   ``--echo``, ``--comp-lzo``, ``--socket-flags``, ``--sndbuf``,</span><=
br><span>   ``--rcvbuf``, ``--session-timeout``</span><br><span> </span><br=
><span>diff --git a/doc/man-sections/signals.rst b/doc/man-sections/signals=
.rst</span><br><span>index 63611b3..01e8e5b 100644</span><br><span>--- a/do=
c/man-sections/signals.rst</span><br><span>+++ b/doc/man-sections/signals.r=
st</span><br><span>@@ -10,9 +10,8 @@</span><br><span>     Like :code:`SIGHU=
P``, except don&#39;t re-read configuration file, and</span><br><span>     =
possibly don&#39;t close and reopen TUN/TAP device, re-read key files,</spa=
n><br><span>     preserve local IP address/port, or preserve most recently =
authenticated</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    remo=
te IP address/port based on ``--persist-tun``, ``--persist-key``,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    ``--persist-local-ip`` and =
``--persist-remote-ip`` options respectively</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    (see above).</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    remote IP address/port based on ``--persist-tun``, =
``--persist-local-ip``</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    and ``--persist-remote-ip`` options respectively (see above).</span>=
<br><span> </span><br><span>     This signal may also be internally generat=
ed by a timeout condition,</span><br><span>     governed by the ``--ping-re=
start`` option.</span><br><span>diff --git a/doc/man-sections/unsupported-o=
ptions.rst b/doc/man-sections/unsupported-options.rst</span><br><span>index=
 a0c1232..11467ca 100644</span><br><span>--- a/doc/man-sections/unsupported=
-options.rst</span><br><span>+++ b/doc/man-sections/unsupported-options.rst=
</span><br><span>@@ -42,3 +42,6 @@</span><br><span> </span><br><span> --prn=
g</span><br><span>   Removed in OpenVPN 2.6.  We now always use the PRNG of=
 the SSL library.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+--persist-key</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  Ignored since OpenVPN 2.7=
. Keys are now always persisted across restarts.</span><br><span>\ No newli=
ne at end of file</span><br><span>diff --git a/sample/sample-config-files/c=
lient.conf b/sample/sample-config-files/client.conf</span><br><span>index 1=
5cb1b3..f51e017 100644</span><br><span>--- a/sample/sample-config-files/cli=
ent.conf</span><br><span>+++ b/sample/sample-config-files/client.conf</span=
><br><span>@@ -62,7 +62,6 @@</span><br><span> ;group openvpn</span><br><spa=
n> </span><br><span> # Try to preserve some state across restarts.</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-persist-key</span><br><span> p=
ersist-tun</span><br><span> </span><br><span> # If you are connecting throu=
gh an</span><br><span>diff --git a/sample/sample-config-files/server.conf b=
/sample/sample-config-files/server.conf</span><br><span>index d9345b6..009f=
e56 100644</span><br><span>--- a/sample/sample-config-files/server.conf</sp=
an><br><span>+++ b/sample/sample-config-files/server.conf</span><br><span>@=
@ -274,11 +274,10 @@</span><br><span> ;user openvpn</span><br><span> ;group=
 openvpn</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-# The persist options will try to avoid</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+# The persist option will try to avoid</span><br><=
span> # accessing certain resources on restart</span><br><span> # that may =
no longer be accessible because</span><br><span> # of the privilege downgra=
de.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-persist-key</span>=
<br><span> persist-tun</span><br><span> </span><br><span> # Output a short =
status file showing</span><br><span>diff --git a/sample/sample-windows/samp=
le.ovpn b/sample/sample-windows/sample.ovpn</span><br><span>index 51e3274..=
be24faa 100755</span><br><span>--- a/sample/sample-windows/sample.ovpn</spa=
n><br><span>+++ b/sample/sample-windows/sample.ovpn</span><br><span>@@ -89,=
7 +89,6 @@</span><br><span> ; ping-restart 60</span><br><span> ; ping-timer=
-rem</span><br><span> ; persist-tun</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-; persist-key</span><br><span> ; resolv-retry 86400</span><br=
><span> </span><br><span> # keep-alive ping</span><br><span>diff --git a/sr=
c/openvpn/init.c b/src/openvpn/init.c</span><br><span>index 52b4308..52b393=
1 100644</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src=
/openvpn/init.c</span><br><span>@@ -3559,14 +3559,6 @@</span><br><span>    =
     {</span><br><span>             msg(M_WARN, &quot;WARNING: you are usin=
g user/group/chroot/setcon without persist-tun -- this may cause restarts t=
o fail&quot;);</span><br><span>         }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (!o-&gt;persist_key</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_PKCS11</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            &amp;&amp; !o-&gt;pkcs11_id</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            )</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            msg(M_WARN, &quot;WARNING: you are using user/group=
/chroot/setcon without persist-key -- this may cause restarts to fail&quot;=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br=
><span>     }</span><br><span> </span><br><span>     if (o-&gt;chroot_dir &=
amp;&amp; !(o-&gt;username &amp;&amp; o-&gt;groupname))</span><br><span>@@ =
-3857,7 +3849,7 @@</span><br><span> do_close_free_key_schedule(struct conte=
xt *c, bool free_ssl_ctx)</span><br><span> {</span><br><span>     /*</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-     * always free the tls_a=
uth/crypt key. If persist_key is true, the key will</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * always free the tls_auth/crypt key=
. The key will</span><br><span>      * be reloaded from memory (pre-cached)=
</span><br><span>      */</span><br><span>     free_key_ctx(&amp;c-&gt;c1.k=
s.tls_crypt_v2_server_key);</span><br><span>@@ -3866,7 +3858,7 @@</span><br=
><span>     buf_clear(&amp;c-&gt;c1.ks.tls_crypt_v2_wkc);</span><br><span> =
    free_buf(&amp;c-&gt;c1.ks.tls_crypt_v2_wkc);</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (!(c-&gt;sig-&gt;signal=
_received =3D=3D SIGUSR1 &amp;&amp; c-&gt;options.persist_key))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!(c-&gt;sig-&gt;signal_=
received =3D=3D SIGUSR1))</span><br><span>     {</span><br><span>         k=
ey_schedule_free(&amp;c-&gt;c1.ks, free_ssl_ctx);</span><br><span>     }</s=
pan><br><span>diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h</s=
pan><br><span>index dabc5be..df93b0e 100644</span><br><span>--- a/src/openv=
pn/openvpn.h</span><br><span>+++ b/src/openvpn/openvpn.h</span><br><span>@@=
 -48,7 +48,7 @@</span><br><span> </span><br><span> /*</span><br><span>  * O=
ur global key schedules, packaged thusly</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * to facilitate --persist-key.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * to facilitate key persistence.</span><br>=
<span>  */</span><br><span> </span><br><span> struct key_schedule</span><br=
><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br=
><span>index 2c79a1e..94a88f9 100644</span><br><span>--- a/src/openvpn/opti=
ons.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -273,7=
 +273,6 @@</span><br><span>     &quot;--persist-tun   : Keep tun/tap device=
 open across SIGUSR1 or --ping-restart.\n&quot;</span><br><span>     &quot;=
--persist-remote-ip : Keep remote IP address across SIGUSR1 or --ping-resta=
rt.\n&quot;</span><br><span>     &quot;--persist-local-ip  : Keep local IP =
address across SIGUSR1 or --ping-restart.\n&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    &quot;--persist-key   : Don&#39;t re-read k=
ey files across SIGUSR1 or --ping-restart.\n&quot;</span><br><span> #if PAS=
STOS_CAPABILITY</span><br><span>     &quot;--passtos       : TOS passthroug=
h (applies to IPv4 only).\n&quot;</span><br><span> #endif</span><br><span>@=
@ -1857,7 +1856,6 @@</span><br><span>     SHOW_BOOL(persist_tun);</span><br=
><span>     SHOW_BOOL(persist_local_ip);</span><br><span>     SHOW_BOOL(per=
sist_remote_ip);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    S=
HOW_BOOL(persist_key);</span><br><span> </span><br><span> #if PASSTOS_CAPAB=
ILITY</span><br><span>     SHOW_BOOL(passtos);</span><br><span>@@ -3240,18 =
+3238,16 @@</span><br><span>         ce-&gt;tls_crypt_v2_file_inline =3D o-=
&gt;tls_crypt_v2_file_inline;</span><br><span>     }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Pre-cache tls-auth/=
crypt(-v2) key file if persist-key was specified and</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Pre-cache tls-auth/crypt(-v2) key =
file if</span><br><span>      * keys were not already embedded in the confi=
g file.</span><br><span>      */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (o-&gt;persist_key)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        connection_entry_preload_key(&amp;ce-&gt;tls_auth_file,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                 =
    &amp;ce-&gt;tls_auth_file_inline, &amp;o-&gt;gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        connection_entry_preload_key(&amp;c=
e-&gt;tls_crypt_file,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                                     &amp;ce-&gt;tls_crypt_file_inline, &am=
p;o-&gt;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c=
onnection_entry_preload_key(&amp;ce-&gt;tls_crypt_v2_file,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                                     &=
amp;ce-&gt;tls_crypt_v2_file_inline, &amp;o-&gt;gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    connection_entry_preload_key(&amp;ce-&gt;tls_auth_fil=
e,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
                &amp;ce-&gt;tls_auth_file_inline, &amp;o-&gt;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    connection_entry_preload_=
key(&amp;ce-&gt;tls_crypt_file,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                 &amp;ce-&gt;tls_crypt_file_inl=
ine, &amp;o-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    connection_entry_preload_key(&amp;ce-&gt;tls_crypt_v2_file,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
   &amp;ce-&gt;tls_crypt_v2_file_inline, &amp;o-&gt;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span><br><span>   =
  if (!proto_is_udp(ce-&gt;proto) &amp;&amp; ce-&gt;explicit_exit_notificat=
ion)</span><br><span>     {</span><br><span>@@ -6963,7 +6959,8 @@</span><br=
><span>     else if (streq(p[0], &quot;persist-key&quot;) &amp;&amp; !p[1])=
</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_PE=
RSIST);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        option=
s-&gt;persist_key =3D true;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        msg(M_WARN, &quot;DEPRECATED: --persist-key option ignored.=
 &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
&quot;Keys are now always persisted across restarts. &quot;);</span><br><sp=
an>     }</span><br><span>     else if (streq(p[0], &quot;persist-local-ip&=
quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>diff --git =
a/src/openvpn/options.h b/src/openvpn/options.h</span><br><span>index 85de8=
87..2b37d1f 100644</span><br><span>--- a/src/openvpn/options.h</span><br><s=
pan>+++ b/src/openvpn/options.h</span><br><span>@@ -344,7 +344,6 @@</span><=
br><span>     bool persist_tun;           /* Don&#39;t close/reopen TUN/TAP=
 dev on SIGUSR1 or PING_RESTART */</span><br><span>     bool persist_local_=
ip;      /* Don&#39;t re-resolve local address on SIGUSR1 or PING_RESTART *=
/</span><br><span>     bool persist_remote_ip;     /* Don&#39;t re-resolve =
remote address on SIGUSR1 or PING_RESTART */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    bool persist_key;           /* Don&#39;t re-read=
 key files on SIGUSR1 or PING_RESTART */</span><br><span> </span><br><span>=
 #if PASSTOS_CAPABILITY</span><br><span>     bool passtos;</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/529?usp=3Demail">change 529</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/529?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I57f1c2ed42bd9dfd43577238749=
a9b7f4c1419ff </div>
<div style=3D"display:none"> Gerrit-Change-Number: 529 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--ghzBJZ4f+Hg=--

