From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 23 Apr 2025 10:55:28 +0000
References: <gerrit.1745405723000.Ica02244c9f0ac9b4690a51f940fda9d900465289@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <a543251dca91a6c3868d46e589b8de3d820287e5-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cvSPOzLy9kQ="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Make dh none
 behaviour default if not specific and add dh auto
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

--cvSPOzLy9kQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/945?usp=3Demail

to review the following change.


Change subject: Make dh none behaviour default if not specific and add dh a=
uto
......................................................................

Make dh none behaviour default if not specific and add dh auto

Nowadays ciphers that are using still DH and not ECDH are rarely chosen
as best cipher suite. Our man page even indicates that OpenSSL 1.0.1+
supports ECDH cipher suites. So it does not feel useful to force
specifying --dh anymore.

Custom generated Diffie Hellmann parameters are also discouraged
nowadays. The newest OpenSSL FIPS libraries even flat out reject them:

   FIPS 186-4 type domain parameters no longer allowed in FIPS mode,
   since the required validation routines were removed from FIPS 186-5

So add --dh auto since is very little extra code to let the TLS library
itself pick the parameter.

Change-Id: Ica02244c9f0ac9b4690a51f940fda9d900465289
---
M Changes.rst
M doc/man-sections/tls-options.rst
M src/openvpn/options.c
M src/openvpn/ssl.c
M src/openvpn/ssl_backend.h
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_openssl.c
7 files changed, 53 insertions(+), 9 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/45/945/1

diff --git a/Changes.rst b/Changes.rst
index a4f5e57..a7ce8f8 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -103,6 +103,12 @@
 - ``--x509-username-field`` will no longer automatically convert fieldname=
s to
   uppercase. This is deprecated since OpenVPN 2.4, and has now been remove=
d.

+- ``--dh none`` is now the default if ``--dh`` is specified. Modern TLS
+  implementations will prefer ECDH and other more modern algorithm anyway.
+
+- ``--dh auto`` instructs the TLS library - if supported - to use internal
+  Diffie-Hellmann parameters.
+
 Overview of changes in 2.6
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-option=
s.rst
index 0638d09..d5ebf52 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -171,16 +171,22 @@


 --dh file
-  File containing Diffie Hellman parameters in .pem format (required for
+  File containing Diffie Hellman parameters in .pem format (used by
   ``--tls-server`` only).

   Set ``file`` to :code:`none` to disable Diffie Hellman key exchange (and
-  use ECDH only). Note that this requires peers to be using an SSL library
-  that supports ECDH TLS cipher suites (e.g. OpenSSL 1.0.1+, or
-  mbed TLS 2.0+).
+  use ECDH or newer hybrid key agreement algorithms like X25519MLKEM768).
+  Note that this requires peers to be using an SSL library that supports
+  ECDH TLS cipher suites (e.g. OpenSSL 1.0.1+, or mbed TLS 2.0+). Starting
+  with 2.7.0, this is the same as not specifying ``--dh`` at all.

