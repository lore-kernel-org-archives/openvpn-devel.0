From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 11 Apr 2026 14:41:34 +0000
In-Reply-To: <gerrit.1771675669000.Iff9f6811fdf553f59f2afee0072d7bf90133d328@...2715...>
References: <gerrit.1771675669000.Iff9f6811fdf553f59f2afee0072d7bf90133d328@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., matthias.andree@...68...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <7f349a087e6b1f380103ab362764fd2b51e9e0b1-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uBg1X++22qA="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, mandree <matthias.andree@...68...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--uBg1X++22qA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#7) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1550?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+1 by mandree, Code-Review+2 by ordex


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
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1550
Message-Id: <20260411090625.18343-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
573.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M Changes.rst
M configure.ac
M doc/man-sections/advanced-options.rst
M doc/man-sections/generic-options.rst
M src/openvpn/dco.c
M src/openvpn/dco_linux.c
6 files changed, 18 insertions(+), 20 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/50/1550/7

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
index 73ca44a..3eff3085 100644
--- a/doc/man-sections/advanced-options.rst
+++ b/doc/man-sections/advanced-options.rst
@@ -103,7 +103,9 @@

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
index 415b81f..6815dc2 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -176,15 +176,6 @@
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
index b878428..4c896f6 100644
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
@@ -1249,7 +1249,10 @@
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
Gerrit-PatchSet: 7
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: mandree <matthias.andree@...68...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--uBg1X++22qA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #7</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1550?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+1 by mandree, Code-Review+2 by ordex</p><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">Try to em=
phasise the transition from old ovpn-dco to new ovpn module<br><br>This tri=
es to ensure that the difference between the old and new module<br>is clear=
er.<br><br>Also removed a duplicate section about --disable-dco from the ma=
nual page.<br><br>This also changes one instance of ovpn-dco to ovpn that i=
s probably a bug<br>when reusing a tun device.<br><br>Change-Id: Iff9f6811f=
df553f59f2afee0072d7bf90133d328<br>Signed-off-by: Arne Schwabe &lt;arne@...493...=
1227...&gt;<br>Acked-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>Ge=
rrit URL: https://gerrit.openvpn.net/c/openvpn/+/1550<br>Message-Id: &lt;20=
260411090625.18343-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.c=
om/openvpn-devel@lists.sourceforge.net/msg36573.html<br>Signed-off-by: Gert=
 Doering &lt;gert@...1296...&gt;<br>---<br>M Changes.rst<br>M configure.ac<=
br>M doc/man-sections/advanced-options.rst<br>M doc/man-sections/generic-op=
tions.rst<br>M src/openvpn/dco.c<br>M src/openvpn/dco_linux.c<br>6 files ch=
anged, 18 insertions(+), 20 deletions(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit.openvpn.net:29418/openvpn refs/changes/50/1550/7</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/Changes.rst b/Changes.rst</span><br><span>index 36af4e7..1f992b2 =
100644</span><br><span>--- a/Changes.rst</span><br><span>+++ b/Changes.rst<=
/span><br><span>@@ -54,11 +54,12 @@</span><br><span>     are not readable f=
or ``NT SERVICE\OpenVPNService``.</span><br><span> </span><br><span> Suppor=
t for new version of Linux DCO module</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    OpenVPN DCO module is moving upstream and being merged =
into the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    main Linu=
x kernel. For this process some API changes were required.</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    OpenVPN 2.7 will only support the =
new API. The new module is called</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    ``ovpn``. Out-of-tree builds for older kernels are availabl=
e. Please</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    see the =
release announcements for futher information.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    The OpenVPN DCO module has been merged into t=
he Linux kernel as of</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    6.16.  This required some API changes and OpenVPN 2.7 only supports</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    the new API. The =
new module is called ``ovpn``. Out-of-tree builds</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    for older kernels are available from</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    https://github.com/O=
penVPN/ovpn-backports. Please</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    see the release announcements for further information.</span>=
<br><span> </span><br><span> Support for server mode in win-dco driver</spa=
n><br><span>     On Windows the win-dco driver can now be used in server se=
tups.</span><br><span>diff --git a/configure.ac b/configure.ac</span><br><s=
pan>index ecef2b9..1fd44f3 100644</span><br><span>--- a/configure.ac</span>=
<br><span>+++ b/configure.ac</span><br><span>@@ -731,7 +731,7 @@</span><br>=
<span> 				OPTIONAL_LIBNL_GENL_LIBS=3D&quot;${LIBNL_GENL_LIBS}&quot;</span>=
<br><span> </span><br><span> 				AC_DEFINE(ENABLE_DCO, 1, [Enable shared da=
ta channel offload])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
			AC_MSG_NOTICE([Enabled ovpn-dco support for Linux])</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+				AC_MSG_NOTICE([Enabled ovpn-dco (via=
 ovpn kernel module) support for Linux])</span><br><span> 			fi</span><br><=
span> 			;;</span><br><span> 		*-*-freebsd*)</span><br><span>diff --git a/d=
oc/man-sections/advanced-options.rst b/doc/man-sections/advanced-options.rs=
t</span><br><span>index 73ca44a..3eff3085 100644</span><br><span>--- a/doc/=
man-sections/advanced-options.rst</span><br><span>+++ b/doc/man-sections/ad=
vanced-options.rst</span><br><span>@@ -103,7 +103,9 @@</span><br><span> </s=
pan><br><span>   Data channel offload currently requires data-ciphers to on=
ly contain</span><br><span>   AEAD ciphers (AES-GCM and Chacha20-Poly1305) =
and Linux with the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  o=
vpn-dco module.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ov=
pn module. The ovpn module has been integrated into the Linux kernel</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  since 6.16 or is availab=
le as backport from</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  https://github.com/OpenVPN/ovpn-backports.</span><br><span> </span><br><s=
pan>   Note that some options have no effect or cannot be used when DCO mod=
e</span><br><span>   is enabled.</span><br><span>diff --git a/doc/man-secti=
ons/generic-options.rst b/doc/man-sections/generic-options.rst</span><br><s=
pan>index 415b81f..6815dc2 100644</span><br><span>--- a/doc/man-sections/ge=
neric-options.rst</span><br><span>+++ b/doc/man-sections/generic-options.rs=
t</span><br><span>@@ -176,15 +176,6 @@</span><br><span>   on console) and `=
`--auth-nocache`` will fail as soon as key</span><br><span>   renegotiation=
 (and reauthentication) occurs.</span><br><span> </span><br><span>---disabl=
