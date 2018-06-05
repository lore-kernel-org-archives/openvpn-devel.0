Date: Tue, 5 Jun 2018 16:36:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180605143603.GL57262@...1296...>
References: <20180605090421.9746-1-a@...2181...>
 <20180605090421.9746-2-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="yQbNiKLmgenwUfTN"
Content-Disposition: inline
In-Reply-To: <20180605090421.9746-2-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] tun: ensure interface can be
 configured with IPv6 only
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>

--yQbNiKLmgenwUfTN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Prelimiaries: I think this whole series should only go to 2.5, as it
has the potential to be fairly intrusive and uncover hidden bugs - I've
discussed this with Antonio already (and we're in agreement) but for
the sake of the list.


On Tue, Jun 05, 2018 at 05:04:17PM +0800, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
>=20
> This change ensures that an interface is properly brought
> up even when only IPv6 settings are configured.
>=20
> This can be useful on a client that wants to ignore the IPv4
> settings pushed by the server and configure only IPv6.
> To achieve the above, a client can use
> `pull-filter ignore "ifconfig "` (thanks Gert for this hint).
>=20
> Trac: #208
> Cc: Gert Doering <gert@...1296...>
> Signed-off-by: Antonio Quartulli <antonio@...515...>

ACK on the feature, but NAK on "we can do this more nicely" reasons :-)

First, I'd leave off the bits about "this can be useful" of the commit
message - because that's not the point of this patch, you can *ignore*=20
the settings already today.    Maybe word this

  "This patch enables the client to run IPv6-only on the tun/tap interface,
   but will not make it ignore a pushed IPv4 config.  To achieve that, one=
=20
   can use 'pull-filter ignore "ifconfig "' on the client or 'push-filter' =
on
   the server".

(if we want to go into this here at all)


Then, splitting do_ifconfig() in a "we do all in here, except for IPv6,
which is in do_ifconfig_ipv6()" is not looking right - if we do it, do
it right, as in "split out do_ifconfig_ipv4() as well", make things fully
symmetric wrt ipv4/ipv6, and have do_ifconfig() look something like this:

do_ifconfig()
{
   msg (M_DEBUG, "do_ifconfig, ipv4=3D%d, ipv6=3D%d", u
		tt->did_ifconfig_setup, tt->did_ifconfig_ipv6_setup );
   if (tt->did_ifconfig_setup)
      do_ifconfig_ipv4()
   if (tt->did_ifconfig_ipv6_setup)
      do_ifconfig_ipv6()

   if (management)
     management_set_state()
}

... and get rid of the "if (tt->did_ifconfig_setup)" extra nesting level
in do_ifconfig() and do_ifconfig_ipv6().


Of course we'll also need to check if typical consumers of the management=20
interface explode if you're not giving an IPv4 address to them...

Selva, Jonathan, how will our GUI and Tunnelblick handle that?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--yQbNiKLmgenwUfTN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbFp/SAAoJEB2Cnv7KVigSgzQL/R1mQsxu4uA3worbs0XXaX2/
op1si4SaDg3qvln9R+eL2v7mP8ilX2JA+Mr3ykAPsfU1NOXm1HNmaePBW7zNHskO
MUuWHQkHbOwL/fjqxdIl7Rpb6/p22rnLDOKjqBLKjeA9LOVGF4FdpFgP7a5rfUHg
TZswqznCLLLE+pLew9XuoDeCpz6HKowvjgT59Yui28fTPqUuXrDAQMP0a87A0CUj
YQp8a/9xyQjAECmGTPCvYTQEPr8E/BnVHVxGh6rm8VBVfImyu/DpFM+r4ZreDlgT
pCrTiPo83ximI8TSDawilk/RzXVEJ2YISdDf7lMmiiEcVrpJcZTKXvBRjOl5ahZH
KtyS+i8wTA1l3hONqz8oSsazJnJf1lVNhl41danu0WB9bXz3IObljXAN6P0GAk1C
ooempqOTddIc/Q2zmt34uWU1gUnq+Jm7oMlrFmL5VvZ1NcBZWC6Mt+UBJQliFmTz
qTidjXE2BHYRKyProwbwmoyes+3Pl8AQJ6+dltQUwQ==
=qj5P
-----END PGP SIGNATURE-----

--yQbNiKLmgenwUfTN--

