From: Heiko Hund <heiko@...2662...>
Date: Wed, 14 Sep 2022 17:13:41 +0200
Message-ID: <10170681.nUPlyArG6x@...2664...>
In-Reply-To: <20220824125858.81885-1-arne@...1227...>
References: <20220520213250.3126372-1-arne@...1227...>
 <20220824125858.81885-1-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v3] Implement AUTH_FAIL,
 TEMP message support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Mittwoch, 24. August 2022 14:58:58 CEST Arne Schwabe wrote:
> Patch v3: cleanup parse_auth_failed_temp to use a simple const string
>           instead of a buffer

Besides the pending rebase and the one code smell below:
Acked-by: Heiko Hund <heiko@...2662...>

>  src/openvpn/openvpn.vcxproj.filters  |   3 +

This file is gone in the meantime

>  src/openvpn/ssl.c                    |  13 ++--

Doesn't apply to master anymore

> +parse_auth_failed_temp(struct options *o, const char *reason)
> +{
> +    struct gc_arena gc = gc_new();
> +    /* skip TEMP */
> +    const char *message = reason + strlen("TEMP");

This should be checked more. Or probably better, "reason" should be passed 
from the outside as "reason + 4".





