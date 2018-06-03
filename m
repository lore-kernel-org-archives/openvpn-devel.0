References: <20180602034206.9459-1-a@...2181...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <1c15d88e-edd4-ad2d-0596-567715f41e43@...1856...>
Date: Sun, 3 Jun 2018 10:27:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180602034206.9459-1-a@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 1/2] make tls-auth a
 per-connection-block option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Hi,

On 02-06-18 05:42, Antonio Quartulli wrote:
> Different VPN servers may use different tls-auth keys. For this
> reason it is convenient to make tls-auth a per-connection-block
> option so that the user is allowed to specify one key per remote.

Want!  This also helps with tls-auth key rollover.  Feature-ACK.

> If no tls-auth option is specified in a given connection block,
> the global one, if any, is used.
> 
> Trac: #720
> Cc: Steffan Karger <steffan@...1856...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  doc/openvpn.8         |  1 +
>  src/openvpn/init.c    | 10 +++---
>  src/openvpn/options.c | 82 ++++++++++++++++++++++++++++++++++---------
>  src/openvpn/options.h |  5 +++
>  4 files changed, 77 insertions(+), 21 deletions(-)
> 
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 4114f408..e7bc3f4f 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -372,6 +372,7 @@ block:
>  .B remote,
>  .B rport,
>  .B socks\-proxy,
> +.B tls\-auth,
>  .B tun\-mtu and
>  .B tun\-mtu\-extra.

Shouldn't this also include key-direction?

(Didn't really review or test yet, but otherwise looks good at first
glance.)

-Steffan

