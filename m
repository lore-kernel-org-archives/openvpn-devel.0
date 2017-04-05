References: <ee5a8207241568cedcccc4f7f2ea5bc8.squirrel@...2257...>
	<b6bac00d6d7260eea944814b0c995806.squirrel@...2257...>
	<53a21cf3f4e04fcf5d6b9798e04be3ce.squirrel@...2257...>
	<20170404064534.GC93896@...1296...>
	<6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
	<063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
	<20170405065745.GI93896@...1296...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <c923cbd7-6876-dfcf-513c-f8bbba21f421@...1435...>
Date: Wed, 5 Apr 2017 09:31:26 +0200
MIME-Version: 1.0
In-Reply-To: <20170405065745.GI93896@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PfCMqmB62snG9HlRPLXktMJlcbPbgeBfQ"
Subject: Re: [Openvpn-devel] [PATCH v2] Add per session pseudo-random
 component to --reneg-sec intervals
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--PfCMqmB62snG9HlRPLXktMJlcbPbgeBfQ
Content-Type: multipart/mixed; boundary="fqnlKP6k7mP6a7sIPnVOPPLUcxP4gusO1";
	protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <c923cbd7-6876-dfcf-513c-f8bbba21f421@...1435...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add per session pseudo-random
	component to --reneg-sec intervals
References: <ee5a8207241568cedcccc4f7f2ea5bc8.squirrel@...2257...>
	<b6bac00d6d7260eea944814b0c995806.squirrel@...2257...>
	<53a21cf3f4e04fcf5d6b9798e04be3ce.squirrel@...2257...>
	<20170404064534.GC93896@...1296...>
	<6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
	<063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
	<20170405065745.GI93896@...1296...>
In-Reply-To: <20170405065745.GI93896@...1296...>

--fqnlKP6k7mP6a7sIPnVOPPLUcxP4gusO1
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 05-04-17 08:57, Gert Doering wrote:
> On Wed, Apr 05, 2017 at 06:34:34AM +0200, Simon Matter wrote:
>> I've attached v2 now which works without any config change:
> [..]
>> I prefer this version as it allows everybody to profit from it without
>> touching any config files.
>=20
> I can see the reasoning, but 25% feels a bit on the high side :-) - so
> let the ratholing begin what the number should be.
>=20
> Steffan, any views from the crypto side of things?

Not really.  I think the feature makes sense, and I like that this will
only *substract* from the set time (so not exceed any set limits).

(And I agree that 25% feels on the high side - my gut says somewhere
around 10%, but I have no analysis to show why that would be better.
I'll leave picking that number to you.)

-Steffan


--fqnlKP6k7mP6a7sIPnVOPPLUcxP4gusO1--

--PfCMqmB62snG9HlRPLXktMJlcbPbgeBfQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJY5J1SAAoJEEEwndWOY1w5w8IH/jODa1iO25uweOdXTUIUoHcO
IdDEfVGtDj3detAYivqZjf1Zq22iUnb7kfOAyy7wZKfgraEOGhtZUcilau2jkPiI
XVBlhfO8odqk9PdZPMe2+IF9Aq8huIjOjocMEd0R2jpGpglTeaAfIqLNV/PRbNiD
1frOTSAJvbUdA3e1p9W95hknSPn2T691KsGqux53EVSG3gW9LZBSET2+fZugbcg9
nVCnGpKFhqRVpFjNCF1eKJBlI4OzY6hW6TpKspIo2J2hURUDrVQRSrND9+Q2+P2Q
+nLrXKBZTR0Ty1bXKVvAyR6ZERcQ9KQh3e3hheRcqYmtx74jl5y4PWUz08dTICI=
=SZak
-----END PGP SIGNATURE-----

--PfCMqmB62snG9HlRPLXktMJlcbPbgeBfQ--

