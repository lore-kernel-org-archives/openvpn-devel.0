References: <20160916161354.GM78279@...1296...>
	<1476263591-12401-1-git-send-email-arne@...1227...>
	<CAEsd45Tkkmbp=qbgVZxAt-U3hkLBQemOxDGRjTucLCoJPM+bTg@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <026a4dab-8aac-7edb-4f58-4fbacfe56795@...1227...>
Date: Wed, 12 Oct 2016 14:08:51 +0200
MIME-Version: 1.0
In-Reply-To: <CAEsd45Tkkmbp=qbgVZxAt-U3hkLBQemOxDGRjTucLCoJPM+bTg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v4] Remove tun-ipv6 Option. Instead
 assume that IPv6 is always supported.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: "Jonathan K. Bullard" <jkbullard@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>



Am 12.10.16 um 13:17 schrieb Jonathan K. Bullard:
> Hi.
>
> On Wed, Oct 12, 2016 at 5:13 AM, Arne Schwabe <arne@...1227...> wrote:
>> This option was useful when Ipv6 tun support was
>> non standard and was an internal/user specified flag
>> that tracked the Ipv6 capability of the tun device.
>>
>> All supported OS support IPv6. Also tun-ipv6 is
>> pushable by the remote so not putting tun-ipv6
>> does not forbid ipv6 addresses.
> How will this patch affect a VPN on a system that has IPv6 disabled?
>
>
Short version: Fail as miserable as before.

tun-ipv6 is not saying "My OS can do IPv6" but more "My OS has the
required calls to configure a IPv6 tun". It came from a time when
configuring/sending IPv6 packets into a non IPv6 prepared tun screwed
things ups. You might think that leaving out tun-ipv6 might fix your
problem but tun-ipv6 is a pushable option and the server-ipv6 macro will
push it, so you end up with tun-ipv6 without having it in the client config.

You can do pull-filter tun-ipv6 or disable pulling all together but then
again you can do also pull-filter ifconfig-ipv6 and pull-filter
route-ipv6 which is a cleaner way then letting those commands fails (and
probably also the connection attempt).

The option really serves no good purposse anymore. If someone really
wants a disable IPv6 option this option isn't it.

Arne

