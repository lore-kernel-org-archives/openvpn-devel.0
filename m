From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 10 Dec 2025 08:50:19 +0000
In-Reply-To: <gerrit.1765287788000.I59995bf0fd6bc48a738a94e41141ed37d8d637ba@...2715...>
References: <gerrit.1765287788000.I59995bf0fd6bc48a738a94e41141ed37d8d637ba@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7b42289150b76e6c5ba6864f7154caec5001ae82-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="i+74RParOL8="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--i+74RParOL8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1427?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/1427/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I59995bf0fd6bc48a738a94e41141ed37d8d637ba
Gerrit-Change-Number: 1427
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--i+74RParOL8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1427?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">options: Remove some verbose error =
messages for options deprecated in 2.4<br><br>It has been a long time since=
 2.3. So move this from the code<br>to the documentation.<br><br>Includes s=
ome minimal drive-by fixes.<br><br>Change-Id: I59995bf0fd6bc48a738a94e41141=
ed37d8d637ba<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<b=
r>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://ger=
rit.openvpn.net/c/openvpn/+/1427<br>Message-Id: &lt;20251210075056.27185-1-=
gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1514...=
s.sourceforge.net/msg34972.html<br>Signed-off-by: Gert Doering &lt;gert@...493...=
1296...&gt;<br>---<br>M doc/man-sections/unsupported-options.rst<br>M src/o=
penvpn/options.c<br>2 files changed, 18 insertions(+), 17 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs=
/changes/27/1427/2</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/doc/man-sections/unsupported-option=
s.rst b/doc/man-sections/unsupported-options.rst</span><br><span>index 821a=
c07..6e77333 100644</span><br><span>--- a/doc/man-sections/unsupported-opti=
ons.rst</span><br><span>+++ b/doc/man-sections/unsupported-options.rst</spa=
n><br><span>@@ -6,9 +6,16 @@</span><br><span> longer supported</span><br><s=
pan> </span><br><span> --client-cert-not-required</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-  Removed in OpenVPN 2.5.  This should be repla=
xed with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Removed i=
n OpenVPN 2.5.  This should be replaced with</span><br><span>   ``--verify-=
client-cert none``.</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+--http-proxy-retry</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  Removed in OpenVPN 2.4.  All retries are controlled by `=
`--max-connect-retry``.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+--http-proxy-ti=
meout</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Removed in O=
penVPN 2.4.  Connection timeout is controlled by</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  ``--connect-timeout``.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --ifconfig-pool-linear<=
/span><br><span>   Removed in OpenVPN 2.5.  This should be replaced with ``=
--topology p2p``.</span><br><span> </span><br><span>@@ -21,6 +28,9 @@</span=
><br><span>   Removed in OpenVPN 2.6.  The built-in packet filtering (pf) f=
unctionality</span><br><span>   has been removed.</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+--max-routes</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  Removed in OpenVPN 2.4.  The lim=
it was removed.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> --ncp-disable</span><br><span>   Removed in OpenVPN 2.6.  Thi=
s option mainly served a role as debug option</span><br><span>   when NCP w=
as first introduced.  It should no longer be necessary.</span><br><span>@@ =
-50,6 +60,9 @@</span><br><span>   Removed in OpenVPN 2.7.  This option does=
 not make sense anymore as option</span><br><span>   strings may not match =
due to the introduction of parameters negotiation.</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+--socks-proxy-retry</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  Removed in OpenVPN 2.4. =
 All retries are controlled by ``--max-connect-retry``.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --windows-driver</spa=
n><br><span>   Removed in OpenVPN 2.7. OpenVPN will always use ovpn-dco as =
the default</span><br><span>   driver on Windows. It will fall back to tap-=
windows6 if options are used</span><br><span>diff --git a/src/openvpn/optio=
ns.c b/src/openvpn/options.c</span><br><span>index 1be105b..bd6dc07 100644<=
/span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openv=
pn/options.c</span><br><span>@@ -6699,19 +6699,10 @@</span><br><span>      =
   ho-&gt;auth_file_up =3D p[1];</span><br><span>         ho-&gt;inline_cre=
ds =3D is_inline;</span><br><span>     }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    else if (streq(p[0], &quot;http-proxy-retry&quot;) |=
| streq(p[0], &quot;socks-proxy-retry&quot;))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;http-proxy-retry&q=
uot;) || streq(p[0], &quot;socks-proxy-retry&quot;) || streq(p[0], &quot;ht=
tp-proxy-timeout&quot;))</span><br><span>     {</span><br><span>         VE=
RIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;DEPRECATED OPTION: h=
ttp-proxy-retry and socks-proxy-retry: &quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                    &quot;In OpenVPN 2.4 proxy conn=
ection retries are handled like regular connections. &quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                    &quot;Use connect=
-retry-max 1 to get a similar behavior as before.&quot;);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    else if (streq(p[0], &quot;http-proxy-timeout&quot;=
) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            &quot;DEPRECATED OPTION: htt=
p-proxy-timeout: In OpenVPN 2.4 the timeout until a connection to a &quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &quot;serv=
er is established is managed with a single timeout set by connect-timeout&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M=
_WARN, &quot;DEPRECATED OPTION: %s option ignored.&quot;, p[0]);</span><br>=
<span>     }</span><br><span>     else if (streq(p[0], &quot;http-proxy-opt=
ion&quot;) &amp;&amp; p[1] &amp;&amp; !p[4])</span><br><span>     {</span><=
br><span>@@ -6826,7 +6817,7 @@</span><br><span>     else if (streq(p[0], &q=
uot;persist-key&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><=
span>         VERIFY_PERMISSION(OPT_P_PERSIST);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;DEPRECATED: --persist-k=
ey option ignored. &quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        msg(M_WARN, &quot;DEPRECATED OPTION: --persist-key option ign=
ored. &quot;</span><br><span>                     &quot;Keys are now always=
 persisted across restarts. &quot;);</span><br><span>     }</span><br><span=
>     else if (streq(p[0], &quot;persist-local-ip&quot;) &amp;&amp; !p[1])<=
/span><br><span>@@ -6875,10 +6866,7 @@</span><br><span>     }</span><br><sp=
an>     else if (streq(p[0], &quot;max-routes&quot;) &amp;&amp; !p[2])</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     msg(M_WARN, &quot;DEPRECATED OPTION: --max-routes option ignored. &quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
 &quot;The number of routes is unlimited as of OpenVPN 2.4. &quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                    &quot;This=
 option will be removed in a future version, &quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    &quot;please remove it =
from your configuration.&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        msg(M_WARN, &quot;DEPRECATED OPTION: --max-routes opti=
on ignored.&quot;);</span><br><span>     }</span><br><span>     else if (st=
req(p[0], &quot;route-gateway&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</spa=
n><br><span>     {</span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1427?usp=3Demail">change 1427</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1427?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--i+74RParOL8=--

