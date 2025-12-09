From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 9 Dec 2025 13:43:14 +0000
References: <gerrit.1765287788000.I59995bf0fd6bc48a738a94e41141ed37d8d637ba@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <96b5d05f86a606225fd67069d93663c3e3d4b5b8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ukmuWB93RAo="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ukmuWB93RAo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1427?usp=3Demail

to review the following change.


Change subject: options: Remove some verbose error messages for options dep=
recated in 2.4
......................................................................

options: Remove some verbose error messages for options deprecated in 2.4

It has been a long time since 2.3. So move this from the code
to the documentation.

Includes some minimal drive-by fixes.

Change-Id: I59995bf0fd6bc48a738a94e41141ed37d8d637ba
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M doc/man-sections/unsupported-options.rst
M src/openvpn/options.c
2 files changed, 18 insertions(+), 17 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/1427/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I59995bf0fd6bc48a738a94e41141ed37d8d637ba
Gerrit-Change-Number: 1427
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--ukmuWB93RAo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1427?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">options: Remove some verbose error messages=
 for options deprecated in 2.4<br><br>It has been a long time since 2.3. So=
 move this from the code<br>to the documentation.<br><br>Includes some mini=
mal drive-by fixes.<br><br>Change-Id: I59995bf0fd6bc48a738a94e41141ed37d8d6=
37ba<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br=
>M doc/man-sections/unsupported-options.rst<br>M src/openvpn/options.c<br>2=
 files changed, 18 insertions(+), 17 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/1427/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/doc/man-sections/unsupported-options.rst b/doc/man-sec=
tions/unsupported-options.rst</span><br><span>index 821ac07..6e77333 100644=
</span><br><span>--- a/doc/man-sections/unsupported-options.rst</span><br><=
span>+++ b/doc/man-sections/unsupported-options.rst</span><br><span>@@ -6,9=
 +6,16 @@</span><br><span> longer supported</span><br><span> </span><br><sp=
an> --client-cert-not-required</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-  Removed in OpenVPN 2.5.  This should be replaxed with</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  Removed in OpenVPN 2.5.  Thi=
s should be replaced with</span><br><span>   ``--verify-client-cert none``.=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+-=
-http-proxy-retry</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
Removed in OpenVPN 2.4.  All retries are controlled by ``--max-connect-retr=
y``.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+--http-proxy-timeout</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  Removed in OpenVPN 2.4.  Connec=
tion timeout is controlled by</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  ``--connect-timeout``.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> --ifconfig-pool-linear</span><br><span>   =
Removed in OpenVPN 2.5.  This should be replaced with ``--topology p2p``.</=
span><br><span> </span><br><span>@@ -21,6 +28,9 @@</span><br><span>   Remov=
ed in OpenVPN 2.6.  The built-in packet filtering (pf) functionality</span>=
<br><span>   has been removed.</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+--max-routes</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  Removed in OpenVPN 2.4.  The limit was removed.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --ncp=
-disable</span><br><span>   Removed in OpenVPN 2.6.  This option mainly ser=
ved a role as debug option</span><br><span>   when NCP was first introduced=
.  It should no longer be necessary.</span><br><span>@@ -50,6 +60,9 @@</spa=
n><br><span>   Removed in OpenVPN 2.7.  This option does not make sense any=
more as option</span><br><span>   strings may not match due to the introduc=
tion of parameters negotiation.</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+--socks-proxy-retry</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  Removed in OpenVPN 2.4.  All retries are co=
ntrolled by ``--max-connect-retry``.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> --windows-driver</span><br><span>   Remo=
ved in OpenVPN 2.7. OpenVPN will always use ovpn-dco as the default</span><=
br><span>   driver on Windows. It will fall back to tap-windows6 if options=
 are used</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/=
options.c</span><br><span>index 1be105b..bd6dc07 100644</span><br><span>---=
 a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span>=
<br><span>@@ -6699,19 +6699,10 @@</span><br><span>         ho-&gt;auth_file=
_up =3D p[1];</span><br><span>         ho-&gt;inline_creds =3D is_inline;</=
span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    else if (streq(p[0], &quot;http-proxy-retry&quot;) || streq(p[0], &quot=
;socks-proxy-retry&quot;))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    else if (streq(p[0], &quot;http-proxy-retry&quot;) || streq(p[0]=
, &quot;socks-proxy-retry&quot;) || streq(p[0], &quot;http-proxy-timeout&qu=
ot;))</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT=
_P_GENERAL | OPT_P_CONNECTION);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        msg(M_WARN, &quot;DEPRECATED OPTION: http-proxy-retry and=
 socks-proxy-retry: &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                    &quot;In OpenVPN 2.4 proxy connection retries are =
handled like regular connections. &quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                    &quot;Use connect-retry-max 1 to get=
 a similar behavior as before.&quot;);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    else if (streq(p[0], &quot;http-proxy-timeout&quot;) &amp;&amp; p[1] &=
amp;&amp; !p[2])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        VERIFY_PERMIS=
SION(OPT_P_GENERAL | OPT_P_CONNECTION);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        msg(M_WARN,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            &quot;DEPRECATED OPTION: http-proxy-timeout: In=
 OpenVPN 2.4 the timeout until a connection to a &quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            &quot;server is established i=
s managed with a single timeout set by connect-timeout&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;DEPREC=
ATED OPTION: %s option ignored.&quot;, p[0]);</span><br><span>     }</span>=
<br><span>     else if (streq(p[0], &quot;http-proxy-option&quot;) &amp;&am=
p; p[1] &amp;&amp; !p[4])</span><br><span>     {</span><br><span>@@ -6826,7=
 +6817,7 @@</span><br><span>     else if (streq(p[0], &quot;persist-key&quo=
t;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>         VERIF=
Y_PERMISSION(OPT_P_PERSIST);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        msg(M_WARN, &quot;DEPRECATED: --persist-key option ignored. =
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M=
_WARN, &quot;DEPRECATED OPTION: --persist-key option ignored. &quot;</span>=
<br><span>                     &quot;Keys are now always persisted across r=
estarts. &quot;);</span><br><span>     }</span><br><span>     else if (stre=
q(p[0], &quot;persist-local-ip&quot;) &amp;&amp; !p[1])</span><br><span>@@ =
-6875,10 +6866,7 @@</span><br><span>     }</span><br><span>     else if (st=
req(p[0], &quot;max-routes&quot;) &amp;&amp; !p[2])</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &q=
uot;DEPRECATED OPTION: --max-routes option ignored. &quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                    &quot;The number o=
f routes is unlimited as of OpenVPN 2.4. &quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                    &quot;This option will be rem=
oved in a future version, &quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                    &quot;please remove it from your configurati=
on.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
msg(M_WARN, &quot;DEPRECATED OPTION: --max-routes option ignored.&quot;);</=
span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;route=
-gateway&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1427?usp=3Demail">change 1427</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1427?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I59995bf0fd6bc48a738a94e4114=
1ed37d8d637ba </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1427 </div>
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

--ukmuWB93RAo=--

