From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 10 Dec 2025 08:50:22 +0000
In-Reply-To: <gerrit.1765287788000.I59995bf0fd6bc48a738a94e41141ed37d8d637ba@...2715...>
References: <gerrit.1765287788000.I59995bf0fd6bc48a738a94e41141ed37d8d637ba@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7b42289150b76e6c5ba6864f7154caec5001ae82-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xT2XrqTf3us="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: Remove some
 verbose error messages for options deprecated in...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xT2XrqTf3us=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
27?usp=3Demail )

Change subject: options: Remove some verbose error messages for options dep=
recated in 2.4
......................................................................

options: Remove some verbose error messages for options deprecated in 2.4

It has been a long time since 2.3. So move this from the code
to the documentation.

Includes some minimal drive-by fixes.

Change-Id: I59995bf0fd6bc48a738a94e41141ed37d8d637ba
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1427
Message-Id: <20251210075056.27185-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
972.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/unsupported-options.rst
M src/openvpn/options.c
2 files changed, 18 insertions(+), 17 deletions(-)




diff --git a/doc/man-sections/unsupported-options.rst b/doc/man-sections/un=
supported-options.rst
index 821ac07..6e77333 100644
--- a/doc/man-sections/unsupported-options.rst
+++ b/doc/man-sections/unsupported-options.rst
@@ -6,9 +6,16 @@
 longer supported

 --client-cert-not-required
-  Removed in OpenVPN 2.5.  This should be replaxed with
+  Removed in OpenVPN 2.5.  This should be replaced with
   ``--verify-client-cert none``.

+--http-proxy-retry
+  Removed in OpenVPN 2.4.  All retries are controlled by ``--max-connect-r=
etry``.
+
+--http-proxy-timeout
+  Removed in OpenVPN 2.4.  Connection timeout is controlled by
+  ``--connect-timeout``.
+
 --ifconfig-pool-linear
   Removed in OpenVPN 2.5.  This should be replaced with ``--topology p2p``.

@@ -21,6 +28,9 @@
   Removed in OpenVPN 2.6.  The built-in packet filtering (pf) functionality
   has been removed.

+--max-routes
+  Removed in OpenVPN 2.4.  The limit was removed.
+
 --ncp-disable
   Removed in OpenVPN 2.6.  This option mainly served a role as debug option
   when NCP was first introduced.  It should no longer be necessary.
@@ -50,6 +60,9 @@
   Removed in OpenVPN 2.7.  This option does not make sense anymore as opti=
on
   strings may not match due to the introduction of parameters negotiation.

+--socks-proxy-retry
+  Removed in OpenVPN 2.4.  All retries are controlled by ``--max-connect-r=
etry``.
+
 --windows-driver
   Removed in OpenVPN 2.7. OpenVPN will always use ovpn-dco as the default
   driver on Windows. It will fall back to tap-windows6 if options are used
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1be105b..bd6dc07 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6699,19 +6699,10 @@
         ho->auth_file_up =3D p[1];
         ho->inline_creds =3D is_inline;
     }
