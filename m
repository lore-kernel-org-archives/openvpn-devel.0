From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Sun, 22 Feb 2026 01:05:12 +0000
In-Reply-To: <gerrit.1771675669000.Iff9f6811fdf553f59f2afee0072d7bf90133d328@...2715...>
References: <gerrit.1771675669000.Iff9f6811fdf553f59f2afee0072d7bf90133d328@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <01dffaaa907ae0380ae2d12aee3695bbf5f41391-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PtNxGnXgbXg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Try to emphasise the
 transition from old ovpn-dco to new ovpn module
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--PtNxGnXgbXg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#2). ( http://gerrit.openvpn.net/c/=
openvpn/+/1550?usp=3Demail )


Change subject: Try to emphasise the transition from old ovpn-dco to new ov=
pn module
......................................................................

Try to emphasise the transition from old ovpn-dco to new ovpn module

This tries to ensure that the difference between the old and new module
is clearer.

Also removed a duplicate section about --disable-dco from the manual page.

This also changes one instance of ovpn-dco to ovpn that is probably a bug
when reusing a tun device.

Change-Id: Iff9f6811fdf553f59f2afee0072d7bf90133d328
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M Changes.rst
M configure.ac
M doc/man-sections/advanced-options.rst
M doc/man-sections/generic-options.rst
M src/openvpn/dco.c
M src/openvpn/dco_linux.c
6 files changed, 15 insertions(+), 18 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/50/1550/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iff9f6811fdf553f59f2afee0072d7bf90133d328
Gerrit-Change-Number: 1550
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--PtNxGnXgbXg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #2</strong> to this change.</p><p><a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1550?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Try to emphasise the transition from old ovpn-dco to new ovpn module<br=
><br>This tries to ensure that the difference between the old and new modul=
e<br>is clearer.<br><br>Also removed a duplicate section about --disable-dc=
o from the manual page.<br><br>This also changes one instance of ovpn-dco t=
o ovpn that is probably a bug<br>when reusing a tun device.<br><br>Change-I=
d: Iff9f6811fdf553f59f2afee0072d7bf90133d328<br>Signed-off-by: Arne Schwabe=
 &lt;arne@...1227...&gt;<br>---<br>M Changes.rst<br>M configure.ac<br>M doc=
/man-sections/advanced-options.rst<br>M doc/man-sections/generic-options.rs=
t<br>M src/openvpn/dco.c<br>M src/openvpn/dco_linux.c<br>6 files changed, 1=
5 insertions(+), 18 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/50/1550/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/Changes.rst b/Changes.rst</span><br><span>index 36af4e7..9c80ee8 1006=
44</span><br><span>--- a/Changes.rst</span><br><span>+++ b/Changes.rst</spa=
n><br><span>@@ -55,10 +55,11 @@</span><br><span> </span><br><span> Support =
for new version of Linux DCO module</span><br><span>     OpenVPN DCO module=
 is moving upstream and being merged into the</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    main Linux kernel. For this process some API ch=
