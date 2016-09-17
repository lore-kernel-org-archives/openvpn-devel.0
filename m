MIME-Version: 1.0
In-Reply-To: <1474116820-16824-1-git-send-email-lstipakov@...277...>
References: <5643AC41.6090501@...1856...>
	<1474116820-16824-1-git-send-email-lstipakov@...277...>
From: Steffan Karger <steffan@...1856...>
Date: Sat, 17 Sep 2016 15:07:43 +0200
Message-ID: <CAA1Abx+mo5c3EgOW6iOJuH7p-7LUK36syygt+-NjSeGTLoDH-A@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] Support for disabled peer-id
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
To: Lev Stipakov <lstipakov@...277...>
Cc: Lev Stipakov <lev.stipakov@...2164...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 17 September 2016 at 14:53, Lev Stipakov <lstipakov@...277...> wrote:
> From: Lev Stipakov <lev.stipakov@...2164...>
>
> v3:
> * move assert outside of loop
> * add max-clients value check to options
>
> [...]
>
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -5893,6 +5893,11 @@ add_option (struct options *options,
>           msg (msglevel, "--max-clients must be at least 1");
>           goto err;
>         }
> +      if (max_clients >= 0xFFFFFF) /* max peer-id value */
> +       {
> +         msg (msglevel, "--max-clients must be less than 0xFFFFFF");
> +         goto err;
> +       }
>        options->max_clients = max_clients;
>      }
>    else if (streq (p[0], "max-routes-per-client") && p[1] && !p[2])

Thanks.  One more nitpick though.  There are quite some occurrences of
0xFFFFFF now.  I think a #define MAX_PEER_ID 0xFFFFFF is warranted.

And if you do so, please change to error message to print the decimal
value, since that is also how we expect users to specify the
--max-clients argument.

-Steffan

