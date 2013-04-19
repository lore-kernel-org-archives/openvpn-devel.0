From: Adriaan de Jong <dejong@...1435...>
Date: Fri, 19 Apr 2013 08:51:40 +0200
Message-ID: <1CED409804E2164C8104F9E623B08B9013BC630BF0@...1436...>
References: <5170496A.6000000@...1737...>
	<20130418204455.GW29506@...1296...>
In-Reply-To: <20130418204455.GW29506@...1296...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Support for libsodium?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>, Ed W <lists@...1737...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

> From: Gert Doering [mailto:gert@...1296...]
> Sent: donderdag 18 april 2013 22:45
>=20
> Hi,
>=20
> On Thu, Apr 18, 2013 at 08:28:42PM +0100, Ed W wrote:
> > Hi, given the new abstractions to support PolarSSL, what
> > interest/resistance would there be to supporting libsodium?
> >      https://github.com/jedisct1/libsodium
>=20
> It took us quite some effort to reach the point where a polarssl-
> compiled openvpn would be able to talk to a (default-configured)
> openssl-openvpn, and I don't really see us using a crypto library that
> has none of the algorithms that we need for interoperability.
>=20
> But then, I'm not the crypto geek here, I'm just the janitor...
>=20

As a (minor) crypto geek, I'd love to see support for NaCl. I'm personally =
very happy with PolarSSL, but it's good to have more options.

There's a few issues that we need to overcome though:

 - Unfortunately as far as I know there's no TLS support in NaCl. I guess i=
t could work as a crypto library for the data channel and TLS-Auth parts of=
 OpenVPN though. The control channel could then still be managed by PolarSS=
L/OpenSSL.

 - Maintenance is an issue, are you (or do you know someone :)) willing to =
take responsibility for writing the required patches and maintaining them?

 - As Gert said, he default algorithm in OpenVPN is Blowfish with a SHA-1 H=
MAC. There's no support for auto-negotiation, so using NaCl will break comp=
atibility with an OpenSSL/PolarSSL-based OpenVPN. This is minor though, as =
it's easy to work around this as an end-user by specifying the algorithms i=
n the client and server config files.

I don't want to sound overly negative though, the crypto abstraction in Ope=
nVPN is flexible enough to support this sort of hybrid multi-library implem=
entation now. At first glance, it would just require some tweaks to the bui=
ld system, and some glue for libsodium.

Adriaan

