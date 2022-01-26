MIME-Version: 1.0
References: <20220125025128.2117-1-selva.nair@...277...>
 <20220125025128.2117-3-selva.nair@...277...>
 <3682fe69-a2e8-3018-fb29-ca3db9bfffe7@...1227...>
In-Reply-To: <3682fe69-a2e8-3018-fb29-ca3db9bfffe7@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 26 Jan 2022 09:23:29 -0500
Message-ID: <CAKuzo_gJh9Yrj-Qfz_ZWNF2Cd9AqPLfo-CooOO1moHHvNSNJzA@...278...>
Content-Type: multipart/alternative; boundary="000000000000119bd105d67cf3e2"
Subject: Re: [Openvpn-devel] [PATCH 3/3] Support PSS signing using
 pkcs11-helper >= 1.28
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000119bd105d67cf3e2
Content-Type: text/plain; charset="UTF-8"

On Wed, Jan 26, 2022 at 6:50 AM Arne Schwabe <arne@...1227...> wrote:

> Am 25.01.22 um 03:51 schrieb selva.nair@...277...:
> > From: Selva Nair <selva.nair@...277...>
> >
> > - Call pkcs11h_certificate_signAny_ex() when available
> >    so that the signature mechanism parameters can be pased.
> >    (Required for RSA-PSS signature).
> >
> > Signed-off-by: Selva Nair <selva.nair@...277...>
> > ---
> >   src/openvpn/pkcs11_openssl.c | 123 +++++++++++++++++++++++++++++++++--
> >   1 file changed, 118 insertions(+), 5 deletions(-)
> >
> > diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
> > index 9cf46b2c..5d1a5de6 100644
> > --- a/src/openvpn/pkcs11_openssl.c
> > +++ b/src/openvpn/pkcs11_openssl.c
> > @@ -45,10 +45,112 @@
> >   #ifdef HAVE_XKEY_PROVIDER
> >   static XKEY_EXTERNAL_SIGN_fn xkey_pkcs11h_sign;
> >
> > +#if PKCS11H_VERSION > ((1<<16) | (27<<8)) /* version > 1.27 */
> > +
> > +/* Table linking OpenSSL digest NID with CKM and CKG constants in
> PKCS#11 */
> > +#define MD_TYPE(n) {NID_sha##n, CKM_SHA##n, CKG_MGF1_SHA##n}
> > +static const struct
> > +{
> > +   int nid;
> > +   unsigned long ckm_id;
> > +   unsigned long mgf_id;
> > +} mdtypes[] = {MD_TYPE(224), MD_TYPE(256), MD_TYPE(384), MD_TYPE(512),
> > +              {NID_sha1, CKM_SHA_1, CKG_MGF1_SHA1}, /* SHA_1 naming is
> an oddity */
> > +              {NID_undef, 0, 0}};
> > +
> > +/* From sigalg, derive parameters for pss signature and fill in
> pss_params.
> > + * Its of type CK_RSA_PKCS_PSS_PARAMS struct with three fields to be
> filled in:
> > + * {enum hashAlg, enum mgf, ulong sLen}
> > + * where hashAlg is CKM_SHA256 etc., mgf is CKG_MGF1_SHA256 etc.
> > + */
> > +static int
> > +set_pss_params(CK_RSA_PKCS_PSS_PARAMS *pss_params, XKEY_SIGALG sigalg,
> > +               pkcs11h_certificate_t cert)
> > +{
> > +    int ret = 0;
> > +    X509 *x509 = NULL;
> > +    EVP_PKEY *pubkey = NULL;
> > +
> > +    if ((x509 = pkcs11h_openssl_getX509(cert)) == NULL
> > +        || (pubkey = X509_get0_pubkey(x509)) == NULL)
> > +    {
> > +        msg(M_WARN, "PKCS#11: Unable get public key");
> > +        goto cleanup;
> > +    }
> > +
> > +    /* map mdname to CKM and CKG constants for hash and mgf algorithms
> */
> > +    int i = 0;
> > +    int nid = OBJ_sn2nid(sigalg.mdname);
> > +    while (mdtypes[i].nid != NID_undef && mdtypes[i].nid != nid)
> > +    {
> > +        i++;
> > +    }
> > +    pss_params->hashAlg = mdtypes[i].ckm_id;
> > +    pss_params->mgf = mdtypes[i].mgf_id;
> > +
> > +    /* determine salt length */
> > +    int mdsize = EVP_MD_size(EVP_get_digestbyname(sigalg.mdname));
>
> This will break for newer hashes since it relies on nids but we have a
> fixed table anyway, it will break before that. But maybe we should bail
> out if we cannot find an entry in the translation table? Or is
> EVP_MD_size(NID_undef) well defined?
>

EVP_get_digestbyname(mdname) will return NULL if mdname is not recognized
(or has no NID etc), that when passed to EVP_MD_size(NULL) will trigger
an error and return -1 (based on OpenSSL source). So, yes, mdsize will be
wrong (-1), but we will catch it below where we check whether NID was found
in the table.

Not ideal, and you say, may be better to error out earlier if NID is
NID_undef or not in our table, or if EVP_get_digestbyname() returns NULL.

Selva
P.S. If the commit is not pushed yet, I can send a v2 for review, or follow
up with a fixup.

--000000000000119bd105d67cf3e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 26, 2022 at 6:50 AM Arne =
Schwabe &lt;<a href=3D"mailto:arne@...1227...">arne@...1227...</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Am 25.01.22 u=
m 03:51 schrieb <a href=3D"mailto:selva.nair@...277..." target=3D"_blank">s=
elva.nair@...277...</a>:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt; <br>
&gt; - Call pkcs11h_certificate_signAny_ex() when available<br>
&gt;=C2=A0 =C2=A0 so that the signature mechanism parameters can be pased.<=
br>
&gt;=C2=A0 =C2=A0 (Required for RSA-PSS signature).<br>
&gt; <br>
&gt; Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." =
target=3D"_blank">selva.nair@...277...</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0src/openvpn/pkcs11_openssl.c | 123 +++++++++++++++++++++++=
++++++++++--<br>
&gt;=C2=A0 =C2=A01 file changed, 118 insertions(+), 5 deletions(-)<br>
&gt; <br>
&gt; diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl=
.c<br>
&gt; index 9cf46b2c..5d1a5de6 100644<br>
&gt; --- a/src/openvpn/pkcs11_openssl.c<br>
&gt; +++ b/src/openvpn/pkcs11_openssl.c<br>
&gt; @@ -45,10 +45,112 @@<br>
&gt;=C2=A0 =C2=A0#ifdef HAVE_XKEY_PROVIDER<br>
&gt;=C2=A0 =C2=A0static XKEY_EXTERNAL_SIGN_fn xkey_pkcs11h_sign;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +#if PKCS11H_VERSION &gt; ((1&lt;&lt;16) | (27&lt;&lt;8)) /* version &=
gt; 1.27 */<br>
&gt; +<br>
&gt; +/* Table linking OpenSSL digest NID with CKM and CKG constants in PKC=
S#11 */<br>
&gt; +#define MD_TYPE(n) {NID_sha##n, CKM_SHA##n, CKG_MGF1_SHA##n}<br>
&gt; +static const struct<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0int nid;<br>
&gt; +=C2=A0 =C2=A0unsigned long ckm_id;<br>
&gt; +=C2=A0 =C2=A0unsigned long mgf_id;<br>
&gt; +} mdtypes[] =3D {MD_TYPE(224), MD_TYPE(256), MD_TYPE(384), MD_TYPE(51=
2),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {NID_sha1, CKM_SHA_1=
, CKG_MGF1_SHA1}, /* SHA_1 naming is an oddity */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {NID_undef, 0, 0}};<=
br>
&gt; +<br>
&gt; +/* From sigalg, derive parameters for pss signature and fill in=C2=A0=
 pss_params.<br>
&gt; + * Its of type CK_RSA_PKCS_PSS_PARAMS struct with three fields to be =
filled in:<br>
&gt; + * {enum hashAlg, enum mgf, ulong sLen}<br>
&gt; + * where hashAlg is CKM_SHA256 etc., mgf is CKG_MGF1_SHA256 etc.<br>
&gt; + */<br>
&gt; +static int<br>
&gt; +set_pss_params(CK_RSA_PKCS_PSS_PARAMS *pss_params, XKEY_SIGALG sigalg=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pkcs11h_certif=
icate_t cert)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int ret =3D 0;<br>
&gt; +=C2=A0 =C2=A0 X509 *x509 =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 EVP_PKEY *pubkey =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if ((x509 =3D pkcs11h_openssl_getX509(cert)) =3D=3D NUL=
L<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 || (pubkey =3D X509_get0_pubkey(x509)) =
=3D=3D NULL)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;PKCS#11: Unable get pub=
lic key&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* map mdname to CKM and CKG constants for hash and mgf=
 algorithms */<br>
