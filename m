From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 22 Sep 2023 12:39:20 +0000
In-Reply-To: <gerrit.1685031225000.I58706019add6d348483ba222dd74e1466ff6c709@...2715...>
References: <gerrit.1685031225000.I58706019add6d348483ba222dd74e1466ff6c709@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277..., a@...2181...
Message-ID: <718b1b331ca608abf79965e16d965374c4c198db-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="49XFE6wM/GA="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove --no-replay
 option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, stipa <lstipakov@...277...>

--49XFE6wM/GA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/28=
1?usp=3Demail )

Change subject: Remove --no-replay option
......................................................................

Remove --no-replay option

Officially deprecated since v2.4.
We have warned about using this forever.
It is time to pull the plug.

Change-Id: I58706019add6d348483ba222dd74e1466ff6c709
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Heiko Hund <heiko@...515...>
Message-Id: <20230922103830.37151-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
059.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/link-options.rst
M doc/man-sections/server-options.rst
M doc/man-sections/unsupported-options.rst
M src/openvpn/crypto.c
M src/openvpn/crypto.h
M src/openvpn/init.c
M src/openvpn/mtu.c
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/ssl.c
M src/openvpn/ssl_common.h
M tests/unit_tests/openvpn/test_crypto.c
12 files changed, 22 insertions(+), 90 deletions(-)




diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-opti=
ons.rst
index 14e76b4..675fee4 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -366,8 +366,7 @@
   order they were received to the TCP/IP protocol stack, provided they
   satisfy several constraints.

-  (a)   The packet cannot be a replay (unless ``--no-replay`` is
-        specified, which disables replay protection altogether).
+  (a)   The packet cannot be a replay.

   (b)   If a packet arrives out of order, it will only be accepted if
         the difference between its sequence number and the highest sequence
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-=
options.rst
index 6b9ad21..80dc77d 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -406,7 +406,7 @@
   Options that will be compared for compatibility include ``dev-type``,
   ``link-mtu``, ``tun-mtu``, ``proto``, ``ifconfig``,
   ``comp-lzo``, ``fragment``, ``keydir``, ``cipher``,
-  ``auth``, ``keysize``, ``secret``, ``no-replay``,
+  ``auth``, ``keysize``, ``secret``,
   ``tls-auth``, ``key-method``, ``tls-server``
   and ``tls-client``.

diff --git a/doc/man-sections/unsupported-options.rst b/doc/man-sections/un=
supported-options.rst
index 5c4e3a0..a0c1232 100644
--- a/doc/man-sections/unsupported-options.rst
+++ b/doc/man-sections/unsupported-options.rst
@@ -30,8 +30,9 @@
   VPN tunnel security.  This has been a NOOP option since OpenVPN 2.4.

 --no-replay
-  Removed in OpenVPN 2.5.  This option should not be used as it weakens the
-  VPN tunnel security.
+  Removed in OpenVPN 2.7.  This option should not be used as it weakens the
+  VPN tunnel security.  Previously we claimed to have removed this in
+  OpenVPN 2.5, but this wasn't actually the case.

 --ns-cert-type
   Removed in OpenVPN 2.5.  The ``nsCertType`` field is no longer supported
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index a77b5a1..e4452d7 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -328,7 +328,7 @@
         if (!(opt->flags & CO_MUTE_REPLAY_WARNINGS))
         {
             msg(D_REPLAY_ERRORS, "%s: bad packet ID (may be a replay): %s =
-- "
-                "see the man page entry for --no-replay and --replay-windo=
w for "
+                "see the man page entry for --replay-window for "
                 "more info or silence this warning with --mute-replay-warn=
ings",
                 error_prefix, packet_id_net_print(pin, true, gc));
         }
@@ -942,18 +942,6 @@
     return true;
 }

