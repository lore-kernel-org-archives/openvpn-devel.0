From: "comododragon (Code Review)" <gerrit@...515...>
Date: Wed, 18 Jun 2025 08:21:54 +0000
References: <gerrit.1750234912000.I8eb1ded62a415a0734de11a4503cffafcc23d9f3@...2715...>
Reply-To: rein.vanbaaren@...1435..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a57e2fb1ca42ec592b58f7446e82cdd5a3d4f395-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WtT8DFYcCSA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Removed trailing
 whitespaces
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

--WtT8DFYcCSA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1045?usp=3Demail

to review the following change.


Change subject: Removed trailing whitespaces
......................................................................

Removed trailing whitespaces

Change-Id: I8eb1ded62a415a0734de11a4503cffafcc23d9f3
---
M src/openvpn/ssl_openssl.c
M src/openvpn/wolfssl_compat.h
2 files changed, 9 insertions(+), 9 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/45/1045/1

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 5dbacf0..29aa502 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -593,7 +593,7 @@

 #ifdef ENABLE_CRYPTO_WOLFSSL
         int nid =3D wolfssl_OBJ_sn2nid(token);
-#else
+#else
         int nid =3D OBJ_sn2nid(token);
 #endif

diff --git a/src/openvpn/wolfssl_compat.h b/src/openvpn/wolfssl_compat.h
index c16d918..a25e5c3 100644
--- a/src/openvpn/wolfssl_compat.h
+++ b/src/openvpn/wolfssl_compat.h
@@ -31,18 +31,18 @@

 #ifdef ENABLE_CRYPTO_WOLFSSL

-int
-wolfssl_OBJ_sn2nid(const char *sn)
+int
+wolfssl_OBJ_sn2nid(const char *sn)
 {

-    int nid =3D OBJ_sn2nid(sn);
+	int nid =3D OBJ_sn2nid(sn);

-    if (nid =3D=3D WC_NID_undef)
-    {
-        return wolfSSL_EC_curve_nist2nid(sn);
-    }
+	if (nid =3D=3D WC_NID_undef)
+	{
+		return wolfSSL_EC_curve_nist2nid(sn);
+	}

-    return WC_NID_undef;
+	return WC_NID_undef;
 }

 #endif

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1045?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8eb1ded62a415a0734de11a4503cffafcc23d9f3
Gerrit-Change-Number: 1045
Gerrit-PatchSet: 1
Gerrit-Owner: comododragon <rein.vanbaaren@...1435...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--WtT8DFYcCSA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>comododragon would like plaisthos and flichtenheld to <strong>review</st=
rong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1045?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Removed trailing whitespaces<br><br>Change-Id: I8eb1ded62a41=
5a0734de11a4503cffafcc23d9f3<br>---<br>M src/openvpn/ssl_openssl.c<br>M src=
/openvpn/wolfssl_compat.h<br>2 files changed, 9 insertions(+), 9 deletions(=
-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/4=
5/1045/1</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_o=
penssl.c</span><br><span>index 5dbacf0..29aa502 100644</span><br><span>--- =
a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c=
</span><br><span>@@ -593,7 +593,7 @@</span><br><span> </span><br><span> #if=
def ENABLE_CRYPTO_WOLFSSL</span><br><span>         int nid =3D wolfssl_OBJ_=
sn2nid(token);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><spa=
n>         int nid =3D OBJ_sn2nid(token);</span><br><span> #endif</span><br=
><span> </span><br><span>diff --git a/src/openvpn/wolfssl_compat.h b/src/op=
envpn/wolfssl_compat.h</span><br><span>index c16d918..a25e5c3 100644</span>=
<br><span>--- a/src/openvpn/wolfssl_compat.h</span><br><span>+++ b/src/open=
vpn/wolfssl_compat.h</span><br><span>@@ -31,18 +31,18 @@</span><br><span> <=
/span><br><span> #ifdef ENABLE_CRYPTO_WOLFSSL</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-int </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-wolfssl_OBJ_sn2nid(const char *sn) </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+wolfssl_OBJ_sn2nid(const char *sn)</span><br><span=
> {</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    int nid =3D OBJ_sn2nid(sn);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	int nid =3D OBJ_sn2nid(sn);</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (nid =3D=3D WC_NID_undef) </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        return wolfSSL_EC_curve_nist2nid(s=
n);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+	if (nid =3D=3D WC_NID_undef)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+	{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+		return wolfSSL_EC_curve_nist2nid(sn);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	}</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return WC_NID_un=
def;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	return WC_NID_=
undef;</span><br><span> }</span><br><span> </span><br><span> #endif</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1045?usp=3Demail">change 1045</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1045?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8eb1ded62a415a0734de11a4503=
cffafcc23d9f3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1045 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: comododragon &lt;rein.vanbaaren@=
...1435...&gt; </div>
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


--WtT8DFYcCSA=--

