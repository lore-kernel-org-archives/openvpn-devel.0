Message-ID: <0b3294fe6920f300df23b1c407d530f9ccdc4650.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Sun, 15 Jan 2023 11:29:29 -0500
In-Reply-To: <Y8QWDbHsGP9zBcw6@...1296...>
References: <6c0e8ca1-9518-1bc0-65cb-f742311ef08f@...1227...>
 <f52172ec20da430975373e7192380874bc600062.camel@...2316...>
 <43485320-4957-8ac1-7bab-4e769000d156@...1227...>
 <234ef71a00e43f74bda0836d66c63a3d8c54a74c.camel@...2316...>
 <Y8PnGp9Rt/n9FODz@...1296...>
 <7e0167f8-b1d3-a3f7-db40-5a441dba602f@...68...>
 <44a2128f-2ade-5def-beb1-20fd48d838d2@...1227...>
 <8f361fc115ba580d9fc62735b24dd8ebb315f496.camel@...2316...>
 <Y8QWDbHsGP9zBcw6@...1296...>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-sYHqNQTj0ZKljN4wI4FG"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Amend OpenVPN license to allow continued mbed
 TLS support (allow mbed TLS 3.x linking)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Arne Schwabe <arne@...1227...>, Matthias Andree <matthias.andree@...68...>, openvpn-devel@lists.sourceforge.net

--=-sYHqNQTj0ZKljN4wI4FG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2023-01-15 at 16:04 +0100, Gert Doering wrote:
> Hi,
>=20
> On Sun, Jan 15, 2023 at 08:37:00AM -0500, James Bottomley wrote:
> > The GNU project began in 1982.=C2=A0 Static libraries for SYS-V were
> > initially proposed around 1986 and didn't become widespread until
> > the 90s.
>=20
> And exactly when was *the Apache license* published, or GPL *v2*?
>=20
> This was the context, not "the GNU project".
>=20
> Wikipedia says the GPLv2 was released in June 1991, and as you say,
> shared libraries already existed then.

No, I'm saying two things

   1. The GNU project began before shared libraries were a thing, so
      the system library exception was specifically designed to allow
      shipping of GNU tools along with huge statically linked blobs of
      proprietary or otherwise differently licensed code under a non-
      GPL licence.
   2. The advent of Apache-2 didn't change the analysis in 1.

James


--=-sYHqNQTj0ZKljN4wI4FG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABMIAB0WIQTnYEDbdso9F2cI+arnQslM7pishQUCY8Qp6QAKCRDnQslM7pis
hQEhAPwKpAC5s4PrUN3AyAPmyaur7uIYqlLrMYTYZmwed/yKhAD8DY5QdJl7Oc8+
SxL07hdhYGphJNODXaXX98CSPVPkwqo=
=Fqrq
-----END PGP SIGNATURE-----

--=-sYHqNQTj0ZKljN4wI4FG--

