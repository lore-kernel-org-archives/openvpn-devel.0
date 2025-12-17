From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 17 Dec 2025 14:52:44 +0000
In-Reply-To: <gerrit.1765453028000.I72947bd4f0213fd118327f740daeb1d86ae166de@...2715...>
References: <gerrit.1765453028000.I72947bd4f0213fd118327f740daeb1d86ae166de@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., max@...2606..., gert@...1296...
Message-ID: <769d2e7ee0e556a9a54357d27a68b1b0f83c2425-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jduNNzSciCU="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Allow test-crypto to
 work without the --secret argument
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, MaxF <max@...2606...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--jduNNzSciCU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello MaxF, cron2, flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1435?usp=3Demail

to look at the new patch set (#6).


Change subject: Allow test-crypto to work without the --secret argument
......................................................................

Allow test-crypto to work without the --secret argument

The --test-crypto still requires the --secret argument. Since --secret
will be removed in OpenVPN 2.8 but we want to keep test-crypt, remove
the dependency of test-crypto on --static.

Instead we will just generate a random key for this selftest method.
This also removes the extra logic that is a leftover from the early
multi-thread implementation attempt.

Change-Id: I72947bd4f0213fd118327f740daeb1d86ae166de
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M Changes.rst
M doc/man-sections/generic-options.rst
M src/openvpn/crypto.c
M src/openvpn/crypto.h
M src/openvpn/init.c
M src/openvpn/init.h
M src/openvpn/openvpn.c
M src/openvpn/options.c
M tests/t_lpback.sh
9 files changed, 69 insertions(+), 39 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/35/1435/6

diff --git a/Changes.rst b/Changes.rst
index 32efbe7..1a92b94 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -338,6 +338,9 @@
   (force egress =3D ingress interface) can be achieved with the new
   ``--multihome same-interface`` sub-option.

+- The ``test-crypto`` option no longer requires a ``--secret`` argument and
+  will automatically generate a random key.
+
 Deprecated features
 -------------------
 ``--opt-verify`` feature removed
diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generi=
c-options.rst
index a9232ce..ed581b1 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -427,13 +427,13 @@
   The typical usage of ``--test-crypto`` would be something like this:
   ::

-     openvpn --test-crypto --secret key
+     openvpn --test-crypto

   or

   ::

-     openvpn --test-crypto --secret key --verb 9
+     openvpn --test-crypto --verb 9

   This option is very useful to test OpenVPN after it has been ported to a
   new platform, or to isolate problems in the compiler, OpenSSL crypto
@@ -441,6 +441,10 @@
   problems with encryption and authentication can be debugged
   independently of network and tunnel issues.

+  Older versions of OpenVPN used the ``--secret`` argument to specify a
+  static key for this test. Newer version generate a random key for the
+  test.
+
 --tmp-dir dir
   Specify a directory ``dir`` for temporary files instead of the default
   :code:`TMPDIR` (or "/tmp" if unset). Note that it must be writable by th=
e main
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index e43bc6c..ddf3c17 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1325,6 +1325,18 @@
     secure_memzero(&key2, sizeof(key2));
 }

+void
+generate_test_crypto_random_key(const struct key_type *key_type, struct ke=
y_ctx_bi *ctx,
+                                const char *key_name)
+{
+    struct key2 key2;
+    key2.n =3D 2;
+    generate_key_random(&key2.keys[0]);
+    generate_key_random(&key2.keys[1]);
+    init_key_ctx_bi(ctx, &key2, KEY_DIRECTION_BIDIRECTIONAL, key_type, key=
_name);
+}
+
+
 /* header and footer for static key file */
 static const char static_key_head[] =3D "-----BEGIN OpenVPN Static key V1-=
----";
 static const char static_key_foot[] =3D "-----END OpenVPN Static key V1---=
--";
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 9424fd7..6670deb 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -632,6 +632,13 @@
                              const char *key_file, bool key_inline, const =
int key_direction,
                              const char *key_name, const char *opt_name, s=
truct key2 *keydata);

+/**
+ * Generate a random key and initialise ctx to be used the in the crypto r=
andom
+ * test
+ */
+void generate_test_crypto_random_key(const struct key_type *key_type, stru=
ct key_ctx_bi *ctx,
+                                     const char *key_name);
+
 /*
  * Inline functions
  */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index ee198ce..c0e4418 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2998,6 +2998,34 @@
 #endif
 }