anges were required.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    main Linux kernel in 6.16. For this process some API changes were requ=
ired.</span><br><span>     OpenVPN 2.7 will only support the new API. The n=
ew module is called</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  ``ovpn``. Out-of-tree builds for older kernels are available. Please</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    see the release announ=
cements for futher information.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    ``ovpn``. Out-of-tree builds for older kernels are availabl=
e from</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    https://g=
ithub.com/OpenVPN/ovpn-backports. Please</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    see the release announcements for further informat=
ion.</span><br><span> </span><br><span> Support for server mode in win-dco =
driver</span><br><span>     On Windows the win-dco driver can now be used i=
n server setups.</span><br><span>diff --git a/configure.ac b/configure.ac</=
span><br><span>index e151816..57f1bd6 100644</span><br><span>--- a/configur=
e.ac</span><br><span>+++ b/configure.ac</span><br><span>@@ -731,7 +731,7 @@=
</span><br><span> 				OPTIONAL_LIBNL_GENL_LIBS=3D&quot;${LIBNL_GENL_LIBS}&q=
uot;</span><br><span> </span><br><span> 				AC_DEFINE(ENABLE_DCO, 1, [Enabl=
e shared data channel offload])</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-				AC_MSG_NOTICE([Enabled ovpn-dco support for Linux])</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+				AC_MSG_NOTICE([Enabled ov=
pn-dco (via ovpn kernel module) support for Linux])</span><br><span> 			fi<=
/span><br><span> 			;;</span><br><span> 		*-*-freebsd*)</span><br><span>dif=
f --git a/doc/man-sections/advanced-options.rst b/doc/man-sections/advanced=
-options.rst</span><br><span>index e1115e4..e50c578 100644</span><br><span>=
--- a/doc/man-sections/advanced-options.rst</span><br><span>+++ b/doc/man-s=
ections/advanced-options.rst</span><br><span>@@ -102,7 +102,9 @@</span><br>=
<span> </span><br><span>   Data channel offload currently requires data-cip=
hers to only contain</span><br><span>   AEAD ciphers (AES-GCM and Chacha20-=
Poly1305) and Linux with the</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-  ovpn-dco module.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  ovpn module. The ovpn module is integrated into the Linux kernel</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  since 6.16 or availa=
ble as backport from</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  https://github.com/OpenVPN/ovpn-backports.</span><br><span> </span><br><=
span>   Note that some options have no effect or cannot be used when DCO mo=
de</span><br><span>   is enabled.</span><br><span>diff --git a/doc/man-sect=
ions/generic-options.rst b/doc/man-sections/generic-options.rst</span><br><=
span>index f46dfec..81e375d 100644</span><br><span>--- a/doc/man-sections/g=
eneric-options.rst</span><br><span>+++ b/doc/man-sections/generic-options.r=
st</span><br><span>@@ -178,15 +178,6 @@</span><br><span>   on console) and =
``--auth-nocache`` will fail as soon as key</span><br><span>   renegotiatio=
n (and reauthentication) occurs.</span><br><span> </span><br><span>---disab=
le-dco</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Disable &quot=
;data channel offload&quot; (DCO).</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  On Lin=
ux don&#39;t use the ovpn-dco device driver, but rather rely on the</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  legacy tun module.</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  You may want to use this option if your server ne=
eds to allow clients</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 older than version 2.4 to connect.</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span> --disable-occ</span><br><span>   **DEPRECAT=
ED** Disable &quot;options consistency check&quot; (OCC) in configurations<=
/span><br><span>   that do not use TLS.</span><br><span>diff --git a/src/op=
envpn/dco.c b/src/openvpn/dco.c</span><br><span>index 26b8645..a696d7a 1006=
44</span><br><span>--- a/src/openvpn/dco.c</span><br><span>+++ b/src/openvp=
n/dco.c</span><br><span>@@ -376,9 +376,10 @@</span><br><span>          * do=
n&#39;t need to have the net_ctx percolate all the way here</span><br><span=
>          */</span><br><span>         int ret =3D net_iface_type(NULL, o-&=
gt;dev, iftype);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if ((ret =3D=3D 0) &amp;&amp; (strcmp(iftype, &quot;ovpn-dco&quot;) !=3D=
 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if ((re=
t =3D=3D 0) &amp;&amp; (strcmp(iftype, &quot;ovpn&quot;) !=3D 0))</span><br=
><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        msg(msglevel, &quot;Interface %s exists and is non-DCO. Disabling d=
ata channel offload&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            msg(msglevel, &quot;Interface %s exists and its not usin=
g &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
               &quot;ovpn DCO driver. Disabling data channel offload&quot;,=
</span><br><span>                 o-&gt;dev);</span><br><span>             =
return false;</span><br><span>         }</span><br><span>diff --git a/src/o=
penvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br><span>index 3ad8b90.=
.96ce643 100644</span><br><span>--- a/src/openvpn/dco_linux.c</span><br><sp=
an>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -159,7 +159,7 @@</span>=
<br><span>             break;</span><br><span> </span><br><span>         ca=
se -NLE_OBJ_NOTFOUND:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            msg(M_INFO, &quot;%s: netlink reports object not found, ovpn-dc=
o unloaded?&quot;, prefix);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            msg(M_INFO, &quot;%s: netlink reports object not found,=
 ovpn kernel module unloaded?&quot;, prefix);</span><br><span>             =
break;</span><br><span> </span><br><span>         default:</span><br><span>=
@@ -1239,7 +1239,9 @@</span><br><span> {</span><br><span>     if (resolve_o=
vpn_netlink_id(D_DCO_DEBUG) &lt; 0)</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        msg(msglevel, &quot;Note: Kern=
el support for ovpn-dco missing, disabling data channel offload.&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel, =
&quot;Note: Kernel support for ovpn missing, disabling data &quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                      &quot;=
channel offload. Use a 6.16.0 kernel with ovpn or use&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                      &quot;ovpn-ba=
ckports to enable data channel offload.&quot;);</span><br><span>         re=
turn false;</span><br><span>     }</span><br><span> </span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1550?usp=3Demail">change 1550</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demai=
l">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1550?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iff9f6811fdf553f59f2afee0072=
d7bf90133d328 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1550 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--PtNxGnXgbXg=--

