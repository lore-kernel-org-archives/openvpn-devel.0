From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 9 Dec 2025 13:43:13 +0000
References: <gerrit.1765287788000.I78c6f335c635e97bb41d26ed8908a978d7b49387@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <984f05b6ca3b4cb7a42af09cbd8f1851b1f4f581-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xrlldHm0QeU="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xrlldHm0QeU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1426?usp=3Demail

to review the following change.


Change subject: Remove some obsolete references to --windows-driver
......................................................................

Remove some obsolete references to --windows-driver

The option doesn't exist anymore so don't point
people to it.

But add it to the list of unsupported options.

Change-Id: I78c6f335c635e97bb41d26ed8908a978d7b49387
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M doc/man-sections/unsupported-options.rst
M doc/man-sections/vpn-network-options.rst
M src/openvpn/options.c
M src/openvpn/tun.c
4 files changed, 8 insertions(+), 12 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/26/1426/1

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
=20
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
index 7c61dcf..a7c5ebb 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -6061,7 +6061,7 @@
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I78c6f335c635e97bb41d26ed8908a978d7b49387
Gerrit-Change-Number: 1426
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--xrlldHm0QeU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1426?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Remove some obsolete references to --window=
s-driver<br><br>The option doesn&#39;t exist anymore so don&#39;t point<br>=
people to it.<br><br>But add it to the list of unsupported options.<br><br>=
Change-Id: I78c6f335c635e97bb41d26ed8908a978d7b49387<br>Signed-off-by: Fran=
k Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M doc/man-sections/unsuppo=
rted-options.rst<br>M doc/man-sections/vpn-network-options.rst<br>M src/ope=
nvpn/options.c<br>M src/openvpn/tun.c<br>4 files changed, 8 insertions(+), =
12 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.ne=
t:29418/openvpn refs/changes/26/1426/1</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-section=
s/unsupported-options.rst b/doc/man-sections/unsupported-options.rst</span>=
<br><span>index e8e76eb..821ac07 100644</span><br><span>--- a/doc/man-secti=
ons/unsupported-options.rst</span><br><span>+++ b/doc/man-sections/unsuppor=
ted-options.rst</span><br><span>@@ -49,3 +49,8 @@</span><br><span> --opt-ve=
rify</span><br><span>   Removed in OpenVPN 2.7.  This option does not make =
sense anymore as option</span><br><span>   strings may not match due to the=
 introduction of parameters negotiation.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+--windows-driver</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 Removed in OpenVPN 2.7. OpenVPN will always use ovpn-dco as the default</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  driver on Windows. I=
t will fall back to tap-windows6 if options are used</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  that are incompatible with ovpn-dco.</s=
pan><br><span>diff --git a/doc/man-sections/vpn-network-options.rst b/doc/m=
an-sections/vpn-network-options.rst</span><br><span>index 2a06ef6..33ebedb =
100644</span><br><span>--- a/doc/man-sections/vpn-network-options.rst</span=
><br><span>+++ b/doc/man-sections/vpn-network-options.rst</span><br><span>@=
@ -89,7 +89,7 @@</span><br><span> </span><br><span>   On Windows, only the =
names :code:`tun` and :code:`tap` are supported.</span><br><span>   Selecti=
on among multiple installed drivers or driver instances is done</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  with ``--dev-node`` and ``--win=
dows-driver``.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  wit=
h ``--dev-node``.</span><br><span> </span><br><span> --dev-node node</span>=
<br><span>   This is a highly system dependent option to influence tun/tap =
driver</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/opt=
ions.c</span><br><span>index a3fc19d..1be105b 100644</span><br><span>--- a/=
src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br=
><span>@@ -3905,16 +3905,7 @@</span><br><span>     }</span><br><span>     e=
lse</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (o-&gt;windows_driver =3D=3D DRIVER_DCO)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            msg(M_WARN,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                &quot;Option --windows-driver ovpn=
-dco is ignored because Data Channel Offload is disabled&quot;);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            o-&gt;windows_driver=
 =3D WINDOWS_DRIVER_TAP_WINDOWS6;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        else if (o-&gt;windows_driver =3D=3D WINDOWS_DRIVER_UNSPECIFIED)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            o-&gt;windows_driver =3D=
 WINDOWS_DRIVER_TAP_WINDOWS6;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      o-&gt;windows_driver =3D WINDOWS_DRIVER_TAP_WINDOWS6;</span><br><span=
>     }</span><br><span> #else  /* _WIN32 */</span><br><span>     if (dco_e=
nabled(o) &amp;&amp; o-&gt;dev_node)</span><br><span>diff --git a/src/openv=
pn/tun.c b/src/openvpn/tun.c</span><br><span>index 7c61dcf..a7c5ebb 100644<=
/span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn/t=
un.c</span><br><span>@@ -6061,7 +6061,7 @@</span><br><span>         if (tt-=
&gt;backend_driver !=3D windows_driver)</span><br><span>         {</span><b=
r><span>             msg(M_FATAL,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                &quot;Adapter &#39;%s&#39; is using %s driver, =
%s expected. If you want to use this device, adjust --windows-driver.&quot;=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                &q=
uot;Adapter &#39;%s&#39; is using %s driver, %s expected.&quot;,</span><br>=
<span>                 dev_node, print_tun_backend_driver(windows_driver),<=
/span><br><span>                 print_tun_backend_driver(tt-&gt;backend_dr=
iver));</span><br><span>         }</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1426?usp=3Demai=
l">change 1426</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1426?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I78c6f335c635e97bb41d26ed890=
8a978d7b49387 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1426 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--xrlldHm0QeU=--

