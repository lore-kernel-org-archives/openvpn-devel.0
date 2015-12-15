MIME-Version: 1.0
In-Reply-To: <56704CD4.5030402@...1147...>
References: <1450131285-30182-1-git-send-email-steffan@...1856...>
	<566FD25F.7080804@...1147...>
	<CAA1AbxJVpBGqOLVzqPpbTPMcO4DQzM=_a9=i+yMHpcPnApDG_A@...278...>
	<566FE713.2090208@...1147...>
	<CAA1AbxJQTFPumc5y3OvGdendwsx7zWhLD4+RWmAYf=FGj7bpeQ@...278...>
	<56704CD4.5030402@...1147...>
From: Steffan Karger <steffan@...1856...>
Date: Tue, 15 Dec 2015 20:02:23 +0100
Message-ID: <CAA1AbxJM1Ek01Gp5RT4gbhWE06wL4HtT1ORDcareppB4hV3nhQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Disable certificate notBefore/notAfter
 sanity check on OpenSSL < 1.0.2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Tue, Dec 15, 2015 at 6:24 PM, Jan Just Keijser <janjust@...1147...> wrote:
> ah well, in that case I would simply write out get0_certificate again: the
> code for that function actually is:
>
> 3011 X509 *SSL_CTX_get0_certificate(const SSL_CTX *ctx)
> 3012 {
> 3013     if (ctx->cert != NULL)
> 3014         return ctx->cert->key->x509;
> 3015     else
> 3016         return NULL;
> 3017 }
>
>
> and as far as I can tell that "struct-path" is also valid for openssl <
> 1.0.2

Yes that was my first attempt to work around it, but ctx->cert is an
opaque struct cert_st (declared in ssl.h, but defined in ssl_locl.h,
which is not in include/openssl/).

-Steffan

