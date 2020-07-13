Date: Mon, 13 Jul 2020 08:10:23 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200713061023.GK1431@...1296...>
References: <20200622113022.23047-1-davids@...515...>
 <CAKuzo_g7QxVL90ikT57H6b4+St2c860us6S3cN_6jbfeHujpzw@...278...>
 <a1cfd42d-e371-187a-55c2-f14a3a986b34@...1823...>
 <4562876f-45c1-d3bb-f725-52e9b78600de@...1227...>
 <20200623090252.GE1431@...1296...>
 <4f03e378-f327-21a6-9f11-fe06a42052b6@...1823...>
 <518ceb3d-e060-f777-f19f-4998b8d27170@...1227...>
 <3f6159de-c513-78d5-194c-989a8611c291@...1823...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="TyPj8yijo+jt5sFm"
Content-Disposition: inline
In-Reply-To: <3f6159de-c513-78d5-194c-989a8611c291@...1823...>
Subject: Re: [Openvpn-devel] git master crashes on connect of 2.3 client
 with --enable-small
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Dmitry Melekhov <dm@...1823...>
Cc: Arne Schwabe <arne@...1227...>, Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--TyPj8yijo+jt5sFm
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jul 13, 2020 at 09:36:45AM +0400, Dmitry Melekhov wrote:
> Then I compiled openvpn-2.3.18 on Centos 6.
>=20
> It connects if it is compiled by just=A0 using configure.
>=20
> But if I compile 2.3.18 with enable-small, then 2.5 server dies, always,=
=20
> even if there is no cipher in ccd and ciphers match.

Ouch.  This is not good.  My gut feeling is "2.3 with --enable-small =3D=20
no OCC *and* no NCP =3D the server runs across a NULL pointer here".

Can you run the server side with --verb 4 to get a bit more log before
the crash?

I'll see that I can reproduce this on my end as well.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--TyPj8yijo+jt5sFm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfC/rOAAoJEB2Cnv7KVigSIyQMAIkKYTbujuv9fX8cfEcnqyVL
IyjFRUfccDnWBs9wNRFPnBxQuPldEBgiZxihhZFQpKDJOIRbkBri3B46QhkUEQjA
Q8NXuP8NrfF8sBBxTIH9Pv+xYvGH9R6EEg4pse51RY+58mhqFD6X8oP5i1BlOsCm
XjoMWfdxo/sF8sQb4yI3Ljv7YI9ZE5bi89louTvvN0Lv4Vut5IL9LMLDcS9z5UG+
AxovXQPREw8qsHZPjxYjgbHzp4vm6fChoL040HeDceQnXU16zipvVBPZCmO6QP/n
SVSMTlk/WFxRsjf2e7T+Ua36gKF8xZYOWG4AZWVAWYnsTTur/K5BOl8PA5PPCSF6
7wJ7S5Q7J6JP/XF6OQGYnu7wrG9wNIRSkPlTpHg4ma/A9hfLK9FX7habdvcnuI0v
jpnl8/4Jf7UhHPB+7dAisnK2vK4mMYXvP60YhyDcmtEAG28x3IJeuI9CRtCzZlvd
h3iSyPhVGjWg4UEhrf99GvJPDDUVjXf+p935hE7bMg==
=mo3C
-----END PGP SIGNATURE-----

--TyPj8yijo+jt5sFm--

