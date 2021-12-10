Date: Fri, 10 Dec 2021 17:17:30 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1582627291.849748.1639153050584@...2642...>
In-Reply-To: <20211207170211.3275837-7-arne@...1227...>
References: <20211207170211.3275837-1-arne@...1227...>
 <20211207170211.3275837-7-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 06/21] Remove post_open_mtu code
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

> Arne Schwabe <arne@...1227...> hat am 07.12.2021 18:01 geschrieben:
> This code is probably from a time when we could not set the MTU on
> the Windows tap6 driver. Nowadays we can set the MTU on this device,
> so this code is a noop now.
[...]
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 75d5eaf7b..12bdd2005 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -6071,7 +6071,6 @@ tuntap_get_mtu(struct tuntap *tt)
>                          &mtu, sizeof(mtu),
>                          &mtu, sizeof(mtu), &len, NULL))
>      {
> -        tt->post_open_mtu = (int)mtu;
>          msg(D_MTU_INFO, "TAP-Windows MTU=%d", (int)mtu);
>      }
>  }

This change makes no sense to me. Why would you not remove the complete tuntap_get_mtu call? If the whole point was to get the MTU, and now it will be the one we set, why even to the ioctl at all?

Regards,
  Frank
--
Frank Lichtenheld

