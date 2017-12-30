From: Steffan Karger <steffan@...1856...>
References: <20171126141555.25930-1-steffan@...1856...>
 <20171130085330.mftz2f3vnx53vrz6@...2352...>
Message-ID: <06b2118d-61b7-aa56-93ba-b2d342c78d34@...1856...>
Date: Sat, 30 Dec 2017 12:00:49 +0100
MIME-Version: 1.0
In-Reply-To: <20171130085330.mftz2f3vnx53vrz6@...2352...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/3] Fix --tls-version-min and
 --tls-version-max for OpenSSL 1.1+
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Bernhard Schmidt <berni@...376...>
Cc: openvpn-devel@lists.sourceforge.net, Kurt Roeckx <kurt@...2310...>

Hi Bernard, Kurt,

On 30-11-17 09:53, Bernhard Schmidt wrote:
>> As described in <80e6b449-c536-dc87-7215-3693872bce5a@...376...> on
>> the openvpn-devel mailing list, --tls-version-min no longer works with
>> OpenSSL 1.1.  Kurt Roeckx posted in a debian bug report:
>>
>> "This is marked as important because if you switch to openssl 1.1.0
>> the defaults minimum version in Debian is currently TLS 1.2 and
>> you can't override it with the options that you're currently using
>> (and are deprecated)."
>>
>> This patch is loosely based on the original patch by Kurt, but solves the
>> issue by adding functions to openssl-compat.h, like we also did for all
>> other openssl 1.1. breakage.  This results in not having to add more ifdefs
>> in ssl_openssl.c and thus cleaner code.
> 
> I have forwarded your patch to Kurt and asked for feedback. See attached
> mail.
> 
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=873302#32

Thanks!

On 29-11-17 20:14, Kurt Roeckx wrote:
> I have some comments:

Also thanks!

> - It has:
> +/* TLS Version defines are new in OpenSSL 1.1 */
> +#ifndef TLS1_0_VERSION
> +#define TLS1_0_VERSION 0x0301
> +#endif
> +#ifndef TLS1_1_VERSION
> +#define TLS1_1_VERSION 0x0302
> +#endif
> +#ifndef TLS1_2_VERSION
> +#define TLS1_2_VERSION 0x0303
> +#endif
> 
> It's TLS1_VERSION (not TLS1_0_VERSION)

Oops, will fix.

> The defines all exist in at least 1.0.1, the version that added
> support for TLS 1.1 and 1.2

Good, then we won't need this in master.  (But we do in release/2.4
because there we still support 0.9.8 as suse still maintains it.)

> - It calls SSL_CTX_set_min_proto_version() unconditionally,
>   overriding the library default. In the 1.0.2 case SSLv2 and
>   SSLv3 are then disabled, in the 1.1 case it could enable SSLv3.

This is something I pondered about, and once again now you mention it.
OpenVPN < 2.3.4 (and OpenSSL < 1.0.1), which are still widely used by
our user base, do not support TLS 1.1+.  Combined with the fact that
many HTTPS-style TLS attacks do not work for OpenVPN (the record layer
data is not attacker controlled like in browser), I opted to just fix
the minimum at 1.0 and keep the code slightly simpler.

But I think it's okay to confront users with old cruft, and follow the
system defaults.  Since users can re-enable TLS 1.0 if they really want,
I think that should be okay.  The v2 of this patch will obey the system
defaults.

> - openssl_tls_version() should probably add SSL3_VERSION support.

Nope - OpenVPN never supported SSLv3 and never will.

-Steffan

