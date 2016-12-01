Date: Thu, 1 Dec 2016 13:37:26 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161201123726.GL78624@...1296...>
References: <1480545687-19365-1-git-send-email-davids@...515...>
	<a2f41141-898c-d317-0481-3ce6ce6a9082@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dFWYt1i2NyOo1oI9"
Content-Disposition: inline
In-Reply-To: <a2f41141-898c-d317-0481-3ce6ce6a9082@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] push: Provide a warning if
 --ifconfig-push have argument mismatch with --topology
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net, David Sommerseth <davids@...515...>

--dFWYt1i2NyOo1oI9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 01, 2016 at 01:31:31PM +0100, Arne Schwabe wrote:
> Am 30.11.16 um 23:41 schrieb David Sommerseth:
> > This adds a warning to the log file if --topology is configured to use
> > subnet or net30 and the 'subnet mask' argument of an --ifconfig-push op=
tion
> > is not an subnet mask.  The check done is to ensure the first octet is =
0xff (255)
>
> But way you actually want to test is
>=20
> if topology =3D=3D subnet or net30:
>    if gateway not in net(ip, mask):
>       print ("Your gw and ip and netmask disagree!)
>=20
> right? And isn't there code that gets executed for the client side that
> can be disabled by ifconfig-nowarn. Can we reuse that code?

That is certainly something we should test as well, but the particular
case I had in mind was

 - someone uses --topology p2p
 - they have ccd/ files with "ifconfig-push 10.4.0.14 10.4.0.13"
   (for some clients that need to get a static address)
 - they change their server.conf to --topology subnet
 - everything works for "dynamic clients", but the static client now
   receives "10.4.0.13" and interprets it as a "netmask", which will
   cause the most interesting things, depending on platform code

so the idea was to help this case by looking at only the "netmask" thing,
and see if it makes sense (simplified sense: starts with 255.) - and if
not, log this on the server side right when reading the ccd/ file so
the admin in question can see "oh, I overlooked *that* special client".

(Since that happened to a friend of mine based on my advice, I know that
this is not a purely theoretical possibility :-) )

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--dFWYt1i2NyOo1oI9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYQBmGAAoJEB2Cnv7KVigSrZYL/RllFptHUDMbgMcXewQOhc6G
LdEuo7+BR/SEK08aa5xhihUXU4IEpQQbAu56iQye19XXKgZfpBNhqiEP5omDPUeZ
t6hLxxUEQpxCVj6vVaCMK4YfioJHhvgZUGsjpd3bEHM9wbMrxq7KQeAkoERJ6NgM
YCJ1vvfocs/27LYSBb86BIkyBIEtzOtPYAkVCqlmQh91QB0vIerGmWkU4zVA0ruP
cZfP/4IQ9ETlOm2xPWHoWkCs7TO+FWMRXehWX0i22KEuTU3RDvq3FSrGqrq6ATG1
OYK9Yk8prTXqfxK8l/znHql2aDYNRt+WZRfKfEjNY8UY+Ym2s+Gya5xYKsdQkmAC
1GW6pWDLjA621AKOuR73dVQ1V0zsZsGXjWGM/PGQ2yCEzfb3PKxmoUQUvACZj5Ye
NZYUPjzHXA1V4iEsSGsX+qw22b7Natof7ISc+wP0gLoxIgSgmV/fFnn/rT5KANKm
pgoUGn9aMQslqZ9EhZ705h/BfGgzSVGKPtrnRo/FXw==
=vWA7
-----END PGP SIGNATURE-----

--dFWYt1i2NyOo1oI9--

