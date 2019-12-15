References: <20191213191634.250-1-lstipakov@...277...>
 <20191213191901.300-1-lstipakov@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <3a52ffe7-4da4-be0f-d90f-948e8e9a1cec@...1856...>
Date: Sun, 15 Dec 2019 14:45:55 +0100
MIME-Version: 1.0
In-Reply-To: <20191213191901.300-1-lstipakov@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v6 4/7] wintun: ring buffers based I/O
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

Hi Lev,

Thanks for the update. Even with the latest added fixes and sanity
checks, the resulting code is now 30 lines shorter *and* more readable.

Some last questions / comments inline:

On 13-12-2019 20:19, Lev Stipakov wrote:
> @@ -2099,6 +2115,13 @@ io_wait_dowork(struct context *c, const unsigned int flags)
>          tuntap |= EVENT_READ;
>      }
>  
> +#ifdef _WIN32
> +    if (tuntap_is_wintun(c->c1.tuntap))
> +    {
> +        tuntap = EVENT_READ;
> +    }
> +#endif

Now that the code is refactored, it is clear that for the tuntap case
the code will ignore any of the earlier set flags. Can you maybe add a
comment explaining why the other flags are being ignored?

> +            /* there is a data in wintun ring buffer, read it immediately */

Grammar nit: "there is data" (remove 'a').

Otherwise, as far as stare-at-code goes, I'm fine with this patch now. I
haven't tested it, nor have I reviewed Windows-specific interaction. So
this needs at least one other review from someone able to review those
parts.

Regarding the integration into OpenVPN:

Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

