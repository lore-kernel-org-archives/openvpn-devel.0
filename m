References: <CAKuzo_gJK_1jU5juC1YQzKzm=25Cm+c-3X7-pT1DW_fkkW_9dQ@...278...>
 <6fd65f21-7f90-b2a1-7cb6-67559d60d8e1@...1435...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <a5a2341f-ff5f-0f7a-f2ca-da576bd4d76d@...1227...>
Date: Wed, 3 Jan 2018 09:34:29 +0100
MIME-Version: 1.0
In-Reply-To: <6fd65f21-7f90-b2a1-7cb6-67559d60d8e1@...1435...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] openvpn segfaults on --management-external-key
 with ECC certificate
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan.karger@...1435...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 03.01.18 um 09:19 schrieb Steffan Karger:
> On 03-01-18 03:22, Selva Nair wrote:
>> This is with openssl 1.0.1 and that could be the problem -- it may not
>> have EVP_PKEY_get0_RSA() in which case the compatibility interface in
>> use is probably not smart enough...
> 
> Exactly this is the case I think.  The following should solve the issue:
> 
> --- a/src/openvpn/openssl_compat.h
> +++ b/src/openvpn/openssl_compat.h
> @@ -240,7 +240,7 @@ X509_OBJECT_get_type(const X509_OBJECT *obj)
>  static inline RSA *
>  EVP_PKEY_get0_RSA(EVP_PKEY *pkey)
>  {
> -    return pkey ? pkey->pkey.rsa : NULL;
> +    return (pkey && pkey->type == EVP_PKEY_RSA) ? pkey->pkey.rsa : NULL;
>  }
>  #endif
> 
> (No time to properly test and send a patch now, will look into it more
> later if nobody else does.)

You are right. This is also what OpenSSL 1.1.0  does:

RSA *EVP_PKEY_get0_RSA(EVP_PKEY *pkey)
{
    if (pkey->type != EVP_PKEY_RSA) {
        EVPerr(EVP_F_EVP_PKEY_GET0_RSA, EVP_R_EXPECTING_AN_RSA_KEY);
        return NULL;
    }
    return pkey->pkey.rsa;
}

Arne

