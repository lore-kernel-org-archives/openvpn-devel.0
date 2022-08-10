Date: Wed, 10 Aug 2022 11:31:34 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <YvN69hGHat3gwP9C@...2685...>
References: <20220802082316.1424-1-a@...2181...>
 <20220802130312.18871-1-a@...2181...>
MIME-Version: 1.0
In-Reply-To: <20220802130312.18871-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] dco: move availability check to the
 end of check_option_conflict() function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

FWIW I put this through the buildbot as a test for the new
extended t_client tests on the docker workers and it caused
no issues. Also ran the t_client tests on my DCO-enabled
Ubuntu 22 laptop. I did not do any more specific tests.

Changes look sensible to me, so
Acked-By: Frank Lichtenheld <frank@...2641...>

On Tue, Aug 02, 2022 at 03:03:12PM +0200, Antonio Quartulli wrote:
> To better arrange the order DCO option conflict messages are printed, we
> decided to first perform all needed checks on provided options and, only
> at the end, if no conflict was detected, to check if DCO is really
> available on the system.
> 
> This way a user gets prompted with all warnings about their
> configuration first and, when everything is fixed, they will see if DCO
> is available or not.
> 
> While at it, compress the first check in just one if to make the code
> simpler.
> 
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
> 
> Changes from v1:
> * pass proper argument to dco_available()
> ---
>  src/openvpn/dco.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
> index a6912d4e..0877f0af 100644
> --- a/src/openvpn/dco.c
> +++ b/src/openvpn/dco.c
> @@ -268,18 +268,11 @@ dco_check_option_conflict_ce(const struct connection_entry *ce, int msglevel)
>  bool
>  dco_check_option_conflict(int msglevel, const struct options *o)
>  {
> -    if (o->tuntap_options.disable_dco)
> -    {
> -        /* already disabled by --disable-dco, no need to print warnings */
> -        return false;
> -    }
> -
> -    if (!dco_available(msglevel))
> -    {
> -        return false;
> -    }
> -
> -    if (!o->dev)
> +    /* check if DCO was already disabled by the user or if no dev name was
> +     * specified at all. In the latter case, later logic will most likely stop
> +     * OpenVPN, so no need to print any message here.
> +     */
> +    if (o->tuntap_options.disable_dco || !o->dev)
>      {
>          return false;
>      }
> @@ -361,7 +354,10 @@ dco_check_option_conflict(int msglevel, const struct options *o)
>      }
>      gc_free(&gc);
>  
> -    return true;
> +    /* now that all options have been confirmed to be supported, check if DCO is
> +     * truly available on the system
> +     */
> +    return dco_available(msglevel);
>  }
>  

-- 
  Frank Lichtenheld

