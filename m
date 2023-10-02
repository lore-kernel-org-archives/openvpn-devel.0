Message-ID: <781cc541-86c5-21f8-a104-2b5f32676159@...1227...>
Date: Mon, 2 Oct 2023 10:05:34 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20231001174920.54154-1-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20231001174920.54154-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Log OpenSSL errors on failure to set
 certificate
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

Am 01.10.23 um 19:49 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> Currently we log a bogus error message saying private key password verification
> failed when SSL_CTX_use_cert_and_key() fails in pkcs11_openssl.c. Instead print
> OpenSSL error queue and exit promptly.
> 
> Also log OpenSSL errors when SSL_CTX_use_certiifcate() fails in cryptoapi.c
> and elsewhere. Such logging could be useful especially when the ceritficate is
> rejected by OpenSSL due to stricter security restrictions in recent versions
> of the library.

Yeah, looks good.

Acked-By: Arne Schwabe <arne@...1227...>


