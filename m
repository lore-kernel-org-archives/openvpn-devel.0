From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 1 Apr 2026 11:56:52 +0000
In-Reply-To: <gerrit.1774445432000.I77500d435f212a4bf42ee8cfca07d0285fe694f2@...2715...>
References: <gerrit.1774445432000.I77500d435f212a4bf42ee8cfca07d0285fe694f2@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <eef3758434caf97c792b38e4333ca959453f0e99-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pcxBOTNxpeg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Use
 ASN1_BIT_STRING_get_bit to check for netscape certificate usage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--pcxBOTNxpeg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1587?usp=3Demail

to look at the new patch set (#4).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


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
1 file changed, 15 insertions(+), 12 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/87/1587/4

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index 08946cd..a15640d 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -609,22 +609,24 @@
     if (usage =3D=3D NS_CERT_CHECK_CLIENT)
     {
         /*
-         * Unfortunately, X509_check_purpose() does some weird thing that
+         * Unfortunately, X509_check_purpose() before OpenSSL 4.0 does som=
e weird thing that
          * prevent it to take a const argument
          */
         result_t result =3D
             X509_check_purpose(peer_cert, X509_PURPOSE_SSL_CLIENT, 0) ? SU=
CCESS : FAILURE;

         /*
-         * old versions of OpenSSL allow us to make the less strict check =
we used to
-         * do. If this less strict check pass, warn user that this might n=
ot be the
-         * case when its distribution will update to OpenSSL 1.1
+         * Note that we do not check for netscape certificate type here bu=
t rather
+         * check for a gneral SSL/TLS client purpose. We do not know how l=
ong nscert
+         * attributes are accepted by TLS library in the future. Currently=
 OpenSSL 4.0
+         * and aws-lc 1.9.0 still consider nscert client as acceptable.
          */
         if (result =3D=3D FAILURE)
         {
             ASN1_BIT_STRING *ns;
             ns =3D X509_get_ext_d2i(peer_cert, NID_netscape_cert_type, NUL=
L, NULL);
-            result =3D (ns && ASN1_STRING_length(ns) > 0 && (ASN1_STRING_g=
et0_data(ns)[0] & NS_SSL_CLIENT)) ? SUCCESS : FAILURE;
+            // bit 0 is to check if certificate is the client certificate
+            result =3D ASN1_BIT_STRING_get_bit(ns, 0) ? SUCCESS : FAILURE;
             if (result =3D=3D SUCCESS)
             {
                 msg(M_WARN, "X509: Certificate is a client certificate yet=
 it's purpose "
@@ -637,22 +639,23 @@
     if (usage =3D=3D NS_CERT_CHECK_SERVER)
     {
         /*
-         * Unfortunately, X509_check_purpose() does some weird thing that
+         * Unfortunately, X509_check_purpose() before OpenSSL 4.0 does som=
e weird thing that
          * prevent it to take a const argument
          */
         result_t result =3D
             X509_check_purpose(peer_cert, X509_PURPOSE_SSL_SERVER, 0) ? SU=
CCESS : FAILURE;

         /*
-         * old versions of OpenSSL allow us to make the less strict check =
we used to
-         * do. If this less strict check pass, warn user that this might n=
ot be the
-         * case when its distribution will update to OpenSSL 1.1
+         * Note that we do not check for netscape certificate type here bu=
t rather
+         * check for a gneral SSL/TLS server purpose. We do not know how l=
ong nscert
+         * attributes are accepted by TLS library in the future. Currently=
 OpenSSL 4.0
+         * and aws-lc 1.9.0 still consider nscert server as acceptable.
          */
         if (result =3D=3D FAILURE)
         {
-            ASN1_BIT_STRING *ns;
-            ns =3D X509_get_ext_d2i(peer_cert, NID_netscape_cert_type, NUL=
L, NULL);
-            result =3D (ns && ASN1_STRING_length(ns) > 0 && (ASN1_STRING_g=
et0_data(ns)[0] & NS_SSL_SERVER)) ? SUCCESS : FAILURE;
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I77500d435f212a4bf42ee8cfca07d0285fe694f2
Gerrit-Change-Number: 1587
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>

--pcxBOTNxpeg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #4</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1587?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Use ASN1_BIT_STRING_get_bit =
to check for netscape certificate usage<br><br>The ASN_BIT_STRING object ha=
s become opaque in OpenSSL 4.0. So instead<br>of accessing the internal, we=
 have to use a method now to check these<br>attributes.<br><br>The bit coun=
ting in ANS.1 and of this method is a bit strange and<br>it will count bits=
 from the left instead of the right, so the previous<br>mask of 0x80 for cl=
ients is now 0 and 0x40 for server is now 1.<br><br>Change-Id: I77500d435f2=
12a4bf42ee8cfca07d0285fe694f2<br>Signed-off-by: Arne Schwabe &lt;arne@...1711...=
27...&gt;<br>---<br>M src/openvpn/ssl_verify_openssl.c<br>1 file changed, 1=
5 insertions(+), 12 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/87/1587/4</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c</=
span><br><span>index 08946cd..a15640d 100644</span><br><span>--- a/src/open=
vpn/ssl_verify_openssl.c</span><br><span>+++ b/src/openvpn/ssl_verify_opens=
sl.c</span><br><span>@@ -609,22 +609,24 @@</span><br><span>     if (usage =
=3D=3D NS_CERT_CHECK_CLIENT)</span><br><span>     {</span><br><span>       =
  /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * Unfort=
unately, X509_check_purpose() does some weird thing that</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+         * Unfortunately, X509_check_p=
urpose() before OpenSSL 4.0 does some weird thing that</span><br><span>    =
      * prevent it to take a const argument</span><br><span>          */</s=
pan><br><span>         result_t result =3D</span><br><span>             X50=
9_check_purpose(peer_cert, X509_PURPOSE_SSL_CLIENT, 0) ? SUCCESS : FAILURE;=
</span><br><span> </span><br><span>         /*</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-         * old versions of OpenSSL allow us to mak=
e the less strict check we used to</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-         * do. If this less strict check pass, warn user that =
this might not be the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
         * case when its distribution will update to OpenSSL 1.1</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+         * Note that we do not=
 check for netscape certificate type here but rather</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * check for a gneral SSL/TLS cli=
ent purpose. We do not know how long nscert</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+         * attributes are accepted by TLS library i=
n the future. Currently OpenSSL 4.0</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+         * and aws-lc 1.9.0 still consider nscert client as=
 acceptable.</span><br><span>          */</span><br><span>         if (resu=
lt =3D=3D FAILURE)</span><br><span>         {</span><br><span>             =
ASN1_BIT_STRING *ns;</span><br><span>             ns =3D X509_get_ext_d2i(p=
eer_cert, NID_netscape_cert_type, NULL, NULL);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            result =3D (ns &amp;&amp; ASN1_STRING_=
length(ns) &gt; 0 &amp;&amp; (ASN1_STRING_get0_data(ns)[0] &amp; NS_SSL_CLI=
ENT)) ? SUCCESS : FAILURE;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            // bit 0 is to check if certificate is the client certif=
icate</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            re=
sult =3D ASN1_BIT_STRING_get_bit(ns, 0) ? SUCCESS : FAILURE;</span><br><spa=
n>             if (result =3D=3D SUCCESS)</span><br><span>             {</s=
pan><br><span>                 msg(M_WARN, &quot;X509: Certificate is a cli=
ent certificate yet it&#39;s purpose &quot;</span><br><span>@@ -637,22 +639=
,23 @@</span><br><span>     if (usage =3D=3D NS_CERT_CHECK_SERVER)</span><b=
r><span>     {</span><br><span>         /*</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-         * Unfortunately, X509_check_purpose() does so=
me weird thing that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
         * Unfortunately, X509_check_purpose() before OpenSSL 4.0 does some=
 weird thing that</span><br><span>          * prevent it to take a const ar=
gument</span><br><span>          */</span><br><span>         result_t resul=
t =3D</span><br><span>             X509_check_purpose(peer_cert, X509_PURPO=
SE_SSL_SERVER, 0) ? SUCCESS : FAILURE;</span><br><span> </span><br><span>  =
       /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * o=
ld versions of OpenSSL allow us to make the less strict check we used to</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-         * do. If this l=
ess strict check pass, warn user that this might not be the</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-         * case when its distribution=
 will update to OpenSSL 1.1</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+         * Note that we do not check for netscape certificate type =
here but rather</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
     * check for a gneral SSL/TLS server purpose. We do not know how long n=
scert</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * att=
ributes are accepted by TLS library in the future. Currently OpenSSL 4.0</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+         * and aws-lc =
1.9.0 still consider nscert server as acceptable.</span><br><span>         =
 */</span><br><span>         if (result =3D=3D FAILURE)</span><br><span>   =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            AS=
N1_BIT_STRING *ns;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         ns =3D X509_get_ext_d2i(peer_cert, NID_netscape_cert_type, NULL, N=
ULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            resu=
lt =3D (ns &amp;&amp; ASN1_STRING_length(ns) &gt; 0 &amp;&amp; (ASN1_STRING=
_get0_data(ns)[0] &amp; NS_SSL_SERVER)) ? SUCCESS : FAILURE;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            ASN1_BIT_STRING *ns =
=3D X509_get_ext_d2i(peer_cert, NID_netscape_cert_type, NULL, NULL);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            // Server bit =
is 1 for ASN1_BIT_STRING_get_bit</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            result =3D ASN1_BIT_STRING_get_bit(ns, 1) ? SUCCES=
S : FAILURE;</span><br><span>             if (result =3D=3D SUCCESS)</span>=
<br><span>             {</span><br><span>                 msg(M_WARN, &quot=
;X509: Certificate is a server certificate yet it&#39;s purpose &quot;</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1587?usp=3Demail">change 1587</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1587?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I77500d435f212a4bf42ee8cfca0=
7d0285fe694f2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1587 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--pcxBOTNxpeg=--

