From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 22 Dec 2025 21:47:41 +0000
In-Reply-To: <gerrit.1765453028000.I72947bd4f0213fd118327f740daeb1d86ae166de@...2715...>
References: <gerrit.1765453028000.I72947bd4f0213fd118327f740daeb1d86ae166de@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <c2cc9debe3d4684b79cffd3b38ddf180cea5209a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rI0MSPyeQ8o="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, MaxF <max@...2606...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--rI0MSPyeQ8o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#8) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1435?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/35/1435/8

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

Gerrit-MessageType: newpatchset
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

--rI0MSPyeQ8o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #8</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1435?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Allow test-crypto to work wi=
thout the --secret argument<br><br>The --test-crypto still requires the --s=
ecret argument. Since --secret<br>will be removed in OpenVPN 2.8 but we wan=
t to keep test-crypt, remove<br>the dependency of test-crypto on --static.<=
br><br>Instead we will just generate a random key for this selftest method.=
<br>This also removes the extra logic that is a leftover from the early<br>=
multi-thread implementation attempt.<br><br>Change-Id: I72947bd4f0213fd1183=
27f740daeb1d86ae166de<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt=
;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Gerrit URL: ht=
tps://gerrit.openvpn.net/c/openvpn/+/1435<br>Message-Id: &lt;20251219135110=
.166468-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn=
-devel@lists.sourceforge.net/msg35157.html<br>Signed-off-by: Gert Doering &=
lt;gert@...1296...&gt;<br>---<br>M Changes.rst<br>M doc/man-sections/generi=
c-options.rst<br>M src/openvpn/crypto.c<br>M src/openvpn/crypto.h<br>M src/=
openvpn/init.c<br>M src/openvpn/init.h<br>M src/openvpn/openvpn.c<br>M src/=
openvpn/options.c<br>M tests/t_lpback.sh<br>9 files changed, 70 insertions(=
+), 39 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvp=
n.net:29418/openvpn refs/changes/35/1435/8</pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;"><span>diff --git a/Changes.rst=
 b/Changes.rst</span><br><span>index 048434d..c8a3058 100644</span><br><spa=
n>--- a/Changes.rst</span><br><span>+++ b/Changes.rst</span><br><span>@@ -3=
43,6 +343,10 @@</span><br><span>   loading for key/cert files with non-ASCI=
I characters in their file names</span><br><span>   (GH: OpenVPN/openvpn#92=
0).</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+- The ``test-crypto`` option no longer requires a ``--secret`` argument a=
nd</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  will automatica=
lly generate a random key.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> Deprecated features</span><br><span> -------------------</span><br><s=
pan> ``--opt-verify`` feature removed</span><br><span>diff --git a/doc/man-=
sections/generic-options.rst b/doc/man-sections/generic-options.rst</span><=
br><span>index a9232ce..ed581b1 100644</span><br><span>--- a/doc/man-sectio=
ns/generic-options.rst</span><br><span>+++ b/doc/man-sections/generic-optio=
ns.rst</span><br><span>@@ -427,13 +427,13 @@</span><br><span>   The typical=
 usage of ``--test-crypto`` would be something like this:</span><br><span> =
  ::</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-     openvpn --test-crypto --secret key</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     openvpn --test-crypto</span><br><span> </span><br=
><span>   or</span><br><span> </span><br><span>   ::</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-     openvpn --test-crypto=
 --secret key --verb 9</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     openvpn --test-crypto --verb 9</span><br><span> </span><br><span>  =
 This option is very useful to test OpenVPN after it has been ported to a</=
span><br><span>   new platform, or to isolate problems in the compiler, Ope=
nSSL crypto</span><br><span>@@ -441,6 +441,10 @@</span><br><span>   problem=
s with encryption and authentication can be debugged</span><br><span>   ind=
ependently of network and tunnel issues.</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  Older versions of OpenVPN used the=
 ``--secret`` argument to specify a</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  static key for this test. Newer version generate a random=
 key for the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  test.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> -=
