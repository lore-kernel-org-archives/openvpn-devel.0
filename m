Message-ID: <cbb446dd-729c-1faa-5375-ef24277f8491@...1227...>
Date: Thu, 20 Jan 2022 12:12:23 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20211214165928.30676-1-selva.nair@...277...>
 <20211214165928.30676-15-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20211214165928.30676-15-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3 14/18] pkcs11: Interface the xkey
 provider with pkcs11-helper
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

Am 14.12.21 um 17:59 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> - Load the 'private key' handle through the provider and set it in
>    SSL_CTX
> - Add a sign op function to interface provider with pkcs11-helper.
>    Previously we used its "OpenSSL Session" which internally sets up
>    callbacks in RSA and EC key methods. Not useful for the provider
>    interface, so, we directly call the PKCS#11 sign operation
>    as done with mbedTLS.
> - tls_libctx is made global for accessing from pkcs11_openssl.c
> 
>    Supports ECDSA and RSA_PKCS1_PADDING signatures. PSS support
>    will be added when pkcs11-helper with our PR for specifying
>    CK_MECHANISM variable in sign operations is released.
>    (i.e., next release of pkcs11-helper).
> 

Acked-By: Arne Schwabe <arne@...1227...>


