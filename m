From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Sun, 22 Sep 2024 14:15:38 +0000
References: <gerrit.1727014533000.I00209b880cfcedd93e28f97fc3941d8b85e095f3@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e808d4206024cd233bea4d4f4ddb0ee220f374df-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Z2EZo+eF2RA="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Automatically enable
 --compress migrate on the server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Z2EZo+eF2RA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/756?usp=3Demail

to review the following change.


Change subject: Automatically enable --compress migrate on the server
......................................................................

Automatically enable --compress migrate on the server

If we enable LZO compression, automatically switch to
migrate mode.

Change-Id: I00209b880cfcedd93e28f97fc3941d8b85e095f3
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M doc/man-sections/protocol-options.rst
M src/openvpn/comp.h
M src/openvpn/options.c
3 files changed, 56 insertions(+), 62 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/56/756/1

diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/proto=
col-options.rst
index 8b061d2..b2a23fa 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -30,7 +30,9 @@
       framing (stub).

   :code:`yes`
-      OpenVPN will send and receive compressed packets.
+      **DEPRECATED** This option is an alias for :code:`asym`. Previously
+      it did enable compression for uplink packets, but OpenVPN never
+      compresses uplink packets now.

 --auth alg
   Authenticate data channel packets and (if enabled) ``tls-auth`` control
@@ -125,6 +127,12 @@
   configuration if supported by the client and otherwise switch to ``comp-=
lzo no``
   and add ``--push comp-lzo`` to the client specific configuration.

+  If used in a server configuration :code:`lzo` is an alias for :code:`mig=
rate` in
+  current versions of OpenVPN. Compression will only be enabled if there i=
s no
+  other choice. Note that these versions of OpenVPN also never actually co=
mpress
+  any packets. But they still will decompress packets received from the ot=
her side
+  of the connection if required.
+
   ***Security Considerations***

   Compression and encryption is a tricky combination. If an attacker knows
@@ -135,48 +143,31 @@
   entirely sure that the above does not apply to your traffic, you are
   advised to *not* enable compression.

+  For this reason compression support was removed from current versions
+  of OpenVPN. It will still decompress compressed packets removed via
+  a VPN connection but it will never compress any outgoing packets.
+
 --comp-lzo mode
   **DEPRECATED** Enable LZO compression algorithm.  Compression is
   generally not recommended.  VPN tunnels which uses compression are
   suspectible to the VORALCE attack vector.

-  Use LZO compression -- may add up to 1 byte per packet for incompressible
-  data. ``mode`` may be :code:`yes`, :code:`no`, or :code:`adaptive`
-  (default).
+  Allows the other side of the connection to use LZO compression. Due
+  to difference in packet format this may adds 1 additional byte per packe=
t.
+  With current versions of OpenVPN no actual compression will happen.

-  In a server mode setup, it is possible to selectively turn compression
-  on or off for individual clients.
+  ``mode`` may be :code:`yes`, :code:`no`, or :code:`adaptive`
+  but there is no actual change in behavior anymore.

-  First, make sure the client-side config file enables selective
-  compression by having at least one ``--comp-lzo`` directive, such as
-  ``--comp-lzo no``. This will turn off compression by default, but allow
-  a future directive push from the server to dynamically change the
-  :code:`on`/:code:`off`/:code:`adaptive` setting.
-
-  Next in a ``--client-config-dir`` file, specify the compression setting
-  for the client, for example:
-  ::
-
-    comp-lzo yes
-    push "comp-lzo yes"
-
-  The first line sets the ``comp-lzo`` setting for the server side of the
-  link, the second sets the client side.
+  In server mode we convert this setting to ``--compress migrate`` to
+  automatically disable it when the client doesn't need it. If you want
+  to remove this setting from your server config you might need to add
+  an explicit ``--compress migrate`` instead if some clients still have
+  any variant of ``--comp-lzo`` in their config.

 --comp-noadapt
