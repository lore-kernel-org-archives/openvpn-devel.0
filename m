From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Sat, 21 Feb 2026 12:07:53 +0000
References: <gerrit.1771675669000.Iff9f6811fdf553f59f2afee0072d7bf90133d328@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <24897e8a9c2a93f7060d520135d1d5446d440350-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="h/ILRtKMS24="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Try to emphasise the
 difference between new ovpn and old ovpn-dco
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--h/ILRtKMS24=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/1550?usp=3Demail )


Change subject: Try to emphasise the difference between new ovpn and old ov=
pn-dco
......................................................................

Try to emphasise the difference between new ovpn and old ovpn-dco

This tries to ensure that the difference between the old and new module
is clearer.

Also removed a duplicate section about --disable-dco from the manual page.

Change-Id: Iff9f6811fdf553f59f2afee0072d7bf90133d328
---
M Changes.rst
M configure.ac
M doc/man-sections/advanced-options.rst
M doc/man-sections/generic-options.rst
M src/openvpn/dco.c
M src/openvpn/dco_linux.c
6 files changed, 15 insertions(+), 18 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/50/1550/1

diff --git a/Changes.rst b/Changes.rst
index 36af4e7..9c80ee8 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -55,10 +55,11 @@

 Support for new version of Linux DCO module
     OpenVPN DCO module is moving upstream and being merged into the
-    main Linux kernel. For this process some API changes were required.
+    main Linux kernel in 6.16. For this process some API changes were requ=
ired.
     OpenVPN 2.7 will only support the new API. The new module is called
-    ``ovpn``. Out-of-tree builds for older kernels are available. Please
-    see the release announcements for futher information.
+    ``ovpn``. Out-of-tree builds for older kernels are available from
+    https://github.com/OpenVPN/ovpn-backports. Please
+    see the release announcements for further information.

 Support for server mode in win-dco driver
     On Windows the win-dco driver can now be used in server setups.
diff --git a/configure.ac b/configure.ac
index e151816..57f1bd6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -731,7 +731,7 @@
 				OPTIONAL_LIBNL_GENL_LIBS=3D"${LIBNL_GENL_LIBS}"

 				AC_DEFINE(ENABLE_DCO, 1, [Enable shared data channel offload])
-				AC_MSG_NOTICE([Enabled ovpn-dco support for Linux])
+				AC_MSG_NOTICE([Enabled ovpn-dco (via ovpn kernel module) support for L=
inux])
 			fi
 			;;
 		*-*-freebsd*)
diff --git a/doc/man-sections/advanced-options.rst b/doc/man-sections/advan=
ced-options.rst
index e1115e4..e50c578 100644
--- a/doc/man-sections/advanced-options.rst
+++ b/doc/man-sections/advanced-options.rst
@@ -102,7 +102,9 @@

   Data channel offload currently requires data-ciphers to only contain
   AEAD ciphers (AES-GCM and Chacha20-Poly1305) and Linux with the
-  ovpn-dco module.
+  ovpn module. The ovpn module is integrated into the Linux kernel
+  since 6.16 or available as backport from
+  https://github.com/OpenVPN/ovpn-backports.

   Note that some options have no effect or cannot be used when DCO mode
   is enabled.
diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generi=
c-options.rst
index f46dfec..81e375d 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -178,15 +178,6 @@
   on console) and ``--auth-nocache`` will fail as soon as key
   renegotiation (and reauthentication) occurs.

---disable-dco
-  Disable "data channel offload" (DCO).
-
-  On Linux don't use the ovpn-dco device driver, but rather rely on the
-  legacy tun module.
-
-  You may want to use this option if your server needs to allow clients
-  older than version 2.4 to connect.
-
 --disable-occ
   **DEPRECATED** Disable "options consistency check" (OCC) in configuratio=
ns
   that do not use TLS.
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 26b8645..a696d7a 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -376,9 +376,10 @@
          * don't need to have the net_ctx percolate all the way here
          */
         int ret =3D net_iface_type(NULL, o->dev, iftype);