-tmp-dir dir</span><br><span>   Specify a directory ``dir`` for temporary f=
iles instead of the default</span><br><span>   :code:`TMPDIR` (or &quot;/tm=
p&quot; if unset). Note that it must be writable by the main</span><br><spa=
n>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span><br><span>=
index e43bc6c..ddf3c17 100644</span><br><span>--- a/src/openvpn/crypto.c</s=
pan><br><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -1325,6 +1325,1=
8 @@</span><br><span>     secure_memzero(&amp;key2, sizeof(key2));</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+genera=
te_test_crypto_random_key(const struct key_type *key_type, struct key_ctx_b=
i *ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                    const char *key_name)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct key2 key2;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    key2.n =3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    generate_key_random(&amp;key2.keys[0]);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    generate_key_random(&amp;key2.keys[1]);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_key_ctx_bi(ctx=
, &amp;key2, KEY_DIRECTION_BIDIRECTIONAL, key_type, key_name);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> /* header and footer for static key file */</span><=
br><span> static const char static_key_head[] =3D &quot;-----BEGIN OpenVPN =
Static key V1-----&quot;;</span><br><span> static const char static_key_foo=
t[] =3D &quot;-----END OpenVPN Static key V1-----&quot;;</span><br><span>di=
ff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h</span><br><span>inde=
x 9424fd7..6670deb 100644</span><br><span>--- a/src/openvpn/crypto.h</span>=
<br><span>+++ b/src/openvpn/crypto.h</span><br><span>@@ -632,6 +632,13 @@</=
span><br><span>                              const char *key_file, bool key=
_inline, const int key_direction,</span><br><span>                         =
     const char *key_name, const char *opt_name, struct key2 *keydata);</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Generate a random =
key and initialise ctx to be used the in the crypto random</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * test</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void generate_test_crypto_random_key(const struct key_type *key_=
type, struct key_ctx_bi *ctx,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                     const char *key_name);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</spa=
n><br><span>  * Inline functions</span><br><span>  */</span><br><span>diff =
--git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index ee198=
ce..c0e4418 100644</span><br><span>--- a/src/openvpn/init.c</span><br><span=
>+++ b/src/openvpn/init.c</span><br><span>@@ -2998,6 +2998,34 @@</span><br>=
<span> #endif</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+do_init_crypto_test(struct context *c)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const struct options *options =3D &amp;c-&gt;options;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(options-&gt;test_cryp=
to);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    init_crypto_pre(c, 0);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    c-&gt;c2.crypto_options.flags |=3D CO_PACK=
ET_ID_LONG_FORM;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Initialize pack=
et ID tracking */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  packet_id_init(&amp;c-&gt;c2.crypto_options.packet_id, options-&gt;replay=
_window, options-&gt;replay_time,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                   &quot;STATIC&quot;, 0);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    ASSERT(!key_ctx_bi_defined(&amp;c-&gt;c1.ks.static_ke=
y));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* Init cipher and hash algori=
thm */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_key_=
type(&amp;c-&gt;c1.ks.key_type, options-&gt;ciphername, options-&gt;authnam=
e,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
 options-&gt;test_crypto, true);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ge=
