From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 7 Mar 2024 13:00:50 +0000
In-Reply-To: <gerrit.1708351044000.I57f1c2ed42bd9dfd43577238749a9b7f4c1419ff@...2715...>
References: <gerrit.1708351044000.I57f1c2ed42bd9dfd43577238749a9b7f4c1419ff@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7b71ad67caa813680434351a57009ddfe1894a8d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8Ty6gQJMinI="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8Ty6gQJMinI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/529?usp=3Demail

to look at the new patch set (#5).

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


Change subject: Persist-key: enable persist-key option by default
......................................................................

Persist-key: enable persist-key option by default

Change the default behavior of the OpenVPN configuration
by enabling the persist-key option by default.

This means that all the keys will be kept in memory
across restart.

Fixes: Trac #1405
Change-Id: I57f1c2ed42bd9dfd43577238749a9b7f4c1419ff
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/29/529/5

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
=20
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
Gerrit-PatchSet: 5
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--8Ty6gQJMinI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, plaistho=
s. </p>
<p>its_Giaan <strong>uploaded patch set #5</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/529?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><p>The change is no longer submittable: Code-=
Review and checks~ChecksSubmitRule are unsatisfied now.</p><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">Persist-key: enable=
 persist-key option by default<br><br>Change the default behavior of the Op=
enVPN configuration<br>by enabling the persist-key option by default.<br><b=
r>This means that all the keys will be kept in memory<br>across restart.<br=
><br>Fixes: Trac #1405<br>Change-Id: I57f1c2ed42bd9dfd43577238749a9b7f4c141=
9ff<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...2726...&gt;<br>=
---<br>M Changes.rst<br>M doc/man-sections/connection-profiles.rst<br>M doc=
/man-sections/generic-options.rst<br>M doc/man-sections/link-options.rst<br=
>M doc/man-sections/server-options.rst<br>M doc/man-sections/signals.rst<br=
>M doc/man-sections/unsupported-options.rst<br>M sample/sample-config-files=
/client.conf<br>M sample/sample-config-files/server.conf<br>M sample/sample=
-windows/sample.ovpn<br>M src/openvpn/init.c<br>M src/openvpn/openvpn.h<br>=
M src/openvpn/options.c<br>M src/openvpn/options.h<br>14 files changed, 24 =
insertions(+), 47 deletions(-)<br><br></pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/29/529/5</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/Changes.rst b/Chan=
ges.rst</span><br><span>index 58cb3db..4cded98 100644</span><br><span>--- a=
/Changes.rst</span><br><span>+++ b/Changes.rst</span><br><span>@@ -20,6 +20=
,8 @@</span><br><span>     When configured to authenticate with NTLMv1 (``n=
tlm`` keyword in</span><br><span>     ``--http-proxy``) OpenVPN will try NT=
LMv2 instead.</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+``persist-key`` option has been enabled by default.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    All the keys will be kept i=
n memory across restart.</span><br><span> </span><br><span> Overview of cha=
nges in 2.6</span><br><span> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span>diff --git a/doc/man-sect=
ions/connection-profiles.rst b/doc/man-sections/connection-profiles.rst</sp=
an><br><span>index c8816e1..520bbef 100644</span><br><span>--- a/doc/man-se=
ctions/connection-profiles.rst</span><br><span>+++ b/doc/man-sections/conne=
ction-profiles.rst</span><br><span>@@ -39,7 +39,6 @@</span><br><span>    ht=
tp-proxy 192.168.0.8 8080</span><br><span>    &lt;/connection&gt;</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   persist-ke=
y</span><br><span>    persist-tun</span><br><span>    pkcs12 client.p12</sp=
an><br><span>    remote-cert-tls server</span><br><span>diff --git a/doc/ma=
n-sections/generic-options.rst b/doc/man-sections/generic-options.rst</span=
><br><span>index 30c990d..f8a0f48 100644</span><br><span>--- a/doc/man-sect=
ions/generic-options.rst</span><br><span>+++ b/doc/man-sections/generic-opt=
ions.rst</span><br><span>@@ -302,17 +302,6 @@</span><br><span>   Change pro=
cess priority after initialization (``n`` greater than 0 is</span><br><span=
>   lower priority, ``n`` less than zero is higher priority).</span><br><sp=
an> </span><br><span>---persist-key</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-  Don&#39;t re-read key files across :code:`SIGUSR1` or ``--p=
ing-restart``.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-  This option can be combine=
d with ``--user`` to allow restarts</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-  triggered by the :code:`SIGUSR1` signal. Normally if you dr=
op root</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  privileges i=
n OpenVPN, the daemon cannot be restarted since it will now</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  be unable to re-read protected key =
files.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  This option solves the problem by =
persisting keys across :code:`SIGUSR1`</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  resets, so they don&#39;t need to be re-read.</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> --providers pr=
oviders</span><br><span>   Load the list of (OpenSSL) providers. This is ma=
inly useful for using an</span><br><span>   external provider for key manag=
ement like tpm2-openssl or to load the</span><br><span>@@ -402,7 +391,7 @@<=
/span><br><span> </span><br><span>   Like with chroot, complications can re=
sult when scripts or restarts are</span><br><span>   executed after the set=
con operation, which is why you should really</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  consider using the ``--persist-key`` and ``--pers=
ist-tun`` options.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 consider using the ``--persist-tun`` option.</span><br><span> </span><br><=
span> --status args</span><br><span>   Write operational status to ``file``=
 every ``n`` seconds. ``n`` defaults</span><br><span>diff --git a/doc/man-s=
ections/link-options.rst b/doc/man-sections/link-options.rst</span><br><spa=
n>index ca26bfe..ca192c3 100644</span><br><span>--- a/doc/man-sections/link=
-options.rst</span><br><span>+++ b/doc/man-sections/link-options.rst</span>=
<br><span>@@ -283,7 +283,7 @@</span><br><span>   See the signals section be=
low for more information on :code:`SIGUSR1`.</span><br><span> </span><br><s=
pan>   Note that the behavior of ``SIGUSR1`` can be modified by the</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  ``--persist-tun``, ``--pers=
ist-key``, ``--persist-local-ip`` and</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  ``--persist-tun``, ``--persist-local-ip`` and</span><br=
><span>   ``--persist-remote-ip`` options.</span><br><span> </span><br><spa=
n>   Also note that ``--ping-exit`` and ``--ping-restart`` are mutually</sp=
an><br><span>diff --git a/doc/man-sections/server-options.rst b/doc/man-sec=
tions/server-options.rst</span><br><span>index 98f5340..0632e31 100644</spa=
n><br><span>--- a/doc/man-sections/server-options.rst</span><br><span>+++ b=
/doc/man-sections/server-options.rst</span><br><span>@@ -452,7 +452,7 @@</s=
pan><br><span>   ``--route``, ``--route-gateway``, ``--route-delay``,</span=
><br><span>   ``--redirect-gateway``, ``--ip-win32``, ``--dhcp-option``, ``=
--dns``,</span><br><span>   ``--inactive``, ``--ping``, ``--ping-exit``, ``=
--ping-restart``,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``=
--setenv``, ``--auth-token``, ``--persist-key``, ``--persist-tun``,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--setenv``, ``--auth-to=
ken``, ``--persist-tun``,</span><br><span>   ``--echo``, ``--comp-lzo``, ``=
--socket-flags``, ``--sndbuf``,</span><br><span>   ``--rcvbuf``, ``--sessio=
n-timeout``</span><br><span> </span><br><span>diff --git a/doc/man-sections=
/signals.rst b/doc/man-sections/signals.rst</span><br><span>index 63611b3..=
01e8e5b 100644</span><br><span>--- a/doc/man-sections/signals.rst</span><br=
><span>+++ b/doc/man-sections/signals.rst</span><br><span>@@ -10,9 +10,8 @@=
</span><br><span>     Like :code:`SIGHUP``, except don&#39;t re-read config=
uration file, and</span><br><span>     possibly don&#39;t close and reopen =
TUN/TAP device, re-read key files,</span><br><span>     preserve local IP a=
ddress/port, or preserve most recently authenticated</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    remote IP address/port based on ``--per=
sist-tun``, ``--persist-key``,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    ``--persist-local-ip`` and ``--persist-remote-ip`` options res=
pectively</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    (see abo=
ve).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    remote IP a=
ddress/port based on ``--persist-tun``, ``--persist-local-ip``</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    and ``--persist-remote-ip`` =
options respectively (see above).</span><br><span> </span><br><span>     Th=
is signal may also be internally generated by a timeout condition,</span><b=
r><span>     governed by the ``--ping-restart`` option.</span><br><span>dif=
f --git a/doc/man-sections/unsupported-options.rst b/doc/man-sections/unsup=
ported-options.rst</span><br><span>index a0c1232..11467ca 100644</span><br>=
<span>--- a/doc/man-sections/unsupported-options.rst</span><br><span>+++ b/=
doc/man-sections/unsupported-options.rst</span><br><span>@@ -42,3 +42,6 @@<=
/span><br><span> </span><br><span> --prng</span><br><span>   Removed in Ope=
nVPN 2.6.  We now always use the PRNG of the SSL library.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+--persist-key</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  Ignored since OpenVPN 2.7. Keys are now always persisted acr=
oss restarts.</span><br><span>\ No newline at end of file</span><br><span>d=
iff --git a/sample/sample-config-files/client.conf b/sample/sample-config-f=
iles/client.conf</span><br><span>index 15cb1b3..f51e017 100644</span><br><s=
pan>--- a/sample/sample-config-files/client.conf</span><br><span>+++ b/samp=
le/sample-config-files/client.conf</span><br><span>@@ -62,7 +62,6 @@</span>=
<br><span> ;group openvpn</span><br><span> </span><br><span> # Try to prese=
rve some state across restarts.</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-persist-key</span><br><span> persist-tun</span><br><span> </span>=
<br><span> # If you are connecting through an</span><br><span>diff --git a/=
sample/sample-config-files/server.conf b/sample/sample-config-files/server.=
conf</span><br><span>index d9345b6..009fe56 100644</span><br><span>--- a/sa=
mple/sample-config-files/server.conf</span><br><span>+++ b/sample/sample-co=
nfig-files/server.conf</span><br><span>@@ -274,11 +274,10 @@</span><br><spa=
n> ;user openvpn</span><br><span> ;group openvpn</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-# The persist options will try=
 to avoid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# The pers=
ist option will try to avoid</span><br><span> # accessing certain resources=
 on restart</span><br><span> # that may no longer be accessible because</sp=
an><br><span> # of the privilege downgrade.</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-persist-key</span><br><span> persist-tun</span><br><s=
pan> </span><br><span> # Output a short status file showing</span><br><span=
>diff --git a/sample/sample-windows/sample.ovpn b/sample/sample-windows/sam=
ple.ovpn</span><br><span>index 51e3274..be24faa 100755</span><br><span>--- =
a/sample/sample-windows/sample.ovpn</span><br><span>+++ b/sample/sample-win=
dows/sample.ovpn</span><br><span>@@ -89,7 +89,6 @@</span><br><span> ; ping-=
restart 60</span><br><span> ; ping-timer-rem</span><br><span> ; persist-tun=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-; persist-key</span><=
br><span> ; resolv-retry 86400</span><br><span> </span><br><span> # keep-al=
ive ping</span><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init=
.c</span><br><span>index 52b4308..52b3931 100644</span><br><span>--- a/src/=
openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ =
-3559,14 +3559,6 @@</span><br><span>         {</span><br><span>            =
 msg(M_WARN, &quot;WARNING: you are using user/group/chroot/setcon without =
persist-tun -- this may cause restarts to fail&quot;);</span><br><span>    =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!o-=
&gt;persist_key</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef=
 ENABLE_PKCS11</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     &amp;&amp; !o-&gt;pkcs11_id</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        )</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, =
&quot;WARNING: you are using user/group/chroot/setcon without persist-key -=
- this may cause restarts to fail&quot;);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        }</span><br><span>     }</span><br><span> </spa=
n><br><span>     if (o-&gt;chroot_dir &amp;&amp; !(o-&gt;username &amp;&amp=
; o-&gt;groupname))</span><br><span>@@ -3857,7 +3849,7 @@</span><br><span> =
do_close_free_key_schedule(struct context *c, bool free_ssl_ctx)</span><br>=
<span> {</span><br><span>     /*</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-     * always free the tls_auth/crypt key. If persist_key is tru=
e, the key will</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * always free the tls_auth/crypt key. The key will</span><br><span>      *=
 be reloaded from memory (pre-cached)</span><br><span>      */</span><br><s=
pan>     free_key_ctx(&amp;c-&gt;c1.ks.tls_crypt_v2_server_key);</span><br>=
<span>@@ -3866,7 +3858,7 @@</span><br><span>     buf_clear(&amp;c-&gt;c1.ks=
.tls_crypt_v2_wkc);</span><br><span>     free_buf(&amp;c-&gt;c1.ks.tls_cryp=
t_v2_wkc);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (!(c-&gt;sig-&gt;signal_received =3D=3D SIGUSR1 &amp;&amp; c-=
&gt;options.persist_key))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!(c-&gt;sig-&gt;signal_received =3D=3D SIGUSR1))</span><br><s=
pan>     {</span><br><span>         key_schedule_free(&amp;c-&gt;c1.ks, fre=
e_ssl_ctx);</span><br><span>     }</span><br><span>diff --git a/src/openvpn=
/openvpn.h b/src/openvpn/openvpn.h</span><br><span>index dabc5be..df93b0e 1=
00644</span><br><span>--- a/src/openvpn/openvpn.h</span><br><span>+++ b/src=
/openvpn/openvpn.h</span><br><span>@@ -48,7 +48,7 @@</span><br><span> </spa=
n><br><span> /*</span><br><span>  * Our global key schedules, packaged thus=
ly</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * to facilitate --=
persist-key.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to f=
acilitate key persistence.</span><br><span>  */</span><br><span> </span><br=
><span> struct key_schedule</span><br><span>diff --git a/src/openvpn/option=
s.c b/src/openvpn/options.c</span><br><span>index 2c79a1e..94a88f9 100644</=
span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvp=
n/options.c</span><br><span>@@ -273,7 +273,6 @@</span><br><span>     &quot;=
--persist-tun   : Keep tun/tap device open across SIGUSR1 or --ping-restart=
.\n&quot;</span><br><span>     &quot;--persist-remote-ip : Keep remote IP a=
ddress across SIGUSR1 or --ping-restart.\n&quot;</span><br><span>     &quot=
;--persist-local-ip  : Keep local IP address across SIGUSR1 or --ping-resta=
rt.\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;=
--persist-key   : Don&#39;t re-read key files across SIGUSR1 or --ping-rest=
art.\n&quot;</span><br><span> #if PASSTOS_CAPABILITY</span><br><span>     &=
quot;--passtos       : TOS passthrough (applies to IPv4 only).\n&quot;</spa=
n><br><span> #endif</span><br><span>@@ -1857,7 +1856,6 @@</span><br><span> =
    SHOW_BOOL(persist_tun);</span><br><span>     SHOW_BOOL(persist_local_ip=
);</span><br><span>     SHOW_BOOL(persist_remote_ip);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(persist_key);</span><br><span=
> </span><br><span> #if PASSTOS_CAPABILITY</span><br><span>     SHOW_BOOL(p=
asstos);</span><br><span>@@ -3240,18 +3238,16 @@</span><br><span>         c=
e-&gt;tls_crypt_v2_file_inline =3D o-&gt;tls_crypt_v2_file_inline;</span><b=
r><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    /* Pre-cache tls-auth/crypt(-v2) key file if persist-key was=
 specified and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* Pre-cache tls-auth/crypt(-v2) key file if</span><br><span>      * keys we=
re not already embedded in the config file.</span><br><span>      */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;persist_key)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        connection_entry_preload_key(&a=
mp;ce-&gt;tls_auth_file,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                                     &amp;ce-&gt;tls_auth_file_inline, &=
amp;o-&gt;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 connection_entry_preload_key(&amp;ce-&gt;tls_crypt_file,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                                     &a=
mp;ce-&gt;tls_crypt_file_inline, &amp;o-&gt;gc);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        connection_entry_preload_key(&amp;ce-&gt=
;tls_crypt_v2_file,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                                   &amp;ce-&gt;tls_crypt_v2_file_inline, &a=
mp;o-&gt;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    connection_entry_p=
reload_key(&amp;ce-&gt;tls_auth_file,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                 &amp;ce-&gt;tls_auth_fil=
e_inline, &amp;o-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    connection_entry_preload_key(&amp;ce-&gt;tls_crypt_file,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
     &amp;ce-&gt;tls_crypt_file_inline, &amp;o-&gt;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    connection_entry_preload_key(&amp;c=
e-&gt;tls_crypt_v2_file,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                 &amp;ce-&gt;tls_crypt_v2_file_inline,=
 &amp;o-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> </span><br><span>     if (!proto_is_udp(ce-&gt;proto) &amp;&=
amp; ce-&gt;explicit_exit_notification)</span><br><span>     {</span><br><s=
pan>@@ -6963,7 +6959,8 @@</span><br><span>     else if (streq(p[0], &quot;p=
ersist-key&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>=
         VERIFY_PERMISSION(OPT_P_PERSIST);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        options-&gt;persist_key =3D true;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;DEPREC=
ATED: --persist-key option ignored. &quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            &quot;Keys are now always persisted acro=
ss restarts. &quot;);</span><br><span>     }</span><br><span>     else if (=
streq(p[0], &quot;persist-local-ip&quot;) &amp;&amp; !p[1])</span><br><span=
>     {</span><br><span>diff --git a/src/openvpn/options.h b/src/openvpn/op=
tions.h</span><br><span>index 85de887..2b37d1f 100644</span><br><span>--- a=
/src/openvpn/options.h</span><br><span>+++ b/src/openvpn/options.h</span><b=
r><span>@@ -344,7 +344,6 @@</span><br><span>     bool persist_tun;         =
  /* Don&#39;t close/reopen TUN/TAP dev on SIGUSR1 or PING_RESTART */</span=
><br><span>     bool persist_local_ip;      /* Don&#39;t re-resolve local a=
ddress on SIGUSR1 or PING_RESTART */</span><br><span>     bool persist_remo=
te_ip;     /* Don&#39;t re-resolve remote address on SIGUSR1 or PING_RESTAR=
T */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool persist_=
key;           /* Don&#39;t re-read key files on SIGUSR1 or PING_RESTART */=
</span><br><span> </span><br><span> #if PASSTOS_CAPABILITY</span><br><span>=
     bool passtos;</span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/529?usp=3Demail">change 529</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/529?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I57f1c2ed42bd9dfd43577238749=
a9b7f4c1419ff </div>
<div style=3D"display:none"> Gerrit-Change-Number: 529 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--8Ty6gQJMinI=--