-        if ((ret =3D=3D 0) && (strcmp(iftype, "ovpn-dco") !=3D 0))
+        if ((ret =3D=3D 0) && (strcmp(iftype, "ovpn") !=3D 0))
         {
-            msg(msglevel, "Interface %s exists and is non-DCO. Disabling d=
ata channel offload",
+            msg(msglevel, "Interface %s exists and its not using "
+                          "ovpn DCO driver. Disabling data channel offload=
",
                 o->dev);
             return false;
         }
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 3ad8b90..96ce643 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -159,7 +159,7 @@
             break;

         case -NLE_OBJ_NOTFOUND:
-            msg(M_INFO, "%s: netlink reports object not found, ovpn-dco un=
loaded?", prefix);
+            msg(M_INFO, "%s: netlink reports object not found, ovpn kernel=
 module unloaded?", prefix);
             break;

         default:
@@ -1239,7 +1239,9 @@
 {
     if (resolve_ovpn_netlink_id(D_DCO_DEBUG) < 0)
     {
-        msg(msglevel, "Note: Kernel support for ovpn-dco missing, disablin=
g data channel offload.");
+        msg(msglevel, "Note: Kernel support for ovpn missing, disabling da=
ta "
+                      "channel offload. Use a 6.16.0 kernel with ovpn or u=
se"
+                      "ovpn-backports to enable data channel offload.");
         return false;
     }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1550?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iff9f6811fdf553f59f2afee0072d7bf90133d328
Gerrit-Change-Number: 1550
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--h/ILRtKMS24=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>.</p><p><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1550?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Try to emphasise the difference between new ovpn and old ovpn-dco<br><b=
r>This tries to ensure that the difference between the old and new module<b=
r>is clearer.<br><br>Also removed a duplicate section about --disable-dco f=
rom the manual page.<br><br>Change-Id: Iff9f6811fdf553f59f2afee0072d7bf9013=
3d328<br>---<br>M Changes.rst<br>M configure.ac<br>M doc/man-sections/advan=
ced-options.rst<br>M doc/man-sections/generic-options.rst<br>M src/openvpn/=
dco.c<br>M src/openvpn/dco_linux.c<br>6 files changed, 15 insertions(+), 18=
 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/50/1550/1</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/Changes.rst b/Cha=
nges.rst</span><br><span>index 36af4e7..9c80ee8 100644</span><br><span>--- =
a/Changes.rst</span><br><span>+++ b/Changes.rst</span><br><span>@@ -55,10 +=
55,11 @@</span><br><span> </span><br><span> Support for new version of Linu=
x DCO module</span><br><span>     OpenVPN DCO module is moving upstream and=
 being merged into the</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    main Linux kernel. For this process some API changes were required.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    main Linux kernel =
in 6.16. For this process some API changes were required.</span><br><span> =
    OpenVPN 2.7 will only support the new API. The new module is called</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    ``ovpn``. Out-of-tree=
 builds for older kernels are available. Please</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    see the release announcements for futher info=
rmation.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ``ovpn`=
`. Out-of-tree builds for older kernels are available from</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    https://github.com/OpenVPN/ovpn-=
backports. Please</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  see the release announcements for further information.</span><br><span> <=
/span><br><span> Support for server mode in win-dco driver</span><br><span>=
     On Windows the win-dco driver can now be used in server setups.</span>=
<br><span>diff --git a/configure.ac b/configure.ac</span><br><span>index e1=
51816..57f1bd6 100644</span><br><span>--- a/configure.ac</span><br><span>++=
+ b/configure.ac</span><br><span>@@ -731,7 +731,7 @@</span><br><span> 				O=
PTIONAL_LIBNL_GENL_LIBS=3D&quot;${LIBNL_GENL_LIBS}&quot;</span><br><span> <=
/span><br><span> 				AC_DEFINE(ENABLE_DCO, 1, [Enable shared data channel o=
ffload])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-				AC_MSG_NO=
TICE([Enabled ovpn-dco support for Linux])</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+				AC_MSG_NOTICE([Enabled ovpn-dco (via ovpn kernel=
 module) support for Linux])</span><br><span> 			fi</span><br><span> 			;;<=
/span><br><span> 		*-*-freebsd*)</span><br><span>diff --git a/doc/man-secti=
ons/advanced-options.rst b/doc/man-sections/advanced-options.rst</span><br>=
<span>index e1115e4..e50c578 100644</span><br><span>--- a/doc/man-sections/=
advanced-options.rst</span><br><span>+++ b/doc/man-sections/advanced-option=
s.rst</span><br><span>@@ -102,7 +102,9 @@</span><br><span> </span><br><span=
>   Data channel offload currently requires data-ciphers to only contain</s=
pan><br><span>   AEAD ciphers (AES-GCM and Chacha20-Poly1305) and Linux wit=
h the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ovpn-dco modul=
e.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ovpn module. Th=
e ovpn module is integrated into the Linux kernel</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  since 6.16 or available as backport from</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  https://github.com/O=
penVPN/ovpn-backports.</span><br><span> </span><br><span>   Note that some =
options have no effect or cannot be used when DCO mode</span><br><span>   i=
s enabled.</span><br><span>diff --git a/doc/man-sections/generic-options.rs=
t b/doc/man-sections/generic-options.rst</span><br><span>index f46dfec..81e=
375d 100644</span><br><span>--- a/doc/man-sections/generic-options.rst</spa=
n><br><span>+++ b/doc/man-sections/generic-options.rst</span><br><span>@@ -=
178,15 +178,6 @@</span><br><span>   on console) and ``--auth-nocache`` will=
 fail as soon as key</span><br><span>   renegotiation (and reauthentication=
) occurs.</span><br><span> </span><br><span>---disable-dco</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  Disable &quot;data channel offload&q=
uot; (DCO).</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-  On Linux don&#39;t use the ov=
pn-dco device driver, but rather rely on the</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  legacy tun module.</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  You may want to use this option if your server needs to allow clients</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-  older than version 2.4=
 to connect.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span> --disable-occ</span><br><span>   **DEPRECATED** Disable &quot;opti=
ons consistency check&quot; (OCC) in configurations</span><br><span>   that=
 do not use TLS.</span><br><span>diff --git a/src/openvpn/dco.c b/src/openv=
pn/dco.c</span><br><span>index 26b8645..a696d7a 100644</span><br><span>--- =
a/src/openvpn/dco.c</span><br><span>+++ b/src/openvpn/dco.c</span><br><span=
>@@ -376,9 +376,10 @@</span><br><span>          * don&#39;t need to have th=
e net_ctx percolate all the way here</span><br><span>          */</span><br=
><span>         int ret =3D net_iface_type(NULL, o-&gt;dev, iftype);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if ((ret =3D=3D 0) &=
amp;&amp; (strcmp(iftype, &quot;ovpn-dco&quot;) !=3D 0))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if ((ret =3D=3D 0) &amp;&amp; =
(strcmp(iftype, &quot;ovpn&quot;) !=3D 0))</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(msglevel, &=
quot;Interface %s exists and is non-DCO. Disabling data channel offload&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(=
msglevel, &quot;Interface %s exists and its not using &quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                          &quot;ov=
pn DCO driver. Disabling data channel offload&quot;,</span><br><span>      =
           o-&gt;dev);</span><br><span>             return false;</span><br=
><span>         }</span><br><span>diff --git a/src/openvpn/dco_linux.c b/sr=
c/openvpn/dco_linux.c</span><br><span>index 3ad8b90..96ce643 100644</span><=
br><span>--- a/src/openvpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dc=
o_linux.c</span><br><span>@@ -159,7 +159,7 @@</span><br><span>             =
break;</span><br><span> </span><br><span>         case -NLE_OBJ_NOTFOUND:</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_INFO,=
 &quot;%s: netlink reports object not found, ovpn-dco unloaded?&quot;, pref=
ix);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg=
(M_INFO, &quot;%s: netlink reports object not found, ovpn kernel module unl=
oaded?&quot;, prefix);</span><br><span>             break;</span><br><span>=
 </span><br><span>         default:</span><br><span>@@ -1239,7 +1239,9 @@</=
span><br><span> {</span><br><span>     if (resolve_ovpn_netlink_id(D_DCO_DE=
BUG) &lt; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        msg(msglevel, &quot;Note: Kernel support for ovpn-dco=
 missing, disabling data channel offload.&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;Note: Kernel supp=
ort for ovpn missing, disabling data &quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                      &quot;channel offload. Use a =
6.16.0 kernel with ovpn or use&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                      &quot;ovpn-backports to enable data =
channel offload.&quot;);</span><br><span>         return false;</span><br><=
span>     }</span><br><span> </span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1550?usp=3Demail">ch=
ange 1550</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1550?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iff9f6811fdf553f59f2afee0072=
d7bf90133d328 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1550 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--h/ILRtKMS24=--

