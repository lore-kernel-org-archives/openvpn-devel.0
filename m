From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 10 Apr 2026 14:14:45 +0000
In-Reply-To: <gerrit.1771675669000.Iff9f6811fdf553f59f2afee0072d7bf90133d328@...2715...>
References: <gerrit.1771675669000.Iff9f6811fdf553f59f2afee0072d7bf90133d328@...2715...>
Reply-To: arne-openvpn@...1227..., matthias.andree@...68...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <af1bbd82dc00f47ba19d72b058c39a47d9affdbb-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xSffYy5zUl8="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, mandree <matthias.andree@...68...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xSffYy5zUl8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos.

Hello flichtenheld, mandree, ordex,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1550?usp=3Demail

to look at the new patch set (#6).

The following approvals got outdated and were removed:
Code-Review+2 by ordex


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
6 files changed, 18 insertions(+), 20 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/50/1550/6

diff --git a/Changes.rst b/Changes.rst
index 36af4e7..1f992b2 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -54,11 +54,12 @@
     are not readable for ``NT SERVICE\OpenVPNService``.

 Support for new version of Linux DCO module
-    OpenVPN DCO module is moving upstream and being merged into the
-    main Linux kernel. For this process some API changes were required.
-    OpenVPN 2.7 will only support the new API. The new module is called
-    ``ovpn``. Out-of-tree builds for older kernels are available. Please
-    see the release announcements for futher information.
+    The OpenVPN DCO module has been merged into the Linux kernel as of
+    6.16.  This required some API changes and OpenVPN 2.7 only supports
+    the new API. The new module is called ``ovpn``. Out-of-tree builds
+    for older kernels are available from
+    https://github.com/OpenVPN/ovpn-backports. Please
+    see the release announcements for further information.

 Support for server mode in win-dco driver
     On Windows the win-dco driver can now be used in server setups.
diff --git a/configure.ac b/configure.ac
index ecef2b9..1fd44f3 100644
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
index e1115e4..ab4eb48 100644
--- a/doc/man-sections/advanced-options.rst
+++ b/doc/man-sections/advanced-options.rst
@@ -102,7 +102,9 @@

   Data channel offload currently requires data-ciphers to only contain
   AEAD ciphers (AES-GCM and Chacha20-Poly1305) and Linux with the
-  ovpn-dco module.
+  ovpn module. The ovpn module has been integrated into the Linux kernel
+  since 6.16 or is available as backport from
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
index 26b8645..f5b7081 100644
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
+            msg(msglevel, "Interface %s exists and is not using the "
+                          "ovpn DCO driver. Disabling data channel offload=
",
                 o->dev);
             return false;
         }
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index b92fa43..e7caff6 100644
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
@@ -1248,7 +1248,10 @@
 {
     if (resolve_ovpn_netlink_id(D_DCO_DEBUG) < 0)
     {
-        msg(msglevel, "Note: Kernel support for ovpn-dco missing, disablin=
g data channel offload.");
+        msg(msglevel, "Note: Kernel support for ovpn interfaces missing, "
+                      "disabling data channel offload. Use Linux 6.16.0 or=
 "
+                      "newer with ovpn support or use ovpn-backports for "
+                      "interface support.");
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
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: mandree <matthias.andree@...68...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>

--xSffYy5zUl8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, ordex, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #6</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1550?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by ordex</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Try to emphasise the transition fro=
m old ovpn-dco to new ovpn module<br><br>This tries to ensure that the diff=
erence between the old and new module<br>is clearer.<br><br>Also removed a =
duplicate section about --disable-dco from the manual page.<br><br>This als=
o changes one instance of ovpn-dco to ovpn that is probably a bug<br>when r=
eusing a tun device.<br><br>Change-Id: Iff9f6811fdf553f59f2afee0072d7bf9013=
3d328<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M Ch=
anges.rst<br>M configure.ac<br>M doc/man-sections/advanced-options.rst<br>M=
 doc/man-sections/generic-options.rst<br>M src/openvpn/dco.c<br>M src/openv=
pn/dco_linux.c<br>6 files changed, 18 insertions(+), 20 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/c=
hanges/50/1550/6</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/Changes.rst b/Changes.rst</span><br><=
span>index 36af4e7..1f992b2 100644</span><br><span>--- a/Changes.rst</span>=
<br><span>+++ b/Changes.rst</span><br><span>@@ -54,11 +54,12 @@</span><br><=
span>     are not readable for ``NT SERVICE\OpenVPNService``.</span><br><sp=
an> </span><br><span> Support for new version of Linux DCO module</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    OpenVPN DCO module is movin=
g upstream and being merged into the</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    main Linux kernel. For this process some API changes wer=
e required.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    OpenVP=
N 2.7 will only support the new API. The new module is called</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    ``ovpn``. Out-of-tree builds fo=
r older kernels are available. Please</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    see the release announcements for futher information.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    The OpenVPN DCO m=
odule has been merged into the Linux kernel as of</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    6.16.  This required some API changes and=
 OpenVPN 2.7 only supports</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    the new API. The new module is called ``ovpn``. Out-of-tree buil=
ds</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for older ker=
nels are available from</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    https://github.com/OpenVPN/ovpn-backports. Please</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    see the release announcements for=
 further information.</span><br><span> </span><br><span> Support for server=
 mode in win-dco driver</span><br><span>     On Windows the win-dco driver =
can now be used in server setups.</span><br><span>diff --git a/configure.ac=
 b/configure.ac</span><br><span>index ecef2b9..1fd44f3 100644</span><br><sp=
an>--- a/configure.ac</span><br><span>+++ b/configure.ac</span><br><span>@@=
 -731,7 +731,7 @@</span><br><span> 				OPTIONAL_LIBNL_GENL_LIBS=3D&quot;${L=
IBNL_GENL_LIBS}&quot;</span><br><span> </span><br><span> 				AC_DEFINE(ENAB=
LE_DCO, 1, [Enable shared data channel offload])</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-				AC_MSG_NOTICE([Enabled ovpn-dco support for =
Linux])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+				AC_MSG_N=
OTICE([Enabled ovpn-dco (via ovpn kernel module) support for Linux])</span>=
<br><span> 			fi</span><br><span> 			;;</span><br><span> 		*-*-freebsd*)</s=
pan><br><span>diff --git a/doc/man-sections/advanced-options.rst b/doc/man-=
sections/advanced-options.rst</span><br><span>index e1115e4..ab4eb48 100644=
</span><br><span>--- a/doc/man-sections/advanced-options.rst</span><br><spa=
n>+++ b/doc/man-sections/advanced-options.rst</span><br><span>@@ -102,7 +10=
2,9 @@</span><br><span> </span><br><span>   Data channel offload currently =
requires data-ciphers to only contain</span><br><span>   AEAD ciphers (AES-=
GCM and Chacha20-Poly1305) and Linux with the</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  ovpn-dco module.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  ovpn module. The ovpn module has been integrated i=
nto the Linux kernel</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  since 6.16 or is available as backport from</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  https://github.com/OpenVPN/ovpn-backports.</sp=
an><br><span> </span><br><span>   Note that some options have no effect or =
cannot be used when DCO mode</span><br><span>   is enabled.</span><br><span=
>diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/gener=
ic-options.rst</span><br><span>index f46dfec..81e375d 100644</span><br><spa=
n>--- a/doc/man-sections/generic-options.rst</span><br><span>+++ b/doc/man-=
sections/generic-options.rst</span><br><span>@@ -178,15 +178,6 @@</span><br=
><span>   on console) and ``--auth-nocache`` will fail as soon as key</span=
><br><span>   renegotiation (and reauthentication) occurs.</span><br><span>=
 </span><br><span>---disable-dco</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  Disable &quot;data channel offload&quot; (DCO).</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-  On Linux don&#39;t use the ovpn-dco device driver, but =
rather rely on the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  l=
egacy tun module.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  You may want to use thi=
s option if your server needs to allow clients</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-  older than version 2.4 to connect.</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> --disable-occ</sp=
an><br><span>   **DEPRECATED** Disable &quot;options consistency check&quot=
; (OCC) in configurations</span><br><span>   that do not use TLS.</span><br=
><span>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>i=
ndex 26b8645..f5b7081 100644</span><br><span>--- a/src/openvpn/dco.c</span>=
<br><span>+++ b/src/openvpn/dco.c</span><br><span>@@ -376,9 +376,10 @@</spa=
n><br><span>          * don&#39;t need to have the net_ctx percolate all th=
e way here</span><br><span>          */</span><br><span>         int ret =
=3D net_iface_type(NULL, o-&gt;dev, iftype);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if ((ret =3D=3D 0) &amp;&amp; (strcmp(iftype=
, &quot;ovpn-dco&quot;) !=3D 0))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if ((ret =3D=3D 0) &amp;&amp; (strcmp(iftype, &quot;ov=
pn&quot;) !=3D 0))</span><br><span>         {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            msg(msglevel, &quot;Interface %s exists=
 and is non-DCO. Disabling data channel offload&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;Interfac=
e %s exists and is not using the &quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                          &quot;ovpn DCO driver. Disabl=
ing data channel offload&quot;,</span><br><span>                 o-&gt;dev)=
;</span><br><span>             return false;</span><br><span>         }</sp=
an><br><span>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c=
</span><br><span>index b92fa43..e7caff6 100644</span><br><span>--- a/src/op=
envpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><br><=
span>@@ -159,7 +159,7 @@</span><br><span>             break;</span><br><spa=
n> </span><br><span>         case -NLE_OBJ_NOTFOUND:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            msg(M_INFO, &quot;%s: netlink r=
eports object not found, ovpn-dco unloaded?&quot;, prefix);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            msg(M_INFO, &quot;%s: n=
etlink reports object not found, ovpn kernel module unloaded?&quot;, prefix=
);</span><br><span>             break;</span><br><span> </span><br><span>  =
       default:</span><br><span>@@ -1248,7 +1248,10 @@</span><br><span> {</=
span><br><span>     if (resolve_ovpn_netlink_id(D_DCO_DEBUG) &lt; 0)</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   msg(msglevel, &quot;Note: Kernel support for ovpn-dco missing, disabling=
 data channel offload.&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        msg(msglevel, &quot;Note: Kernel support for ovpn interf=
aces missing, &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                      &quot;disabling data channel offload. Use Linux 6.16=
.0 or &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
               &quot;newer with ovpn support or use ovpn-backports for &quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
     &quot;interface support.&quot;);</span><br><span>         return false=
;</span><br><span>     }</span><br><span> </span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1550?us=
p=3Demail">change 1550</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1550?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iff9f6811fdf553f59f2afee0072=
d7bf90133d328 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1550 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: mandree &lt;matthias.andree@...220...=
..68...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>

</body></html>=

--xSffYy5zUl8=--

