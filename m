Date: Wed, 24 May 2023 18:06:22 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZG41/misxYNR+gp/@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
References: <20230509154657.2756-1-gianmarco@...2726...>
MIME-Version: 1.0
In-Reply-To: <20230509154657.2756-1-gianmarco@...2726...>
Subject: Re: [Openvpn-devel] [PATCH] Persist-key: enable persist-key option
 by default.
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
To: Gianmarco De Gregori <gianmarco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, May 09, 2023 at 05:46:58PM +0200, Gianmarco De Gregori wrote:
> This commit changes the default behavior of
> the OpenVPN configuration to enable the
> persist-key option by default.
> 
> This means that all the key file content will be kept
> in memory throughout the lifetime of the VPN connection.
> 
> Fixes: Trac #1405
> Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
> ---
>  doc/man-sections/generic-options.rst |  2 ++
>  src/openvpn/init.c                   | 12 ++----------
>  src/openvpn/options.c                | 23 +++++++++++------------
>  src/openvpn/options.h                |  1 -
>  4 files changed, 15 insertions(+), 23 deletions(-)
> 
> diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
> index 97e1b5aa..5f74ab67 100644
> --- a/doc/man-sections/generic-options.rst
> +++ b/doc/man-sections/generic-options.rst
> @@ -303,6 +303,8 @@ which mode OpenVPN is configured as.
>    lower priority, ``n`` less than zero is higher priority).
>  
>  --persist-key
> +  DEPRECATED OPTION, corresponding behavior is now always enabled.

The usual style in the documentation seems to be "**DEPRECATED**". See
e.g. --disable-occ in the same file.

> +
>    Don't re-read key files across :code:`SIGUSR1` or ``--ping-restart``.
>  
>    This option can be combined with ``--user`` to allow restarts
[...]
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 2680f268..9ef21bc9 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c


Please also add (DEPRECATED) marker in usage_message.

[...]

Regards,
-- 
  Frank Lichtenheld

