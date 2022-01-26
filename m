Message-ID: <3682fe69-a2e8-3018-fb29-ca3db9bfffe7@...1227...>
Date: Wed, 26 Jan 2022 12:50:48 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20220125025128.2117-1-selva.nair@...277...>
 <20220125025128.2117-3-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220125025128.2117-3-selva.nair@...277...>
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

Am 25.01.22 um 03:51 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> - Call pkcs11h_certificate_signAny_ex() when available
>    so that the signature mechanism parameters can be pased.
>    (Required for RSA-PSS signature).
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>   src/openvpn/pkcs11_openssl.c | 123 +++++++++++++++++++++++++++++++++--
>   1 file changed, 118 insertions(+), 5 deletions(-)
> 
> diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
> index 9cf46b2c..5d1a5de6 100644
> --- a/src/openvpn/pkcs11_openssl.c
> +++ b/src/openvpn/pkcs11_openssl.c
> @@ -45,10 +45,112 @@
>   #ifdef HAVE_XKEY_PROVIDER
>   static XKEY_EXTERNAL_SIGN_fn xkey_pkcs11h_sign;
>   
> +#if PKCS11H_VERSION > ((1<<16) | (27<<8)) /* version > 1.27 */
> +
> +/* Table linking OpenSSL digest NID with CKM and CKG constants in PKCS#11 */
> +#define MD_TYPE(n) {NID_sha##n, CKM_SHA##n, CKG_MGF1_SHA##n}
> +static const struct
> +{
> +   int nid;
> +   unsigned long ckm_id;
> +   unsigned long mgf_id;
> +} mdtypes[] = {MD_TYPE(224), MD_TYPE(256), MD_TYPE(384), MD_TYPE(512),
> +              {NID_sha1, CKM_SHA_1, CKG_MGF1_SHA1}, /* SHA_1 naming is an oddity */
> +              {NID_undef, 0, 0}};
> +
> +/* From sigalg, derive parameters for pss signature and fill in  pss_params.
> + * Its of type CK_RSA_PKCS_PSS_PARAMS struct with three fields to be filled in:
> + * {enum hashAlg, enum mgf, ulong sLen}
> + * where hashAlg is CKM_SHA256 etc., mgf is CKG_MGF1_SHA256 etc.
> + */
> +static int
> +set_pss_params(CK_RSA_PKCS_PSS_PARAMS *pss_params, XKEY_SIGALG sigalg,
> +               pkcs11h_certificate_t cert)
> +{
> +    int ret = 0;
> +    X509 *x509 = NULL;
> +    EVP_PKEY *pubkey = NULL;
> +
> +    if ((x509 = pkcs11h_openssl_getX509(cert)) == NULL
> +        || (pubkey = X509_get0_pubkey(x509)) == NULL)
> +    {
> +        msg(M_WARN, "PKCS#11: Unable get public key");
> +        goto cleanup;
> +    }
> +
> +    /* map mdname to CKM and CKG constants for hash and mgf algorithms */
> +    int i = 0;
> +    int nid = OBJ_sn2nid(sigalg.mdname);
> +    while (mdtypes[i].nid != NID_undef && mdtypes[i].nid != nid)
> +    {
> +        i++;
> +    }
> +    pss_params->hashAlg = mdtypes[i].ckm_id;
> +    pss_params->mgf = mdtypes[i].mgf_id;
> +
> +    /* determine salt length */
> +    int mdsize = EVP_MD_size(EVP_get_digestbyname(sigalg.mdname));

This will break for newer hashes since it relies on nids but we have a 
fixed table anyway, it will break before that. But maybe we should bail 
out if we cannot find an entry in the translation table? Or is 
EVP_MD_size(NID_undef) well defined?

Arne

