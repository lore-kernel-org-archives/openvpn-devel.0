From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 7 Nov 2025 15:38:22 +0000
References: <gerrit.1762529900000.I31024f93d9d9d0f678fb39d4758a7e870bf00873@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <3e489e5943393f15bc7e8dcaf97a7f75382b74fb-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6pJmHuH4im8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openssl_compat:
 Avoid conversion warning for SSL_get_negotiated_group
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

--6pJmHuH4im8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1359?usp=3Demail

to review the following change.


Change subject: openssl_compat: Avoid conversion warning for SSL_get_negoti=
ated_group
......................................................................

openssl_compat: Avoid conversion warning for SSL_get_negotiated_group

SSL_get_negotiated_group is documented to return
int and SSL_group_to_name definitely expects an int.

But SSL_get_negotiated_group is actually a macro
implemented by SSL_ctrl, which does return a long.
So to avoid the conversion warning we need the cast.

Change-Id: I31024f93d9d9d0f678fb39d4758a7e870bf00873
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/openssl_compat.h
1 file changed, 1 insertion(+), 10 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/59/1359/1

diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index fb3c9b1..b9af132 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -194,21 +194,12 @@
           LIBRESSL_VERSION_NUMBER > 0x3050400fL) */

 #if OPENSSL_VERSION_NUMBER < 0x30200000L && OPENSSL_VERSION_NUMBER >=3D 0x=
30000000L
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static inline const char *
 SSL_get0_group_name(SSL *s)
 {
-    int nid =3D SSL_get_negotiated_group(s);
+    int nid =3D (int)SSL_get_negotiated_group(s);
     return SSL_group_to_name(s, nid);
 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
 #endif

 /* Introduced in OpenSSL 3.6.0 */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1359?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I31024f93d9d9d0f678fb39d4758a7e870bf00873
Gerrit-Change-Number: 1359
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--6pJmHuH4im8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1359?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">openssl_compat: Avoid conversion warning fo=
r SSL_get_negotiated_group<br><br>SSL_get_negotiated_group is documented to=
 return<br>int and SSL_group_to_name definitely expects an int.<br><br>But =
SSL_get_negotiated_group is actually a macro<br>implemented by SSL_ctrl, wh=
ich does return a long.<br>So to avoid the conversion warning we need the c=
ast.<br><br>Change-Id: I31024f93d9d9d0f678fb39d4758a7e870bf00873<br>Signed-=
off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/=
openssl_compat.h<br>1 file changed, 1 insertion(+), 10 deletions(-)<br><br>=
</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/ch=
anges/59/1359/1</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/src/openvpn/openssl_compat.h b/src/ope=
nvpn/openssl_compat.h</span><br><span>index fb3c9b1..b9af132 100644</span><=
br><span>--- a/src/openvpn/openssl_compat.h</span><br><span>+++ b/src/openv=
pn/openssl_compat.h</span><br><span>@@ -194,21 +194,12 @@</span><br><span> =
          LIBRESSL_VERSION_NUMBER &gt; 0x3050400fL) */</span><br><span> </s=
pan><br><span> #if OPENSSL_VERSION_NUMBER &lt; 0x30200000L &amp;&amp; OPENS=
SL_VERSION_NUMBER &gt;=3D 0x30000000L</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored =
&quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> static inline const char *</span><br><span> SSL_get0_group_name(SSL *=
s)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    int nid =3D SSL_get_negotiated_group(s);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    int nid =3D (int)SSL_get_negotiated_group(s);<=
/span><br><span>     return SSL_group_to_name(s, nid);</span><br><span> }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span> #endif</span><br><span> </span><br><span> /* Introduced in OpenSSL =
3.6.0 */</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1359?usp=3Demail">change 1359</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1359?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I31024f93d9d9d0f678fb39d4758=
a7e870bf00873 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1359 </div>
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

--6pJmHuH4im8=--