&gt; +=C2=A0 =C2=A0 int i =3D 0;<br>
&gt; +=C2=A0 =C2=A0 int nid =3D OBJ_sn2nid(sigalg.mdname);<br>
&gt; +=C2=A0 =C2=A0 while (mdtypes[i].nid !=3D NID_undef &amp;&amp; mdtypes=
[i].nid !=3D nid)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 i++;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 pss_params-&gt;hashAlg =3D mdtypes[i].ckm_id;<br>
&gt; +=C2=A0 =C2=A0 pss_params-&gt;mgf =3D mdtypes[i].mgf_id;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* determine salt length */<br>
&gt; +=C2=A0 =C2=A0 int mdsize =3D EVP_MD_size(EVP_get_digestbyname(sigalg.=
mdname));<br>
<br>
This will break for newer hashes since it relies on nids but we have a <br>
fixed table anyway, it will break before that. But maybe we should bail <br>
out if we cannot find an entry in the translation table? Or is <br>
EVP_MD_size(NID_undef) well defined?<br></blockquote><div><br></div><div>EV=
P_get_digestbyname(mdname) will return NULL if mdname is not recognized (or=
 has no NID etc), that when passed to EVP_MD_size(NULL) will trigger an=C2=
=A0error and return -1 (based on OpenSSL source). So, yes, mdsize will be w=
rong (-1), but we will catch it below where we check whether NID was found =
in the table.</div><div><br></div><div>Not ideal, and you say, may be bette=
r to error out earlier if NID is NID_undef or not in our table, or if EVP_g=
et_digestbyname() returns NULL.</div><div><br></div><div>Selva=C2=A0</div><=
div>P.S. If the commit is not pushed yet, I can send a v2 for review, or fo=
llow up with a fixup.</div></div></div>

--000000000000119bd105d67cf3e2--

