From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 10 Dec 2025 08:47:31 +0000
In-Reply-To: <gerrit.1765287788000.I78c6f335c635e97bb41d26ed8908a978d7b49387@...2715...>
References: <gerrit.1765287788000.I78c6f335c635e97bb41d26ed8908a978d7b49387@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <aad376029df59b99ec542762c6da68e6fda67929-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Cvcmdy6bbZY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Remove some obsolete
 references to --windows-driver
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Cvcmdy6bbZY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
26?usp=3Demail )

Change subject: Remove some obsolete references to --windows-driver
......................................................................

Remove some obsolete references to --windows-driver

The option doesn't exist anymore so don't point
people to it.

But add it to the list of unsupported options.

Change-Id: I78c6f335c635e97bb41d26ed8908a978d7b49387
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1426
Message-Id: <20251210074904.27067-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
970.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/unsupported-options.rst
M doc/man-sections/vpn-network-options.rst
M src/openvpn/options.c
M src/openvpn/tun.c
4 files changed, 8 insertions(+), 12 deletions(-)




diff --git a/doc/man-sections/unsupported-options.rst b/doc/man-sections/un=
supported-options.rst
index e8e76eb..821ac07 100644
--- a/doc/man-sections/unsupported-options.rst
+++ b/doc/man-sections/unsupported-options.rst
@@ -49,3 +49,8 @@
 --opt-verify
   Removed in OpenVPN 2.7.  This option does not make sense anymore as opti=
on
   strings may not match due to the introduction of parameters negotiation.
+
+--windows-driver
+  Removed in OpenVPN 2.7. OpenVPN will always use ovpn-dco as the default
+  driver on Windows. It will fall back to tap-windows6 if options are used
+  that are incompatible with ovpn-dco.
diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vp=
n-network-options.rst
index 2a06ef6..33ebedb 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -89,7 +89,7 @@

   On Windows, only the names :code:`tun` and :code:`tap` are supported.
   Selection among multiple installed drivers or driver instances is done
