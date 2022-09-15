Date: Thu, 15 Sep 2022 12:23:14 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <YyL9Eu3Q3m4fDmmL@...2678...>
References: <YyH6RL7q13+juVuJ@...2685...>
 <20220914184337.158-1-lstipakov@...277...>
MIME-Version: 1.0
In-Reply-To: <20220914184337.158-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3] Use DCO on Windows by default
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

On Wed, Sep 14, 2022 at 09:43:37PM +0300, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
[...]
>  v3:
>   - simplify #ifdefs, as per Frank's suggestions
> 
[...]
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 2e567571..e615a71e 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -183,7 +183,7 @@ static const char usage_message[] =
>      "                  does not begin with \"tun\" or \"tap\".\n"
>      "--dev-node node : Explicitly set the device node rather than using\n"
>      "                  /dev/net/tun, /dev/tun, /dev/tap, etc.\n"
> -#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))
> +#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32))

Any particular reason you left this one in?

>      "--disable-dco   : Do not attempt using Data Channel Offload.\n"
>  #endif
>      "--lladdr hw     : Set the link layer address of the tap device.\n"

Regards,
-- 
  Frank Lichtenheld

