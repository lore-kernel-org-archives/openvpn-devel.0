Date: Mon, 31 Aug 2020 15:23:57 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200831132357.GZ75094@...1296...>
References: <20200814080619.2108-1-arne@...1227...>
 <CAAWBBYM2+4FqN-HyV9W19fJfAHKd9K4KHhnQFz2_5f3tzdvMFA@...278...>
 <20200829194728.GU75094@...1296...>
 <CAAWBBYM+8YfP9-nwAsPYM806CzQXoy_5d+9MLkfyGPatE3BTAQ@...278...>
 <20200830120703.GV75094@...1296...>
 <20200830203720.GX75094@...1296...>
 <CAAWBBYMnFOBo4pp_iZ-KnYu7pHbiLqYQJ3rKO1RF+yXcvivgYg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8J60KZR6DtQGXGd/"
Content-Disposition: inline
In-Reply-To: <CAAWBBYMnFOBo4pp_iZ-KnYu7pHbiLqYQJ3rKO1RF+yXcvivgYg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix client's poor man NCP fallback
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Rafael Gava <gava100@...277...>
Cc: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8J60KZR6DtQGXGd/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Aug 30, 2020 at 09:26:10PM -0300, Rafael Gava wrote:
> Good news, it worked beautifully with tun and tap interfaces!
>=20
> Thank you very much!!!!

Cool, thanks for testing.  I have just tagged 2.5_beta3, and lev/mattock
will go about building a beta3 .msi with it (and hopefully lots of other
windows specific fixes :-) ).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--8J60KZR6DtQGXGd/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfTPnsAAoJEB2Cnv7KVigSLakL/3mlTTwb2SYG4PrqY6FIAQd3
9rnC/w9SRFciKRLTm3anU1YPKcu2bGl/xiRrSwfOuZjeaembKDNqcd4WoGmj9jGO
Z4dz8cB9LcDnQkFt6UkONKSzKhiVXXBdM5QbSG7tsnRw6QwrOg4FWPetorQQsahO
FegnPZlWNON3FJ1zZi3TA1ke3FIbNCH5UyrvgaEbW8tqHoUxxauz/4//xzxPvWU+
C+dK6yQAlIGZxqz5FYSedgLq8Tey09n1SwFPuhvmQ0jRPWXhPT7bO+rLe0VMxQ1I
80x/gatZdkDk6keTbMJfM+tZTC53sV+7i8VGTQU0K9aY1+g3CYFwaKIJstK4R/ob
FW3F2omPR54+1nARUnHucUXwWO2UX8u0F5qIJ/HQR0GEY3H9iUXWVH3gFSRGGr9W
Oku4TSfdxaev7BG0Ss3uaJUTaHA/8Da8sAkWWqOLF7fJxF5eBdPYw+aMM1Ru79ur
RaG8TIvwBkPQydJ0UOSTet1mFEAxJI8UlP4Ny2ROHw==
=9VFJ
-----END PGP SIGNATURE-----

--8J60KZR6DtQGXGd/--

