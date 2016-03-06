Date: Sun, 6 Mar 2016 22:48:50 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160306214850.GY24952@...1296...>
References: <CAKuzo_jrTKkAWGv7gRoADPWz5VTDFPqfrHxUDppPuQ63Y+RFKA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ChEms48zFi6DdgnO"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jrTKkAWGv7gRoADPWz5VTDFPqfrHxUDppPuQ63Y+RFKA@...278...>
Subject: Re: [Openvpn-devel] operations that still require elevation on
 windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--ChEms48zFi6DdgnO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 06, 2016 at 03:17:40PM -0500, Selva Nair wrote:
> There at least two more things on windows that the interactive service has
> to support:
>=20
> (i)  register-dns

Indeed, this seems to be missing today.

> (ii) ipv6 address and route setup
>=20
> Is there anything else? For (ii)  can't it be done using the IP Helper API
> on vista+ -- is the use of net command required? If not, it should be easy
> to delegate it to the service.

... but this should all be nicely done...?

tun.c, around line 1390:

        if (tt->options.msg_channel)
          {
            do_address_service (true, AF_INET6, tt);
          }
        else
          {
            /* example: netsh interface ipv6 set address interface=3D42 200=
1:608:8
003::d store=3Dactive */

and route.c, add_route_ipv6()

...
#elif defined (WIN32)

  if (tt->options.msg_channel)
    status =3D add_route_ipv6_service (r6, tt);
  else
...


Looking at interactive.c, "HandleAddressMessage()" uses=20
CreateUnicastIpAddressEntry(), which according to my reading of MSDN
supports IPv4 and IPv6.  It's filled using "sockaddr_inet()", which
actually does IPv4 and IPv6 even if the name doesn't suggest so:

static SOCKADDR_INET
sockaddr_inet (short family, inet_address_t *addr)
{
  SOCKADDR_INET sa_inet;
  ZeroMemory (&sa_inet, sizeof (sa_inet));
  sa_inet.si_family =3D family;
  if (family =3D=3D AF_INET)
    sa_inet.Ipv4.sin_addr =3D addr->ipv4;
  else if (family =3D=3D AF_INET6)
    sa_inet.Ipv6.sin6_addr =3D addr->ipv6;
  return sa_inet;
}

So, we should be fine - and I'm fairly sure it actually works as one of
my test cases was "unprivileged user, iservice, VPN tunnel has IPv6".


Now, I have no clue whether this might be a deprecated API, and something
in the IP Helper API suite is "better" - just pointing out that we seem
to be actually fine regarding IPv6 address and route.

(HandleRouteMessage() uses CreateIpForwardEntry2(), so that's also=20
IPv4+IPv6)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ChEms48zFi6DdgnO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVtylwakuBuNlUUl1AQJJmQP9EYRu8NE5b6cVsbXQw40DvhHxvDw8eB6V
M2ZX3PCmzuZa91dbTIqE6O7HDGPlZdUOAv81E7QUrRQp2QySXmUyH0/PmjTLNWq5
cZqlaG1gYXIGbk3srS40xlwyil5f/uZ6SsDpcULB6nRqUJ1lol5c+ZSjiEio5bsN
2Wdin6YQl2Y=
=wZkQ
-----END PGP SIGNATURE-----

--ChEms48zFi6DdgnO--

