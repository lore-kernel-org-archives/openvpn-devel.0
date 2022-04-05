Date: Tue, 5 Apr 2022 12:14:23 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1653915871.596525.1649153663382@...2642...>
In-Reply-To: <20220402070902.30282-7-a@...2181...>
References: <20220402070902.30282-1-a@...2181...>
 <20220402070902.30282-7-a@...2181...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 6/7] ovpn-dco-win: introduce windows
 data-channel offload support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Cc: Lev Stipakov <lev@...515...>



> Antonio Quartulli <a@...2181...> hat am 02.04.2022 09:09 geschrieben:
[...]
> diff --git a/README.dco.md b/README.dco.md
> index 27c166b9..d3599727 100644
> --- a/README.dco.md
> +++ b/README.dco.md
> @@ -109,6 +116,8 @@ Limitations by design
>  - topology subnet is the only supported `--topology` for servers
>  - iroute directives install routes on the host operating system, see also
>    routing with ovpn-dco
> +- (ovpn-dco-win) client and p2p mode only
> +- (ovpn-dco-win) only AES-GCM-128/192/256 cipher support

This seems to be out-of-sync with the code. The code seems to add CHACHA20-POLY1305 support
on Windows 11.

As seen here:
> +
> +const char *
> +dco_get_supported_ciphers()
> +{
> +    /*
> +     * this API can be called either from user mode or kernel mode,
> +     * which enables us to probe driver's chachapoly support
> +     * (available starting from Windows 11)
> +     */
> +
> +    BCRYPT_ALG_HANDLE h;
> +    NTSTATUS status = BCryptOpenAlgorithmProvider(&h, L"CHACHA20_POLY1305", NULL, 0);
> +    if (BCRYPT_SUCCESS(status))
> +    {
> +        BCryptCloseAlgorithmProvider(h, 0);
> +        return "AES-128-GCM:AES-256-GCM:AES-192-GCM:CHACHA20-POLY1305";
> +    }
> +    else
> +    {
> +        return "AES-128-GCM:AES-256-GCM:AES-192-GCM";
> +    }
> +}
> +

Regards,
--
Frank Lichtenheld

