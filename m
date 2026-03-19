From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 19 Mar 2026 14:19:11 +0000
In-Reply-To: <gerrit.1771675669000.Iff9f6811fdf553f59f2afee0072d7bf90133d328@...2715...>
References: <gerrit.1771675669000.Iff9f6811fdf553f59f2afee0072d7bf90133d328@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <ae3ad8b035384cbd31af7793fd0b526597ef0971-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="svtuJ3mNpMY="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--svtuJ3mNpMY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1550?usp=3Demail

to look at the new patch set (#4).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


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
6 files changed, 16 insertions(+), 18 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/50/1550/4

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
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>

--svtuJ3mNpMY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #4</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1550?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Try to emphasise the transit=
ion from old ovpn-dco to new ovpn module<br><br>This tries to ensure that t=
he difference between the old and new module<br>is clearer.<br><br>Also rem=
oved a duplicate section about --disable-dco from the manual page.<br><br>T=
his also changes one instance of ovpn-dco to ovpn that is probably a bug<br=
>when reusing a tun device.<br><br>Change-Id: Iff9f6811fdf553f59f2afee0072d=
7bf90133d328<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<=
br>M Changes.rst<br>M configure.ac<br>M doc/man-sections/advanced-options.r=
st<br>M doc/man-sections/generic-options.rst<br>M src/openvpn/dco.c<br>M sr=
c/openvpn/dco_linux.c<br>6 files changed, 16 insertions(+), 18 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn=
 refs/changes/50/1550/4</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/Changes.rst b/Changes.rst</spa=
n><br><span>index 36af4e7..9c80ee8 100644</span><br><span>--- a/Changes.rst=
</span><br><span>+++ b/Changes.rst</span><br><span>@@ -55,10 +55,11 @@</spa=
n><br><span> </span><br><span> Support for new version of Linux DCO module<=
/span><br><span>     OpenVPN DCO module is moving upstream and being merged=
 into the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    main Lin=
ux kernel. For this process some API changes were required.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    main Linux kernel in 6.16. For =
this process some API changes were required.</span><br><span>     OpenVPN 2=
.7 will only support the new API. The new module is called</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    ``ovpn``. Out-of-tree builds for o=
lder kernels are available. Please</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    see the release announcements for futher information.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    ``ovpn``. Out-of-tre=
e builds for older kernels are available from</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    https://github.com/OpenVPN/ovpn-backports. Pl=
ease</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    see the rel=
ease announcements for further information.</span><br><span> </span><br><sp=
an> Support for server mode in win-dco driver</span><br><span>     On Windo=
ws the win-dco driver can now be used in server setups.</span><br><span>dif=
f --git a/configure.ac b/configure.ac</span><br><span>index ecef2b9..1fd44f=
3 100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/configure=
.ac</span><br><span>@@ -731,7 +731,7 @@</span><br><span> 				OPTIONAL_LIBNL=
_GENL_LIBS=3D&quot;${LIBNL_GENL_LIBS}&quot;</span><br><span> </span><br><sp=
an> 				AC_DEFINE(ENABLE_DCO, 1, [Enable shared data channel offload])</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-				AC_MSG_NOTICE([Enabled=
 ovpn-dco support for Linux])</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+				AC_MSG_NOTICE([Enabled ovpn-dco (via ovpn kernel module) supp=
ort for Linux])</span><br><span> 			fi</span><br><span> 			;;</span><br><sp=
an> 		*-*-freebsd*)</span><br><span>diff --git a/doc/man-sections/advanced-=
options.rst b/doc/man-sections/advanced-options.rst</span><br><span>index e=
1115e4..e50c578 100644</span><br><span>--- a/doc/man-sections/advanced-opti=
ons.rst</span><br><span>+++ b/doc/man-sections/advanced-options.rst</span><=
br><span>@@ -102,7 +102,9 @@</span><br><span> </span><br><span>   Data chan=
nel offload currently requires data-ciphers to only contain</span><br><span=
>   AEAD ciphers (AES-GCM and Chacha20-Poly1305) and Linux with the</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  ovpn-dco module.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  ovpn module. The ovpn module=
 is integrated into the Linux kernel</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  since 6.16 or available as backport from</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  https://github.com/OpenVPN/ovpn-b=
