Date: Mon, 19 Dec 2022 13:18:27 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y6BWk4Za7GjzcFt9@...2685...>
References: <20221218195810.1216368-1-selva.nair@...277...>
MIME-Version: 1.0
In-Reply-To: <20221218195810.1216368-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Reduce default restart pause to 1 second
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
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

On Sun, Dec 18, 2022 at 02:58:10PM -0500, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
> 
> Current value of restart pause is 5 seconds which feels
> unduly long. Reduce it to 1 second.
> 
> User can still customize the delay using the first parameter for
> "--connect-retry".
> 
> Also improve the description of "--connect-retry" in the
> man page.

Some comments about that part:
 
> diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
> index 07651479..37d24044 100644
> --- a/doc/man-sections/client-options.rst
> +++ b/doc/man-sections/client-options.rst
> @@ -138,7 +138,7 @@ configuration.
>    Set ``--verb 6`` for debugging info showing the transformation of
>    src/dest addresses in packets.
>  
> ---connect-retry n
> +--connect-retry n [max]

This breaks the formatting, because rst option lists are stupid and
only expect zero or one arguments.
Needs to use the "args" -> "valid syntaxes" pattern seen elsewhere
in the documentation.

>    Wait ``n`` seconds between connection attempts (default :code:`5`).

You didn't actually adapt the default here.

>    Repeated reconnection attempts are slowed down after 5 retries per
>    remote by doubling the wait time after each unsuccessful attempt. An

Regards,
-- 
  Frank Lichtenheld