-void
-check_replay_consistency(const struct key_type *kt, bool packet_id)
-{
-    ASSERT(kt);
-
-    if (!packet_id && (cipher_kt_mode_ofb_cfb(kt->cipher)
-                       || cipher_kt_mode_aead(kt->cipher)))
-    {
-        msg(M_FATAL, "--no-replay cannot be used with a CFB, OFB or AEAD m=
ode cipher");
-    }
-}
-
 /*
  * Generate a random key.
  */
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 88f8f44..c5fd253 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -40,7 +40,7 @@
  *    HMAC at all.
  *  - \b Ciphertext \b IV. The IV size depends on the \c \-\-cipher option.
  *  - \b Packet \b ID, a 32-bit incrementing packet counter that provides =
replay
- *    protection (if not disabled by \c \-\-no-replay).
+ *    protection.
  *  - \b Timestamp, a 32-bit timestamp of the current time.
  *  - \b Payload, the plain text network packet to be encrypted (unless
  *    encryption is disabled by using \c \-\-cipher \c none). The payload =
might
@@ -304,8 +304,6 @@
  */
 int write_key_file(const int nkeys, const char *filename);

-void check_replay_consistency(const struct key_type *kt, bool packet_id);
-
 bool check_key(struct key *key, const struct key_type *kt);

 bool write_key(const struct key *key, const struct key_type *kt,
@@ -445,7 +443,7 @@
  * this and add it themselves.
  *
  * @param kt            Struct with the crypto algorithm to use
- * @param packet_id_size Size of the packet id, can be 0 if no-replay is u=
sed
+ * @param packet_id_size Size of the packet id
  * @param occ           if true calculates the overhead for crypto in the =
same
  *                      incorrect way as all previous OpenVPN versions did=
, to
  *                      end up with identical numbers for OCC compatibility
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 80c1b2e..019f5a4 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3019,17 +3019,14 @@
     }

     /* Initialize packet ID tracking */
-    if (options->replay)
-    {
-        packet_id_init(&c->c2.crypto_options.packet_id,
-                       options->replay_window,
-                       options->replay_time,
-                       "STATIC", 0);
-        c->c2.crypto_options.pid_persist =3D &c->c1.pid_persist;
-        c->c2.crypto_options.flags |=3D CO_PACKET_ID_LONG_FORM;
-        packet_id_persist_load_obj(&c->c1.pid_persist,
-                                   &c->c2.crypto_options.packet_id);
-    }
+    packet_id_init(&c->c2.crypto_options.packet_id,
+                   options->replay_window,
+                   options->replay_time,
+                   "STATIC", 0);
+    c->c2.crypto_options.pid_persist =3D &c->c1.pid_persist;
+    c->c2.crypto_options.flags |=3D CO_PACKET_ID_LONG_FORM;
+    packet_id_persist_load_obj(&c->c1.pid_persist,
+                               &c->c2.crypto_options.packet_id);

     if (!key_ctx_bi_defined(&c->c1.ks.static_key))
     {
@@ -3051,9 +3048,6 @@

     /* Get key schedule */
     c->c2.crypto_options.key_ctx_bi =3D c->c1.ks.static_key;
-
-    /* Sanity check on sequence number, and cipher mode options */
-    check_replay_consistency(&c->c1.ks.key_type, options->replay);
 }

 /*
@@ -3256,9 +3250,6 @@
         return;
     }

-    /* Sanity check on sequence number, and cipher mode options */
-    check_replay_consistency(&c->c1.ks.key_type, options->replay);
-
     /* In short form, unique datagram identifier is 32 bits, in long form =
64 bits */
     packet_id_long_form =3D cipher_kt_mode_ofb_cfb(c->c1.ks.key_type.ciphe=
r);

@@ -3279,7 +3270,6 @@
     to.ssl_ctx =3D c->c1.ks.ssl_ctx;
     to.key_type =3D c->c1.ks.key_type;
     to.server =3D options->tls_server;
-    to.replay =3D options->replay;
     to.replay_window =3D options->replay_window;
     to.replay_time =3D options->replay_time;
     to.tcp_mode =3D link_socket_proto_connection_oriented(options->ce.prot=
o);
@@ -3645,11 +3635,6 @@
         }
     }

