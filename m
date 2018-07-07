Date: Sat, 7 Jul 2018 10:49:15 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180707084915.GP989@...1296...>
References: <BN6PR04MB088248FC428ABCF529D3CFD5DD460@...2438...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="BLwZsoChvJp3+clz"
Content-Disposition: inline
In-Reply-To: <BN6PR04MB088248FC428ABCF529D3CFD5DD460@...2438...>
Subject: Re: [Openvpn-devel] OpenVPN Connect App on IOS // Support for
 IPv6-only networks with DNS64/NAT64
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kristian McColm <kristianmccolm@...160...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--BLwZsoChvJp3+clz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jul 07, 2018 at 01:27:23AM +0000, Kristian McColm wrote:
> Is anyone aware of whether the developers of this application
> have any experience testing the IOS version of the app on IOS devices
> on IPv6-only networks, and moreover are the developers aware of and
> ensuring the app is compliant with Apple standards for IPv6-only
> networks as documented here: https://developer.apple.com/support/ipv6?

Part of OpenVPN's test cycle has been ("for ages") to connect over IPv6-
transport, and then put IPv4+IPv6 into the tunnel.
--BLwZsoChvJp3+clz--
