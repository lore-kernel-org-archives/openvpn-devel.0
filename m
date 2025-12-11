From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 11 Dec 2025 11:38:01 +0000
In-Reply-To: <gerrit.1765453028000.I72947bd4f0213fd118327f740daeb1d86ae166de@...2715...>
References: <gerrit.1765453028000.I72947bd4f0213fd118327f740daeb1d86ae166de@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <071ede272fbdf411101497127228a1229be46767-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EXdDfVc+WEE="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Allow test-crypto to
 work without --secret argument
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--EXdDfVc+WEE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#2). ( http://gerrit.openvpn.net/c/=
openvpn/+/1435?usp=3Demail )


Change subject: Allow test-crypto to work without --secret argument
......................................................................

Allow test-crypto to work without --secret argument

The --test-crypto still requires the --secret argument. Since --secret
will be removed in OpenVPN 2.8 but we want to keep test-crypt, remove
the dependency of test-crypto on --static.

Instead we will just generate a random key for this selftest method.

Change-Id: I72947bd4f0213fd118327f740daeb1d86ae166de
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M Changes.rst
M doc/man-sections/generic-options.rst
M src/openvpn/crypto.c
M src/openvpn/crypto.h
M src/openvpn/init.c
M src/openvpn/options.c
M tests/t_lpback.sh
7 files changed, 75 insertions(+), 14 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/35/1435/2

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
index 882cf28..b6e513d 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -439,13 +439,13 @@
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
@@ -453,6 +453,10 @@
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
index fc079e1..2b7cfc2 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2997,6 +2997,33 @@
 #endif
 }