-    if (!o->replay)
-    {
-        msg(M_WARN, "WARNING: You have disabled Replay Protection (--no-re=
play) which may make " PACKAGE_NAME " less secure");
-    }
-
     if (o->tls_server)
     {
         warn_on_use_of_common_subnets(&c->net_ctx);
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 132f93c..56db118 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -52,13 +52,6 @@
 unsigned int
 calc_packet_id_size_dc(const struct options *options, const struct key_typ=
e *kt)
 {
-    /* Unless no-replay is enabled, we have a packet id, no matter if
-     * encryption is used or not */
-    if (!options->replay)
-    {
-        return 0;
-    }
-
     bool tlsmode =3D options->tls_server || options->tls_client;

     bool packet_id_long_form =3D !tlsmode || cipher_kt_mode_ofb_cfb(kt->ci=
pher);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index d168163..ab59a41 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -549,7 +549,6 @@
 #ifndef ENABLE_CRYPTO_MBEDTLS
     "--engine [name] : Enable OpenSSL hardware crypto engine functionality=
.\n"
 #endif
-    "--no-replay     : (DEPRECATED) Disable replay protection.\n"
     "--mute-replay-warnings : Silence the output of replay warnings to log=
 file.\n"
     "--replay-window n [t]  : Use a replay protection sliding window of si=
ze n\n"
     "                         and a time window of t seconds.\n"
@@ -868,7 +867,6 @@
     o->ifconfig_pool_persist_refresh_freq =3D 600;
     o->scheduled_exit_interval =3D 5;
     o->authname =3D "SHA1";
-    o->replay =3D true;
     o->replay_window =3D DEFAULT_SEQ_BACKTRACK;
     o->replay_time =3D DEFAULT_TIME_BACKTRACK;
     o->key_direction =3D KEY_DIRECTION_BIDIRECTIONAL;
@@ -1954,7 +1952,6 @@
 #ifndef ENABLE_CRYPTO_MBEDTLS
     SHOW_BOOL(engine);
 #endif /* ENABLE_CRYPTO_MBEDTLS */
-    SHOW_BOOL(replay);
     SHOW_BOOL(mute_replay_warnings);
     SHOW_INT(replay_window);
     SHOW_INT(replay_time);
@@ -2817,16 +2814,6 @@
     }

     /*
-     * Check consistency of replay options
-     */
-    if (!options->replay
-        && (options->replay_window !=3D defaults.replay_window
-            || options->replay_time !=3D defaults.replay_time))
-    {
-        msg(M_USAGE, "--replay-window doesn't make sense when replay prote=
ction is disabled with --no-replay");
-    }
-
-    /*
      * SSL/TLS mode sanity checks.
      */
     if (options->tls_server + options->tls_client
@@ -4198,7 +4185,6 @@
  * --cipher
  * --auth
  * --secret
- * --no-replay
  *
  * SSL Options:
  *
@@ -4364,10 +4350,6 @@
         {
             buf_printf(&out, ",secret");
         }
-        if (!o->replay)
-        {
-            buf_printf(&out, ",no-replay");
-        }

 #ifdef ENABLE_PREDICTION_RESISTANCE
         if (o->use_prediction_resistance)
@@ -8670,7 +8652,9 @@
     else if (streq(p[0], "no-replay") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->replay =3D false;
+        /* always error out, this breaks the connection */
+        msg(M_FATAL, "--no-replay was removed in OpenVPN 2.7. "
+            "Update your configuration.");
     }
     else if (streq(p[0], "replay-window") && !p[3])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index f5890b9..5810fd1 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -560,7 +560,6 @@
     const char *authname;
     const char *engine;
     struct provider_list providers;
-    bool replay;
     bool mute_replay_warnings;
     int replay_window;
     int replay_time;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index c975dbc..5e6205c 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1007,12 +1007,9 @@
     reliable_set_timeout(ks->send_reliable, session->opt->packet_timeout);

     /* init packet ID tracker */
-    if (session->opt->replay)
-    {
-        packet_id_init(&ks->crypto_options.packet_id,
-                       session->opt->replay_window, session->opt->replay_t=
ime, "SSL",
-                       ks->key_id);
-    }
+    packet_id_init(&ks->crypto_options.packet_id,
+                   session->opt->replay_window, session->opt->replay_time,=
 "SSL",
+                   ks->key_id);

     ks->crypto_options.pid_persist =3D NULL;

diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 27b0294..d3edc5f 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -310,7 +310,6 @@
     const char *remote_options;

     /* from command line */
-    bool replay;
     bool single_session;
     bool disable_occ;
     int mode;
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/open=
vpn/test_crypto.c
index 58eebc0..5564524 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -247,7 +247,6 @@

     /* common defaults */
     o.ce.tun_mtu =3D 1400;
-    o.replay =3D true;
     o.ce.proto =3D PROTO_UDP;

     /* No crypto at all */
@@ -334,15 +333,6 @@
     linkmtu =3D calc_options_string_link_mtu(&o, &f);
     assert_int_equal(linkmtu, 1405);

-    /* tls client, auth none, cipher none, no-replay */
-    o.replay =3D false;
-
-    linkmtu =3D calc_options_string_link_mtu(&o, &f);
-    assert_int_equal(linkmtu, 1401);
-
-
-    o.replay =3D true;
-
     /* tls client, auth SHA1, cipher AES-256-GCM */
     o.authname =3D "SHA1";
     o.ciphername =3D "AES-256-GCM";
@@ -378,7 +368,6 @@
     /* common defaults */
     o.ce.tun_mtu =3D 1400;
     o.ce.mssfix =3D 1000;
-    o.replay =3D true;
     o.ce.proto =3D PROTO_UDP;

     /* No crypto at all */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/281?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I58706019add6d348483ba222dd74e1466ff6c709
Gerrit-Change-Number: 281
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: d12fk <heiko@...515...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--49XFE6wM/GA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/281?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Remove --no-replay option<br><br>Officially de=
precated since v2.4.<br>We have warned about using this forever.<br>It is t=
ime to pull the plug.<br><br>Change-Id: I58706019add6d348483ba222dd74e1466f=
f6c709<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acke=
d-by: Heiko Hund &lt;heiko@...515...&gt;<br>Message-Id: &lt;20230922103830.=
37151-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-d=
evel@lists.sourceforge.net/msg27059.html<br>Signed-off-by: Gert Doering &lt=
;gert@...1296...&gt;<br>---<br>M doc/man-sections/link-options.rst<br>M doc=
/man-sections/server-options.rst<br>M doc/man-sections/unsupported-options.=
rst<br>M src/openvpn/crypto.c<br>M src/openvpn/crypto.h<br>M src/openvpn/in=
it.c<br>M src/openvpn/mtu.c<br>M src/openvpn/options.c<br>M src/openvpn/opt=
ions.h<br>M src/openvpn/ssl.c<br>M src/openvpn/ssl_common.h<br>M tests/unit=
_tests/openvpn/test_crypto.c<br>12 files changed, 22 insertions(+), 90 dele=
tions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-o=
ptions.rst</span><br><span>index 14e76b4..675fee4 100644</span><br><span>--=
- a/doc/man-sections/link-options.rst</span><br><span>+++ b/doc/man-section=
s/link-options.rst</span><br><span>@@ -366,8 +366,7 @@</span><br><span>   o=
rder they were received to the TCP/IP protocol stack, provided they</span><=
br><span>   satisfy several constraints.</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  (a)   The packet cannot be a replay =
(unless ``--no-replay`` is</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        specified, which disables replay protection altogether).</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  (a)   The packet cannot=
 be a replay.</span><br><span> </span><br><span>   (b)   If a packet arrive=
s out of order, it will only be accepted if</span><br><span>         the di=
fference between its sequence number and the highest sequence</span><br><sp=
an>diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/serv=
er-options.rst</span><br><span>index 6b9ad21..80dc77d 100644</span><br><spa=
n>--- a/doc/man-sections/server-options.rst</span><br><span>+++ b/doc/man-s=
ections/server-options.rst</span><br><span>@@ -406,7 +406,7 @@</span><br><s=
pan>   Options that will be compared for compatibility include ``dev-type``=
,</span><br><span>   ``link-mtu``, ``tun-mtu``, ``proto``, ``ifconfig``,</s=
pan><br><span>   ``comp-lzo``, ``fragment``, ``keydir``, ``cipher``,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-  ``auth``, ``keysize``, ``s=
ecret``, ``no-replay``,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  ``auth``, ``keysize``, ``secret``,</span><br><span>   ``tls-auth``, `=
`key-method``, ``tls-server``</span><br><span>   and ``tls-client``.</span>=
<br><span> </span><br><span>diff --git a/doc/man-sections/unsupported-optio=
ns.rst b/doc/man-sections/unsupported-options.rst</span><br><span>index 5c4=
e3a0..a0c1232 100644</span><br><span>--- a/doc/man-sections/unsupported-opt=
ions.rst</span><br><span>+++ b/doc/man-sections/unsupported-options.rst</sp=
an><br><span>@@ -30,8 +30,9 @@</span><br><span>   VPN tunnel security.  Thi=
s has been a NOOP option since OpenVPN 2.4.</span><br><span> </span><br><sp=
an> --no-replay</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Remo=
ved in OpenVPN 2.5.  This option should not be used as it weakens the</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-  VPN tunnel security.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  Removed in OpenVPN 2.7=
.  This option should not be used as it weakens the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  VPN tunnel security.  Previously we cla=
imed to have removed this in</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  OpenVPN 2.5, but this wasn&#39;t actually the case.</span><br><s=
pan> </span><br><span> --ns-cert-type</span><br><span>   Removed in OpenVPN=
 2.5.  The ``nsCertType`` field is no longer supported</span><br><span>diff=
 --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span><br><span>index =
a77b5a1..e4452d7 100644</span><br><span>--- a/src/openvpn/crypto.c</span><b=
r><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -328,7 +328,7 @@</spa=
n><br><span>         if (!(opt-&gt;flags &amp; CO_MUTE_REPLAY_WARNINGS))</s=
pan><br><span>         {</span><br><span>             msg(D_REPLAY_ERRORS, =
&quot;%s: bad packet ID (may be a replay): %s -- &quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                &quot;see the man page en=
try for --no-replay and --replay-window for &quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                &quot;see the man page entry=
 for --replay-window for &quot;</span><br><span>                 &quot;more=
 info or silence this warning with --mute-replay-warnings&quot;,</span><br>=
<span>                 error_prefix, packet_id_net_print(pin, true, gc));</=
span><br><span>         }</span><br><span>@@ -942,18 +942,6 @@</span><br><s=
pan>     return true;</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-check_replay_consistency(const struct key_type *kt, boo=
l packet_id)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(kt);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (!packet_id &amp;&amp; (cipher_kt_mode_ofb_cfb(kt=
-&gt;cipher)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
              || cipher_kt_mode_aead(kt-&gt;cipher)))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        msg(M_FATAL, &quot;--no-replay cannot be used with =
a CFB, OFB or AEAD mode cipher&quot;);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /=
*</span><br><span>  * Generate a random key.</span><br><span>  */</span><br=
><span>diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h</span><br><=
span>index 88f8f44..c5fd253 100644</span><br><span>--- a/src/openvpn/crypto=
.h</span><br><span>+++ b/src/openvpn/crypto.h</span><br><span>@@ -40,7 +40,=
7 @@</span><br><span>  *    HMAC at all.</span><br><span>  *  - \b Cipherte=
xt \b IV. The IV size depends on the \c \-\-cipher option.</span><br><span>=
  *  - \b Packet \b ID, a 32-bit incrementing packet counter that provides =
replay</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    protectio=
n (if not disabled by \c \-\-no-replay).</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *    protection.</span><br><span>  *  - \b Timestamp,=
 a 32-bit timestamp of the current time.</span><br><span>  *  - \b Payload,=
 the plain text network packet to be encrypted (unless</span><br><span>  * =
   encryption is disabled by using \c \-\-cipher \c none). The payload migh=
t</span><br><span>@@ -304,8 +304,6 @@</span><br><span>  */</span><br><span>=
 int write_key_file(const int nkeys, const char *filename);</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void check_replay_c=
onsistency(const struct key_type *kt, bool packet_id);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool check_key(struct ke=
y *key, const struct key_type *kt);</span><br><span> </span><br><span> bool=
 write_key(const struct key *key, const struct key_type *kt,</span><br><spa=
n>@@ -445,7 +443,7 @@</span><br><span>  * this and add it themselves.</span=
><br><span>  *</span><br><span>  * @param kt            Struct with the cry=
pto algorithm to use</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* @param packet_id_size Size of the packet id, can be 0 if no-replay is use=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param packet_i=
d_size Size of the packet id</span><br><span>  * @param occ           if tr=
ue calculates the overhead for crypto in the same</span><br><span>  *      =
                incorrect way as all previous OpenVPN versions did, to</spa=
n><br><span>  *                      end up with identical numbers for OCC =
compatibility</span><br><span>diff --git a/src/openvpn/init.c b/src/openvpn=
/init.c</span><br><span>index 80c1b2e..019f5a4 100644</span><br><span>--- a=
/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><spa=
n>@@ -3019,17 +3019,14 @@</span><br><span>     }</span><br><span> </span><b=
r><span>     /* Initialize packet ID tracking */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (options-&gt;replay)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        packet_id_init(&amp;c-&gt;c2.crypto_options.packet=
_id,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
      options-&gt;replay_window,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                       options-&gt;replay_time,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                       &quot;STATIC&qu=
ot;, 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c-&gt=
;c2.crypto_options.pid_persist =3D &amp;c-&gt;c1.pid_persist;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        c-&gt;c2.crypto_options.fla=
gs |=3D CO_PACKET_ID_LONG_FORM;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        packet_id_persist_load_obj(&amp;c-&gt;c1.pid_persist,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
          &amp;c-&gt;c2.crypto_options.packet_id);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    packet_id_init(&amp;c-&gt;c2.crypto_options.packet_id,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   op=
tions-&gt;replay_window,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                   options-&gt;replay_time,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                   &quot;STATIC&quot;, 0);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2.crypto_opt=
ions.pid_persist =3D &amp;c-&gt;c1.pid_persist;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    c-&gt;c2.crypto_options.flags |=3D CO_PACKE=
T_ID_LONG_FORM;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
packet_id_persist_load_obj(&amp;c-&gt;c1.pid_persist,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                               &amp;c-&gt=
;c2.crypto_options.packet_id);</span><br><span> </span><br><span>     if (!=
key_ctx_bi_defined(&amp;c-&gt;c1.ks.static_key))</span><br><span>     {</sp=
an><br><span>@@ -3051,9 +3048,6 @@</span><br><span> </span><br><span>     /=
* Get key schedule */</span><br><span>     c-&gt;c2.crypto_options.key_ctx_=
bi =3D c-&gt;c1.ks.static_key;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Sanit=
y check on sequence number, and cipher mode options */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    check_replay_consistency(&amp;c-&gt;c1=
.ks.key_type, options-&gt;replay);</span><br><span> }</span><br><span> </sp=
an><br><span> /*</span><br><span>@@ -3256,9 +3250,6 @@</span><br><span>    =
     return;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* Sanity check on sequence number, and=
 cipher mode options */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    check_replay_consistency(&amp;c-&gt;c1.ks.key_type, options-&gt;repla=
y);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
    /* In short form, unique datagram identifier is 32 bits, in long form 6=
4 bits */</span><br><span>     packet_id_long_form =3D cipher_kt_mode_ofb_c=
fb(c-&gt;c1.ks.key_type.cipher);</span><br><span> </span><br><span>@@ -3279=
,7 +3270,6 @@</span><br><span>     to.ssl_ctx =3D c-&gt;c1.ks.ssl_ctx;</spa=
n><br><span>     to.key_type =3D c-&gt;c1.ks.key_type;</span><br><span>    =
 to.server =3D options-&gt;tls_server;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    to.replay =3D options-&gt;replay;</span><br><span>    =
 to.replay_window =3D options-&gt;replay_window;</span><br><span>     to.re=
play_time =3D options-&gt;replay_time;</span><br><span>     to.tcp_mode =3D=
 link_socket_proto_connection_oriented(options-&gt;ce.proto);</span><br><sp=
an>@@ -3645,11 +3635,6 @@</span><br><span>         }</span><br><span>     }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (!o-&gt;replay)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN=
, &quot;WARNING: You have disabled Replay Protection (--no-replay) which ma=
y make &quot; PACKAGE_NAME &quot; less secure&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span>     if (o-&gt;tls_server)</span><br><span=
>     {</span><br><span>         warn_on_use_of_common_subnets(&amp;c-&gt;n=
et_ctx);</span><br><span>diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c=
</span><br><span>index 132f93c..56db118 100644</span><br><span>--- a/src/op=
envpn/mtu.c</span><br><span>+++ b/src/openvpn/mtu.c</span><br><span>@@ -52,=
13 +52,6 @@</span><br><span> unsigned int</span><br><span> calc_packet_id_s=
ize_dc(const struct options *options, const struct key_type *kt)</span><br>=
<span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Unless=
 no-replay is enabled, we have a packet id, no matter if</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-     * encryption is used or not */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!options-&gt;repla=
y)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span>     bool tlsmode =3D options-&gt;tls_=
server || options-&gt;tls_client;</span><br><span> </span><br><span>     bo=
ol packet_id_long_form =3D !tlsmode || cipher_kt_mode_ofb_cfb(kt-&gt;cipher=
);</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options=
.c</span><br><span>index d168163..ab59a41 100644</span><br><span>--- a/src/=
openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><sp=
an>@@ -549,7 +549,6 @@</span><br><span> #ifndef ENABLE_CRYPTO_MBEDTLS</span=
><br><span>     &quot;--engine [name] : Enable OpenSSL hardware crypto engi=
ne functionality.\n&quot;</span><br><span> #endif</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    &quot;--no-replay     : (DEPRECATED) Disabl=
e replay protection.\n&quot;</span><br><span>     &quot;--mute-replay-warni=
ngs : Silence the output of replay warnings to log file.\n&quot;</span><br>=
<span>     &quot;--replay-window n [t]  : Use a replay protection sliding w=
indow of size n\n&quot;</span><br><span>     &quot;                        =
 and a time window of t seconds.\n&quot;</span><br><span>@@ -868,7 +867,6 @=
@</span><br><span>     o-&gt;ifconfig_pool_persist_refresh_freq =3D 600;</s=
pan><br><span>     o-&gt;scheduled_exit_interval =3D 5;</span><br><span>   =
  o-&gt;authname =3D &quot;SHA1&quot;;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    o-&gt;replay =3D true;</span><br><span>     o-&gt;repl=
ay_window =3D DEFAULT_SEQ_BACKTRACK;</span><br><span>     o-&gt;replay_time=
 =3D DEFAULT_TIME_BACKTRACK;</span><br><span>     o-&gt;key_direction =3D K=
EY_DIRECTION_BIDIRECTIONAL;</span><br><span>@@ -1954,7 +1952,6 @@</span><br=
><span> #ifndef ENABLE_CRYPTO_MBEDTLS</span><br><span>     SHOW_BOOL(engine=
);</span><br><span> #endif /* ENABLE_CRYPTO_MBEDTLS */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(replay);</span><br><span>   =
  SHOW_BOOL(mute_replay_warnings);</span><br><span>     SHOW_INT(replay_win=
dow);</span><br><span>     SHOW_INT(replay_time);</span><br><span>@@ -2817,=
16 +2814,6 @@</span><br><span>     }</span><br><span> </span><br><span>    =
 /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * Check consi=
