Message-ID: <3022a3a7-53cb-e73f-bbc9-78b3c79ccd41@...1227...>
Date: Fri, 10 Mar 2023 14:20:23 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20230309131419.29157-1-a@...2181...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20230309131419.29157-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3] dco: print version to log if
 available
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Am 09.03.23 um 14:14 schrieb Antonio Quartulli:
> In order to provide better support in case of troubleshooting issues,
> it's important to know what exact DCO version is loaded on the user
> system.
> 
> Therefore print the DCO version during bootup.
> 
> For Windows and FreeBSD we currently implement a placeholder printing 'v0'.
> This should be improved with a follow-up patch.
> 
> For Linux we directly fetch the module version from /sys and print
> something like:
> 
> 	DCO version: 0.1.20230206-15-g580608ec7c59
> 
> Change-Id: Ie1f6fa5d12a473d353d84fd119c2430b638e8bcd
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
> Changes from v1:
> * beautify usage of buf with some helpers
> * don't apply -1 to buffer capacity as fgets will already read one byte
>    less than provided length and will add a null terminator there
> 
> Changes from v2:
> * fix style of type returned by dco_version_string() (uncrustify doesn't
>    work anymore on my box..due to incompatibler config)

any more, incompatible



>       return true;
>   }
>   
> +const char *
> +dco_version_string(struct gc_arena *gc)
> +{
> +    struct buffer out = alloc_buf_gc(256, gc);
> +    FILE *fp = fopen("/sys/module/ovpn_dco_v2/version", "r");
> +    if (!fp)


Note: this patch should only merged after "dco: don't use NetLink to 
exchange control packets" as it uses the same API version as that patch.

Acked-By: Arne Schwabe <arne@...1227...>