ackports.</span><br><span> </span><br><span>   Note that some options have =
no effect or cannot be used when DCO mode</span><br><span>   is enabled.</s=
pan><br><span>diff --git a/doc/man-sections/generic-options.rst b/doc/man-s=
ections/generic-options.rst</span><br><span>index f46dfec..81e375d 100644</=
span><br><span>--- a/doc/man-sections/generic-options.rst</span><br><span>+=
++ b/doc/man-sections/generic-options.rst</span><br><span>@@ -178,15 +178,6=
 @@</span><br><span>   on console) and ``--auth-nocache`` will fail as soon=
 as key</span><br><span>   renegotiation (and reauthentication) occurs.</sp=
an><br><span> </span><br><span>---disable-dco</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  Disable &quot;data channel offload&quot; (DCO).</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  On Linux don&#39;t use the ovpn-dco devic=
e driver, but rather rely on the</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  legacy tun module.</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  You may w=
ant to use this option if your server needs to allow clients</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  older than version 2.4 to connect.=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> --d=
isable-occ</span><br><span>   **DEPRECATED** Disable &quot;options consiste=
ncy check&quot; (OCC) in configurations</span><br><span>   that do not use =
TLS.</span><br><span>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</sp=
an><br><span>index 26b8645..f5b7081 100644</span><br><span>--- a/src/openvp=
n/dco.c</span><br><span>+++ b/src/openvpn/dco.c</span><br><span>@@ -376,9 +=
376,10 @@</span><br><span>          * don&#39;t need to have the net_ctx pe=
rcolate all the way here</span><br><span>          */</span><br><span>     =
    int ret =3D net_iface_type(NULL, o-&gt;dev, iftype);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if ((ret =3D=3D 0) &amp;&amp; (s=
trcmp(iftype, &quot;ovpn-dco&quot;) !=3D 0))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if ((ret =3D=3D 0) &amp;&amp; (strcmp(ifty=
pe, &quot;ovpn&quot;) !=3D 0))</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            msg(msglevel, &quot;Interfa=
ce %s exists and is non-DCO. Disabling data channel offload&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &q=
uot;Interface %s exists and is not using the &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                          &quot;ovpn DCO =
driver. Disabling data channel offload&quot;,</span><br><span>             =
    o-&gt;dev);</span><br><span>             return false;</span><br><span>=
         }</span><br><span>diff --git a/src/openvpn/dco_linux.c b/src/openv=
pn/dco_linux.c</span><br><span>index b92fa43..e7caff6 100644</span><br><spa=
n>--- a/src/openvpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dco_linux=
.c</span><br><span>@@ -159,7 +159,7 @@</span><br><span>             break;<=
/span><br><span> </span><br><span>         case -NLE_OBJ_NOTFOUND:</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_INFO, &quot;=
%s: netlink reports object not found, ovpn-dco unloaded?&quot;, prefix);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_INFO=
, &quot;%s: netlink reports object not found, ovpn kernel module unloaded?&=
quot;, prefix);</span><br><span>             break;</span><br><span> </span=
><br><span>         default:</span><br><span>@@ -1248,7 +1248,10 @@</span><=
br><span> {</span><br><span>     if (resolve_ovpn_netlink_id(D_DCO_DEBUG) &=
lt; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        msg(msglevel, &quot;Note: Kernel support for ovpn-dco missi=
ng, disabling data channel offload.&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        msg(msglevel, &quot;Note: Kernel support fo=
r ovpn interfaces missing, &quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                      &quot;disabling data channel offload. U=
se Linux 6.16.0 or &quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                      &quot;newer with ovpn support or use ovpn-backp=
orts for &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                  &quot;interface support.&quot;);</span><br><span>        =
 return false;</span><br><span>     }</span><br><span> </span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1550?usp=3Demail">change 1550</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3De=
mail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1550?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iff9f6811fdf553f59f2afee0072=
d7bf90133d328 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1550 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--svtuJ3mNpMY=--

