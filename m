Date: Wed, 11 Jan 2023 13:40:50 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y76uUkSUP2scgLlu@...2685...>
References: <20230111120728.1099815-1-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20230111120728.1099815-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Deprecate OCC checking
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

On Wed, Jan 11, 2023 at 01:07:28PM +0100, Arne Schwabe wrote:
> - Move OCC warnings to debug level. This moves the only useful OCC message
>   of compress-migrate to D_PUSH
> - remove configure option --enable-strict-options
> - ignore disable-occ in TLS mode as it is logged under debug now only
>   disable-occ is now strictly a non-TLS option
> - mark opt-verify and disable-occ as deprecated.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  Changes.rst                          |  6 ++++++
>  configure.ac                         |  1 -
>  doc/man-sections/generic-options.rst |  3 ++-
>  doc/man-sections/server-options.rst  |  4 ++--
>  src/openvpn/errlevel.h               |  3 ++-
>  src/openvpn/init.c                   |  2 --
>  src/openvpn/options.c                | 12 +++++++-----
>  src/openvpn/ssl.c                    |  5 ++---
>  8 files changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/Changes.rst b/Changes.rst
> index 187d03fcf..35337a483 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -183,6 +183,12 @@ PF (Packet Filtering) support has been removed
>     This implies that also ``--management-client-pf`` and any other compile
>     time or run time related option do not exist any longer.
>  
> +Option conflict checking is being deprecated and phased out
> +    The static option checking is no longer useful in typical setup that
> +    negotiate most connection parameters. The ``--opt-verify`` and
> +    ``--occ-disable`` are deprecated and the configure option

I would suggest "``./configure`` option" just to make it clear that this
is talking about build-time configuration option. Alternatively we could
actually write "build configuration option".

> +    enable-strict-options has been removed. Logging of mismatched options has
> +    been moved to debug logging.
>  
>  User-visible Changes
>  --------------------

Regards,
-- 
  Frank Lichtenheld

