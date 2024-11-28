From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 28 Nov 2024 12:04:51 +0000
References: <gerrit.1732795471000.Ifad21a2841e97e910775f3618ddac1c483d74b65@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <63c25cfb2c0bc003dd399a12e01d3c1a6f564e80-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zRJR+MhvRX0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Various typo fixes
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

--zRJR+MhvRX0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/822?usp=3Demail

to review the following change.


Change subject: Various typo fixes
......................................................................

Various typo fixes

This collects some minor typo fixes that are not
worth each their own commit.

Fixes: OpenVPN/openvpn#644
Fixes: OpenVPN/openvpn#442

Change-Id: Ifad21a2841e97e910775f3618ddac1c483d74b65
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M doc/man-sections/connection-profiles.rst
M sample/sample-config-files/server.conf
M src/openvpn/options.c
3 files changed, 5 insertions(+), 5 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/22/822/1

diff --git a/doc/man-sections/connection-profiles.rst b/doc/man-sections/co=
nnection-profiles.rst
index 520bbef..767ff3a 100644
--- a/doc/man-sections/connection-profiles.rst
+++ b/doc/man-sections/connection-profiles.rst
@@ -6,7 +6,7 @@
 options which are related to specific ``--remote`` options.  For these
 use cases, connection profiles are the solution.

-By enacpulating the ``--remote`` option and related options within
+By encapsulating the ``--remote`` option and related options within
 ``<connection>`` and ``</connection>``, these options are handled as a
 group.

diff --git a/sample/sample-config-files/server.conf b/sample/sample-config-=
files/server.conf
index 48716a0..f6d9e65 100644
--- a/sample/sample-config-files/server.conf
+++ b/sample/sample-config-files/server.conf
@@ -199,7 +199,7 @@
 # all clients to redirect their default
 # network gateway through the VPN, causing
 # all IP traffic such as web browsing and
-# and DNS lookups to go through the VPN
+# DNS lookups to go through the VPN
 # (The OpenVPN server machine may need to NAT
 # or bridge the TUN/TAP interface to the internet
 # in order for this to work properly).
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 043b240..d8dd518 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -879,7 +879,7 @@
     o->pkcs11_pin_cache_period =3D -1;
 #endif                  /* ENABLE_PKCS11 */

-/* P2MP server context features */
+    /* P2MP server context features */
     o->auth_token_generate =3D false;

     /* Set default --tmp-dir */
