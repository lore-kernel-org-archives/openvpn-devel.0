MIME-Version: 1.0
References: <20200806190140.9637-1-tincanteksup@...277...>
In-Reply-To: <20200806190140.9637-1-tincanteksup@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 6 Aug 2020 15:27:09 -0400
Message-ID: <CAKuzo_h_VRDBt4C76KXcrX0STyf0iP4sjq5DbZvOnXaFpkOp2A@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Improve error msg when all TAP adapters
 are in use "or disabled"
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

Hi,

This looks good but can we do better? We don't check the error
(GetLastError()) after the CreateFile() failure -- can we determine
whether the error was due to permissions, busy file (in use) or
disabled device and print out a more specific error message? I'm not
sure what errors are triggered by CreateFile, so just wondering..

Selva

On Thu, Aug 6, 2020 at 3:02 PM Richard Bonhomme <tincanteksup@...277...> wrote:
>
> Ref: https://github.com/OpenVPN/openvpn-gui/issues/356
>
> Signed-off-by: Richard Bonhomme <tincanteksup@...277...>
> ---
>  src/openvpn/tun.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index cc7b65cf..44ca8450 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -6436,7 +6436,7 @@ tun_open_device(struct tuntap *tt, const char *dev_node, const char **device_gui
>
>              if (!*device_guid)
>              {
> -                msg(M_FATAL, "All %s adapters on this system are currently in use.", print_windows_driver(tt->windows_driver));
> +                msg(M_FATAL, "All %s adapters on this system are currently in use or disabled.", print_windows_driver(tt->windows_driver));
>              }
>
>              if (tt->windows_driver != windows_driver)
> --
> 2.17.1
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

