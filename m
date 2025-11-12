From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 12 Nov 2025 13:58:57 +0000
In-Reply-To: <gerrit.1762529900000.I31024f93d9d9d0f678fb39d4758a7e870bf00873@...2715...>
References: <gerrit.1762529900000.I31024f93d9d9d0f678fb39d4758a7e870bf00873@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <46f001df2054564efee5ff94cb7c34f2a5de0ab1-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+cnJrfUKags="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+cnJrfUKags=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1359?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


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
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1359
Message-Id: <20251111153230.29865-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
316.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/openssl_compat.h
1 file changed, 1 insertion(+), 10 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/59/1359/3

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I31024f93d9d9d0f678fb39d4758a7e870bf00873
Gerrit-Change-Number: 1359
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+cnJrfUKags=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1359?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">openssl_compat: Avoid conversio=
n warning for SSL_get_negotiated_group<br><br>SSL_get_negotiated_group is d=
ocumented to return<br>int and SSL_group_to_name definitely expects an int.=
<br><br>But SSL_get_negotiated_group is actually a macro<br>implemented by =
SSL_ctrl, which does return a long.<br>So to avoid the conversion warning w=
e need the cast.<br><br>Change-Id: I31024f93d9d9d0f678fb39d4758a7e870bf0087=
3<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by:=
 Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Gerrit URL: https://gerrit=
.openvpn.net/c/openvpn/+/1359<br>Message-Id: &lt;20251111153230.29865-1-ger=
t@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1096...=
ourceforge.net/msg34316.html<br>Signed-off-by: Gert Doering &lt;gert@...1826...=
6...&gt;<br>---<br>M src/openvpn/openssl_compat.h<br>1 file changed, 1 inse=
rtion(+), 10 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.=
openvpn.net:29418/openvpn refs/changes/59/1359/3</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/openssl_compat.h b/src/openvpn/openssl_compat.h</span><br><span>inde=
x fb3c9b1..b9af132 100644</span><br><span>--- a/src/openvpn/openssl_compat.=
h</span><br><span>+++ b/src/openvpn/openssl_compat.h</span><br><span>@@ -19=
4,21 +194,12 @@</span><br><span>           LIBRESSL_VERSION_NUMBER &gt; 0x3=
050400fL) */</span><br><span> </span><br><span> #if OPENSSL_VERSION_NUMBER =
&lt; 0x30200000L &amp;&amp; OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || d=
efined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pra=
gma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span> static inline const char *</span><br=
><span> SSL_get0_group_name(SSL *s)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    int nid =3D SSL_get_negotiated_group(s=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int nid =3D (=
int)SSL_get_negotiated_group(s);</span><br><span>     return SSL_group_to_n=
ame(s, nid);</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined=
(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#endif</span><br><span> #endif</span><br><span> </span><br>=
<span> /* Introduced in OpenSSL 3.6.0 */</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1359?usp=
=3Demail">change 1359</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1359?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I31024f93d9d9d0f678fb39d4758=
a7e870bf00873 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1359 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--+cnJrfUKags=--