-  **DEPRECATED** When used in conjunction with ``--comp-lzo``, this option
-  will disable OpenVPN's adaptive compression algorithm. Normally, adaptive
-  compression is enabled with ``--comp-lzo``.
-
-  Adaptive compression tries to optimize the case where you have
-  compression enabled, but you are sending predominantly incompressible
-  (or pre-compressed) packets over the tunnel, such as an FTP or rsync
-  transfer of a large, compressed file. With adaptive compression, OpenVPN
-  will periodically sample the compression process to measure its
-  efficiency. If the data being sent over the tunnel is already
-  compressed, the compression efficiency will be very low, triggering
-  openvpn to disable compression for a period of time until the next
-  re-sample test.
+  **DEPRECATED** This option does not have any effect anymore since current
+  versions of OpenVPN never compress outgoing packets.

 --key-direction
   Alternative way of specifying the optional direction parameter for the
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index decf0d9..1bc4648 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -32,8 +32,8 @@
  * outside of the USE_COMP define */

 /* Compression flags */
-#define COMP_F_ADAPTIVE             (1<<0) /* COMP_ALG_LZO only */
 /*Removed */
+/*#define COMP_F_ADAPTIVE             (1<<0) / * COMP_ALG_LZO only */
 /*#define COMP_F_ALLOW_COMPRESS       (1<<1) / * not only downlink is comp=
ressed but also uplink * / */
 #define COMP_F_SWAP                 (1<<2) /* initial command byte is swap=
ped with last byte in buffer to preserve payload alignment */
 #define COMP_F_ADVERTISE_STUBS_ONLY (1<<3) /* tell server that we only sup=
port compression stubs */
@@ -49,6 +49,7 @@
 #define COMP_ALG_LZO    2 /* LZO algorithm */
 #define COMP_ALG_SNAPPY 3 /* Snappy algorithm (no longer supported) */
 #define COMP_ALG_LZ4    4 /* LZ4 algorithm */
+#define COMP_ALG_LZO_NO 5 /* --comp-lzo no which is similar to COMP_ALG_ST=
UB, but no SWAP */


 /* algorithm v2 */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4745ddf..f8688d4 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3448,6 +3448,24 @@
     }
 #endif /* ifdef _WIN32 */

+    if (options->mode =3D=3D MODE_SERVER)
+    {
+        /*
+         * Enable comp migrate automatically on server
+         */
+        if (options->comp.alg =3D=3D COMP_ALG_LZO || options->comp.alg =3D=
=3D COMP_ALG_LZO_NO)
+        {
+            msg(M_INFO, "DEPRECATED OPTION: LZO compression enabled on the=
 server side. "
+                "We will enable --compress migrate instead.");
+            options->comp.alg =3D COMP_ALG_UNDEF;
+            options->comp.flags =3D COMP_F_MIGRATE;
+        }
+    }
+    else if (options->comp.alg =3D=3D COMP_ALG_LZO_NO)
+    {
+        options->comp.alg =3D COMP_ALG_STUB;
+    }
+
 #ifdef DEFAULT_PKCS11_MODULE
     /* If p11-kit is present on the system then load its p11-kit-proxy.so
      * by default if the user asks for PKCS#11 without otherwise specifying
@@ -8450,45 +8468,29 @@

         /* All lzo variants do not use swap */
         options->comp.flags &=3D ~COMP_F_SWAP;
+        options->comp.alg =3D COMP_ALG_LZO;

