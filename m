From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 11 Nov 2025 14:26:54 +0000
In-Reply-To: <gerrit.1762529900000.I31024f93d9d9d0f678fb39d4758a7e870bf00873@...2715...>
References: <gerrit.1762529900000.I31024f93d9d9d0f678fb39d4758a7e870bf00873@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e22e2847cd6e8722d7a9a84ffa0d6ab432f5a97a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="o2W7ULbIshE="; charset=UTF-8
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

--o2W7ULbIshE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1359?usp=3Demail

to look at the new patch set (#2).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/59/1359/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>

--o2W7ULbIshE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1359?usp=3Demail">View C=
hange</a></p><p>The change is no longer submittable: checks~ChecksSubmitRul=
e is unsatisfied now.</p><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">openssl_compat: Avoid conversion war=
ning for SSL_get_negotiated_group<br><br>SSL_get_negotiated_group is docume=
nted to return<br>int and SSL_group_to_name definitely expects an int.<br><=
br>But SSL_get_negotiated_group is actually a macro<br>implemented by SSL_c=
trl, which does return a long.<br>So to avoid the conversion warning we nee=
d the cast.<br><br>Change-Id: I31024f93d9d9d0f678fb39d4758a7e870bf00873<br>=
Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/o=
penvpn/openssl_compat.h<br>1 file changed, 1 insertion(+), 10 deletions(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn =
refs/changes/59/1359/2</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/openssl_compat.h b/=
src/openvpn/openssl_compat.h</span><br><span>index fb3c9b1..b9af132 100644<=
/span><br><span>--- a/src/openvpn/openssl_compat.h</span><br><span>+++ b/sr=
c/openvpn/openssl_compat.h</span><br><span>@@ -194,21 +194,12 @@</span><br>=
<span>           LIBRESSL_VERSION_NUMBER &gt; 0x3050400fL) */</span><br><sp=
an> </span><br><span> #if OPENSSL_VERSION_NUMBER &lt; 0x30200000L &amp;&amp=
; OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic i=
gnored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> static inline const char *</span><br><span> SSL_get0_group_nam=
e(SSL *s)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    int nid =3D SSL_get_negotiated_group(s);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int nid =3D (int)SSL_get_negotiated_g=
roup(s);</span><br><span>     return SSL_group_to_name(s, nid);</span><br><=
span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__=
clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC d=
iagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</=
span><br><span> #endif</span><br><span> </span><br><span> /* Introduced in =
OpenSSL 3.6.0 */</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1359?usp=3Demail">change 1359</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1359?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I31024f93d9d9d0f678fb39d4758=
a7e870bf00873 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1359 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--o2W7ULbIshE=--

