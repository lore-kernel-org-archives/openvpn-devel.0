From: "MaxF (Code Review)" <gerrit@...515...>
Date: Fri, 14 Jun 2024 13:14:58 +0000
In-Reply-To: <gerrit.1718364874000.Ia3883a26ac26df6bbb5353fb074a2e0f814737be@...2715...>
References: <gerrit.1718364874000.Ia3883a26ac26df6bbb5353fb074a2e0f814737be@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <541adc008c7374b1b1e2eee0f51e108046d10452-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xVqrblBvp1U="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mbedtls: Remove
 support for old TLS versions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xVqrblBvp1U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/682?usp=3Demail

to look at the new patch set (#2).


Change subject: mbedtls: Remove support for old TLS versions
......................................................................

mbedtls: Remove support for old TLS versions

Recent versions of mbedtls have dropped support for TLS 1.0 and 1.1.
Rather than checking which versions are supported, drop support for
everything before 1.2.

Change-Id: Ia3883a26ac26df6bbb5353fb074a2e0f814737be
Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
---
M src/openvpn/ssl_mbedtls.c
1 file changed, 1 insertion(+), 19 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/82/682/2

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index a68588e..ec9ec13 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1040,12 +1040,8 @@
 {
 #if defined(MBEDTLS_SSL_PROTO_TLS1_2)
     return TLS_VER_1_2;
-#elif defined(MBEDTLS_SSL_PROTO_TLS1_1)
-    return TLS_VER_1_1;
-#elif defined(MBEDTLS_SSL_PROTO_TLS1)
-    return TLS_VER_1_0;
 #else /* defined(MBEDTLS_SSL_PROTO_TLS1_2) */
-    #error "mbedtls is compiled without support for TLS 1.0, 1.1 and 1.2."
+    #error "mbedtls is compiled without support for TLS 1.2."
 #endif /* defined(MBEDTLS_SSL_PROTO_TLS1_2) */
 }

@@ -1067,20 +1063,6 @@

     switch (tls_ver)
     {
-#if defined(MBEDTLS_SSL_PROTO_TLS1)
-        case TLS_VER_1_0:
-            *major =3D MBEDTLS_SSL_MAJOR_VERSION_3;
-            *minor =3D MBEDTLS_SSL_MINOR_VERSION_1;
-            break;
-#endif
-
-#if defined(MBEDTLS_SSL_PROTO_TLS1_1)
-        case TLS_VER_1_1:
-            *major =3D MBEDTLS_SSL_MAJOR_VERSION_3;
-            *minor =3D MBEDTLS_SSL_MINOR_VERSION_2;
-            break;
-#endif
-
 #if defined(MBEDTLS_SSL_PROTO_TLS1_2)
         case TLS_VER_1_2:
             *major =3D MBEDTLS_SSL_MAJOR_VERSION_3;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/682?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia3883a26ac26df6bbb5353fb074a2e0f814737be
Gerrit-Change-Number: 682
Gerrit-PatchSet: 2
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--xVqrblBvp1U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>MaxF <strong>uploaded patch set #2</strong> to this change.</p><p><a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/682?usp=3Demail">View Change</a>=
</p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>mbedtls: Remove support for old TLS versions<br><br>Recent versions of mbe=
dtls have dropped support for TLS 1.0 and 1.1.<br>Rather than checking whic=
h versions are supported, drop support for<br>everything before 1.2.<br><br=
>Change-Id: Ia3883a26ac26df6bbb5353fb074a2e0f814737be<br>Signed-off-by: Max=
 Fillinger &lt;maximilian.fillinger@...2507...&gt;<br>---<br>M src/openvpn/=
ssl_mbedtls.c<br>1 file changed, 1 insertion(+), 19 deletions(-)<br><br></p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/82/682/2</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</span=
><br><span>index a68588e..ec9ec13 100644</span><br><span>--- a/src/openvpn/=
ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</span><br><sp=
an>@@ -1040,12 +1040,8 @@</span><br><span> {</span><br><span> #if defined(M=
BEDTLS_SSL_PROTO_TLS1_2)</span><br><span>     return TLS_VER_1_2;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(MBEDTLS_SSL_PROTO=
_TLS1_1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return TL=
S_VER_1_1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defin=
ed(MBEDTLS_SSL_PROTO_TLS1)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    return TLS_VER_1_0;</span><br><span> #else /* defined(MBEDTLS_SSL_=
PROTO_TLS1_2) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    #=
error &quot;mbedtls is compiled without support for TLS 1.0, 1.1 and 1.2.&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    #error &quo=
t;mbedtls is compiled without support for TLS 1.2.&quot;</span><br><span> #=
endif /* defined(MBEDTLS_SSL_PROTO_TLS1_2) */</span><br><span> }</span><br>=
<span> </span><br><span>@@ -1067,20 +1063,6 @@</span><br><span> </span><br>=
<span>     switch (tls_ver)</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#if defined(MBEDTLS_SSL_PROTO_TLS1)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        case TLS_VER_1_0:</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            *major =3D MBEDT=
LS_SSL_MAJOR_VERSION_3;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            *minor =3D MBEDTLS_SSL_MINOR_VERSION_1;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if def=
ined(MBEDTLS_SSL_PROTO_TLS1_1)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        case TLS_VER_1_1:</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            *major =3D MBEDTLS_SSL_MAJOR_VERSION_3;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            *minor =3D MBEDTLS_S=
SL_MINOR_VERSION_2;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endi=
f</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #i=
f defined(MBEDTLS_SSL_PROTO_TLS1_2)</span><br><span>         case TLS_VER_1=
_2:</span><br><span>             *major =3D MBEDTLS_SSL_MAJOR_VERSION_3;</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/682?usp=3Demail">change 682</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/682?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia3883a26ac26df6bbb5353fb074=
a2e0f814737be </div>
<div style=3D"display:none"> Gerrit-Change-Number: 682 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--xVqrblBvp1U=--

