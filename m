From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 22 Dec 2025 21:47:46 +0000
In-Reply-To: <gerrit.1765453028000.I72947bd4f0213fd118327f740daeb1d86ae166de@...2715...>
References: <gerrit.1765453028000.I72947bd4f0213fd118327f740daeb1d86ae166de@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <c2cc9debe3d4684b79cffd3b38ddf180cea5209a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ttKTwiY6+wg="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, MaxF <max@...2606...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ttKTwiY6+wg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
35?usp=3Demail )

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
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1435
Message-Id: <20251219135110.166468-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
157.html
Signed-off-by: Gert Doering <gert@...1296...>
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
9 files changed, 70 insertions(+), 39 deletions(-)




diff --git a/Changes.rst b/Changes.rst
index 048434d..c8a3058 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -343,6 +343,10 @@
   loading for key/cert files with non-ASCII characters in their file names
   (GH: OpenVPN/openvpn#920).

+- The ``test-crypto`` option no longer requires a ``--secret`` argument and
+  will automatically generate a random key.
+
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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I72947bd4f0213fd118327f740daeb1d86ae166de
Gerrit-Change-Number: 1435
Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ttKTwiY6+wg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1435?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Allow test-crypto to work without the --secret a=
rgument<br><br>The --test-crypto still requires the --secret argument. Sinc=
e --secret<br>will be removed in OpenVPN 2.8 but we want to keep test-crypt=
, remove<br>the dependency of test-crypto on --static.<br><br>Instead we wi=
ll just generate a random key for this selftest method.<br>This also remove=
s the extra logic that is a leftover from the early<br>multi-thread impleme=
ntation attempt.<br><br>Change-Id: I72947bd4f0213fd118327f740daeb1d86ae166d=
e<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Frank=
 Lichtenheld &lt;frank@...2641...&gt;<br>Gerrit URL: https://gerrit.openvpn=
.net/c/openvpn/+/1435<br>Message-Id: &lt;20251219135110.166468-1-frank@...1665...=
641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1535...=
orge.net/msg35157.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&g=
t;<br>---<br>M Changes.rst<br>M doc/man-sections/generic-options.rst<br>M s=
rc/openvpn/crypto.c<br>M src/openvpn/crypto.h<br>M src/openvpn/init.c<br>M =
src/openvpn/init.h<br>M src/openvpn/openvpn.c<br>M src/openvpn/options.c<br=
>M tests/t_lpback.sh<br>9 files changed, 70 insertions(+), 39 deletions(-)<=
br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/Changes.rst b/Changes.rst</span><br><span>index 048434d..c8=
a3058 100644</span><br><span>--- a/Changes.rst</span><br><span>+++ b/Change=
s.rst</span><br><span>@@ -343,6 +343,10 @@</span><br><span>   loading for k=
ey/cert files with non-ASCII characters in their file names</span><br><span=
>   (GH: OpenVPN/openvpn#920).</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+- The ``test-crypto`` option no longer require=
s a ``--secret`` argument and</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  will automatically generate a random key.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> Deprecated features</span><br><span> -----=
--------------</span><br><span> ``--opt-verify`` feature removed</span><br>=
<span>diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/=
generic-options.rst</span><br><span>index a9232ce..ed581b1 100644</span><br=
><span>--- a/doc/man-sections/generic-options.rst</span><br><span>+++ b/doc=
/man-sections/generic-options.rst</span><br><span>@@ -427,13 +427,13 @@</sp=
an><br><span>   The typical usage of ``--test-crypto`` would be something l=
ike this:</span><br><span>   ::</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-     openvpn --test-crypto --secret key</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     openvpn --test-crypto<=
/span><br><span> </span><br><span>   or</span><br><span> </span><br><span> =
  ::</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-     openvpn --test-crypto --secret key --verb 9</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     openvpn --test-crypto --verb 9</span><br=
><span> </span><br><span>   This option is very useful to test OpenVPN afte=
r it has been ported to a</span><br><span>   new platform, or to isolate pr=
oblems in the compiler, OpenSSL crypto</span><br><span>@@ -441,6 +441,10 @@=
</span><br><span>   problems with encryption and authentication can be debu=
gged</span><br><span>   independently of network and tunnel issues.</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Older v=
ersions of OpenVPN used the ``--secret`` argument to specify a</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  static key for this test. Newe=
r version generate a random key for the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  test.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> --tmp-dir dir</span><br><span>   Specify a direct=
ory ``dir`` for temporary files instead of the default</span><br><span>   :=
code:`TMPDIR` (or &quot;/tmp&quot; if unset). Note that it must be writable=
 by the main</span><br><span>diff --git a/src/openvpn/crypto.c b/src/openvp=
n/crypto.c</span><br><span>index e43bc6c..ddf3c17 100644</span><br><span>--=
- a/src/openvpn/crypto.c</span><br><span>+++ b/src/openvpn/crypto.c</span><=
br><span>@@ -1325,6 +1325,18 @@</span><br><span>     secure_memzero(&amp;ke=
y2, sizeof(key2));</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+generate_test_crypto_random_key(const struct key_type =
*key_type, struct key_ctx_bi *ctx,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                const char *key_name)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct key2 key2;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    key2.n =3D 2;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    generate_key_random(&amp;key2.keys[0]=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    generate_key_=
random(&amp;key2.keys[1]);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    init_key_ctx_bi(ctx, &amp;key2, KEY_DIRECTION_BIDIRECTIONAL, key=
_type, key_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* header and footer =
for static key file */</span><br><span> static const char static_key_head[]=
 =3D &quot;-----BEGIN OpenVPN Static key V1-----&quot;;</span><br><span> st=
atic const char static_key_foot[] =3D &quot;-----END OpenVPN Static key V1-=
----&quot;;</span><br><span>diff --git a/src/openvpn/crypto.h b/src/openvpn=
/crypto.h</span><br><span>index 9424fd7..6670deb 100644</span><br><span>---=
 a/src/openvpn/crypto.h</span><br><span>+++ b/src/openvpn/crypto.h</span><b=
r><span>@@ -632,6 +632,13 @@</span><br><span>                              =
const char *key_file, bool key_inline, const int key_direction,</span><br><=
span>                              const char *key_name, const char *opt_na=
me, struct key2 *keydata);</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Generate a random key and initialise ctx to be used the in the =
crypto random</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * tes=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void generate_test_crypto_random_k=
ey(const struct key_type *key_type, struct key_ctx_bi *ctx,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                   =
  const char *key_name);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> /*</span><br><span>  * Inline functions</span><br><s=
pan>  */</span><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init=
.c</span><br><span>index ee198ce..c0e4418 100644</span><br><span>--- a/src/=
openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ =
-2998,6 +2998,34 @@</span><br><span> #endif</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+do_init_crypto_test(struct context *c)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const struct options *options =3D &a=
mp;c-&gt;options;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  ASSERT(options-&gt;test_crypto);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
init_crypto_pre(c, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2.cry=
pto_options.flags |=3D CO_PACKET_ID_LONG_FORM;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* Initialize packet ID tracking */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    packet_id_init(&amp;c-&gt;c2.crypto_options=
.packet_id, options-&gt;replay_window, options-&gt;replay_time,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                   &quot;STATIC=
&quot;, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(!key_ctx_bi_defi=
ned(&amp;c-&gt;c1.ks.static_key));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* Init cipher and hash algorithm */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    init_key_type(&amp;c-&gt;c1.ks.key_type, options-&gt;c=
iphername, options-&gt;authname,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                  options-&gt;test_crypto, true);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    generate_test_crypto_random_key(&amp;c-&gt;c1.k=
s.key_type, &amp;c-&gt;c1.ks.static_key,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                    &quot;test crypto =
key&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Get key schedule */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2.crypto_=
options.key_ctx_bi =3D c-&gt;c1.ks.static_key;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> /*</span><br><span>  * Static Key Mode (using a =
pre-shared key)</span><br><span>  */</span><br><span>@@ -5003,17 +5031,18 @=
@</span><br><span>  * Do a loopback test</span><br><span>  * on the crypto =
subsystem.</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-static void *</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-test_crypto_thread(void *arg)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+do_=
test_crypto(struct context *c)</span><br><span> {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    struct context *c =3D (struct context *)arg=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* print versi=
on number */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg=
(M_INFO, &quot;%s&quot;, title_string);</span><br><span>     const struct o=
ptions *options =3D &amp;c-&gt;options;</span><br><span> </span><br><span> =
    ASSERT(options-&gt;test_crypto);</span><br><span>     init_verb_mute(c,=
 IVM_LEVEL_1);</span><br><span>     context_init_1(c);</span><br><span>    =
 next_connection_entry(c);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    do_init_crypto_static(c, 0);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    do_init_crypto_test(c);</span><br><span> </span><br><=
span>     frame_finalize_options(c, options);</span><br><span> </span><br><=
span>@@ -5023,25 +5052,4 @@</span><br><span>     packet_id_free(&amp;c-&gt;=
c2.crypto_options.packet_id);</span><br><span> </span><br><span>     contex=
t_gc_free(c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retu=
rn NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-do_test_crypto(const struct options *o)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (o-&gt;test_crypto)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        s=
truct context c;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* print version n=
umber */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M=
_INFO, &quot;%s&quot;, title_string);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   context_clear(&amp;c);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        c.options =3D *o;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        options_detach(&amp;c.options);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        c.first_time =3D true;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        test_crypto_thread((void *)&amp;=
c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return tru=
e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    return false;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span>\ No newline at end of file</span><br><=
span>diff --git a/src/openvpn/init.h b/src/openvpn/init.h</span><br><span>i=
ndex 97318ec..d5c8c04 100644</span><br><span>--- a/src/openvpn/init.h</span=
><br><span>+++ b/src/openvpn/init.h</span><br><span>@@ -71,7 +71,7 @@</span=
><br><span> </span><br><span> void close_instance(struct context *c);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool do_t=
est_crypto(const struct options *o);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void do_test_crypto(struct context *o);</span><br><span> <=
/span><br><span> void context_gc_free(struct context *c);</span><br><span> =
</span><br><span>diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c=
</span><br><span>index eaaa59b..0c22e27 100644</span><br><span>--- a/src/op=
envpn/openvpn.c</span><br><span>+++ b/src/openvpn/openvpn.c</span><br><span=
>@@ -258,8 +258,9 @@</span><br><span>             pre_setup(&amp;c.options)=
;</span><br><span> </span><br><span>             /* test crypto? */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            if (do_test_crypt=
o(&amp;c.options))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           if (c.options.test_crypto)</span><br><span>             {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                do_test_cr=
ypto(&amp;c);</span><br><span>                 break;</span><br><span>     =
        }</span><br><span> </span><br><span>diff --git a/src/openvpn/option=
s.c b/src/openvpn/options.c</span><br><span>index 34af0d3..22ec7fe 100644</=
span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvp=
n/options.c</span><br><span>@@ -2276,11 +2276,7 @@</span><br><span> </span>=
<br><span>     init_options(&amp;defaults, true);</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;test_cryp=
to)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        notnull(options-&gt;shared=
_secret_file, &quot;key file (--secret)&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (!options-&gt;test_crypto)</span><br><span>     {</span><br><span>   =
      notnull(options-&gt;dev, &quot;TUN/TAP device (--dev)&quot;);</span><=
br><span>     }</span><br><span>@@ -2694,7 +2690,7 @@</span><br><span>     =
    msg(M_USAGE, &quot;specify only one of --tls-server, --tls-client, or -=
-secret&quot;);</span><br><span>     }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (!options-&gt;tls_server &amp;&am=
p; !options-&gt;tls_client)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (!options-&gt;tls_server &amp;&amp; !options-&gt;tls_client =
&amp;&amp; !options-&gt;test_crypto)</span><br><span>     {</span><br><span=
>         msglvl_t msglevel =3D M_USAGE;</span><br><span>         if (optio=
ns-&gt;allow_deprecated_insecure_static_crypto)</span><br><span>diff --git =
a/tests/t_lpback.sh b/tests/t_lpback.sh</span><br><span>index 8ab3973..6802=
506 100755</span><br><span>--- a/tests/t_lpback.sh</span><br><span>+++ b/te=
sts/t_lpback.sh</span><br><span>@@ -89,13 +89,12 @@</span><br><span> # Also=
 test cipher &#39;none&#39;</span><br><span> CIPHERS=3D${CIPHERS}$(printf &=
quot;\nnone&quot;)</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-&quot;${openvpn}&quot; --genkey secret key.$$</span><br><spa=
n> set +e</span><br><span> </span><br><span> for cipher in ${CIPHERS}</span=
><br><span> do</span><br><span>     test_start &quot;Testing cipher ${ciphe=
r}... &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ( &qu=
ot;${openvpn}&quot; --test-crypto --secret key.$$  --allow-deprecated-insec=
ure-static-crypto --cipher ${cipher} ) &gt;log.$$ 2&gt;&amp;1</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    ( &quot;${openvpn}&quot; --te=
st-crypto --cipher ${cipher} ) &gt;log.$$ 2&gt;&amp;1</span><br><span>     =
test_end $? log.$$</span><br><span> done</span><br><span> </span><br><span>=
@@ -126,6 +125,6 @@</span><br><span>     echo &quot;$0: tests passed: $test=
s_passed  failed: $tests_failed&quot;</span><br><span> fi</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-rm key.$$ tc-server-k=
ey.$$ tc-client-key.$$ log.$$</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+rm tc-server-key.$$ tc-client-key.$$ log.$$</span><br><span> trap=
 0</span><br><span> exit $e</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1435?usp=3Demail">chan=
ge 1435</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div =
itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1435?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I72947bd4f0213fd118327f740da=
eb1d86ae166de </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1435 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
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

</body></html>=

--ttKTwiY6+wg=--

