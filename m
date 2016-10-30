Date: Sun, 30 Oct 2016 11:16:16 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161030101616.GV28918@...1296...>
References: <a76fef6e-6cc6-0878-4cf6-293d84b4edd3@...277...>
	<deb274b8-709f-9bec-40f3-279d75d114a0@...2070...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tpXFRyzAyQ/GSAaD"
Content-Disposition: inline
In-Reply-To: <deb274b8-709f-9bec-40f3-279d75d114a0@...2070...>
Subject: Re: [Openvpn-devel] dhcp-option DNS IPv6 server address for windows
 client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <iam@...2070...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--tpXFRyzAyQ/GSAaD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Oct 30, 2016 at 12:18:39PM +0300, ValdikSS wrote:
> ?probably not only DHCPv6, but also Router Advertisement too. I doubt tha=
t DHCPv6 could be used without RA on Windows.

It's a somewhat multi-stage thing

 - first, define a new dhcp-option (like, "DNS6") that will take a
   v6 address, and put it into the environment variables on the client
   (so scripts and networkmanger etc. can pick it up and do the right=20
   thing wrt resolv.conf)

 - then, figure out how to inject this into windows - as far as I know,=20
   windows will always try to do DHCPv6, even if no RA seen, but this is
   something easily tested.   Maybe it can be done without DHCPv6 by
   just calling an API call ("hey, here's DNS info!") on recent systems,
   maybe we need to implement a fake DHCPv6 server - someone needs to=20
   look into this, and come up with an implementation.

#1 could easily make 2.4, #2 is very likely to not make it.

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--tpXFRyzAyQ/GSAaD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWBXIb6kuBuNlUUl1AQJHtgQAsY1v+/zh/Mn2SL2ZYWyo/OzkW8EmymQQ
vUHROJ1xRY+oOfEwyEdNNsdHbYjoeeGMML/dXrghgaEKY0RAQKGcQNJtqIBceCdq
U4SO+t5zDWjy7fxIoOSd5ro0dGfN/nwZ2q4JV1NQTEuSBZCsWxWzUvRNlHiG3fTm
/Pm1nNfQTLY=
=Ii+i
-----END PGP SIGNATURE-----

--tpXFRyzAyQ/GSAaD--

