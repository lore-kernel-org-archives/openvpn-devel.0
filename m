MIME-Version: 1.0
References: <20200701011018.31364-1-tincanteksup@...277...>
In-Reply-To: <20200701011018.31364-1-tincanteksup@...277...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Thu, 2 Jul 2020 09:41:23 -0400
Message-ID: <CAEsd45QTnQqWOgDv0u_v2640YSok+2W_zXJ7dgn061eR8Aov9A@...278...>
Subject: Re: [Openvpn-devel] [Patch] New man page corrections -
 windows-options.rst
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Richard Bonhomme <tincanteksup@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Improves English diction and/or grammar of man page.

Acked-by: Jonathan K. Bullard <jkbullard@...277...>

On Tue, Jun 30, 2020 at 9:11 PM Richard Bonhomme <tincanteksup@...277...> wrote:
>
> Signed-off-by: Richard Bonhomme <tincanteksup@...277...>
> ---
>  doc/man-sections/windows-options.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/doc/man-sections/windows-options.rst b/doc/man-sections/windows-options.rst
> index 5ae7116c..72424d6b 100644
> --- a/doc/man-sections/windows-options.rst
> +++ b/doc/man-sections/windows-options.rst
> @@ -231,7 +231,7 @@ Windows-Specific Options
>    directive is not specified, OpenVPN will use the SystemRoot environment
>    variable.
>
> -  This option have changed behaviour in OpenVPN 2.3. Earlier you had to
> +  This option has changed behaviour since OpenVPN 2.3. Earlier you had to
>    define ``--win-sys env`` to use the SystemRoot environment variable,
>    otherwise it defaulted to :code:`C:\\WINDOWS`. It is not needed to use
>    the ``env`` keyword any more, and it will just be ignored. A warning is
> @@ -239,7 +239,7 @@ Windows-Specific Options
>
>  --windows-driver drv
>    Specifies which tun driver to use. Values are :code:`tap-windows6`
> -  (default) and :code:`wintun`.  This is Windows-only option.
> +  (default) and :code:`wintun`.  This is a Windows-only option.
>    :code:`wintun`" requires ``--dev tun`` and the OpenVPN process to run
>    elevated, or be invoked using the Interactive Service.
>
> --
> 2.17.1
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