nerate_test_crypto_random_key(&amp;c-&gt;c1.ks.key_type, &amp;c-&gt;c1.ks.s=
tatic_key,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                           &quot;test crypto key&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* Get key schedule */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    c-&gt;c2.crypto_options.key_ctx_bi =3D c-&gt;c=
1.ks.static_key;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*<=
/span><br><span>  * Static Key Mode (using a pre-shared key)</span><br><spa=
n>  */</span><br><span>@@ -5003,17 +5031,18 @@</span><br><span>  * Do a loo=
pback test</span><br><span>  * on the crypto subsystem.</span><br><span>  *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-test_crypto_thread(void *arg=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+do_test_crypto(struct context *c)=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  struct context *c =3D (struct context *)arg;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* print version number */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    msg(M_INFO, &quot;%s&quot;, title=
_string);</span><br><span>     const struct options *options =3D &amp;c-&gt=
;options;</span><br><span> </span><br><span>     ASSERT(options-&gt;test_cr=
ypto);</span><br><span>     init_verb_mute(c, IVM_LEVEL_1);</span><br><span=
>     context_init_1(c);</span><br><span>     next_connection_entry(c);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    do_init_crypto_static=
(c, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    do_init_=
crypto_test(c);</span><br><span> </span><br><span>     frame_finalize_optio=
ns(c, options);</span><br><span> </span><br><span>@@ -5023,25 +5052,4 @@</s=
pan><br><span>     packet_id_free(&amp;c-&gt;c2.crypto_options.packet_id);<=
/span><br><span> </span><br><span>     context_gc_free(c);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    return NULL;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-do_test_crypto(const struc=
t options *o)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;test_crypto)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        struct context c;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        /* print version number */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(M_INFO, &quot;%s&quot;, title_s=
tring);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        context_clear(&amp;c);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        c.options =3D *o;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options_detach=
(&amp;c.options);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    c.first_time =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        test_crypto_thread((void *)&amp;c);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        return true;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    return false;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span>\ No newline at end of file</span><br><span>diff --git a/src/openvpn/=
init.h b/src/openvpn/init.h</span><br><span>index 97318ec..d5c8c04 100644</=
span><br><span>--- a/src/openvpn/init.h</span><br><span>+++ b/src/openvpn/i=
nit.h</span><br><span>@@ -71,7 +71,7 @@</span><br><span> </span><br><span> =
void close_instance(struct context *c);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-bool do_test_crypto(const struct option=
s *o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void do_test_=
crypto(struct context *o);</span><br><span> </span><br><span> void context_=
gc_free(struct context *c);</span><br><span> </span><br><span>diff --git a/=
src/openvpn/openvpn.c b/src/openvpn/openvpn.c</span><br><span>index eaaa59b=
..0c22e27 100644</span><br><span>--- a/src/openvpn/openvpn.c</span><br><spa=
n>+++ b/src/openvpn/openvpn.c</span><br><span>@@ -258,8 +258,9 @@</span><br=
><span>             pre_setup(&amp;c.options);</span><br><span> </span><br>=
<span>             /* test crypto? */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            if (do_test_crypto(&amp;c.options))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            if (c.options.test_=
crypto)</span><br><span>             {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                do_test_crypto(&amp;c);</span><br><span>=
                 break;</span><br><span>             }</span><br><span> </s=
pan><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</s=
pan><br><span>index 34af0d3..22ec7fe 100644</span><br><span>--- a/src/openv=
pn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@=
 -2276,11 +2276,7 @@</span><br><span> </span><br><span>     init_options(&a=
mp;defaults, true);</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (options-&gt;test_crypto)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        notnull(options-&gt;shared_secret_file, &quot;key file (=
--secret)&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!options-&gt;test_crypt=
o)</span><br><span>     {</span><br><span>         notnull(options-&gt;dev,=
 &quot;TUN/TAP device (--dev)&quot;);</span><br><span>     }</span><br><spa=
n>@@ -2694,7 +2690,7 @@</span><br><span>         msg(M_USAGE, &quot;specify=
 only one of --tls-server, --tls-client, or --secret&quot;);</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (!options-&gt;tls_server &amp;&amp; !options-&gt;tls_client)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!options-&gt;t=
ls_server &amp;&amp; !options-&gt;tls_client &amp;&amp; !options-&gt;test_c=
rypto)</span><br><span>     {</span><br><span>         msglvl_t msglevel =
=3D M_USAGE;</span><br><span>         if (options-&gt;allow_deprecated_inse=
cure_static_crypto)</span><br><span>diff --git a/tests/t_lpback.sh b/tests/=
t_lpback.sh</span><br><span>index 8ab3973..6802506 100755</span><br><span>-=
-- a/tests/t_lpback.sh</span><br><span>+++ b/tests/t_lpback.sh</span><br><s=
pan>@@ -89,13 +89,12 @@</span><br><span> # Also test cipher &#39;none&#39;<=
/span><br><span> CIPHERS=3D${CIPHERS}$(printf &quot;\nnone&quot;)</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-&quot;${openv=
pn}&quot; --genkey secret key.$$</span><br><span> set +e</span><br><span> <=
/span><br><span> for cipher in ${CIPHERS}</span><br><span> do</span><br><sp=
an>     test_start &quot;Testing cipher ${cipher}... &quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    ( &quot;${openvpn}&quot; --test-c=
rypto --secret key.$$  --allow-deprecated-insecure-static-crypto --cipher $=
{cipher} ) &gt;log.$$ 2&gt;&amp;1</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    ( &quot;${openvpn}&quot; --test-crypto --cipher ${cipher}=
 ) &gt;log.$$ 2&gt;&amp;1</span><br><span>     test_end $? log.$$</span><br=
><span> done</span><br><span> </span><br><span>@@ -126,6 +125,6 @@</span><b=
r><span>     echo &quot;$0: tests passed: $tests_passed  failed: $tests_fai=
led&quot;</span><br><span> fi</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-rm key.$$ tc-server-key.$$ tc-client-key.$$ log.$=
$</span><br><span style=3D"color: hsl(120, 100%, 40%);">+rm tc-server-key.$=
$ tc-client-key.$$ log.$$</span><br><span> trap 0</span><br><span> exit $e<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1435?usp=3Demail">change 1435</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1435?usp=3Demail"/><meta itemprop=3D"name" content=3D=
"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--rI0MSPyeQ8o=--

