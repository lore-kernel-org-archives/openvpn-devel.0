References: <CAAUX2SVQRn4zuDC947HE9M38nDNK1oNqyUv0GKeAw2dasHo62Q@...278...>
 <ad7e8624-6f87-2874-9786-d5de521bc6a2@...2181...>
 <f10fc09e-5d7b-c678-02f8-04f80f004b24@...2181...>
 <CAAUX2SU9u8sdsN08ynDTVD15q+qP0yOF-RxMzF5hMRg-pFCWFg@...278...>
 <CAAUX2SXiT1=-5HtKzQRay-R1zreT0_7QpEvjc40H3-0U2nqcAA@...278...>
 <d967fd98-6dd9-fe05-cac8-83fb022e4ea4@...2181...>
 <CAAUX2SVLseVOawC=m-Cs38jEjAtNcHzvHcUeDLpjTK6oYi1nvQ@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <aa0abb28-9256-d2df-0426-e1beb8ac8f40@...2181...>
Date: Thu, 1 Apr 2021 09:07:22 +0200
MIME-Version: 1.0
In-Reply-To: <CAAUX2SVLseVOawC=m-Cs38jEjAtNcHzvHcUeDLpjTK6oYi1nvQ@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [ovpn-dco] sudden network disconnection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Tony He <huangya90@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Arne Schwabe <arne@...1227...>

Hi,

Thanks for providing the info.

On 01/04/2021 09:01, Tony He wrote:
> % ifconfig ovpn-dco0
> ovpn-dco0: flags=81<UP,POINTOPOINT,RUNNING>  mtu 1500

>  % ifconfig ovpn-dco0
> ovpn-dco0: flags=81<UP,POINTOPOINT,RUNNING>  mtu 1500

These values are not what ovpn-dco would set by default.

> log from openvpn client:
> 2021-04-01 14:57:31 net_iface_mtu_set: mtu 1500 for ovpn-dco0

Mhh, I presume the openvpn2 client still sets 1500 MTU as default, while
it should just leave the MTU value alone when no link-mtu was specified
by the user.

Arne, I presume this is a change that could be applied to your dco branch?

Tony, in the meantime, setting the link-mtu to something lower than 1500
is the proper workaround.

Thanks.
Regards,


-- 
Antonio Quartulli

