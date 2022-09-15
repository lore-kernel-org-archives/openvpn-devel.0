Date: Thu, 15 Sep 2022 14:15:24 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <YyMXXCg1UPIUNYYg@...2678...>
References: <20220915120349.239-1-lstipakov@...277...>
MIME-Version: 1.0
In-Reply-To: <20220915120349.239-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] doc: add "ovpn-dco" to usage and man
 page
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

Did you not move the "(default)" to ovpn-dco since the other
patch, that makes ovpn-doc the default, is not merged, yet?

Patch is certainly correct relative to current master, so
Acked-by: Frank Lichtenheld <frank@...2641...>

On Thu, Sep 15, 2022 at 03:03:49PM +0300, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
> 
> While on it, remove redundant sentence
> and quotation from --windows-driver man
> description.
> 
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  doc/man-sections/windows-options.rst | 8 ++++----
>  src/openvpn/options.c                | 1 +
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/doc/man-sections/windows-options.rst b/doc/man-sections/windows-options.rst
> index c389fbc4..0c7cfc1d 100644
> --- a/doc/man-sections/windows-options.rst
> +++ b/doc/man-sections/windows-options.rst
> @@ -238,7 +238,7 @@ Windows-Specific Options
>    logged when this is found in the configuration file.
>  
>  --windows-driver drv
> -  Specifies which tun driver to use. Values are :code:`tap-windows6`
> -  (default) and :code:`wintun`.  This is a Windows-only option.
> -  :code:`wintun`" requires ``--dev tun`` and the OpenVPN process to run
> -  elevated, or be invoked using the Interactive Service.
> +  Specifies which tun driver to use. Values are :code:`ovpn-dco`,
> +  :code:`tap-windows6` (default) and :code:`wintun`. :code:`wintun` requires
> +  ``--dev tun`` and the OpenVPN process to run elevated, or be invoked using
> +  the Interactive Service.
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index d7954ebc..0eef3b3d 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -749,6 +749,7 @@ static const char usage_message[] =
>      "--show-net-up   : Show " PACKAGE_NAME "'s view of routing table and net adapter list\n"
>      "                  after TAP adapter is up and routes have been added.\n"
>      "--windows-driver   : Which tun driver to use?\n"
> +    "                     ovpn-dco\n"
>      "                     tap-windows6 (default)\n"
>      "                     wintun\n"
>      "--block-outside-dns   : Block DNS on other network adapters to prevent DNS leaks\n"
> -- 
> 2.23.0.windows.1

-- 
  Frank Lichtenheld

