From: "MaxF (Code Review)" <gerrit@...515...>
Date: Fri, 14 Jun 2024 11:34:38 +0000
References: <gerrit.1718364874000.Ia3883a26ac26df6bbb5353fb074a2e0f814737be@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4ba969b0779fc939adaa9c78f50a41b7b4bb4483-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QDklFgBLwcA="; charset=UTF-8
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

--QDklFgBLwcA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/682?usp=3Demail

to review the following change.


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
1 file changed, 1 insertion(+), 20 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/82/682/1

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index a68588e..e25fb84 100644
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

@@ -1067,27 +1063,12 @@

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
             *minor =3D MBEDTLS_SSL_MINOR_VERSION_3;
             break;
 #endif
-
         default:
             msg(M_FATAL, "%s: invalid or unsupported TLS version %d", __fu=
nc__, tls_ver);
             break;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/682?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia3883a26ac26df6bbb5353fb074a2e0f814737be
Gerrit-Change-Number: 682
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--QDklFgBLwcA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>MaxF would like plaisthos and flichtenheld to <strong>review</strong> th=
is change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/682?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">mbedtls: Remove support for old TLS versions<br><br>Recent ve=
rsions of mbedtls have dropped support for TLS 1.0 and 1.1.<br>Rather than =
checking which versions are supported, drop support for<br>everything befor=
e 1.2.<br><br>Change-Id: Ia3883a26ac26df6bbb5353fb074a2e0f814737be<br>Signe=
d-off-by: Max Fillinger &lt;maximilian.fillinger@...2507...&gt;<br>---<br>M=
 src/openvpn/ssl_mbedtls.c<br>1 file changed, 1 insertion(+), 20 deletions(=
-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/8=
2/682/1</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mb=
edtls.c</span><br><span>index a68588e..e25fb84 100644</span><br><span>--- a=
/src/openvpn/ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c<=
/span><br><span>@@ -1040,12 +1040,8 @@</span><br><span> {</span><br><span> =
#if defined(MBEDTLS_SSL_PROTO_TLS1_2)</span><br><span>     return TLS_VER_1=
_2;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(MBED=
TLS_SSL_PROTO_TLS1_1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    return TLS_VER_1_1;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#elif defined(MBEDTLS_SSL_PROTO_TLS1)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    return TLS_VER_1_0;</span><br><span> #else /* defined=
(MBEDTLS_SSL_PROTO_TLS1_2) */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    #error &quot;mbedtls is compiled without support for TLS 1.0, 1=
.1 and 1.2.&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  #error &quot;mbedtls is compiled without support for TLS 1.2.&quot;</span=
><br><span> #endif /* defined(MBEDTLS_SSL_PROTO_TLS1_2) */</span><br><span>=
 }</span><br><span> </span><br><span>@@ -1067,27 +1063,12 @@</span><br><spa=
n> </span><br><span>     switch (tls_ver)</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#if defined(MBEDTLS_SSL_PROTO_TL=
S1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case TLS_V=
ER_1_0:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            *m=
ajor =3D MBEDTLS_SSL_MAJOR_VERSION_3;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            *minor =3D MBEDTLS_SSL_MINOR_VERSION_1;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#if defined(MBEDTLS_SSL_PROTO_TLS1_1)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        case TLS_VER_1_1:</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            *major =3D MBEDTLS_SSL_MAJOR_VERSION=
_3;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            *minor=
 =3D MBEDTLS_SSL_MINOR_VERSION_2;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            break;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span> #if defined(MBEDTLS_SSL_PROTO_TLS1_2)</span><br><span>         =
case TLS_VER_1_2:</span><br><span>             *major =3D MBEDTLS_SSL_MAJOR=
_VERSION_3;</span><br><span>             *minor =3D MBEDTLS_SSL_MINOR_VERSI=
ON_3;</span><br><span>             break;</span><br><span> #endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         defau=
lt:</span><br><span>             msg(M_FATAL, &quot;%s: invalid or unsuppor=
ted TLS version %d&quot;, __func__, tls_ver);</span><br><span>             =
break;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/682?usp=3Demail">change 682</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/682?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia3883a26ac26df6bbb5353fb074=
a2e0f814737be </div>
<div style=3D"display:none"> Gerrit-Change-Number: 682 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--QDklFgBLwcA=--

