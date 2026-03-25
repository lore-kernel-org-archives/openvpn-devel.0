From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 25 Mar 2026 13:30:37 +0000
References: <gerrit.1774445432000.I77500d435f212a4bf42ee8cfca07d0285fe694f2@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <7683bef195f08412eecca9d7e360ace586435ebe-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pXf8mrAcqeM="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Use
 ASN1_BIT_STRING_get_bit to check for netscape certificate usage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--pXf8mrAcqeM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/1587?usp=3Demail )


Change subject: Use ASN1_BIT_STRING_get_bit to check for netscape certifica=
te usage
......................................................................

Use ASN1_BIT_STRING_get_bit to check for netscape certificate usage

The ASN_BIT_STRING object has become opaque in OpenSSL 4.0. So instead
of accessing the internal, we have to use a method now to check these
attributes.

The bit counting in ANS.1 and of this method is a bit strange and
it will count bits from the left instead of the right, so the previous
mask of 0x80 for clients is now 0 and 0x40 for server is now 1.

Change-Id: I77500d435f212a4bf42ee8cfca07d0285fe694f2
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/ssl_verify_openssl.c
1 file changed, 5 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/87/1587/1

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index 46401cd..fc14789 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -626,7 +626,8 @@
         {
             ASN1_BIT_STRING *ns;
             ns =3D X509_get_ext_d2i(peer_cert, NID_netscape_cert_type, NUL=
L, NULL);
-            result =3D (ns && ns->length > 0 && (ns->data[0] & NS_SSL_CLIE=
NT)) ? SUCCESS : FAILURE;
+            // bit 0 is to check if certificate is the client certificate
+            result =3D ASN1_BIT_STRING_get_bit(ns, 0) ? SUCCESS : FAILURE;
             if (result =3D=3D SUCCESS)
             {
                 msg(M_WARN, "X509: Certificate is a client certificate yet=
 it's purpose "
@@ -652,9 +653,9 @@
          */
         if (result =3D=3D FAILURE)
         {
-            ASN1_BIT_STRING *ns;
-            ns =3D X509_get_ext_d2i(peer_cert, NID_netscape_cert_type, NUL=
L, NULL);
-            result =3D (ns && ns->length > 0 && (ns->data[0] & NS_SSL_SERV=
ER)) ? SUCCESS : FAILURE;
+            ASN1_BIT_STRING *ns =3D X509_get_ext_d2i(peer_cert, NID_netsca=
pe_cert_type, NULL, NULL);
+            // Server bit is 1 for ASN1_BIT_STRING_get_bit
+            result =3D ASN1_BIT_STRING_get_bit(ns, 1) ? SUCCESS : FAILURE;
             if (result =3D=3D SUCCESS)
             {
                 msg(M_WARN, "X509: Certificate is a server certificate yet=
 it's purpose "

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1587?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I77500d435f212a4bf42ee8cfca07d0285fe694f2
Gerrit-Change-Number: 1587
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--pXf8mrAcqeM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>.</p><p><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1587?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Use ASN1_BIT_STRING_get_bit to check for netscape certificate usage<br>=
<br>The ASN_BIT_STRING object has become opaque in OpenSSL 4.0. So instead<=
br>of accessing the internal, we have to use a method now to check these<br=
>attributes.<br><br>The bit counting in ANS.1 and of this method is a bit s=
trange and<br>it will count bits from the left instead of the right, so the=
 previous<br>mask of 0x80 for clients is now 0 and 0x40 for server is now 1=
.<br><br>Change-Id: I77500d435f212a4bf42ee8cfca07d0285fe694f2<br>Signed-off=
-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/ssl_verif=
y_openssl.c<br>1 file changed, 5 insertions(+), 4 deletions(-)<br><br></pre=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes=
/87/1587/1</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/ssl_verify_openssl.c b/src/open=
vpn/ssl_verify_openssl.c</span><br><span>index 46401cd..fc14789 100644</spa=
n><br><span>--- a/src/openvpn/ssl_verify_openssl.c</span><br><span>+++ b/sr=
c/openvpn/ssl_verify_openssl.c</span><br><span>@@ -626,7 +626,8 @@</span><b=
r><span>         {</span><br><span>             ASN1_BIT_STRING *ns;</span>=
<br><span>             ns =3D X509_get_ext_d2i(peer_cert, NID_netscape_cert=
_type, NULL, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          result =3D (ns &amp;&amp; ns-&gt;length &gt; 0 &amp;&amp; (ns-&gt=
;data[0] &amp; NS_SSL_CLIENT)) ? SUCCESS : FAILURE;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            // bit 0 is to check if certi=
ficate is the client certificate</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            result =3D ASN1_BIT_STRING_get_bit(ns, 0) ? SUCCES=
S : FAILURE;</span><br><span>             if (result =3D=3D SUCCESS)</span>=
<br><span>             {</span><br><span>                 msg(M_WARN, &quot=
;X509: Certificate is a client certificate yet it&#39;s purpose &quot;</spa=
n><br><span>@@ -652,9 +653,9 @@</span><br><span>          */</span><br><spa=
n>         if (result =3D=3D FAILURE)</span><br><span>         {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            ASN1_BIT_STRING *ns;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ns =3D X5=
09_get_ext_d2i(peer_cert, NID_netscape_cert_type, NULL, NULL);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            result =3D (ns &amp;&a=
mp; ns-&gt;length &gt; 0 &amp;&amp; (ns-&gt;data[0] &amp; NS_SSL_SERVER)) ?=
 SUCCESS : FAILURE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            ASN1_BIT_STRING *ns =3D X509_get_ext_d2i(peer_cert, NID_netscap=
e_cert_type, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            // Server bit is 1 for ASN1_BIT_STRING_get_bit</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            result =3D ASN1_BI=
T_STRING_get_bit(ns, 1) ? SUCCESS : FAILURE;</span><br><span>             i=
f (result =3D=3D SUCCESS)</span><br><span>             {</span><br><span>  =
               msg(M_WARN, &quot;X509: Certificate is a server certificate =
yet it&#39;s purpose &quot;</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1587?usp=3Demail">chan=
ge 1587</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div =
itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1587?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I77500d435f212a4bf42ee8cfca0=
7d0285fe694f2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1587 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--pXf8mrAcqeM=--

