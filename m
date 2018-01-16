From: Arne Schwabe <arne@...1227...>
References: <1515959073-10376-1-git-send-email-selva.nair@...277...>
 <1515959073-10376-4-git-send-email-selva.nair@...277...>
Message-ID: <932660f8-ce6b-ab8f-f561-638f4443e2b0@...1227...>
Date: Tue, 16 Jan 2018 23:40:32 +0100
MIME-Version: 1.0
In-Reply-To: <1515959073-10376-4-git-send-email-selva.nair@...277...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH 3/3] Document management request
 >ECDSA_SIGN and response ecdsa-sig
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
To: selva.nair@...277..., "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 14.01.18 um 20:44 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  doc/management-notes.txt | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/doc/management-notes.txt b/doc/management-notes.txt
> index a9ba18a..e2e8249 100644
> --- a/doc/management-notes.txt
> +++ b/doc/management-notes.txt
> @@ -795,6 +795,36 @@ Base64 encoded output of RSA_private_encrypt() (OpenSSL) or mbedtls_pk_sign()
>  This capability is intended to allow the use of arbitrary cryptographic
>  service providers with OpenVPN via the management interface.
>  
> +COMMAND -- ecdsa-sig (OpenVPN 2.5 or higher)
> +------------------------------------------
> +Same as rsa-sig but for EC keys: requires openssl 1.1
> +
> +Provides support for external storage of the EC private key. Requires the
> +--management-external-key option. This option can be used instead of "key"
> +in client mode, and allows the client to run without the need to load the
> +actual private key. When the SSL protocol needs to perform a sign
> +operation, the data to be signed will be sent to the management interface
> +via a notification as follows:
> +
> +>ECDSA_SIGN:[BASE64_DATA]
> +
> +The management interface client should then create a DER encoded signature of
> +the (decoded) BASE64_DATA using the private key and return the SSL signature as
> +follows:
> +
> +ecdsa-sig
> +[BASE64_SIG_LINE]
> +.
> +.
> +.
> +END
> +
> +Base64 encoded output of ECDSA_sign() (OpenSSL) or mbedtls_pk_sign()
> +(mbed TLS) will provide a correct signature.
> +

Signature.getInstance("NONEwithECDSA") worked for me in Java for this.
Any other signature algorithm did _NOT_ work e.g. SHA384withECDSA. I
think ecdsa-sign might already provided a hash to sign.

On the other hand mbedtls documentation states:

   For RSA, md_alg may be MBEDTLS_MD_NONE if hash_len != 0. For
   ECDSA md_alg may never be MBEDTLS_MD_NONE.

So this interface might not work with mbedtls.

Arne

Acked-By: Arne Schwabe



