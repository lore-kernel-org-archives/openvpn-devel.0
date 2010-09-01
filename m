Date: Wed, 1 Sep 2010 10:48:28 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100901084828.GU10703@...1296...>
References: <AANLkTina=B8Z8v2euOJYjZxMQhJ9WB6UMdY0qtnc_qyT@...278...>
	<4C7CD670.4030706@...1147...> <4C7CDAD7.9070500@...1294...>
	<20100831113136.GJ10703@...1296...> <4C7CFD59.8080707@...1294...>
	<20100831165110.GK10703@...1296...> <4C7E0A83.3060206@...1294...>
	<20100901082202.GR10703@...1296...> <4C7E10E9.8000000@...1294...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mgIE+9cwyCTt+85Z"
Content-Disposition: inline
In-Reply-To: <4C7E10E9.8000000@...1294...>
Subject: Re: [Openvpn-devel] Netmask OpenVPN Server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Eike Lohmann <e.lohmann@...1294...>
Cc: openvpn-devel@lists.sourceforge.net

--mgIE+9cwyCTt+85Z
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Sep 01, 2010 at 10:38:01AM +0200, Eike Lohmann wrote:
> We are working with static assignments and if the 2 networks are side by
> side I can recompile the code and define a larger mask.
>=20
> We don't have client-2-client and didn't use the ifconfig-pool.

In that case, all this doesn't really matter.  Just add as many "route"
and "push route" statements as you have networks.  (There's no size limit=20
for "route").

The limitation in the "server" statement for the network is there
because it implicitely defines the ifconfig-pool - "server" is a macro
that translates "server <base-ip> <netmask>" to

  mode server
  tls-server=20
  push "topology <xxx>"
  ifconfig <base-ip +1> <base-ip +2>
  ifconfig-pool <base-ip + 4> <last-ip-4>
  push "route <base-ip> <netmask>"


So for your setup, you could do:

  # first network, used for tun on server and for pool (if needed)
  server 172.16.0.0 255.255.0.0
  # second network: routed to openvpn process, available for ifconfig-push
  route 10.1.0.0 255.255.0.0
  push "route 10.1.0.0 255.255.0.0"
  # third network
  # ...

(this is the lazy way, still using "server" with the first network, but
you could indeed do it without any pool on the server side by explicitely
spelling everything out that "server" configures for you)

> Is this also working if I have 2 networks far away from each other (10.x
> and 192.168.x), with defining a 'all your base belong to us' netmask in
> the code e.g. 0.0.0.0 :)

No, because then OpenVPN would signal the Linux side "the internet is
behind OpenVPN, route everything to me!".

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--mgIE+9cwyCTt+85Z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iQCVAwUBTH4TXKkuBuNlUUl1AQI5vwQAi5PQST1cXzv6xCri6j2cuSpCjfBzwXpO
ZTJacz01r9LfHsEcky8Nef61lr3xFrqIihLTvpxqFO7g+l55nrXMR/DC8VVMOnuS
4TupZlFncnB0O6Zhugaa+9bJwXZles78ghM7h6ZgIAwxWnMGywrmG40vQAGXme4X
pw3npRcCzt0=
=o0BR
-----END PGP SIGNATURE-----

--mgIE+9cwyCTt+85Z--

