Date: Thu, 9 Feb 2023 21:59:49 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y+VexRiModlD6w41@...1296...>
References: <20230209153658.24001-1-ynezz@...2710...>
 <b187a379-2bc1-6a7b-9bb6-a53fb1358c4f@...2712...>
 <Y+VLn5pTX3a3y08t@...1296...>
 <c561e353-4cb2-a584-65c4-50ffd6068ef0@...2712...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="GYPDex4qiDVRIuvd"
Content-Disposition: inline
In-Reply-To: <c561e353-4cb2-a584-65c4-50ffd6068ef0@...2712...>
Subject: Re: [Openvpn-devel] [PATCH] get_addr_generic: fix server crash in
 freeaddrinfo on musl libc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Mykhailo Mishchenko <mdmisch@...2712...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--GYPDex4qiDVRIuvd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 09, 2023 at 10:09:45PM +0200, Mykhailo Mishchenko wrote:
> On 09.02.23 21:38, Gert Doering wrote:
> > (There is an old Trac ticket about it, but nobody went out and fixed
> > the code yet - which is tricky, as you can't just change the format
> > of ifconfig-pool-persist without breaking existing setups)
>=20
> I would escape the comma with backslash, for example. It would only=20
> break those setups, which are already broken because they have a comma=20
> in a CN of a client certificate. But maybe there are reasons why this is=
=20
> also problematic, and I just don't know about them.

status files, management console output & associated consumers, lots of
things inside OpenVPN are separated by commas.

Yes, this can all be fixed, but for all the bits that are "for other
consumers" (status files, management) those entities would know how
to deal with escaped commas.

ifconfig-pool-persist might actually be a fairly easy one to solve,
by going backwards from the end of the line - so not taking "field 2 + 3"
but "last, and second-last", so it doesn't matter if there are commas
in the first section.  OTOH we'd need to deal with old-style files
that have no IPv6...

Mmmh.

"Someone needs to code it, and test all variants"

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--GYPDex4qiDVRIuvd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJj5V7FAAoJEB2Cnv7KVigSE6cL/39Z20dKF+Ks0i2ZOYAczU8c
yGpfSdAjPON78ie2dCJ4AwBz70E1YH+v0o+I8Zq1cBRcoN75dgGjQQaUDHmdNwID
+cEY4dkP6UdKMSpmf/OcRUInKgCGbuZ+gmTY70hkApHYsMWbt9XZ/o1hDqcL/eub
eVl+LQO9iH26Zzg0RNYNlaWtXcJMMnYKKf77AebhWRmCc3hTp8jGwMLHmvqzg9wF
26CRJbo0nRO7hBgy1Di/80OmhWmdh5B0GqqQ5077kU8i4+4C36PzJqIXPuHyNqqN
N+VY0fUaMBjUqMBGfhGy2WTyF2lSYB5n159Uj6+HowhdyD77Pj1hKjY0l4QF2Bqz
EflClBATXvpvq+mAkVNbLQolsm9EAAgBsFQCQRoh9a11B6xsr6dlgwYxAKkqXTjI
VZyAAyRu+nDYqqMfLYpz5a2D7h3PpXEC/qQBL/gf8SgJRI4eKmk8CcjLjrgQ8VRN
5IstBRMayVGXH+KwSSaS+qYq0HPzJxRcqHFTe3kGXA==
=zWdH
-----END PGP SIGNATURE-----

--GYPDex4qiDVRIuvd--