+
+static void
+do_init_crypto_test(struct context *c)
+{
+    const struct options *options =3D &c->options;
+    ASSERT(options->test_crypto);
+
+    init_crypto_pre(c, 0);
+
+    c->c2.crypto_options.flags |=3D CO_PACKET_ID_LONG_FORM;
+
+    /* Initialize packet ID tracking */
+    packet_id_init(&c->c2.crypto_options.packet_id, options->replay_window=
, options->replay_time,
+                   "STATIC", 0);
+
+    ASSERT(!key_ctx_bi_defined(&c->c1.ks.static_key));
+
+    /* Init cipher and hash algorithm */
+    init_key_type(&c->c1.ks.key_type, options->ciphername, options->authna=
me,
+                  options->test_crypto, true);
+
+    generate_test_crypto_random_key(&c->c1.ks.key_type, &c->c1.ks.static_k=
ey,
+                                    "test crypto key");
+
+    /* Get key schedule */
+    c->c2.crypto_options.key_ctx_bi =3D c->c1.ks.static_key;
+}
+
 /*
  * Static Key Mode (using a pre-shared key)
  */
@@ -5003,17 +5031,18 @@
  * Do a loopback test
  * on the crypto subsystem.
  */
-static void *
-test_crypto_thread(void *arg)
+void
+do_test_crypto(struct context *c)
 {
-    struct context *c =3D (struct context *)arg;
+    /* print version number */
+    msg(M_INFO, "%s", title_string);
     const struct options *options =3D &c->options;

     ASSERT(options->test_crypto);
     init_verb_mute(c, IVM_LEVEL_1);
     context_init_1(c);
     next_connection_entry(c);
-    do_init_crypto_static(c, 0);
+    do_init_crypto_test(c);

     frame_finalize_options(c, options);

@@ -5023,25 +5052,4 @@
     packet_id_free(&c->c2.crypto_options.packet_id);

     context_gc_free(c);
-    return NULL;
-}
-
-bool
-do_test_crypto(const struct options *o)
-{
-    if (o->test_crypto)
-    {
-        struct context c;
-
-        /* print version number */
-        msg(M_INFO, "%s", title_string);
-
-        context_clear(&c);
-        c.options =3D *o;
-        options_detach(&c.options);
-        c.first_time =3D true;
-        test_crypto_thread((void *)&c);
-        return true;
-    }
-    return false;
-}
+}
\ No newline at end of file
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 97318ec..d5c8c04 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -71,7 +71,7 @@

 void close_instance(struct context *c);

-bool do_test_crypto(const struct options *o);
+void do_test_crypto(struct context *o);

 void context_gc_free(struct context *c);

diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index eaaa59b..0c22e27 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -258,8 +258,9 @@
             pre_setup(&c.options);

             /* test crypto? */
-            if (do_test_crypto(&c.options))
+            if (c.options.test_crypto)
             {
+                do_test_crypto(&c);
                 break;
             }

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 34af0d3..22ec7fe 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2276,11 +2276,7 @@

     init_options(&defaults, true);

-    if (options->test_crypto)
-    {
-        notnull(options->shared_secret_file, "key file (--secret)");
-    }
-    else
+    if (!options->test_crypto)
     {
         notnull(options->dev, "TUN/TAP device (--dev)");
     }
@@ -2694,7 +2690,7 @@
         msg(M_USAGE, "specify only one of --tls-server, --tls-client, or -=
-secret");
     }