-    else if (streq(p[0], "http-proxy-retry") || streq(p[0], "socks-proxy-r=
etry"))
+    else if (streq(p[0], "http-proxy-retry") || streq(p[0], "socks-proxy-r=
etry") || streq(p[0], "http-proxy-timeout"))
     {
         VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
-        msg(M_WARN, "DEPRECATED OPTION: http-proxy-retry and socks-proxy-r=
etry: "
-                    "In OpenVPN 2.4 proxy connection retries are handled l=
ike regular connections. "
-                    "Use connect-retry-max 1 to get a similar behavior as =
before.");
-    }
-    else if (streq(p[0], "http-proxy-timeout") && p[1] && !p[2])
-    {
-        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
-        msg(M_WARN,
-            "DEPRECATED OPTION: http-proxy-timeout: In OpenVPN 2.4 the tim=
eout until a connection to a "
-            "server is established is managed with a single timeout set by=
 connect-timeout");
+        msg(M_WARN, "DEPRECATED OPTION: %s option ignored.", p[0]);
     }
     else if (streq(p[0], "http-proxy-option") && p[1] && !p[4])
     {
@@ -6826,7 +6817,7 @@
     else if (streq(p[0], "persist-key") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_PERSIST);
-        msg(M_WARN, "DEPRECATED: --persist-key option ignored. "
+        msg(M_WARN, "DEPRECATED OPTION: --persist-key option ignored. "
                     "Keys are now always persisted across restarts. ");
     }
     else if (streq(p[0], "persist-local-ip") && !p[1])
@@ -6875,10 +6866,7 @@
     }
     else if (streq(p[0], "max-routes") && !p[2])
     {
-        msg(M_WARN, "DEPRECATED OPTION: --max-routes option ignored. "
-                    "The number of routes is unlimited as of OpenVPN 2.4. "
-                    "This option will be removed in a future version, "
-                    "please remove it from your configuration.");
+        msg(M_WARN, "DEPRECATED OPTION: --max-routes option ignored.");
     }
     else if (streq(p[0], "route-gateway") && p[1] && !p[2])
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1427?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I59995bf0fd6bc48a738a94e41141ed37d8d637ba
Gerrit-Change-Number: 1427
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xT2XrqTf3us=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1427?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">options: Remove some verbose error messages for =
options deprecated in 2.4<br><br>It has been a long time since 2.3. So move=
 this from the code<br>to the documentation.<br><br>Includes some minimal d=
rive-by fixes.<br><br>Change-Id: I59995bf0fd6bc48a738a94e41141ed37d8d637ba<=
br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: G=
ert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.n=
et/c/openvpn/+/1427<br>Message-Id: &lt;20251210075056.27185-1-gert@...1725...=
..&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...282...=
.net/msg34972.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<b=
r>---<br>M doc/man-sections/unsupported-options.rst<br>M src/openvpn/option=
s.c<br>2 files changed, 18 insertions(+), 17 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/man-sections/unsupported-options.rst b/doc/man-sections=
/unsupported-options.rst</span><br><span>index 821ac07..6e77333 100644</spa=
n><br><span>--- a/doc/man-sections/unsupported-options.rst</span><br><span>=
+++ b/doc/man-sections/unsupported-options.rst</span><br><span>@@ -6,9 +6,1=
6 @@</span><br><span> longer supported</span><br><span> </span><br><span> -=
-client-cert-not-required</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-  Removed in OpenVPN 2.5.  This should be replaxed with</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  Removed in OpenVPN 2.5.  This sho=
uld be replaced with</span><br><span>   ``--verify-client-cert none``.</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+--http=
-proxy-retry</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Remov=
ed in OpenVPN 2.4.  All retries are controlled by ``--max-connect-retry``.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+--http-proxy-timeout</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  Removed in OpenVPN 2.4.  Connection =
timeout is controlled by</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  ``--connect-timeout``.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> --ifconfig-pool-linear</span><br><span>   Remov=
ed in OpenVPN 2.5.  This should be replaced with ``--topology p2p``.</span>=
<br><span> </span><br><span>@@ -21,6 +28,9 @@</span><br><span>   Removed in=
 OpenVPN 2.6.  The built-in packet filtering (pf) functionality</span><br><=
span>   has been removed.</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+--max-routes</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  Removed in OpenVPN 2.4.  The limit was removed.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --ncp-disa=
ble</span><br><span>   Removed in OpenVPN 2.6.  This option mainly served a=
 role as debug option</span><br><span>   when NCP was first introduced.  It=
 should no longer be necessary.</span><br><span>@@ -50,6 +60,9 @@</span><br=
><span>   Removed in OpenVPN 2.7.  This option does not make sense anymore =
as option</span><br><span>   strings may not match due to the introduction =
of parameters negotiation.</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+--socks-proxy-retry</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  Removed in OpenVPN 2.4.  All retries are control=
led by ``--max-connect-retry``.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> --windows-driver</span><br><span>   Removed i=
n OpenVPN 2.7. OpenVPN will always use ovpn-dco as the default</span><br><s=
pan>   driver on Windows. It will fall back to tap-windows6 if options are =
used</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/optio=
ns.c</span><br><span>index 1be105b..bd6dc07 100644</span><br><span>--- a/sr=
c/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><=
span>@@ -6699,19 +6699,10 @@</span><br><span>         ho-&gt;auth_file_up =
=3D p[1];</span><br><span>         ho-&gt;inline_creds =3D is_inline;</span=
><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
else if (streq(p[0], &quot;http-proxy-retry&quot;) || streq(p[0], &quot;soc=
ks-proxy-retry&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    else if (streq(p[0], &quot;http-proxy-retry&quot;) || streq(p[0], &q=
uot;socks-proxy-retry&quot;) || streq(p[0], &quot;http-proxy-timeout&quot;)=
)</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_G=
ENERAL | OPT_P_CONNECTION);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        msg(M_WARN, &quot;DEPRECATED OPTION: http-proxy-retry and soc=
ks-proxy-retry: &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                    &quot;In OpenVPN 2.4 proxy connection retries are hand=
led like regular connections. &quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                    &quot;Use connect-retry-max 1 to get a s=
imilar behavior as before.&quot;);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 else if (streq(p[0], &quot;http-proxy-timeout&quot;) &amp;&amp; p[1] &amp;=
&amp; !p[2])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        VERIFY_PERMISSION=
(OPT_P_GENERAL | OPT_P_CONNECTION);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        msg(M_WARN,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            &quot;DEPRECATED OPTION: http-proxy-timeout: In Ope=
nVPN 2.4 the timeout until a connection to a &quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            &quot;server is established is =
managed with a single timeout set by connect-timeout&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;DEPRECAT=
ED OPTION: %s option ignored.&quot;, p[0]);</span><br><span>     }</span><b=
r><span>     else if (streq(p[0], &quot;http-proxy-option&quot;) &amp;&amp;=
 p[1] &amp;&amp; !p[4])</span><br><span>     {</span><br><span>@@ -6826,7 +=
6817,7 @@</span><br><span>     else if (streq(p[0], &quot;persist-key&quot;=
) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>         VERIFY_=
PERMISSION(OPT_P_PERSIST);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        msg(M_WARN, &quot;DEPRECATED: --persist-key option ignored. &q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_W=
ARN, &quot;DEPRECATED OPTION: --persist-key option ignored. &quot;</span><b=
r><span>                     &quot;Keys are now always persisted across res=
tarts. &quot;);</span><br><span>     }</span><br><span>     else if (streq(=
p[0], &quot;persist-local-ip&quot;) &amp;&amp; !p[1])</span><br><span>@@ -6=
875,10 +6866,7 @@</span><br><span>     }</span><br><span>     else if (stre=
q(p[0], &quot;max-routes&quot;) &amp;&amp; !p[2])</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quo=
t;DEPRECATED OPTION: --max-routes option ignored. &quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                    &quot;The number of =
routes is unlimited as of OpenVPN 2.4. &quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                    &quot;This option will be remov=
ed in a future version, &quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                    &quot;please remove it from your configuration=
.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms=
g(M_WARN, &quot;DEPRECATED OPTION: --max-routes option ignored.&quot;);</sp=
an><br><span>     }</span><br><span>     else if (streq(p[0], &quot;route-g=
ateway&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1427?usp=3Demail">change 1427</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1427?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I59995bf0fd6bc48a738a94e4114=
1ed37d8d637ba </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1427 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--xT2XrqTf3us=--

