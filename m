MIME-Version: 1.0
In-Reply-To: <1476263591-12401-1-git-send-email-arne@...1227...>
References: <20160916161354.GM78279@...1296...>
	<1476263591-12401-1-git-send-email-arne@...1227...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Wed, 12 Oct 2016 07:17:07 -0400
Message-ID: <CAEsd45Tkkmbp=qbgVZxAt-U3hkLBQemOxDGRjTucLCoJPM+bTg@...278...>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi.

On Wed, Oct 12, 2016 at 5:13 AM, Arne Schwabe <arne@...1227...> wrote:
>
> This option was useful when Ipv6 tun support was
> non standard and was an internal/user specified flag
> that tracked the Ipv6 capability of the tun device.
>
> All supported OS support IPv6. Also tun-ipv6 is
> pushable by the remote so not putting tun-ipv6
> does not forbid ipv6 addresses.

How will this patch affect a VPN on a system that has IPv6 disabled?

To prevent information leakage, Tunnelblick has an option in tun mode
that forces the OS to disable IPv6 (via a "networksetup -setv6off" OS
X command.)

The information leakage when using IPv6 in a VPN is described in [1].
As of the date of the article (June 2015), the problem was common
among VPN service providers. The "disable IPv6" feature was added to
Tunnelblick because disabling IPv6 was the only way that a user of
such services could protect themselves. It isn't clear if all VPN
service providers have fixed their configurations yet (or will ever
fix their configurations).

Best regards,

Jon Bullard

[1] http://www.eecs.qmul.ac.uk/~hamed/papers/PETS2015VPN.pdf

