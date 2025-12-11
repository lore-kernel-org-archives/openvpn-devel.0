From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 11 Dec 2025 14:42:08 +0000
In-Reply-To: <gerrit.1765453028000.I72947bd4f0213fd118327f740daeb1d86ae166de@...2715...>
References: <gerrit.1765453028000.I72947bd4f0213fd118327f740daeb1d86ae166de@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <429ca409b3fa0dc789aba309f548948d41763cd4-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="H2PyFvecTN8="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--H2PyFvecTN8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld.

Hello cron2, flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1435?usp=3Demail

to look at the new patch set (#5).


Change subject: Allow test-crypto to work without the --secret argument
......................................................................

Allow test-crypto to work without the --secret argument

The --test-crypto still requires the --secret argument. Since --secret
will be removed in OpenVPN 2.8 but we want to keep test-crypt, remove
the dependency of test-crypto on --static.

Instead we will just generate a random key for this selftest method.

Also remove the call to do_init_crypto_static in test_crypto_thread. We
already call do_init_crypto beforehand.

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
7 files changed, 60 insertions(+), 12 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/35/1435/5

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
index fc079e1..5197c54 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2997,6 +2997,30 @@
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
@@ -3501,6 +3525,10 @@
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
@@ -5045,7 +5073,6 @@
     init_verb_mute(c, IVM_LEVEL_1);
     context_init_1(c);
     next_connection_entry(c);
-    do_init_crypto_static(c, 0);

     frame_finalize_options(c, options);

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2d1f740..b430065 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2283,11 +2283,7 @@

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
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--H2PyFvecTN8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #5</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1435?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">Allow test-crypto to work without the --secret argu=
ment<br><br>The --test-crypto still requires the --secret argument. Since -=
-secret<br>will be removed in OpenVPN 2.8 but we want to keep test-crypt, r=
emove<br>the dependency of test-crypto on --static.<br><br>Instead we will =
just generate a random key for this selftest method.<br><br>Also remove the=
 call to do_init_crypto_static in test_crypto_thread. We<br>already call do=
_init_crypto beforehand.<br><br>Change-Id: I72947bd4f0213fd118327f740daeb1d=
86ae166de<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>=
M Changes.rst<br>M doc/man-sections/generic-options.rst<br>M src/openvpn/cr=
ypto.c<br>M src/openvpn/crypto.h<br>M src/openvpn/init.c<br>M src/openvpn/o=
ptions.c<br>M tests/t_lpback.sh<br>7 files changed, 60 insertions(+), 12 de=
letions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:294=
18/openvpn refs/changes/35/1435/5</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/Changes.rst b/Change=
s.rst</span><br><span>index 32efbe7..1a92b94 100644</span><br><span>--- a/C=
hanges.rst</span><br><span>+++ b/Changes.rst</span><br><span>@@ -338,6 +338=
,9 @@</span><br><span>   (force egress =3D ingress interface) can be achiev=
ed with the new</span><br><span>   ``--multihome same-interface`` sub-optio=
n.</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+- The ``test-crypto`` option no longer requires a ``--secret`` argument an=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  will automatical=
ly generate a random key.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> Deprecated features</span><br><span> --------------=
-----</span><br><span> ``--opt-verify`` feature removed</span><br><span>dif=
f --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-o=
ptions.rst</span><br><span>index 882cf28..b6e513d 100644</span><br><span>--=
- a/doc/man-sections/generic-options.rst</span><br><span>+++ b/doc/man-sect=
ions/generic-options.rst</span><br><span>@@ -439,13 +439,13 @@</span><br><s=
pan>   The typical usage of ``--test-crypto`` would be something like this:=
</span><br><span>   ::</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-     openvpn --test-crypto --secret key</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     openvpn --test-crypto</span><br=
><span> </span><br><span>   or</span><br><span> </span><br><span>   ::</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-     ope=
nvpn --test-crypto --secret key --verb 9</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     openvpn --test-crypto --verb 9</span><br><span> <=
/span><br><span>   This option is very useful to test OpenVPN after it has =
been ported to a</span><br><span>   new platform, or to isolate problems in=
 the compiler, OpenSSL crypto</span><br><span>@@ -453,6 +453,10 @@</span><b=
r><span>   problems with encryption and authentication can be debugged</spa=
n><br><span>   independently of network and tunnel issues.</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Older versions o=
f OpenVPN used the ``--secret`` argument to specify a</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  static key for this test. Newer version=
 generate a random key for the</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  test.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> --tmp-dir dir</span><br><span>   Specify a directory ``dir=
`` for temporary files instead of the default</span><br><span>   :code:`TMP=
DIR` (or &quot;/tmp&quot; if unset). Note that it must be writable by the m=
ain</span><br><span>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.=
c</span><br><span>index e43bc6c..ddf3c17 100644</span><br><span>--- a/src/o=
penvpn/crypto.c</span><br><span>+++ b/src/openvpn/crypto.c</span><br><span>=
@@ -1325,6 +1325,18 @@</span><br><span>     secure_memzero(&amp;key2, sizeo=
f(key2));</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+generate_test_crypto_random_key(const struct key_type *key_type=
, struct key_ctx_bi *ctx,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                const char *key_name)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct key2 key2;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    key2.n =3D 2;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    generate_key_random(&amp;key2.keys[0]);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    generate_key_random(&amp;=
key2.keys[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
nit_key_ctx_bi(ctx, &amp;key2, KEY_DIRECTION_BIDIRECTIONAL, key_type, key_n=
ame);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> /* header and footer for static k=
ey file */</span><br><span> static const char static_key_head[] =3D &quot;-=
----BEGIN OpenVPN Static key V1-----&quot;;</span><br><span> static const c=
har static_key_foot[] =3D &quot;-----END OpenVPN Static key V1-----&quot;;<=
/span><br><span>diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h</s=
pan><br><span>index 9424fd7..6670deb 100644</span><br><span>--- a/src/openv=
pn/crypto.h</span><br><span>+++ b/src/openvpn/crypto.h</span><br><span>@@ -=
632,6 +632,13 @@</span><br><span>                              const char *=
key_file, bool key_inline, const int key_direction,</span><br><span>       =
                       const char *key_name, const char *opt_name, struct k=
ey2 *keydata);</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
Generate a random key and initialise ctx to be used the in the crypto rando=
m</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * test</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void generate_test_crypto_random_key(const str=
uct key_type *key_type, struct key_ctx_bi *ctx,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                     const char=
 *key_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> /*</span><br><span>  * Inline functions</span><br><span>  */</sp=
an><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br=
><span>index fc079e1..5197c54 100644</span><br><span>--- a/src/openvpn/init=
.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -2997,6 +299=
7,30 @@</span><br><span> #endif</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+do_init_crypto_test(struct context *c, const unsigned=
 int flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct options *=
options =3D &amp;c-&gt;options;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    ASSERT(options-&gt;test_crypto);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    init_crypto_pre(c, flags);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    c-&gt;c2.crypto_options.flags |=3D CO_PACKET_ID_LONG_FORM;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ASSERT(!key_ctx_bi_defined(&amp;c-&gt;c1.ks.s=
tatic_key));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Init cipher and has=
h algorithm */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
nit_key_type(&amp;c-&gt;c1.ks.key_type, options-&gt;ciphername, options-&gt=
;authname,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
         options-&gt;test_crypto, true);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    generate_test_crypto_random_key(&amp;c-&gt;c1.ks.key_type, &amp;c-&gt=
;c1.ks.static_key,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                   &quot;test crypto key&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* Get key schedule */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2.crypto_options.key_ctx_bi =
=3D c-&gt;c1.ks.static_key;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> /*</span><br><span>  * Static Key Mode (using a pre-shared key)</sp=
an><br><span>  */</span><br><span>@@ -3501,6 +3525,10 @@</span><br><span>  =
   {</span><br><span>         do_init_crypto_static(c, flags);</span><br><s=
pan>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else =
if (c-&gt;options.test_crypto)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     do_init_crypto_test(c, flags);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span>     else if (c-&gt;options.tls_serve=
r || c-&gt;options.tls_client)</span><br><span>     {</span><br><span>     =
    do_init_crypto_tls(c, flags);</span><br><span>@@ -5045,7 +5073,6 @@</sp=
an><br><span>     init_verb_mute(c, IVM_LEVEL_1);</span><br><span>     cont=
ext_init_1(c);</span><br><span>     next_connection_entry(c);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    do_init_crypto_static(c, 0);</s=
pan><br><span> </span><br><span>     frame_finalize_options(c, options);</s=
pan><br><span> </span><br><span>diff --git a/src/openvpn/options.c b/src/op=
envpn/options.c</span><br><span>index 2d1f740..b430065 100644</span><br><sp=
an>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c<=
/span><br><span>@@ -2283,11 +2283,7 @@</span><br><span> </span><br><span>  =
   init_options(&amp;defaults, true);</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;test_crypto)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        notnull(options-&gt;shared_secret_file=
, &quot;key file (--secret)&quot;);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!opti=
ons-&gt;test_crypto)</span><br><span>     {</span><br><span>         notnul=
l(options-&gt;dev, &quot;TUN/TAP device (--dev)&quot;);</span><br><span>   =
  }</span><br><span>@@ -2701,7 +2697,7 @@</span><br><span>         msg(M_US=
AGE, &quot;specify only one of --tls-server, --tls-client, or --secret&quot=
;);</span><br><span>     }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (!options-&gt;tls_server &amp;&amp; !options-=
&gt;tls_client)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (!options-&gt;tls_server &amp;&amp; !options-&gt;tls_client &amp;&amp; !=
options-&gt;test_crypto)</span><br><span>     {</span><br><span>         ms=
glvl_t msglevel =3D M_USAGE;</span><br><span>         if (options-&gt;allow=
_deprecated_insecure_static_crypto)</span><br><span>diff --git a/tests/t_lp=
back.sh b/tests/t_lpback.sh</span><br><span>index 8ab3973..6802506 100755</=
span><br><span>--- a/tests/t_lpback.sh</span><br><span>+++ b/tests/t_lpback=
.sh</span><br><span>@@ -89,13 +89,12 @@</span><br><span> # Also test cipher=
 &#39;none&#39;</span><br><span> CIPHERS=3D${CIPHERS}$(printf &quot;\nnone&=
quot;)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-&quot;${openvpn}&quot; --genkey secret key.$$</span><br><span> set +e</s=
pan><br><span> </span><br><span> for cipher in ${CIPHERS}</span><br><span> =
do</span><br><span>     test_start &quot;Testing cipher ${cipher}... &quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ( &quot;${openvpn=
}&quot; --test-crypto --secret key.$$  --allow-deprecated-insecure-static-c=
rypto --cipher ${cipher} ) &gt;log.$$ 2&gt;&amp;1</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    ( &quot;${openvpn}&quot; --test-crypto --=
cipher ${cipher} ) &gt;log.$$ 2&gt;&amp;1</span><br><span>     test_end $? =
log.$$</span><br><span> done</span><br><span> </span><br><span>@@ -126,6 +1=
25,6 @@</span><br><span>     echo &quot;$0: tests passed: $tests_passed  fa=
iled: $tests_failed&quot;</span><br><span> fi</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-rm key.$$ tc-server-key.$$ tc-cli=
ent-key.$$ log.$$</span><br><span style=3D"color: hsl(120, 100%, 40%);">+rm=
 tc-server-key.$$ tc-client-key.$$ log.$$</span><br><span> trap 0</span><br=
><span> exit $e</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1435?usp=3Demail">change 1435</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1435?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I72947bd4f0213fd118327f740da=
eb1d86ae166de </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1435 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--H2PyFvecTN8=--