-        if (p[1] && streq(p[1], "no"))
+        if (p[1])
         {
-            options->comp.alg =3D COMP_ALG_STUB;
-            options->comp.flags &=3D ~COMP_F_ADAPTIVE;
-        }
-        else if (p[1])
-        {
-            if (streq(p[1], "yes"))
+            if (streq(p[1], "no"))
             {
-                options->comp.alg =3D COMP_ALG_LZO;
-                options->comp.flags &=3D ~COMP_F_ADAPTIVE;
+                options->comp.alg =3D COMP_ALG_LZO_NO;
             }
-            else if (streq(p[1], "adaptive"))
-            {
-                options->comp.alg =3D COMP_ALG_LZO;
-                options->comp.flags |=3D COMP_F_ADAPTIVE;
-            }
-            else
+            /* There is no actual difference anymore between these variant=
s.
+             * We never compress. On the server side we replace this with
+             * --compress migrate later anyway.
+             */
+            else if (!(streq(p[1], "yes") || streq(p[1], "adaptive")))
             {
                 msg(msglevel, "bad comp-lzo option: %s -- must be 'yes', '=
no', or 'adaptive'", p[1]);
                 goto err;
             }
         }
-        else
-        {
-            options->comp.alg =3D COMP_ALG_LZO;
-            options->comp.flags |=3D COMP_F_ADAPTIVE;
-        }
         show_compression_warning(&options->comp);
     }
     else if (streq(p[0], "comp-noadapt") && !p[1])
     {
-        /*
-         * We do not need to check here if we allow compression since
-         * it only modifies a flag if compression is enabled
-         */
-        VERIFY_PERMISSION(OPT_P_COMP);
-        options->comp.flags &=3D ~COMP_F_ADAPTIVE;
+        /* NO-OP since we never compress anymore */
     }
     else if (streq(p[0], "compress") && !p[2])
     {
@@ -8517,7 +8519,7 @@
         else if (streq(alg, "lzo"))
         {
             options->comp.alg =3D COMP_ALG_LZO;
-            options->comp.flags &=3D ~(COMP_F_ADAPTIVE | COMP_F_SWAP);
+            options->comp.flags &=3D ~COMP_F_SWAP;
         }
         else if (streq(alg, "lz4"))
         {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/756?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I00209b880cfcedd93e28f97fc3941d8b85e095f3
Gerrit-Change-Number: 756
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--Z2EZo+eF2RA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/756?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Automatically enable --compress migrate on the server<br><br>=
If we enable LZO compression, automatically switch to<br>migrate mode.<br><=
br>Change-Id: I00209b880cfcedd93e28f97fc3941d8b85e095f3<br>Signed-off-by: F=
rank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M doc/man-sections/prot=
ocol-options.rst<br>M src/openvpn/comp.h<br>M src/openvpn/options.c<br>3 fi=
les changed, 56 insertions(+), 62 deletions(-)<br><br></pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit.openvpn.net:29418/openvpn refs/changes/56/756/1</pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/do=
c/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst=
</span><br><span>index 8b061d2..b2a23fa 100644</span><br><span>--- a/doc/ma=
n-sections/protocol-options.rst</span><br><span>+++ b/doc/man-sections/prot=
ocol-options.rst</span><br><span>@@ -30,7 +30,9 @@</span><br><span>       f=
raming (stub).</span><br><span> </span><br><span>   :code:`yes`</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-      OpenVPN will send and recei=
ve compressed packets.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+      **DEPRECATED** This option is an alias for :code:`asym`. Previousl=
y</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      it did enabl=
e compression for uplink packets, but OpenVPN never</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      compresses uplink packets now.</spa=
n><br><span> </span><br><span> --auth alg</span><br><span>   Authenticate d=
ata channel packets and (if enabled) ``tls-auth`` control</span><br><span>@=
@ -125,6 +127,12 @@</span><br><span>   configuration if supported by the cl=
ient and otherwise switch to ``comp-lzo no``</span><br><span>   and add ``-=
-push comp-lzo`` to the client specific configuration.</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  If used in a server =
configuration :code:`lzo` is an alias for :code:`migrate` in</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  current versions of OpenVPN. Com=
pression will only be enabled if there is no</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  other choice. Note that these versions of OpenVP=
N also never actually compress</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  any packets. But they still will decompress packets received f=
rom the other side</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 of the connection if required.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span>   ***Security Considerations***</span><br><sp=
an> </span><br><span>   Compression and encryption is a tricky combination.=
 If an attacker knows</span><br><span>@@ -135,48 +143,31 @@</span><br><span=
>   entirely sure that the above does not apply to your traffic, you are</s=
pan><br><span>   advised to *not* enable compression.</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  For this reason compr=
ession support was removed from current versions</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  of OpenVPN. It will still decompress compres=
sed packets removed via</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  a VPN connection but it will never compress any outgoing packets.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --com=
p-lzo mode</span><br><span>   **DEPRECATED** Enable LZO compression algorit=
hm.  Compression is</span><br><span>   generally not recommended.  VPN tunn=
els which uses compression are</span><br><span>   suspectible to the VORALC=
E attack vector.</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  Use LZO compression -- may add up to 1 byte per packet for i=
ncompressible</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  data. =
``mode`` may be :code:`yes`, :code:`no`, or :code:`adaptive`</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  (default).</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  Allows the other side of the connection=
 to use LZO compression. Due</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  to difference in packet format this may adds 1 additional byte p=
er packet.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  With cu=
rrent versions of OpenVPN no actual compression will happen.</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  In a server mode=
 setup, it is possible to selectively turn compression</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-  on or off for individual clients.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  ``mode`` may be :code:`y=
es`, :code:`no`, or :code:`adaptive`</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  but there is no actual change in behavior anymore.</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  First, =
make sure the client-side config file enables selective</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  compression by having at least one ``--=
comp-lzo`` directive, such as</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  ``--comp-lzo no``. This will turn off compression by default, but=
 allow</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  a future dire=
ctive push from the server to dynamically change the</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  :code:`on`/:code:`off`/:code:`adaptive` s=
etting.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  Next in a ``--client-config-dir``=
 file, specify the compression setting</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  for the client, for example:</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  ::</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    comp-lzo=
 yes</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    push &quot;co=
mp-lzo yes&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-  The first line sets the =
``comp-lzo`` setting for the server side of the</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  link, the second sets the client side.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  In server mode we convert =
this setting to ``--compress migrate`` to</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  automatically disable it when the client doesn&#39;=
t need it. If you want</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  to remove this setting from your server config you might need to add</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  an explicit ``--com=
press migrate`` instead if some clients still have</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  any variant of ``--comp-lzo`` in their con=
fig.</span><br><span> </span><br><span> --comp-noadapt</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-  **DEPRECATED** When used in conjunction =
with ``--comp-lzo``, this option</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  will disable OpenVPN&#39;s adaptive compression algorithm. Nor=
mally, adaptive</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  comp=
ression is enabled with ``--comp-lzo``.</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  A=
daptive compression tries to optimize the case where you have</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  compression enabled, but you are =
sending predominantly incompressible</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  (or pre-compressed) packets over the tunnel, such as an FT=
P or rsync</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  transfer =
of a large, compressed file. With adaptive compression, OpenVPN</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  will periodically sample the co=
mpression process to measure its</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  efficiency. If the data being sent over the tunnel is already<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-  compressed, the comp=
ression efficiency will be very low, triggering</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  openvpn to disable compression for a period of =
time until the next</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
re-sample test.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  **=
DEPRECATED** This option does not have any effect anymore since current</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  versions of OpenVPN n=
ever compress outgoing packets.</span><br><span> </span><br><span> --key-di=
rection</span><br><span>   Alternative way of specifying the optional direc=
tion parameter for the</span><br><span>diff --git a/src/openvpn/comp.h b/sr=
c/openvpn/comp.h</span><br><span>index decf0d9..1bc4648 100644</span><br><s=
pan>--- a/src/openvpn/comp.h</span><br><span>+++ b/src/openvpn/comp.h</span=
><br><span>@@ -32,8 +32,8 @@</span><br><span>  * outside of the USE_COMP de=
fine */</span><br><span> </span><br><span> /* Compression flags */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define COMP_F_ADAPTIVE       =
      (1&lt;&lt;0) /* COMP_ALG_LZO only */</span><br><span> /*Removed */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/*#define COMP_F_ADAPT=
IVE             (1&lt;&lt;0) / * COMP_ALG_LZO only */</span><br><span> /*#d=
efine COMP_F_ALLOW_COMPRESS       (1&lt;&lt;1) / * not only downlink is com=
pressed but also uplink * / */</span><br><span> #define COMP_F_SWAP        =
         (1&lt;&lt;2) /* initial command byte is swapped with last byte in =
buffer to preserve payload alignment */</span><br><span> #define COMP_F_ADV=
ERTISE_STUBS_ONLY (1&lt;&lt;3) /* tell server that we only support compress=
ion stubs */</span><br><span>@@ -49,6 +49,7 @@</span><br><span> #define COM=
P_ALG_LZO    2 /* LZO algorithm */</span><br><span> #define COMP_ALG_SNAPPY=
 3 /* Snappy algorithm (no longer supported) */</span><br><span> #define CO=
MP_ALG_LZ4    4 /* LZ4 algorithm */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define COMP_ALG_LZO_NO 5 /* --comp-lzo no which is similar=
 to COMP_ALG_STUB, but no SWAP */</span><br><span> </span><br><span> </span=
><br><span> /* algorithm v2 */</span><br><span>diff --git a/src/openvpn/opt=
ions.c b/src/openvpn/options.c</span><br><span>index 4745ddf..f8688d4 10064=
4</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/ope=
nvpn/options.c</span><br><span>@@ -3448,6 +3448,24 @@</span><br><span>     =
}</span><br><span> #endif /* ifdef _WIN32 */</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (options-&gt;mode =3D=3D =
MODE_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+         * Enable comp migrate=
 automatically on server</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+         */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (options-&gt;comp.alg =3D=3D COMP_ALG_LZO || options-&gt;comp.alg =
=3D=3D COMP_ALG_LZO_NO)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      msg(M_INFO, &quot;DEPRECATED OPTION: LZO compression enabled on the s=
erver side. &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               &quot;We will enable --compress migrate instead.&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            options-&gt=
;comp.alg =3D COMP_ALG_UNDEF;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            options-&gt;comp.flags =3D COMP_F_MIGRATE;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    else if (options-&gt;comp.alg =3D=3D COMP_ALG_LZO_=
NO)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;comp.alg =
=3D COMP_ALG_STUB;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> #ifdef DEFAULT_PKCS11_MODULE</span><br><span>     /* If p11-kit is prese=
nt on the system then load its p11-kit-proxy.so</span><br><span>      * by =
default if the user asks for PKCS#11 without otherwise specifying</span><br=
><span>@@ -8450,45 +8468,29 @@</span><br><span> </span><br><span>         /=
* All lzo variants do not use swap */</span><br><span>         options-&gt;=
comp.flags &amp;=3D ~COMP_F_SWAP;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        options-&gt;comp.alg =3D COMP_ALG_LZO;</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (p[1] &=
amp;&amp; streq(p[1], &quot;no&quot;))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (p[1])</span><br><span>         {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            options-&gt;comp.alg =
=3D COMP_ALG_STUB;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         options-&gt;comp.flags &amp;=3D ~COMP_F_ADAPTIVE;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        else if (p[1])</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            if (streq(p[1], &quot;yes&quot;))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            if (streq(p[1], &quot;n=
o&quot;))</span><br><span>             {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                options-&gt;comp.alg =3D COMP_ALG_LZO;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                options=
-&gt;comp.flags &amp;=3D ~COMP_F_ADAPTIVE;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                options-&gt;comp.alg =3D COMP_ALG_LZ=
O_NO;</span><br><span>             }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            else if (streq(p[1], &quot;adaptive&quot;))</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                options-&gt;comp.a=
lg =3D COMP_ALG_LZO;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               options-&gt;comp.flags |=3D COMP_F_ADAPTIVE;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            else</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            /* There is no actual difference a=
nymore between these variants.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+             * We never compress. On the server side we replace =
this with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
   * --compress migrate later anyway.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+             */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            else if (!(streq(p[1], &quot;yes&quot;) || streq(=
p[1], &quot;adaptive&quot;)))</span><br><span>             {</span><br><spa=
n>                 msg(msglevel, &quot;bad comp-lzo option: %s -- must be &=
#39;yes&#39;, &#39;no&#39;, or &#39;adaptive&#39;&quot;, p[1]);</span><br><=
span>                 goto err;</span><br><span>             }</span><br><s=
pan>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            options-&gt;comp=
.alg =3D COMP_ALG_LZO;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            options-&gt;comp.flags |=3D COMP_F_ADAPTIVE;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span>         show=
_compression_warning(&amp;options-&gt;comp);</span><br><span>     }</span><=
br><span>     else if (streq(p[0], &quot;comp-noadapt&quot;) &amp;&amp; !p[=
1])</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
   * We do not need to check here if we allow compression since</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-         * it only modifies a fla=
g if compression is enabled</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-         */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    VERIFY_PERMISSION(OPT_P_COMP);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        options-&gt;comp.flags &amp;=3D ~COMP_F_ADAPTIVE;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* NO-OP since w=
e never compress anymore */</span><br><span>     }</span><br><span>     els=
e if (streq(p[0], &quot;compress&quot;) &amp;&amp; !p[2])</span><br><span> =
    {</span><br><span>@@ -8517,7 +8519,7 @@</span><br><span>         else i=
f (streq(alg, &quot;lzo&quot;))</span><br><span>         {</span><br><span>=
             options-&gt;comp.alg =3D COMP_ALG_LZO;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            options-&gt;comp.flags &amp;=3D=
 ~(COMP_F_ADAPTIVE | COMP_F_SWAP);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            options-&gt;comp.flags &amp;=3D ~COMP_F_SWAP;</s=
pan><br><span>         }</span><br><span>         else if (streq(alg, &quot=
;lz4&quot;))</span><br><span>         {</span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/756?usp=3D=
email">change 756</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div it=
emscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/756?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I00209b880cfcedd93e28f97fc39=
41d8b85e095f3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 756 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--Z2EZo+eF2RA=--