-  Use ``openssl dhparam -out dh2048.pem 2048`` to generate 2048-bit DH
-  parameters. Diffie Hellman parameters may be considered public.
+  Set ``file`` to :code:`auto` enables using builtin Diffie Hellman
+  parameters of the TLS library, e.g. the ones defined in RFC 7919.
+
+  Diffie Hellman parameters can be generated using
+  ``openssl dhparam -out dh2048.pem 2048`` but it is recommended to
+  use the public well-known parameter or using ``none``.
+  Diffie Hellman parameters may be considered public.

 --ecdh-curve name
   Specify the curve to use for elliptic curve Diffie Hellman. Available
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 96119c4..2979872 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3711,8 +3711,12 @@

     if (o->tls_server)
     {
-        /* Check that DH file is specified, or explicitly disabled */
-        notnull(o->dh_file, "DH file (--dh)");
+        if (streq(o->dh_file, "auto"))
+        {
+            o->dh_file =3D "auto";
+            /* do not check existence of the "auto" file */
+            o->dh_file_inline =3D true;
+        }
         if (streq(o->dh_file, "none"))
         {
             o->dh_file =3D NULL;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 23f6423..d591bac 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -535,7 +535,11 @@
     {
         tls_ctx_server_new(new_ctx);

-        if (options->dh_file)
+        if (options->dh_file && !strcmp(options->dh_file, "auto"))
+        {
+            tls_ctx_use_dh_params_builtin(new_ctx);
+        }
+        else if  (options->dh_file)
         {
             tls_ctx_load_dh_params(new_ctx, options->dh_file,
                                    options->dh_file_inline);
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index e25727f..326f78d 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -223,6 +223,13 @@
                             bool dh_file_inline);

 /**
+ * Instructs the TLS library to use builtin Diffie Hellman Parameters inst=
ead
+ * of loading specific ones (e.g. the ones from RFC 7919)
+ * @param ctx
+ */
+void tls_ctx_use_dh_params_builtin(struct tls_root_ctx *ctx);
+
+/**
  * Load Elliptic Curve Parameters, and load them into the library-specific
  * TLS context.
  *
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index e15c391..f1fada3 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -480,6 +480,13 @@
 }

 void
+tls_ctx_use_dh_params_builtin(struct tls_root_ctx *ctx)
+{
+    msg(M_FATAL, "mbed TLS does not support --dh auto. Use --dh none or "
+        "manually specify Diffie-Hellmann parameters");
+}
+
+void
 tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
                          )
 {
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index f7be50c..f204007 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -714,6 +714,16 @@
 }

 void
+tls_ctx_use_dh_params_builtin(struct tls_root_ctx *ctx)
+{
+    if (!SSL_CTX_set_dh_auto(ctx->ctx, 1))
+    {
+        crypto_msg(M_FATAL, "SSL_CTX_set_dh_auto");
+    }
+
+}
+
+void
 tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name)
 {
 #if OPENSSL_VERSION_NUMBER >=3D 0x30000000L

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/945?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ica02244c9f0ac9b4690a51f940fda9d900465289
Gerrit-Change-Number: 945
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--cvSPOzLy9kQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/945?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Make dh none behaviour default if not specific and add dh aut=
o<br><br>Nowadays ciphers that are using still DH and not ECDH are rarely c=
hosen<br>as best cipher suite. Our man page even indicates that OpenSSL 1.0=
.1+<br>supports ECDH cipher suites. So it does not feel useful to force<br>=
specifying --dh anymore.<br><br>Custom generated Diffie Hellmann parameters=
 are also discouraged<br>nowadays. The newest OpenSSL FIPS libraries even f=
lat out reject them:<br><br>   FIPS 186-4 type domain parameters no longer =
allowed in FIPS mode,<br>   since the required validation routines were rem=
oved from FIPS 186-5<br><br>So add --dh auto since is very little extra cod=
e to let the TLS library<br>itself pick the parameter.<br><br>Change-Id: Ic=
a02244c9f0ac9b4690a51f940fda9d900465289<br>---<br>M Changes.rst<br>M doc/ma=
n-sections/tls-options.rst<br>M src/openvpn/options.c<br>M src/openvpn/ssl.=
c<br>M src/openvpn/ssl_backend.h<br>M src/openvpn/ssl_mbedtls.c<br>M src/op=
envpn/ssl_openssl.c<br>7 files changed, 53 insertions(+), 9 deletions(-)<br=
><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/45/945=
/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;"><span>diff --git a/Changes.rst b/Changes.rst</span><br><span>index a4f=
5e57..a7ce8f8 100644</span><br><span>--- a/Changes.rst</span><br><span>+++ =
b/Changes.rst</span><br><span>@@ -103,6 +103,12 @@</span><br><span> - ``--x=
509-username-field`` will no longer automatically convert fieldnames to</sp=
an><br><span>   uppercase. This is deprecated since OpenVPN 2.4, and has no=
w been removed.</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+- ``--dh none`` is now the default if ``--dh`` is specified. =
Modern TLS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  impleme=
ntations will prefer ECDH and other more modern algorithm anyway.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+- ``--dh auto`` instructs the TLS library - if s=
upported - to use internal</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  Diffie-Hellmann parameters.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> Overview of changes in 2.6</span><br><sp=
an> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D</span><br><span> </span><br><span>diff --git a/doc/man-sections/t=
ls-options.rst b/doc/man-sections/tls-options.rst</span><br><span>index 063=
8d09..d5ebf52 100644</span><br><span>--- a/doc/man-sections/tls-options.rst=
</span><br><span>+++ b/doc/man-sections/tls-options.rst</span><br><span>@@ =
-171,16 +171,22 @@</span><br><span> </span><br><span> </span><br><span> --d=
h file</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  File containi=
ng Diffie Hellman parameters in .pem format (required for</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  File containing Diffie Hellman para=
meters in .pem format (used by</span><br><span>   ``--tls-server`` only).</=
span><br><span> </span><br><span>   Set ``file`` to :code:`none` to disable=
 Diffie Hellman key exchange (and</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  use ECDH only). Note that this requires peers to be using an =
SSL library</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  that sup=
ports ECDH TLS cipher suites (e.g. OpenSSL 1.0.1+, or</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  mbed TLS 2.0+).</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  use ECDH or newer hybrid key agreement algo=
rithms like X25519MLKEM768).</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  Note that this requires peers to be using an SSL library that su=
pports</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ECDH TLS ci=
pher suites (e.g. OpenSSL 1.0.1+, or mbed TLS 2.0+). Starting</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  with 2.7.0, this is the same as=
 not specifying ``--dh`` at all.</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-  Use ``openssl dhparam -out dh2048.pem 2048``=
 to generate 2048-bit DH</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-  parameters. Diffie Hellman parameters may be considered public.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  Set ``file`` to :code:`a=
uto` enables using builtin Diffie Hellman</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  parameters of the TLS library, e.g. the ones define=
d in RFC 7919.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  Diffie Hellman paramet=
ers can be generated using</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  ``openssl dhparam -out dh2048.pem 2048`` but it is recommended to<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  use the public wel=
l-known parameter or using ``none``.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  Diffie Hellman parameters may be considered public.</spa=
n><br><span> </span><br><span> --ecdh-curve name</span><br><span>   Specify=
 the curve to use for elliptic curve Diffie Hellman. Available</span><br><s=
pan>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><s=
pan>index 96119c4..2979872 100644</span><br><span>--- a/src/openvpn/options=
.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -3711,8 +=
3711,12 @@</span><br><span> </span><br><span>     if (o-&gt;tls_server)</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      /* Check that DH file is specified, or explicitly disabled */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        notnull(o-&gt;dh_file=
, &quot;DH file (--dh)&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (streq(o-&gt;dh_file, &quot;auto&quot;))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            o-&gt;dh_file =3D &quot;auto&=
quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /=
* do not check existence of the &quot;auto&quot; file */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            o-&gt;dh_file_inline =3D t=
rue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span>         if (streq(o-&gt;dh_file, &quot;none&quot;))</span><br><=
span>         {</span><br><span>             o-&gt;dh_file =3D NULL;</span>=
<br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><spa=
n>index 23f6423..d591bac 100644</span><br><span>--- a/src/openvpn/ssl.c</sp=
an><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -535,7 +535,11 @@</=
span><br><span>     {</span><br><span>         tls_ctx_server_new(new_ctx);=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (options-&gt;dh_file)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (options-&gt;dh_file &amp;&amp; !strcmp(options-&gt;dh=
_file, &quot;auto&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        tls_ctx_use_dh_params_builtin(new_ctx);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        else if  (options-&gt;dh_file)</span><br><span>  =
       {</span><br><span>             tls_ctx_load_dh_params(new_ctx, optio=
ns-&gt;dh_file,</span><br><span>                                    options=
-&gt;dh_file_inline);</span><br><span>diff --git a/src/openvpn/ssl_backend.=
h b/src/openvpn/ssl_backend.h</span><br><span>index e25727f..326f78d 100644=
</span><br><span>--- a/src/openvpn/ssl_backend.h</span><br><span>+++ b/src/=
openvpn/ssl_backend.h</span><br><span>@@ -223,6 +223,13 @@</span><br><span>=
                             bool dh_file_inline);</span><br><span> </span>=
<br><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * In=
structs the TLS library to use builtin Diffie Hellman Parameters instead</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * of loading specific=
 ones (e.g. the ones from RFC 7919)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @param ctx</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void t=
ls_ctx_use_dh_params_builtin(struct tls_root_ctx *ctx);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/**</span><br><span>  * Load Elliptic Curve Parameters, an=
d load them into the library-specific</span><br><span>  * TLS context.</spa=
n><br><span>  *</span><br><span>diff --git a/src/openvpn/ssl_mbedtls.c b/sr=
c/openvpn/ssl_mbedtls.c</span><br><span>index e15c391..f1fada3 100644</span=
><br><span>--- a/src/openvpn/ssl_mbedtls.c</span><br><span>+++ b/src/openvp=
n/ssl_mbedtls.c</span><br><span>@@ -480,6 +480,13 @@</span><br><span> }</sp=
an><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+tls_ctx_use_dh_params_builtin(struct tls_root_ctx *ctx)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    msg(M_FATAL, &quot;mbed TLS does not=
 support --dh auto. Use --dh none or &quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        &quot;manually specify Diffie-Hellmann para=
meters&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span> tls_ctx_load_ecdh_p=
arams(struct tls_root_ctx *ctx, const char *curve_name</span><br><span>    =
                      )</span><br><span> {</span><br><span>diff --git a/src=
/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span><br><span>index f7=
be50c..f204007 100644</span><br><span>--- a/src/openvpn/ssl_openssl.c</span=
><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><span>@@ -714,6 +714,1=
6 @@</span><br><span> }</span><br><span> </span><br><span> void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+tls_ctx_use_dh_params_builtin(s=
truct tls_root_ctx *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!SSL_=
CTX_set_dh_auto(ctx-&gt;ctx, 1))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       crypto_msg(M_FATAL, &quot;SSL_CTX_set_dh_auto&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span> tls_ctx=
_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name)</span><=
br><span> {</span><br><span> #if OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/945?usp=3Demail">change 945</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/945?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ica02244c9f0ac9b4690a51f940f=
da9d900465289 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 945 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--cvSPOzLy9kQ=--