+
+static void
+do_init_crypto_test(struct context *c, const unsigned int flags)
+{
+    const struct options *options =3D &c->options;
+    ASSERT(options->test_crypto);
+
+    init_crypto_pre(c, flags);
+
+    /* Initialize packet ID tracking */
+    // packet_id_init(&c->c2.crypto_options.packet_id, options->replay_win=
dow, options->replay_time,
+    //                "STATIC", 0);
+    c->c2.crypto_options.flags |=3D CO_PACKET_ID_LONG_FORM;
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
@@ -3004,7 +3031,7 @@
 do_init_crypto_static(struct context *c, const unsigned int flags)
 {
     const struct options *options =3D &c->options;
-    ASSERT(options->shared_secret_file);
+    ASSERT(options->shared_secret_file || options->test_crypto);

     init_crypto_pre(c, flags);

@@ -3027,10 +3054,18 @@
         init_key_type(&c->c1.ks.key_type, options->ciphername, options->au=
thname,
                       options->test_crypto, true);

-        /* Read cipher and hmac keys from shared secret file */
-        crypto_read_openvpn_key(&c->c1.ks.key_type, &c->c1.ks.static_key,
-                                options->shared_secret_file, options->shar=
ed_secret_file_inline,
-                                options->key_direction, "Static Key Encryp=
tion", "secret", NULL);
+        if (!options->shared_secret_file && options->test_crypto)
+        {
+            generate_test_crypto_random_key(&c->c1.ks.key_type, &c->c1.ks.=
static_key,
+                                            "test crypto key");
+        }
+        else
+        {
+            /* Read cipher and hmac keys from shared secret file */
+            crypto_read_openvpn_key(&c->c1.ks.key_type, &c->c1.ks.static_k=
ey,
+                                    options->shared_secret_file, options->=
shared_secret_file_inline,
+                                    options->key_direction, "Static Key En=
cryption", "secret", NULL);
+        }
     }
     else
     {
@@ -3501,6 +3536,10 @@
     {
         do_init_crypto_static(c, flags);
     }
+    else if (c->options.test_crypto)
+    {
+        do_init_crypto_test(c, flags);
+    }
     else if (c->options.tls_server || c->options.tls_client)
     {
         do_init_crypto_tls(c, flags);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2d1f740..b430065 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2283,11 +2283,7 @@
=20
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
@@ -2701,7 +2697,7 @@
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
index 8ab3973..eb6a72f 100755
--- a/tests/t_lpback.sh
+++ b/tests/t_lpback.sh
@@ -95,7 +95,7 @@
 for cipher in ${CIPHERS}
 do
     test_start "Testing cipher ${cipher}... "
-    ( "${openvpn}" --test-crypto --secret key.$$  --allow-deprecated-insec=
ure-static-crypto --cipher ${cipher} ) >log.$$ 2>&1
+    ( "${openvpn}" --test-crypto --cipher ${cipher} ) >log.$$ 2>&1
     test_end $? log.$$
 done


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1435?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I72947bd4f0213fd118327f740daeb1d86ae166de
Gerrit-Change-Number: 1435
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--EXdDfVc+WEE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #2</strong> to this change.</p><p><a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1435?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Allow test-crypto to work without --secret argument<br><br>The --test-c=
rypto still requires the --secret argument. Since --secret<br>will be remov=
ed in OpenVPN 2.8 but we want to keep test-crypt, remove<br>the dependency =
of test-crypto on --static.<br><br>Instead we will just generate a random k=
ey for this selftest method.<br><br>Change-Id: I72947bd4f0213fd118327f740da=
eb1d86ae166de<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---=
<br>M Changes.rst<br>M doc/man-sections/generic-options.rst<br>M src/openvp=
n/crypto.c<br>M src/openvpn/crypto.h<br>M src/openvpn/init.c<br>M src/openv=
pn/options.c<br>M tests/t_lpback.sh<br>7 files changed, 75 insertions(+), 1=
4 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net=
:29418/openvpn refs/changes/35/1435/2</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/Changes.rst b/Ch=
anges.rst</span><br><span>index 32efbe7..1a92b94 100644</span><br><span>---=
 a/Changes.rst</span><br><span>+++ b/Changes.rst</span><br><span>@@ -338,6 =
+338,9 @@</span><br><span>   (force egress =3D ingress interface) can be ac=
hieved with the new</span><br><span>   ``--multihome same-interface`` sub-o=
ption.</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+- The ``test-crypto`` option no longer requires a ``--secret`` argumen=
t and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  will automat=
ically generate a random key.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> Deprecated features</span><br><span> ----------=
---------</span><br><span> ``--opt-verify`` feature removed</span><br><span=
>diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/gener=
ic-options.rst</span><br><span>index 882cf28..b6e513d 100644</span><br><spa=
n>--- a/doc/man-sections/generic-options.rst</span><br><span>+++ b/doc/man-=
sections/generic-options.rst</span><br><span>@@ -439,13 +439,13 @@</span><b=
r><span>   The typical usage of ``--test-crypto`` would be something like t=
his:</span><br><span>   ::</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-     openvpn --test-crypto --secret key</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     openvpn --test-crypto</span=
><br><span> </span><br><span>   or</span><br><span> </span><br><span>   ::<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
 openvpn --test-crypto --secret key --verb 9</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     openvpn --test-crypto --verb 9</span><br><spa=
n> </span><br><span>   This option is very useful to test OpenVPN after it =
has been ported to a</span><br><span>   new platform, or to isolate problem=
s in the compiler, OpenSSL crypto</span><br><span>@@ -453,6 +453,10 @@</spa=
n><br><span>   problems with encryption and authentication can be debugged<=
/span><br><span>   independently of network and tunnel issues.</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Older versio=
ns of OpenVPN used the ``--secret`` argument to specify a</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  static key for this test. Newer ver=
sion generate a random key for the</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  test.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> --tmp-dir dir</span><br><span>   Specify a directory `=
`dir`` for temporary files instead of the default</span><br><span>   :code:=
`TMPDIR` (or &quot;/tmp&quot; if unset). Note that it must be writable by t=
he main</span><br><span>diff --git a/src/openvpn/crypto.c b/src/openvpn/cry=
pto.c</span><br><span>index e43bc6c..ddf3c17 100644</span><br><span>--- a/s=
rc/openvpn/crypto.c</span><br><span>+++ b/src/openvpn/crypto.c</span><br><s=
pan>@@ -1325,6 +1325,18 @@</span><br><span>     secure_memzero(&amp;key2, s=
izeof(key2));</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+generate_test_crypto_random_key(const struct key_type *key_=
type, struct key_ctx_bi *ctx,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                const char *key_name)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct key2 key2;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    key2.n =3D 2;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    generate_key_random(&amp;key2.keys[0]);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    generate_key_random(&=
amp;key2.keys[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   init_key_ctx_bi(ctx, &amp;key2, KEY_DIRECTION_BIDIRECTIONAL, key_type, k=
ey_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> /* header and footer for stat=
ic key file */</span><br><span> static const char static_key_head[] =3D &qu=
ot;-----BEGIN OpenVPN Static key V1-----&quot;;</span><br><span> static con=
st char static_key_foot[] =3D &quot;-----END OpenVPN Static key V1-----&quo=
t;;</span><br><span>diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.=
h</span><br><span>index 9424fd7..6670deb 100644</span><br><span>--- a/src/o=
penvpn/crypto.h</span><br><span>+++ b/src/openvpn/crypto.h</span><br><span>=
@@ -632,6 +632,13 @@</span><br><span>                              const ch=
ar *key_file, bool key_inline, const int key_direction,</span><br><span>   =
                           const char *key_name, const char *opt_name, stru=
ct key2 *keydata);</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Generate a random key and initialise ctx to be used the in the crypto r=
andom</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * test</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void generate_test_crypto_random_key(cons=
t struct key_type *key_type, struct key_ctx_bi *ctx,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                     cons=
t char *key_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> /*</span><br><span>  * Inline functions</span><br><span>  =
*/</span><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</sp=
an><br><span>index fc079e1..2b7cfc2 100644</span><br><span>--- a/src/openvp=
n/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -2997,=
6 +2997,33 @@</span><br><span> #endif</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+do_init_crypto_test(struct context *c, const un=
signed int flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct opt=
ions *options =3D &amp;c-&gt;options;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    ASSERT(options-&gt;test_crypto);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    init_crypto_pre(c, flags);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* Initialize packet ID tracking */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    // packet_id_init(&amp;c-&gt;c2.crypto_opti=
ons.packet_id, options-&gt;replay_window, options-&gt;replay_time,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    //                &quot;=
STATIC&quot;, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  c-&gt;c2.crypto_options.flags |=3D CO_PACKET_ID_LONG_FORM;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ASSERT(!key_ctx_bi_defined(&amp;c-&gt;c1.ks.stati=
c_key));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* Init cipher and hash al=
gorithm */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_=
key_type(&amp;c-&gt;c1.ks.key_type, options-&gt;ciphername, options-&gt;aut=
hname,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
     options-&gt;test_crypto, true);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  generate_test_crypto_random_key(&amp;c-&gt;c1.ks.key_type, &amp;c-&gt;c1.=
ks.static_key,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                               &quot;test crypto key&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* Get key schedule */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    c-&gt;c2.crypto_options.key_ctx_bi =3D c-&=
gt;c1.ks.static_key;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 /*</span><br><span>  * Static Key Mode (using a pre-shared key)</span><br>=
<span>  */</span><br><span>@@ -3004,7 +3031,7 @@</span><br><span> do_init_c=
rypto_static(struct context *c, const unsigned int flags)</span><br><span> =
{</span><br><span>     const struct options *options =3D &amp;c-&gt;options=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(options-&=
gt;shared_secret_file);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    ASSERT(options-&gt;shared_secret_file || options-&gt;test_crypto);<=
/span><br><span> </span><br><span>     init_crypto_pre(c, flags);</span><br=
><span> </span><br><span>@@ -3027,10 +3054,18 @@</span><br><span>         i=
nit_key_type(&amp;c-&gt;c1.ks.key_type, options-&gt;ciphername, options-&gt=
;authname,</span><br><span>                       options-&gt;test_crypto, =
true);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        /* Read cipher and hmac keys from shared secret file */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        crypto_read_openvpn_ke=
y(&amp;c-&gt;c1.ks.key_type, &amp;c-&gt;c1.ks.static_key,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                                options=
-&gt;shared_secret_file, options-&gt;shared_secret_file_inline,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                o=
ptions-&gt;key_direction, &quot;Static Key Encryption&quot;, &quot;secret&q=
uot;, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (!options-&gt;shared_secret_file &amp;&amp; options-&gt;test_crypto)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            generate_test_crypto=
_random_key(&amp;c-&gt;c1.ks.key_type, &amp;c-&gt;c1.ks.static_key,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
                 &quot;test crypto key&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            /* Read cipher and hmac keys from shared secret file */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            crypto_read_ope=
nvpn_key(&amp;c-&gt;c1.ks.key_type, &amp;c-&gt;c1.ks.static_key,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
      options-&gt;shared_secret_file, options-&gt;shared_secret_file_inline=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
                  options-&gt;key_direction, &quot;Static Key Encryption&qu=
ot;, &quot;secret&quot;, NULL);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span>     }</span><br><span>     else</spa=
n><br><span>     {</span><br><span>@@ -3501,6 +3536,10 @@</span><br><span> =
    {</span><br><span>         do_init_crypto_static(c, flags);</span><br><=
span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else=
 if (c-&gt;options.test_crypto)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      do_init_crypto_test(c, flags);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span>     else if (c-&gt;options.tls_serv=
er || c-&gt;options.tls_client)</span><br><span>     {</span><br><span>    =
     do_init_crypto_tls(c, flags);</span><br><span>diff --git a/src/openvpn=
/options.c b/src/openvpn/options.c</span><br><span>index 2d1f740..b430065 1=
00644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src=
/openvpn/options.c</span><br><span>@@ -2283,11 +2283,7 @@</span><br><span> =
</span><br><span>     init_options(&amp;defaults, true);</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;te=
st_crypto)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        notnull(options-&gt=
;shared_secret_file, &quot;key file (--secret)&quot;);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!options-&gt;test_crypto)</span><br><span>     {</span><br><s=
pan>         notnull(options-&gt;dev, &quot;TUN/TAP device (--dev)&quot;);<=
/span><br><span>     }</span><br><span>@@ -2701,7 +2697,7 @@</span><br><spa=
n>         msg(M_USAGE, &quot;specify only one of --tls-server, --tls-clien=
t, or --secret&quot;);</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (!options-&gt;tls_server &=
amp;&amp; !options-&gt;tls_client)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!options-&gt;tls_server &amp;&amp; !options-&gt;tls_=
client &amp;&amp; !options-&gt;test_crypto)</span><br><span>     {</span><b=
r><span>         msglvl_t msglevel =3D M_USAGE;</span><br><span>         if=
 (options-&gt;allow_deprecated_insecure_static_crypto)</span><br><span>diff=
 --git a/tests/t_lpback.sh b/tests/t_lpback.sh</span><br><span>index 8ab397=
3..eb6a72f 100755</span><br><span>--- a/tests/t_lpback.sh</span><br><span>+=
++ b/tests/t_lpback.sh</span><br><span>@@ -95,7 +95,7 @@</span><br><span> f=
or cipher in ${CIPHERS}</span><br><span> do</span><br><span>     test_start=
 &quot;Testing cipher ${cipher}... &quot;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    ( &quot;${openvpn}&quot; --test-crypto --secret key=
.$$  --allow-deprecated-insecure-static-crypto --cipher ${cipher} ) &gt;log=
.$$ 2&gt;&amp;1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
( &quot;${openvpn}&quot; --test-crypto --cipher ${cipher} ) &gt;log.$$ 2&gt=
;&amp;1</span><br><span>     test_end $? log.$$</span><br><span> done</span=
><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1435?usp=3Demail">change 1435</a>. To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemt=
ype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" i=
temtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1435?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I72947bd4f0213fd118327f740da=
eb1d86ae166de </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1435 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--EXdDfVc+WEE=--

