References: <20211019034118.28987-1-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <4d80604c-b112-c3d5-4f54-a07962e3f7fe@...1227...>
Date: Tue, 19 Oct 2021 12:22:37 +0200
MIME-Version: 1.0
In-Reply-To: <20211019034118.28987-1-selva.nair@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 1/3] Require Windows CNG keys for
 cryptoapicert
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

Am 19.10.21 um 05:41 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> Some legacy tokens do not have drivers compatible with
> Windows Cryptography Next generation API (CNG) and require
> the old CAPI interface. These also do not support anything
> but RSA_PKCS1 signatures with MD5+SHA1 digests, and can only
> handle TLS 1.1 and older. Continuing to support these add
> too much maintenance burden especially with newer version of
> OpenSSL and has very little benefit.
> 
> - Remove support for non CNG interface which also removes
>   support for such legacy tokens. Keys uploaded to Windows
>   certificate stores are not affected.
> 
> - Remove support for OpenSSL versions < 1.1.1 in Windows
>   builds
> 
> Note: TLS 1.0 and 1.1 is still supported. Only signing with legacy
> tokens that have drivers incompatible with CNG is affected. These
> can still be used with pkcs11-helper.
> 
> Tested on Windows 10 with RSA and EC keys in store
> 

Acked-By: Arne Schwabe <arne@...1227...>

I haven't tested it myself but the code change looks good and supporting
keys that only support TLS 1.1 is indeed silly nowadays.

Arne


