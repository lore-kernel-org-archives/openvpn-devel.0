References: <1483152307-15687-1-git-send-email-selva.nair@...277...>
From: debbie10t <debbie10t@...277...>
Message-ID: <403b6c99-f62f-6d7e-f3b7-ec207505ca3d@...277...>
Date: Sun, 1 Jan 2017 15:49:06 +0000
MIME-Version: 1.0
In-Reply-To: <1483152307-15687-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Always release dhcp address in
 close_tun()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

I applied this to 2.5 and used the build system to build windows 
installer using windows-nsis/build-snapshot

I tested the windows client against Linux 2.4

The test was:

Connect to first server, receive DHCP 10.*8*.0.6 (net30)
Idle 10 mins / Transfer some data / disconnect

Edit the config file to connect to a new server
(This was an exact copy of first server on a new --port
and with a new --server subnet / PKI identical)

Connect to second server, receive DHCP 10.*9*.0.6 (net30)
Idle 10 mins / Transfer some data / disconnect

No problems encountered.

Note: I *was* able to replicate the original bug using
windows 10 / openvpn 2.4.0 and the same procedure as above.

I am confident that this resolves the problem for Win10.
ACK for W10

Regards



On 31/12/16 02:45, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>
> Also make sure --dhcp-pre-release results in not just dhcp_release()
> in open_tun() but a subsequent dhcp_renew() as well. Else dhcp transaction
> gets aborted as this call to release() happens after the adapter status
> is changed to connected.
>
> Alternatively, the undocumented --dhcp-pre-release may be removed.
>
> Fixes Trac #807 (but can't say the same for Trac #665 without knowing
> how to reproduce it)
>
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  src/openvpn/tun.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index f812844..31fcd67 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -6056,6 +6056,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
>              if (tt->options.dhcp_pre_release)
>              {
>                  dhcp_release(tt);
> +                dhcp_renew(tt);
>              }
>              if (tt->options.dhcp_renew)
>              {
> @@ -6224,10 +6225,7 @@ close_tun(struct tuntap *tt)
>          }
>  #endif
>
> -        if (tt->options.dhcp_release)
> -        {
> -            dhcp_release(tt);
> -        }
> +        dhcp_release(tt);
>
>          if (tt->hand != NULL)
>          {
>

