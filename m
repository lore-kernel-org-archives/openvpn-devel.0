References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-6-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <eeed072a-8693-254d-791d-a6f6a4748d00@...1856...>
Date: Thu, 21 Oct 2021 21:26:21 +0200
MIME-Version: 1.0
In-Reply-To: <20211019183127.614175-6-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 05/21] [OSSL 3.0] Use EVP_PKEY based
 API for loading DH keys
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
To: openvpn-devel@lists.sourceforge.net

Hi,

Just a nit:

On 19-10-2021 20:31, Arne Schwabe wrote:
> +    if (!SSL_CTX_set0_tmp_dh_pkey(ctx->ctx, dh))
> +    {
> +        crypto_msg(M_FATAL, "SSL_CTX_set_tmp_dh");
> +    }

This error message looks incorrect and incomplete.

-Steffan