stency of replay options</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!op=
tions-&gt;replay</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   &amp;&amp; (options-&gt;replay_window !=3D defaults.replay_window</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            || options-&gt;r=
eplay_time !=3D defaults.replay_time))</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        msg(M_USAGE, &quot;--replay-window doesn&#39;t make sense when rep=
lay protection is disabled with --no-replay&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /=
*</span><br><span>      * SSL/TLS mode sanity checks.</span><br><span>     =
 */</span><br><span>     if (options-&gt;tls_server + options-&gt;tls_clien=
t</span><br><span>@@ -4198,7 +4185,6 @@</span><br><span>  * --cipher</span>=
<br><span>  * --auth</span><br><span>  * --secret</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * --no-replay</span><br><span>  *</span><br><s=
pan>  * SSL Options:</span><br><span>  *</span><br><span>@@ -4364,10 +4350,=
6 @@</span><br><span>         {</span><br><span>             buf_printf(&am=
p;out, &quot;,secret&quot;);</span><br><span>         }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        if (!o-&gt;replay)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            buf_printf(&amp;out, &quot;,no-repla=
y&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</s=
pan><br><span> </span><br><span> #ifdef ENABLE_PREDICTION_RESISTANCE</span>=
<br><span>         if (o-&gt;use_prediction_resistance)</span><br><span>@@ =
-8670,7 +8652,9 @@</span><br><span>     else if (streq(p[0], &quot;no-repla=
y&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>         =
VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        options-&gt;replay =3D false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        /* always error out, this breaks the =
connection */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  msg(M_FATAL, &quot;--no-replay was removed in OpenVPN 2.7. &quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;Update yo=
ur configuration.&quot;);</span><br><span>     }</span><br><span>     else =
if (streq(p[0], &quot;replay-window&quot;) &amp;&amp; !p[3])</span><br><spa=
n>     {</span><br><span>diff --git a/src/openvpn/options.h b/src/openvpn/o=
ptions.h</span><br><span>index f5890b9..5810fd1 100644</span><br><span>--- =
a/src/openvpn/options.h</span><br><span>+++ b/src/openvpn/options.h</span><=
br><span>@@ -560,7 +560,6 @@</span><br><span>     const char *authname;</sp=
an><br><span>     const char *engine;</span><br><span>     struct provider_=
list providers;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bo=
ol replay;</span><br><span>     bool mute_replay_warnings;</span><br><span>=
     int replay_window;</span><br><span>     int replay_time;</span><br><sp=
an>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index=
 c975dbc..5e6205c 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br>=
<span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -1007,12 +1007,9 @@</span>=
<br><span>     reliable_set_timeout(ks-&gt;send_reliable, session-&gt;opt-&=
gt;packet_timeout);</span><br><span> </span><br><span>     /* init packet I=
D tracker */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (s=
ession-&gt;opt-&gt;replay)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        pac=
ket_id_init(&amp;ks-&gt;crypto_options.packet_id,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                       session-&gt;opt-&gt;repl=
ay_window, session-&gt;opt-&gt;replay_time, &quot;SSL&quot;,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                       ks-&gt;key_id=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    packet_id_init(&amp;ks-&gt;cr=
ypto_options.packet_id,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                   session-&gt;opt-&gt;replay_window, session-&gt;opt-&=
gt;replay_time, &quot;SSL&quot;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                   ks-&gt;key_id);</span><br><span> </span><br=
><span>     ks-&gt;crypto_options.pid_persist =3D NULL;</span><br><span> </=
span><br><span>diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_comm=
on.h</span><br><span>index 27b0294..d3edc5f 100644</span><br><span>--- a/sr=
c/openvpn/ssl_common.h</span><br><span>+++ b/src/openvpn/ssl_common.h</span=
><br><span>@@ -310,7 +310,6 @@</span><br><span>     const char *remote_opti=
ons;</span><br><span> </span><br><span>     /* from command line */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    bool replay;</span><br><s=
pan>     bool single_session;</span><br><span>     bool disable_occ;</span>=
<br><span>     int mode;</span><br><span>diff --git a/tests/unit_tests/open=
vpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c</span><br><span>=
index 58eebc0..5564524 100644</span><br><span>--- a/tests/unit_tests/openvp=
n/test_crypto.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_crypto.=
c</span><br><span>@@ -247,7 +247,6 @@</span><br><span> </span><br><span>   =
  /* common defaults */</span><br><span>     o.ce.tun_mtu =3D 1400;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    o.replay =3D true;</span>=
<br><span>     o.ce.proto =3D PROTO_UDP;</span><br><span> </span><br><span>=
     /* No crypto at all */</span><br><span>@@ -334,15 +333,6 @@</span><br>=
<span>     linkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</span>=
<br><span>     assert_int_equal(linkmtu, 1405);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    /* tls client, auth none, c=
ipher none, no-replay */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    o.replay =3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    linkmtu =3D =
calc_options_string_link_mtu(&amp;o, &amp;f);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    assert_int_equal(linkmtu, 1401);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 o.replay =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span>     /* tls client, auth SHA1, cipher AES-256-GCM */</span><=
br><span>     o.authname =3D &quot;SHA1&quot;;</span><br><span>     o.ciphe=
rname =3D &quot;AES-256-GCM&quot;;</span><br><span>@@ -378,7 +368,6 @@</spa=
n><br><span>     /* common defaults */</span><br><span>     o.ce.tun_mtu =
=3D 1400;</span><br><span>     o.ce.mssfix =3D 1000;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    o.replay =3D true;</span><br><span>    =
 o.ce.proto =3D PROTO_UDP;</span><br><span> </span><br><span>     /* No cry=
pto at all */</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/281?usp=3Demail">change 281</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/281?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I58706019add6d348483ba222dd7=
4e1466ff6c709 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 281 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--49XFE6wM/GA=--

