Date: Thu, 9 Feb 2023 15:55:40 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y+UJbEFponFT1Qak@...2685...>
References: <20230209142248.455120-1-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20230209142248.455120-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Add 'allow-compression stub-only
 and refuse framing with 'allow-compression no'
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Text-only review:

On Thu, Feb 09, 2023 at 03:22:47PM +0100, Arne Schwabe wrote:
> This changes the "no" setting of allow-compression to also refuse framing. This
> is important for our DCO implementation as these do not implement framing.

"implementations"

> This behaviour surfaced when a commercial VPN provider was pushing
> "comp-lzo no" to a client with DCO. While we are technically at fault here
> for announcing comp-lzo no support by announcing IV_LZO_STUB=1, the
> VPN provider continues to push "comp-lzo no" even in absense of that
> flag.
> 
> As the new default we default to allow-compression stub-only if a stub option
> is found in the config and to allow-compression no otherwise. This ensures
> that we only enable DCO when no compression framing is used.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  Changes.rst                           |  5 +++
>  doc/man-sections/protocol-options.rst |  3 ++
>  src/openvpn/comp.c                    | 32 +++++++++--------
>  src/openvpn/comp.h                    |  2 +-
>  src/openvpn/dco.c                     |  4 +--
>  src/openvpn/options.c                 | 50 +++++++++++++++++++++------
>  6 files changed, 66 insertions(+), 30 deletions(-)
> 
> diff --git a/Changes.rst b/Changes.rst
> index c5335ce93..3a573cc9a 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -223,6 +223,11 @@ User-visible Changes
>    compatibility with older versions. See the manual page on the
>    ``--compat-mode`` for details.
>  
> +- (OpenVPN 2.6.1) ``--allow-compression no`` has been changed to not allow
> +  compression or compression framing at all now and is the new default.

Remove "now". Redundant and doesn't make the sentence clearer.

> +  Use ``--allow-compression stub-only`` for the old ``no`` behaviour of OpenVPN
> +  2.5 and OpenVPN 2.6.0.
> +
>  Common errors with OpenSSL 3.0 and OpenVPN 2.6
>  ----------------------------------------------
>  Both OpenVPN 2.6 and OpenSSL 3.0 tighten the security considerable, so some
> diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
> index 685f40391..027fa0593 100644
> --- a/src/openvpn/comp.h
> +++ b/src/openvpn/comp.h
> @@ -60,7 +60,7 @@
>                                              * we still accept other compressions to be pushed */
>  #define COMP_F_MIGRATE              (1<<5) /* push stub-v2 or comp-lzo no when we see a client with comp-lzo in occ */
>  #define COMP_F_ALLOW_ASYM           (1<<6) /* Compression was explicitly set to allow asymetric compression */
> -
> +#define COMP_F_ALLOW_NOCOMP_ONLY    (1<<7) /* Do not allow compression framing like stub v2 or comp-lzo no. Breaks DCO */

This sounds like this setting breaks DCO. But I think you mean compression framing breaks
DCO, right? So maybe ". Breaks DCO" => "which breaks DCO" ? Or change to something
like "Only DCO-compatible mode".

>  /*
>   * Length of prepended prefix on compressed packets

Regards,
-- 
  Frank Lichtenheld

