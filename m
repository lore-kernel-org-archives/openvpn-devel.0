From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 1 Apr 2026 11:54:53 +0000
In-Reply-To: <gerrit.1774445432000.I5158fbb0762443ea4954e5745f520e83e019ed30@...2715...>
References: <gerrit.1774445432000.I5158fbb0762443ea4954e5745f520e83e019ed30@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <29166cbd1c6d228805969a39730fe4ac8b3aa6ce-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ztNaW3f3Im8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Do not access
 internals of ASN1_INTEGER to print hex of serial
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ztNaW3f3Im8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change by plaisthos. ( http://gerrit.=
openvpn.net/c/openvpn/+/1589?usp=3Demail )

Change subject: Do not access internals of ASN1_INTEGER to print hex of ser=
ial
......................................................................


Patch Set 4:

(1 comment)

File src/openvpn/ssl_verify_openssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1589/comment/c7682b24_7bdda5a6?usp=3D=
email :
PS4, Line 320:     char *ret =3D format_hex_ex(buf, len_serial, 0, 1, ":", =
gc);
> I changed this to use BN_bn2hex only to find out that then test fails sin=
ce we have : in the output  [=E2=80=A6]
For reference the change with BN_bn2hex:

/** Wrapper around OpenSSL_free
 *
 * Passing OPENSSL_free to gc_add_special does not work
 * since OPENSSL_free is a macro, so use this small wrapper
 * to allow passing this function instead */
static void
opensl_free_wrapper(void *arg)
{
    OPENSSL_free(arg);
}


char *
backend_x509_get_serial_hex(openvpn_x509_cert_t *cert, struct gc_arena *gc)
{
    const ASN1_INTEGER *asn1_i =3D X509_get_serialNumber(cert);
    BIGNUM *bn_serial =3D ASN1_INTEGER_to_BN(asn1_i, NULL);
    char *ret =3D BN_bn2hex(bn_serial);

    gc_addspecial(ret, opensl_free_wrapper, gc);
    BN_free(bn_serial);

    return ret;
}



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1589?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5158fbb0762443ea4954e5745f520e83e019ed30
Gerrit-Change-Number: 1589
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 01 Apr 2026 11:54:53 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Comment-In-Reply-To: flichtenheld <frank@...2641...>

--ztNaW3f3Im8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1589?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_verify_openssl=
.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1589/comment/c7682b24_7bdda5a6?usp=3Demail">Pa=
tch Set #4, Line 320:</a> <code style=3D"font-family:monospace,monospace"> =
   char *ret =3D format_hex_ex(buf, len_serial, 0, 1, &quot;:&quot;, gc);</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">I changed this to use BN_bn2hex only to find out that =
then test fails since we have : in the output  [=E2=80=A6]</blockquote></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>For reference the change with BN_bn2hex:</p><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">/** Wrapper arou=
nd OpenSSL_free<br> *<br> * Passing OPENSSL_free to gc_add_special does not=
 work<br> * since OPENSSL_free is a macro, so use this small wrapper<br> * =
to allow passing this function instead */<br>static void<br>opensl_free_wra=
pper(void *arg)<br>{<br>    OPENSSL_free(arg);<br>}</pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><br>=
char *<br>backend_x509_get_serial_hex(openvpn_x509_cert_t *cert, struct gc_=
arena *gc)<br>{<br>    const ASN1_INTEGER *asn1_i =3D X509_get_serialNumber=
(cert);<br>    BIGNUM *bn_serial =3D ASN1_INTEGER_to_BN(asn1_i, NULL);<br> =
   char *ret =3D BN_bn2hex(bn_serial);</pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">    gc_addspecial=
(ret, opensl_free_wrapper, gc);<br>    BN_free(bn_serial);</pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">    return ret;<br>}</pre></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1589?usp=3Demail">change 1589</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1589?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5158fbb0762443ea4954e5745f5=
20e83e019ed30 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1589 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: flichtenheld &lt;frank@...2641...&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 01 Apr 2026 11:54:53=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>

</body></html>=

--ztNaW3f3Im8=--

