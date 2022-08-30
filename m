Message-ID: <0a688831-bcdb-b53c-c2c7-2b7ed2cf865f@...2181...>
Date: Tue, 30 Aug 2022 14:20:44 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220829190124.2636045-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220829190124.2636045-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Adjust Linux+FreeBSD DCO device name
 handling to 'non DCO linux style'
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 29/08/2022 21:01, Gert Doering wrote:
> On Linux, tun devices are created according to the following algorithm
>    --dev tun    -> try tun0, tun1, ... tun255, use first free
>    --dev anything -> create a TUN device named "anything"
> (as long as "anything" is not "null" or "tap[N]")
> 
> DCO was following the "other platform convention", where everything
> not having a digit was iterated ("--dev tun-home" -> "tun-home0") -
> which does not work for classic tun/tap devices on the BSDs anyway,
> so is not the best model.
> 
> Adjust open_tun_dco_generic() to document expected behaviour and
> do the thing.
> 
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>   src/openvpn/tun.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 94803acd..94b0d322 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -1943,12 +1943,14 @@ open_tun_dco_generic(const char *dev, const char *dev_type,
>       }
>   
>       /*
> -     * dynamic open is indicated by --dev specified without
> -     * explicit unit number.  Try opening DCO device named "[dev]n"
> -     * where n = [0, 255].
> +     * unlike "open_tun_generic()", DCO on Linux and FreeBSD follows
> +     * the device naming model of "non-DCO linux", that is:
> +     *   --dev tun         -> try tun0, tun1, ... tun255, use first free
> +     *   --dev <anything>  -> (try to) create a tun device named "anything"
> +     * ("--dev tap" and "--dev null" are caught earlier and not handled here)
>        */
>   
> -    if (!tun_name_is_fixed(dev))
> +    if (strcmp(dev,"tun") == 0)

you need to add a space after the ','.

>       {
>           for (int i = 0; i < 256; ++i)
>           {


Other than that you get a 2nd ACK:

Acked-by: Antonio Quartulli <a@...2181...>

I wonder if we should document this behaviour somewhere else? i.e. manpage?

It seems that even us developers are puzzled by what it is supposed to 
happen.

Cheers,

-- 
Antonio Quartulli

