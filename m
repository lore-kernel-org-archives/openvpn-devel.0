Date: Sun, 29 Jul 2018 21:34:00 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180729193400.GX55859@...1296...>
References: <1516833453-18991-1-git-send-email-selva.nair@...277...>
 <1532486093-24793-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="sA0T44BA86podSFD"
Content-Disposition: inline
In-Reply-To: <1532486093-24793-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3] Parse static challenge response in
 auth-pam plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--sA0T44BA86podSFD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 24, 2018 at 10:34:53PM -0400, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> If static challenge is in use, the password passed to the plugin by openv=
pn
> is of the form "SCRV1:base64-pass:base64-response". Parse this string to
> separate it into password and response and use them to respond to queries
> in the pam conversation function.
>=20
> On the plugin parameters line the substitution keyword for the static
> challenge response is "OTP". For example, for pam config named "test" that
> prompts for "user", "password" and "pin", use
>=20
> plugin openvpn-auth-pam.so "test user USERNAME password PASSWORD pin OTP"
>=20
> Signed-off-by: Selva Nair <selva.nair@...277...>
>=20
> ---
> v2: Depends on the base64 export patch
> v3: match password string with "SCRV1:" instead of "SCRV1"
> (pointed out by Joe Bell <joeaintexas@...277...>)

I'm a bit confused about the prerequisites for this - if I found the
right "base64 export patch", this is still pending some reworking
because you and David disagreed on details, and then David got sucked
into "Client for OpenVPN 3 on Linux" and had no time working on the
plugin API for v2.x anymore.

Or is there a different base64 export patch which is "just" pending
review and merge?

I want *this* (so, feature-ACK, haven't stared at the code yet or=20
tested it) - so I want all the prerequisites too :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--sA0T44BA86podSFD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbXhaoAAoJEB2Cnv7KVigSxO8L/0FKPu/J61SztYFeqfnrnwpb
I6bKJmpIUEGPEaUjLvkOjIt+raQitYMqdT+uM/0dK/uR6KOO6ndDmUEoOcL30a3x
OWHdEgbkXt7o0ERewOOhIqFa9RhTC1za1Zp7B23DFJ+YwxuXK62d3B/myNni9gW2
hbI3Z2SlEtbxvD6ddeWiTuZ8gVtjqXpQbVngOuKHtcZfM81LU8DePQzbQym3UkWh
ODJ3X7cfpx5O8+YyV0wi7zlsaQ/lDugVufiYj4pNm6sn04uncP4CSOg4MUFhojnb
+I7EWCL+aB9Q1JVDarSfjacO4o9s2EDEpuoG9dh9ePHrHuCyMtZbN7KWJ5F2uR3Q
RucYWClmuWpoF70TC7BXqyKIfwaiZhU1RRaOYbCUecOLG/ZFrxtGrwz5KEU/ZbTR
wHKRlFJ9utvRGVWSkcRcX4eP8zqcrbB5fS/IFxqq91BCzNPp69c+U5PJph0Icwfe
VCo5TRTH0orwFpaIVTNUdB0DmWqzYF/NkmUsGZaynA==
=Vtd/
-----END PGP SIGNATURE-----

--sA0T44BA86podSFD--

