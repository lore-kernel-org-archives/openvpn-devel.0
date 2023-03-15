Message-ID: <86d0213e-dd5a-5ee8-f83c-306a9c173afc@...1227...>
Date: Wed, 15 Mar 2023 09:44:34 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20230311052403.1154030-1-selva.nair@...277...>
 <20230314122134.1248576-1-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20230314122134.1248576-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] Bugfix: Convert ECDSA signature form
 pkcs11-helper to DER encoded form
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
Cc: Florian Apolloner <florian@...2720...>

Am 14.03.23 um 13:21 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> - With OpenSSL 3.0 and xkey-provider, we use pkcs11h_certificate_signAny_ex()
>    which returns EC signature as raw r|s concatenated. But OpenSSL expects
>    a DER encoded ASN.1 structure.
> 
>    Do this conversion as done in cryptoapi.c. For code re-use, ecdsa_bin2sig()
>    is consolidated with sig to DER conversion as ecdsa_bin2der() and
>    moved to xkey_helper.c
> 
>    In the past when we used OpenSSL hooks installed by pkcs11-helper,
>    such a conversion was not required as it was internally handled by
>    the library.

Even though the commit is quite long, it is mostly moving the 
ecdsa_bin2der function into xkey_helper.c. While I have not tested it 
myself the code changes make sense and look good and we got a positive 
test report.

Acked-By: Arne Schwabe <arne@...1227...>




