Date: Wed, 30 Nov 2022 08:27:36 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y4cF6LhZRHAxegUr@...1296...>
References: <20221129180534.657529-1-selva.nair@...277...>
 <20221129183756.657793-1-selva.nair@...277...>
 <Y4ZzzbGgy/pUHDN6@...1296...>
 <497c22cb-5140-595f-acd6-75637f59b3c3@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+wlmMfZiNqLPam15"
Content-Disposition: inline
In-Reply-To: <497c22cb-5140-595f-acd6-75637f59b3c3@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] pull-filter: ignore leading "spaces"
 in option names
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, selva.nair@...277..., openvpn-devel@lists.sourceforge.net

--+wlmMfZiNqLPam15
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 30, 2022 at 07:15:50AM +0100, Arne Schwabe wrote:
> > Which options have you seen this with?  I only observed with with
> > "auth-token", which grows an extra leading space when being sent
> > unsolicited.
>=20
> I think since the client wants to ignore these option, we should add=20
> this to the client as well as you can other abuse this to work around a=20
> client that uses pull filter.

Yeah, right.  I was more thinking about this being another tool in my
toolchest (if I push this with an extra space, I can use pull-filter
to just ignore this special version).

But this is going to get more and more obscure, so I'll just merge
Selva's patch and see if I can get the auth-token pushing fixed as well.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--+wlmMfZiNqLPam15
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjhwXoAAoJEB2Cnv7KVigSfZoL/26o1ZONR3ds9Fs3XT4X+q3j
6AG3pX83LWrxzRJ5/ojA/BjdVuyYUIAYVlWAPISXswAMMZnxUIN/UrOslG9mqZOP
pd4znygi6+vRm2mUx/zWgsKJKGfuZDoPTcWinVsXPXnvmjoYTfLp98S67jYzSQvB
/i5KDxISIpsy508lzYgGlR1iQCjdLCH6JNslQyy2M1mj9/1awngfENktSaq88E2T
s6zamrYU5/JU3fktn4vkZr0B7JJUe3JbZWq+gRvv3r1kP6VRinxOvWvpn6hYd4GM
sohXk7WuZECsW320y9cn7PX6Un1GbIVsRzb5SH5d5ahM+hj34y1Szwzw+w2NdXdE
ilsigzLkwplM+smezIVaKm/1qppzd2nEK6cLZH8snznkWqm2/QBiiNQICewh/DmH
B2H1LFobTCZ1eELftKsiWvbAX7bqpLvbpGPkS+ESfANbviF2jmeHF6tcwhCKcqHg
SKjfWvC+kPUm/U5O8XQ6qRp7nvNaaia7+nfaTmUn7w==
=cFra
-----END PGP SIGNATURE-----

--+wlmMfZiNqLPam15--