-    if (!options->tls_server && !options->tls_client)
+    if (!options->tls_server && !options->tls_client && !options->test_cry=
pto)
     {
         msglvl_t msglevel =3D M_USAGE;
         if (options->allow_deprecated_insecure_static_crypto)
diff --git a/tests/t_lpback.sh b/tests/t_lpback.sh
index 8ab3973..6802506 100755
--- a/tests/t_lpback.sh
+++ b/tests/t_lpback.sh
@@ -89,13 +89,12 @@
 # Also test cipher 'none'
 CIPHERS=3D${CIPHERS}$(printf "\nnone")

-"${openvpn}" --genkey secret key.$$
 set +e

 for cipher in ${CIPHERS}
 do
     test_start "Testing cipher ${cipher}... "
-    ( "${openvpn}" --test-crypto --secret key.$$  --allow-deprecated-insec=
ure-static-crypto --cipher ${cipher} ) >log.$$ 2>&1
+    ( "${openvpn}" --test-crypto --cipher ${cipher} ) >log.$$ 2>&1
     test_end $? log.$$
 done

@@ -126,6 +125,6 @@
     echo "$0: tests passed: $tests_passed  failed: $tests_failed"
 fi

-rm key.$$ tc-server-key.$$ tc-client-key.$$ log.$$
+rm tc-server-key.$$ tc-client-key.$$ log.$$
 trap 0
 exit $e

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1435?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I72947bd4f0213fd118327f740daeb1d86ae166de
Gerrit-Change-Number: 1435
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--jduNNzSciCU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #6</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1435?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">Allow test-crypto to work without the --secret argu=
ment<br><br>The --test-crypto still requires the --secret argument. Since -=
-secret<br>will be removed in OpenVPN 2.8 but we want to keep test-crypt, r=
emove<br>the dependency of test-crypto on --static.<br><br>Instead we will =
just generate a random key for this selftest method.<br>This also removes t=
he extra logic that is a leftover from the early<br>multi-thread implementa=
tion attempt.<br><br>Change-Id: I72947bd4f0213fd118327f740daeb1d86ae166de<b=
r>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M Changes.r=
st<br>M doc/man-sections/generic-options.rst<br>M src/openvpn/crypto.c<br>M=
 src/openvpn/crypto.h<br>M src/openvpn/init.c<br>M src/openvpn/init.h<br>M =
src/openvpn/openvpn.c<br>M src/openvpn/options.c<br>M tests/t_lpback.sh<br>=
9 files changed, 69 insertions(+), 39 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/35/1435/6<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/Changes.rst b/Changes.rst</span><br><span>index 32efbe=
7..1a92b94 100644</span><br><span>--- a/Changes.rst</span><br><span>+++ b/C=
hanges.rst</span><br><span>@@ -338,6 +338,9 @@</span><br><span>   (force eg=
ress =3D ingress interface) can be achieved with the new</span><br><span>  =
 ``--multihome same-interface`` sub-option.</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+- The ``test-crypto`` option no l=
onger requires a ``--secret`` argument and</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  will automatically generate a random key.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> Deprecated=
 features</span><br><span> -------------------</span><br><span> ``--opt-ver=
ify`` feature removed</span><br><span>diff --git a/doc/man-sections/generic=
-options.rst b/doc/man-sections/generic-options.rst</span><br><span>index a=
9232ce..ed581b1 100644</span><br><span>--- a/doc/man-sections/generic-optio=
ns.rst</span><br><span>+++ b/doc/man-sections/generic-options.rst</span><br=
><span>@@ -427,13 +427,13 @@</span><br><span>   The typical usage of ``--te=
st-crypto`` would be something like this:</span><br><span>   ::</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-     openvpn --=
test-crypto --secret key</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     openvpn --test-crypto</span><br><span> </span><br><span>   or</sp=
an><br><span> </span><br><span>   ::</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-     openvpn --test-crypto --secret key --=
verb 9</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     openvpn =
--test-crypto --verb 9</span><br><span> </span><br><span>   This option is =
very useful to test OpenVPN after it has been ported to a</span><br><span> =
  new platform, or to isolate problems in the compiler, OpenSSL crypto</spa=
n><br><span>@@ -441,6 +441,10 @@</span><br><span>   problems with encryptio=
n and authentication can be debugged</span><br><span>   independently of ne=
twork and tunnel issues.</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  Older versions of OpenVPN used the ``--secret`` ar=
gument to specify a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  static key for this test. Newer version generate a random key for the</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  test.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --tmp-dir dir</sp=
an><br><span>   Specify a directory ``dir`` for temporary files instead of =
the default</span><br><span>   :code:`TMPDIR` (or &quot;/tmp&quot; if unset=
). Note that it must be writable by the main</span><br><span>diff --git a/s=
rc/openvpn/crypto.c b/src/openvpn/crypto.c</span><br><span>index e43bc6c..d=
df3c17 100644</span><br><span>--- a/src/openvpn/crypto.c</span><br><span>++=
+ b/src/openvpn/crypto.c</span><br><span>@@ -1325,6 +1325,18 @@</span><br><=
span>     secure_memzero(&amp;key2, sizeof(key2));</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+generate_test_crypto_r=
andom_key(const struct key_type *key_type, struct key_ctx_bi *ctx,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
    const char *key_name)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct k=
ey2 key2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    key2.n=
 =3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    generate=
_key_random(&amp;key2.keys[0]);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    generate_key_random(&amp;key2.keys[1]);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    init_key_ctx_bi(ctx, &amp;key2, KEY=
_DIRECTION_BIDIRECTIONAL, key_type, key_name);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> /* header and footer for static key file */</span><br><span> static=
 const char static_key_head[] =3D &quot;-----BEGIN OpenVPN Static key V1---=
--&quot;;</span><br><span> static const char static_key_foot[] =3D &quot;--=
---END OpenVPN Static key V1-----&quot;;</span><br><span>diff --git a/src/o=
penvpn/crypto.h b/src/openvpn/crypto.h</span><br><span>index 9424fd7..6670d=
eb 100644</span><br><span>--- a/src/openvpn/crypto.h</span><br><span>+++ b/=
src/openvpn/crypto.h</span><br><span>@@ -632,6 +632,13 @@</span><br><span> =
                             const char *key_file, bool key_inline, const i=
nt key_direction,</span><br><span>                              const char =
*key_name, const char *opt_name, struct key2 *keydata);</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * Generate a random key and initiali=
se ctx to be used the in the crypto random</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * test</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void =
generate_test_crypto_random_key(const struct key_type *key_type, struct key=
_ctx_bi *ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                               const char *key_name);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * =
Inline functions</span><br><span>  */</span><br><span>diff --git a/src/open=
vpn/init.c b/src/openvpn/init.c</span><br><span>index ee198ce..c0e4418 1006=
44</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openv=
pn/init.c</span><br><span>@@ -2998,6 +2998,34 @@</span><br><span> #endif</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+do_init_cryp=
to_test(struct context *c)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const s=
truct options *options =3D &amp;c-&gt;options;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    ASSERT(options-&gt;test_crypto);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    init_crypto_pre(c, 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    c-&gt;c2.crypto_options.flags |=3D CO_PACKET_ID_LONG_FOR=
M;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* Initialize packet ID tracking=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_in=
it(&amp;c-&gt;c2.crypto_options.packet_id, options-&gt;replay_window, optio=
ns-&gt;replay_time,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                   &quot;STATIC&quot;, 0);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    ASSERT(!key_ctx_bi_defined(&amp;c-&gt;c1.ks.static_key));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* Init cipher and hash algorithm */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    init_key_type(&amp;c-&g=
t;c1.ks.key_type, options-&gt;ciphername, options-&gt;authname,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                  options-&gt;t=
est_crypto, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    generate_test_cr=
ypto_random_key(&amp;c-&gt;c1.ks.key_type, &amp;c-&gt;c1.ks.static_key,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
             &quot;test crypto key&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* Get key schedule */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    c-&gt;c2.crypto_options.key_ctx_bi =3D c-&gt;c1.ks.static_ke=
y;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><spa=
n>  * Static Key Mode (using a pre-shared key)</span><br><span>  */</span><=
br><span>@@ -5003,17 +5031,18 @@</span><br><span>  * Do a loopback test</sp=
an><br><span>  * on the crypto subsystem.</span><br><span>  */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-static void *</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-test_crypto_thread(void *arg)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+do_test_crypto(struct context *c)</span><br><sp=
an> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct conte=
xt *c =3D (struct context *)arg;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /* print version number */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    msg(M_INFO, &quot;%s&quot;, title_string);</spa=
n><br><span>     const struct options *options =3D &amp;c-&gt;options;</spa=
n><br><span> </span><br><span>     ASSERT(options-&gt;test_crypto);</span><=
br><span>     init_verb_mute(c, IVM_LEVEL_1);</span><br><span>     context_=
init_1(c);</span><br><span>     next_connection_entry(c);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    do_init_crypto_static(c, 0);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    do_init_crypto_test(c)=
;</span><br><span> </span><br><span>     frame_finalize_options(c, options)=
;</span><br><span> </span><br><span>@@ -5023,25 +5052,4 @@</span><br><span>=
     packet_id_free(&amp;c-&gt;c2.crypto_options.packet_id);</span><br><spa=
n> </span><br><span>     context_gc_free(c);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    return NULL;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-do_test_crypto(const struct options *o)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;test_crypto)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        struct context c;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        /* print version number */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        msg(M_INFO, &quot;%s&quot;, title_string);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        context_clear(&amp;c);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        c.options =3D *o;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        options_detach(&amp;c.option=
s);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c.first_ti=
me =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        t=
est_crypto_thread((void *)&amp;c);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        return true;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>\ No new=
line at end of file</span><br><span>diff --git a/src/openvpn/init.h b/src/o=
penvpn/init.h</span><br><span>index 97318ec..d5c8c04 100644</span><br><span=
>--- a/src/openvpn/init.h</span><br><span>+++ b/src/openvpn/init.h</span><b=
r><span>@@ -71,7 +71,7 @@</span><br><span> </span><br><span> void close_ins=
tance(struct context *c);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-bool do_test_crypto(const struct options *o);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void do_test_crypto(struct =
context *o);</span><br><span> </span><br><span> void context_gc_free(struct=
 context *c);</span><br><span> </span><br><span>diff --git a/src/openvpn/op=
envpn.c b/src/openvpn/openvpn.c</span><br><span>index eaaa59b..0c22e27 1006=
44</span><br><span>--- a/src/openvpn/openvpn.c</span><br><span>+++ b/src/op=
envpn/openvpn.c</span><br><span>@@ -258,8 +258,9 @@</span><br><span>       =
      pre_setup(&amp;c.options);</span><br><span> </span><br><span>        =
     /* test crypto? */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            if (do_test_crypto(&amp;c.options))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (c.options.test_crypto)</span>=
<br><span>             {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                do_test_crypto(&amp;c);</span><br><span>              =
   break;</span><br><span>             }</span><br><span> </span><br><span>=
diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>=
index 34af0d3..22ec7fe 100644</span><br><span>--- a/src/openvpn/options.c</=
span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -2276,11 +227=
6,7 @@</span><br><span> </span><br><span>     init_options(&amp;defaults, t=
rue);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (options-&gt;test_crypto)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     notnull(options-&gt;shared_secret_file, &quot;key file (--secret)&quot=
;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (!options-&gt;test_crypto)</span><br><=
span>     {</span><br><span>         notnull(options-&gt;dev, &quot;TUN/TAP=
 device (--dev)&quot;);</span><br><span>     }</span><br><span>@@ -2694,7 +=
2690,7 @@</span><br><span>         msg(M_USAGE, &quot;specify only one of -=
-tls-server, --tls-client, or --secret&quot;);</span><br><span>     }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!=
options-&gt;tls_server &amp;&amp; !options-&gt;tls_client)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!options-&gt;tls_server &amp=
;&amp; !options-&gt;tls_client &amp;&amp; !options-&gt;test_crypto)</span><=
br><span>     {</span><br><span>         msglvl_t msglevel =3D M_USAGE;</sp=
an><br><span>         if (options-&gt;allow_deprecated_insecure_static_cryp=
to)</span><br><span>diff --git a/tests/t_lpback.sh b/tests/t_lpback.sh</spa=
n><br><span>index 8ab3973..6802506 100755</span><br><span>--- a/tests/t_lpb=
ack.sh</span><br><span>+++ b/tests/t_lpback.sh</span><br><span>@@ -89,13 +8=
9,12 @@</span><br><span> # Also test cipher &#39;none&#39;</span><br><span>=
 CIPHERS=3D${CIPHERS}$(printf &quot;\nnone&quot;)</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-&quot;${openvpn}&quot; --genk=
ey secret key.$$</span><br><span> set +e</span><br><span> </span><br><span>=
 for cipher in ${CIPHERS}</span><br><span> do</span><br><span>     test_sta=
rt &quot;Testing cipher ${cipher}... &quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    ( &quot;${openvpn}&quot; --test-crypto --secret k=
ey.$$  --allow-deprecated-insecure-static-crypto --cipher ${cipher} ) &gt;l=
og.$$ 2&gt;&amp;1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  ( &quot;${openvpn}&quot; --test-crypto --cipher ${cipher} ) &gt;log.$$ 2&=
gt;&amp;1</span><br><span>     test_end $? log.$$</span><br><span> done</sp=
an><br><span> </span><br><span>@@ -126,6 +125,6 @@</span><br><span>     ech=
o &quot;$0: tests passed: $tests_passed  failed: $tests_failed&quot;</span>=
<br><span> fi</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-rm key.$$ tc-server-key.$$ tc-client-key.$$ log.$$</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+rm tc-server-key.$$ tc-client-key.=
$$ log.$$</span><br><span> trap 0</span><br><span> exit $e</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1435?usp=3Demail">change 1435</a>. To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1435?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I72947bd4f0213fd118327f740da=
eb1d86ae166de </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1435 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--jduNNzSciCU=--

