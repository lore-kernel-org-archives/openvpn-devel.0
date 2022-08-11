Message-ID: <1da7a43c-d5d2-69dd-7f07-b412568083d1@...1227...>
Date: Thu, 11 Aug 2022 14:21:14 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220811120722.29168-1-maximilian.fillinger@...2507...>
 <20220811120722.29168-2-maximilian.fillinger@...2507...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220811120722.29168-2-maximilian.fillinger@...2507...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Handle EVP_MD_CTX as an opaque
 struct
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
To: Max Fillinger <maximilian.fillinger@...2507...>, openvpn-devel@lists.sourceforge.net

Am 11.08.22 um 14:07 schrieb Max Fillinger:
> Building OpenVPN on the latest OpenBSD snapshot failed because EVP_MD_CTX
> is an opaque struct in LibreSSL now. Therefore, call md_ctx_new() instead
> of declaring them on the stack. When they're not on the stack anymore, we
> don't have to call EVP_MD_CTX_init() anymore, but we need to call
> EVP_MD_CTX_free() instead of cleanup.

Urgh. The whole reason I left this code with the EVP_MD_CTX is that it 
is OpenSSL 1.0.2 only and I expected to be able to remove it sooner or 
later. So LibreSSL doeds not support the alternative API for that?

     EVP_PKEY_CTX *pctx = EVP_PKEY_CTX_new_id(EVP_PKEY_TLS1_PRF, NULL);

is what we use for OpenSSL 1.1.0+

I am not happy to soon have LibreSSL specific code in our code but it 
seems like if want to continue that library, we have to.

The change looks good itself.

Acked-By: Arne Schwabe <arne@...1227...>