e-dco</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Disable &quot;=
data channel offload&quot; (DCO).</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  On Linu=
x don&#39;t use the ovpn-dco device driver, but rather rely on the</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  legacy tun module.</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  You may want to use this option if your server nee=
ds to allow clients</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
older than version 2.4 to connect.</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span> --disable-occ</span><br><span>   **DEPRECATE=
D** Disable &quot;options consistency check&quot; (OCC) in configurations</=
span><br><span>   that do not use TLS.</span><br><span>diff --git a/src/ope=
nvpn/dco.c b/src/openvpn/dco.c</span><br><span>index 26b8645..f5b7081 10064=
4</span><br><span>--- a/src/openvpn/dco.c</span><br><span>+++ b/src/openvpn=
/dco.c</span><br><span>@@ -376,9 +376,10 @@</span><br><span>          * don=
&#39;t need to have the net_ctx percolate all the way here</span><br><span>=
          */</span><br><span>         int ret =3D net_iface_type(NULL, o-&g=
t;dev, iftype);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  if ((ret =3D=3D 0) &amp;&amp; (strcmp(iftype, &quot;ovpn-dco&quot;) !=3D =
0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if ((ret=
 =3D=3D 0) &amp;&amp; (strcmp(iftype, &quot;ovpn&quot;) !=3D 0))</span><br>=
<span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       msg(msglevel, &quot;Interface %s exists and is non-DCO. Disabling da=
ta channel offload&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            msg(msglevel, &quot;Interface %s exists and is not using =
the &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                 &quot;ovpn DCO driver. Disabling data channel offload&quot=
;,</span><br><span>                 o-&gt;dev);</span><br><span>           =
  return false;</span><br><span>         }</span><br><span>diff --git a/src=
/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br><span>index b87842=
8..4c896f6 100644</span><br><span>--- a/src/openvpn/dco_linux.c</span><br><=
span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -159,7 +159,7 @@</spa=
n><br><span>             break;</span><br><span> </span><br><span>         =
case -NLE_OBJ_NOTFOUND:</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            msg(M_INFO, &quot;%s: netlink reports object not found, ovpn-=
dco unloaded?&quot;, prefix);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            msg(M_INFO, &quot;%s: netlink reports object not foun=
d, ovpn kernel module unloaded?&quot;, prefix);</span><br><span>           =
  break;</span><br><span> </span><br><span>         default:</span><br><spa=
n>@@ -1249,7 +1249,10 @@</span><br><span> {</span><br><span>     if (resolv=
e_ovpn_netlink_id(D_DCO_DEBUG) &lt; 0)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        msg(msglevel, &quot;Note: K=
ernel support for ovpn-dco missing, disabling data channel offload.&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(msgleve=
l, &quot;Note: Kernel support for ovpn interfaces missing, &quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                      &quot;d=
isabling data channel offload. Use Linux 6.16.0 or &quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                      &quot;newer wit=
h ovpn support or use ovpn-backports for &quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                      &quot;interface support.&=
quot;);</span><br><span>         return false;</span><br><span>     }</span=
><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1550?usp=3Demail">change 1550</a>. To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemt=
ype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" i=
temtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1550?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iff9f6811fdf553f59f2afee0072=
d7bf90133d328 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1550 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
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

</body></html>=

--uBg1X++22qA=--