-  with ``--dev-node`` and ``--windows-driver``.
+  with ``--dev-node``.

 --dev-node node
   This is a highly system dependent option to influence tun/tap driver
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index a3fc19d..1be105b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3905,16 +3905,7 @@
     }
     else
     {
-        if (o->windows_driver =3D=3D DRIVER_DCO)
-        {
-            msg(M_WARN,
-                "Option --windows-driver ovpn-dco is ignored because Data =
Channel Offload is disabled");
-            o->windows_driver =3D WINDOWS_DRIVER_TAP_WINDOWS6;
-        }
-        else if (o->windows_driver =3D=3D WINDOWS_DRIVER_UNSPECIFIED)
-        {
-            o->windows_driver =3D WINDOWS_DRIVER_TAP_WINDOWS6;
-        }
+        o->windows_driver =3D WINDOWS_DRIVER_TAP_WINDOWS6;
     }
 #else  /* _WIN32 */
     if (dco_enabled(o) && o->dev_node)
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 0299285..7236033 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5826,7 +5826,7 @@
         if (tt->backend_driver !=3D windows_driver)
         {
             msg(M_FATAL,
-                "Adapter '%s' is using %s driver, %s expected. If you want=
 to use this device, adjust --windows-driver.",
+                "Adapter '%s' is using %s driver, %s expected.",
                 dev_node, print_tun_backend_driver(windows_driver),
                 print_tun_backend_driver(tt->backend_driver));
         }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1426?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I78c6f335c635e97bb41d26ed8908a978d7b49387
Gerrit-Change-Number: 1426
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Cvcmdy6bbZY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1426?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Remove some obsolete references to --windows-dri=
ver<br><br>The option doesn&#39;t exist anymore so don&#39;t point<br>peopl=
e to it.<br><br>But add it to the list of unsupported options.<br><br>Chang=
e-Id: I78c6f335c635e97bb41d26ed8908a978d7b49387<br>Signed-off-by: Frank Lic=
htenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1826...=
6...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1426<br>Mess=
age-Id: &lt;20251210074904.27067-1-gert@...1296...&gt;<br>URL: https://www.=
mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34970.html<br>Signe=
d-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M doc/man-sections=
/unsupported-options.rst<br>M doc/man-sections/vpn-network-options.rst<br>M=
 src/openvpn/options.c<br>M src/openvpn/tun.c<br>4 files changed, 8 inserti=
ons(+), 12 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/man-sections/unsupported-options.rst b/doc/man-sections=
/unsupported-options.rst</span><br><span>index e8e76eb..821ac07 100644</spa=
n><br><span>--- a/doc/man-sections/unsupported-options.rst</span><br><span>=
+++ b/doc/man-sections/unsupported-options.rst</span><br><span>@@ -49,3 +49=
,8 @@</span><br><span> --opt-verify</span><br><span>   Removed in OpenVPN 2=
.7.  This option does not make sense anymore as option</span><br><span>   s=
trings may not match due to the introduction of parameters negotiation.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+--windows-driver</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  Removed in OpenVPN 2.7. OpenVPN will alway=
s use ovpn-dco as the default</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  driver on Windows. It will fall back to tap-windows6 if options=
 are used</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  that are=
 incompatible with ovpn-dco.</span><br><span>diff --git a/doc/man-sections/=
vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst</span><b=
r><span>index 2a06ef6..33ebedb 100644</span><br><span>--- a/doc/man-section=
s/vpn-network-options.rst</span><br><span>+++ b/doc/man-sections/vpn-networ=
k-options.rst</span><br><span>@@ -89,7 +89,7 @@</span><br><span> </span><br=
><span>   On Windows, only the names :code:`tun` and :code:`tap` are suppor=
ted.</span><br><span>   Selection among multiple installed drivers or drive=
r instances is done</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
with ``--dev-node`` and ``--windows-driver``.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  with ``--dev-node``.</span><br><span> </span><b=
r><span> --dev-node node</span><br><span>   This is a highly system depende=
nt option to influence tun/tap driver</span><br><span>diff --git a/src/open=
vpn/options.c b/src/openvpn/options.c</span><br><span>index a3fc19d..1be105=
b 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/=
src/openvpn/options.c</span><br><span>@@ -3905,16 +3905,7 @@</span><br><spa=
n>     }</span><br><span>     else</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if (o-&gt;windows_driver =3D=3D=
 DRIVER_DCO)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WAR=
N,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                &qu=
ot;Option --windows-driver ovpn-dco is ignored because Data Channel Offload=
 is disabled&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           o-&gt;windows_driver =3D WINDOWS_DRIVER_TAP_WINDOWS6;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        else if (o-&gt;windows_driver =3D=
=3D WINDOWS_DRIVER_UNSPECIFIED)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          o-&gt;windows_driver =3D WINDOWS_DRIVER_TAP_WINDOWS6;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        o-&gt;windows_driver =3D WINDOWS_=
DRIVER_TAP_WINDOWS6;</span><br><span>     }</span><br><span> #else  /* _WIN=
32 */</span><br><span>     if (dco_enabled(o) &amp;&amp; o-&gt;dev_node)</s=
pan><br><span>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br>=
<span>index 0299285..7236033 100644</span><br><span>--- a/src/openvpn/tun.c=
</span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ -5826,7 +5826,7=
 @@</span><br><span>         if (tt-&gt;backend_driver !=3D windows_driver)=
</span><br><span>         {</span><br><span>             msg(M_FATAL,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;Adapt=
er &#39;%s&#39; is using %s driver, %s expected. If you want to use this de=
vice, adjust --windows-driver.&quot;,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                &quot;Adapter &#39;%s&#39; is using %s dr=
iver, %s expected.&quot;,</span><br><span>                 dev_node, print_=
tun_backend_driver(windows_driver),</span><br><span>                 print_=
tun_backend_driver(tt-&gt;backend_driver));</span><br><span>         }</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1426?usp=3Demail">change 1426</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1426?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I78c6f335c635e97bb41d26ed890=
8a978d7b49387 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1426 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--Cvcmdy6bbZY=--

