From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Sun, 22 Sep 2024 14:21:47 +0000
In-Reply-To: <gerrit.1727014533000.I00209b880cfcedd93e28f97fc3941d8b85e095f3@...2715...>
References: <gerrit.1727014533000.I00209b880cfcedd93e28f97fc3941d8b85e095f3@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <c516ce6ac4303ff32f42c0b3d52949e7624f3ac9-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="20t0wE609dU="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Automatically enable
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

--20t0wE609dU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/756?usp=3Demail

to look at the new patch set (#2).


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
3 files changed, 31 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/56/756/2

diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/proto=
col-options.rst
index 37e2240..b2a23fa 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -127,6 +127,12 @@
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
@@ -153,6 +159,11 @@
   ``mode`` may be :code:`yes`, :code:`no`, or :code:`adaptive`
   but there is no actual change in behavior anymore.

+  In server mode we convert this setting to ``--compress migrate`` to
+  automatically disable it when the client doesn't need it. If you want
+  to remove this setting from your server config you might need to add
+  an explicit ``--compress migrate`` instead if some clients still have
+  any variant of ``--comp-lzo`` in their config.

 --comp-noadapt
   **DEPRECATED** This option does not have any effect anymore since current
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index ed6a563..1bc4648 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -49,6 +49,7 @@
 #define COMP_ALG_LZO    2 /* LZO algorithm */
 #define COMP_ALG_SNAPPY 3 /* Snappy algorithm (no longer supported) */
 #define COMP_ALG_LZ4    4 /* LZ4 algorithm */
+#define COMP_ALG_LZO_NO 5 /* --comp-lzo no which is similar to COMP_ALG_ST=
UB, but no SWAP */


 /* algorithm v2 */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4fee671..f8688d4 100644
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
@@ -8456,7 +8474,7 @@
         {
             if (streq(p[1], "no"))
             {
-                options->comp.alg =3D COMP_ALG_STUB;
+                options->comp.alg =3D COMP_ALG_LZO_NO;
             }
             /* There is no actual difference anymore between these variant=
s.
              * We never compress. On the server side we replace this with

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/756?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I00209b880cfcedd93e28f97fc3941d8b85e095f3
Gerrit-Change-Number: 756
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--20t0wE609dU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/756?usp=3Demail">View Ch=
ange</a></p><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Automatically enable --compress migrate on the server<br><br>If we=
 enable LZO compression, automatically switch to<br>migrate mode.<br><br>Ch=
ange-Id: I00209b880cfcedd93e28f97fc3941d8b85e095f3<br>Signed-off-by: Frank =
Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M doc/man-sections/protocol-=
options.rst<br>M src/openvpn/comp.h<br>M src/openvpn/options.c<br>3 files c=
hanged, 31 insertions(+), 1 deletion(-)<br><br></pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.ope=
nvpn.net:29418/openvpn refs/changes/56/756/2</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-s=
ections/protocol-options.rst b/doc/man-sections/protocol-options.rst</span>=
<br><span>index 37e2240..b2a23fa 100644</span><br><span>--- a/doc/man-secti=
ons/protocol-options.rst</span><br><span>+++ b/doc/man-sections/protocol-op=
tions.rst</span><br><span>@@ -127,6 +127,12 @@</span><br><span>   configura=
tion if supported by the client and otherwise switch to ``comp-lzo no``</sp=
an><br><span>   and add ``--push comp-lzo`` to the client specific configur=
ation.</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  If used in a server configuration :code:`lzo` is an alias for :code:=
`migrate` in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  curre=
nt versions of OpenVPN. Compression will only be enabled if there is no</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  other choice. Note th=
at these versions of OpenVPN also never actually compress</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  any packets. But they still will de=
compress packets received from the other side</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  of the connection if required.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   ***Security Cons=
iderations***</span><br><span> </span><br><span>   Compression and encrypti=
on is a tricky combination. If an attacker knows</span><br><span>@@ -153,6 =
+159,11 @@</span><br><span>   ``mode`` may be :code:`yes`, :code:`no`, or :=
code:`adaptive`</span><br><span>   but there is no actual change in behavio=
r anymore.</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  In server mode we convert this setting to ``--compress migrate``=
 to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  automatically =
disable it when the client doesn&#39;t need it. If you want</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  to remove this setting from your =
server config you might need to add</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  an explicit ``--compress migrate`` instead if some client=
s still have</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  any v=
ariant of ``--comp-lzo`` in their config.</span><br><span> </span><br><span=
> --comp-noadapt</span><br><span>   **DEPRECATED** This option does not hav=
e any effect anymore since current</span><br><span>diff --git a/src/openvpn=
/comp.h b/src/openvpn/comp.h</span><br><span>index ed6a563..1bc4648 100644<=
/span><br><span>--- a/src/openvpn/comp.h</span><br><span>+++ b/src/openvpn/=
comp.h</span><br><span>@@ -49,6 +49,7 @@</span><br><span> #define COMP_ALG_=
LZO    2 /* LZO algorithm */</span><br><span> #define COMP_ALG_SNAPPY 3 /* =
Snappy algorithm (no longer supported) */</span><br><span> #define COMP_ALG=
_LZ4    4 /* LZ4 algorithm */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define COMP_ALG_LZO_NO 5 /* --comp-lzo no which is similar to CO=
MP_ALG_STUB, but no SWAP */</span><br><span> </span><br><span> </span><br><=
span> /* algorithm v2 */</span><br><span>diff --git a/src/openvpn/options.c=
 b/src/openvpn/options.c</span><br><span>index 4fee671..f8688d4 100644</spa=
n><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/o=
ptions.c</span><br><span>@@ -3448,6 +3448,24 @@</span><br><span>     }</spa=
n><br><span> #endif /* ifdef _WIN32 */</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (options-&gt;mode =3D=3D MODE_S=
ERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        /*</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+         * Enable comp migrate autom=
atically on server</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
        */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (options-&gt;comp.alg =3D=3D COMP_ALG_LZO || options-&gt;comp.alg =3D=3D =
COMP_ALG_LZO_NO)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
sg(M_INFO, &quot;DEPRECATED OPTION: LZO compression enabled on the server s=
ide. &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        &quot;We will enable --compress migrate instead.&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;comp.a=
lg =3D COMP_ALG_UNDEF;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            options-&gt;comp.flags =3D COMP_F_MIGRATE;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    else if (options-&gt;comp.alg =3D=3D COMP_ALG_LZO_NO)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        options-&gt;comp.alg =3D COMP=
_ALG_STUB;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifde=
f DEFAULT_PKCS11_MODULE</span><br><span>     /* If p11-kit is present on th=
e system then load its p11-kit-proxy.so</span><br><span>      * by default =
if the user asks for PKCS#11 without otherwise specifying</span><br><span>@=
@ -8456,7 +8474,7 @@</span><br><span>         {</span><br><span>           =
  if (streq(p[1], &quot;no&quot;))</span><br><span>             {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                options-&gt;com=
p.alg =3D COMP_ALG_STUB;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                options-&gt;comp.alg =3D COMP_ALG_LZO_NO;</span><br><s=
pan>             }</span><br><span>             /* There is no actual diffe=
rence anymore between these variants.</span><br><span>              * We ne=
ver compress. On the server side we replace this with</span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/756?usp=3Demail">change 756</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</=
a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div item=
scope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/756?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I00209b880cfcedd93e28f97fc39=
41d8b85e095f3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 756 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--20t0wE609dU=--

