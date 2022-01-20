Message-ID: <effdbfae-81ea-c784-77a8-379ce5ba9b35@...1227...>
Date: Thu, 20 Jan 2022 11:54:54 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20211214165928.30676-1-selva.nair@...277...>
 <20211214165928.30676-9-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20211214165928.30676-9-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3 08/18] Add a function to encode
 digests with PKCS1 DigestInfo wrapper
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
> The EVP_PKEY interface as well as provider passes the raw
> digest to the sign() function. In case of RSA_PKCS1,
> our management interface expects an encoded hash, which
> has the DigestInfo header added as per PKCSv1.5 specs,
> unless the hash algorithm is legacy MD5_SHA1.
> 
> Fix this by
>   - add a function to perform the pkcs1 encoding before passing the
>     data to sign to the management interface. The implementation
>     is not pretty, but should work.
>     (Unfortunately OpenSSL does not expose a function for this).
> 
> Note:
> 1. cryptoki interface used by pkcs11-helper also requires this
> to be done before calling the Sign op. This will come handy there
> too.
> 2. We have a similar function in ssl_mbedtls.c but its not prettier,
>     and require porting.
> 
> v2 changes: Use hard-coded headers for known hash algorithms instead
> of assembling it from the ASN.1 objects.


Acked-By: Arne Schwabe <arne@...1227...>



