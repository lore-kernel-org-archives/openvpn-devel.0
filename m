References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-20-arne@...1227...>
From: Max Fillinger <maximilian.fillinger@...2507...>
Message-ID: <8c6bf41d-9c46-2f09-d3bb-4e3899adc956@...2507...>
Date: Wed, 27 Oct 2021 17:14:02 +0200
MIME-Version: 1.0
In-Reply-To: <20211019183127.614175-20-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 19/21] Add insecure tls-cert-profile
 options
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 19/10/2021 20:31, Arne Schwabe wrote:
> The recent deprecation of SHA1 certificates in OpenSSL 3.0 makes it necessary
> to reallow them in certain deployments. Currently this works by using the
> hack of using tls-cipher "DEFAULT:@SECLEVEL=0". Add insecure as option to
> tls-cert-profile to allow setting a seclevel of 0.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

This makes insecure the default mode:

> +    if (!profile || 0 == strcmp(profile, "insecure"))
> +    {
> +        SSL_CTX_set_security_level(ctx->ctx, 0);
> +    }
> +    else if (!profile || 0 == strcmp(profile, "legacy"))
>       {
>           SSL_CTX_set_security_level(ctx->ctx, 1);
>       }
> 

When we don't pass a tls-cert-profile option, profile is NULL here, so 
it takes the first branch.