@@ -2966,7 +2966,7 @@
         if (options->pkcs12_file)
         {
 #ifdef ENABLE_CRYPTO_MBEDTLS
-            msg(M_USAGE, "Parameter --pkcs12 cannot be used with the mbed =
TLS version version of OpenVPN.");
+            msg(M_USAGE, "Parameter --pkcs12 cannot be used with the mbed =
TLS version of OpenVPN.");
 #else
             if (options->ca_path)
             {
@@ -2995,7 +2995,7 @@
 #ifdef ENABLE_CRYPTO_MBEDTLS
             if (options->ca_path)
             {
-                msg(M_USAGE, "Parameter --capath cannot be used with the m=
bed TLS version version of OpenVPN.");
+                msg(M_USAGE, "Parameter --capath cannot be used with the m=
bed TLS version of OpenVPN.");
             }
 #endif  /* ifdef ENABLE_CRYPTO_MBEDTLS */
             if (pull)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/822?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifad21a2841e97e910775f3618ddac1c483d74b65
Gerrit-Change-Number: 822
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--zRJR+MhvRX0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/822?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Various typo fixes<br><br>This collects some minor typo fixes=
 that are not<br>worth each their own commit.<br><br>Fixes: OpenVPN/openvpn=
#644<br>Fixes: OpenVPN/openvpn#442<br><br>Change-Id: Ifad21a2841e97e910775f=
3618ddac1c483d74b65<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2723...=
.&gt;<br>---<br>M doc/man-sections/connection-profiles.rst<br>M sample/samp=
le-config-files/server.conf<br>M src/openvpn/options.c<br>3 files changed, =
5 insertions(+), 5 deletions(-)<br><br></pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net=
:29418/openvpn refs/changes/22/822/1</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/=
connection-profiles.rst b/doc/man-sections/connection-profiles.rst</span><b=
r><span>index 520bbef..767ff3a 100644</span><br><span>--- a/doc/man-section=
s/connection-profiles.rst</span><br><span>+++ b/doc/man-sections/connection=
-profiles.rst</span><br><span>@@ -6,7 +6,7 @@</span><br><span> options whic=
h are related to specific ``--remote`` options.  For these</span><br><span>=
 use cases, connection profiles are the solution.</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-By enacpulating the ``--remot=
e`` option and related options within</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+By encapsulating the ``--remote`` option and related opti=
ons within</span><br><span> ``&lt;connection&gt;`` and ``&lt;/connection&gt=
;``, these options are handled as a</span><br><span> group.</span><br><span=
> </span><br><span>diff --git a/sample/sample-config-files/server.conf b/sa=
mple/sample-config-files/server.conf</span><br><span>index 48716a0..f6d9e65=
 100644</span><br><span>--- a/sample/sample-config-files/server.conf</span>=
<br><span>+++ b/sample/sample-config-files/server.conf</span><br><span>@@ -=
199,7 +199,7 @@</span><br><span> # all clients to redirect their default</s=
pan><br><span> # network gateway through the VPN, causing</span><br><span> =
# all IP traffic such as web browsing and</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-# and DNS lookups to go through the VPN</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+# DNS lookups to go through the VPN=
</span><br><span> # (The OpenVPN server machine may need to NAT</span><br><=
span> # or bridge the TUN/TAP interface to the internet</span><br><span> # =
in order for this to work properly).</span><br><span>diff --git a/src/openv=
pn/options.c b/src/openvpn/options.c</span><br><span>index 043b240..d8dd518=
 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/s=
rc/openvpn/options.c</span><br><span>@@ -879,7 +879,7 @@</span><br><span>  =
   o-&gt;pkcs11_pin_cache_period =3D -1;</span><br><span> #endif           =
       /* ENABLE_PKCS11 */</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-/* P2MP server context features */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* P2MP server context features *=
/</span><br><span>     o-&gt;auth_token_generate =3D false;</span><br><span=
> </span><br><span>     /* Set default --tmp-dir */</span><br><span>@@ -296=
6,7 +2966,7 @@</span><br><span>         if (options-&gt;pkcs12_file)</span>=
<br><span>         {</span><br><span> #ifdef ENABLE_CRYPTO_MBEDTLS</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_USAGE, &quot=
;Parameter --pkcs12 cannot be used with the mbed TLS version version of Ope=
nVPN.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      msg(M_USAGE, &quot;Parameter --pkcs12 cannot be used with the mbed TL=
S version of OpenVPN.&quot;);</span><br><span> #else</span><br><span>      =
       if (options-&gt;ca_path)</span><br><span>             {</span><br><s=
pan>@@ -2995,7 +2995,7 @@</span><br><span> #ifdef ENABLE_CRYPTO_MBEDTLS</sp=
an><br><span>             if (options-&gt;ca_path)</span><br><span>        =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 msg(M_USAGE, &quot;Parameter --capath cannot be used with the mbed TLS ver=
sion version of OpenVPN.&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                msg(M_USAGE, &quot;Parameter --capath cannot b=
e used with the mbed TLS version of OpenVPN.&quot;);</span><br><span>      =
       }</span><br><span> #endif  /* ifdef ENABLE_CRYPTO_MBEDTLS */</span><=
br><span>             if (pull)</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/822?usp=3Demail">c=
hange 822</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/822?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifad21a2841e97e910775f3618dd=
ac1c483d74b65 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 822 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--zRJR+MhvRX0=--

