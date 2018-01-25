Date: Thu, 25 Jan 2018 17:00:37 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180125160037.GT69387@...1296...>
References: <20171105192019.GM958@...1296...>
 <99D61A626FDA8A4B90A270669121BE108587DA0D@...2294...>
 <CAKuzo_hTnJVcEuCqCQ-ZR3swbkio7CWZgy3z5C0fWVJ-E0PCvQ@...278...>
 <99D61A626FDA8A4B90A270669121BE108587DF29@...2294...>
 <CAKuzo_jFp86anFk6mgavBoYhmCCHUeJ_EQpb6Z05PTNJxBYWWw@...278...>
 <99D61A626FDA8A4B90A270669121BE10858830C4@...2294...>
 <20171204192515.GA69387@...1296...>
 <99D61A626FDA8A4B90A270669121BE1085B4AC9A@...2294...>
 <CAKuzo_hJdNEMMmUqa4d=n4k9vZXoYtkC9CFcvAkW9cDgzT2wCA@...278...>
 <99D61A626FDA8A4B90A270669121BE1085B4CA4D@...2294...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Kjn60822oUuI93ff"
Content-Disposition: inline
In-Reply-To: <99D61A626FDA8A4B90A270669121BE1085B4CA4D@...2294...>
Subject: Re: [Openvpn-devel] [PATCH 09/13] Signed/unsigned warnings of MSVC
 resolved
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: Selva Nair <selva.nair@...277...>, Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--Kjn60822oUuI93ff
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Dec 06, 2017 at 05:10:45PM +0000, Simon Rozman wrote:
> > > The get_interface_metric() function should get a more thorough rewrite
> > than just a compiler warning shut-up. So the patch will probably get di=
vided
> > in two - the simple signed/unsigned fixes and get_interface_metric()
> > redesign.
[..]
> I have tested and am confirming MSVC is happy with the block_dns.c now.
>=20
> Should your patch be merged, I shall rebase the "[PATCH 09/13] Signed/uns=
igned warnings of MSVC resolved" to the new master and deliver the next ver=
sion.

I finally came around to merging the get_interface_metric() patch from
Selva today, so I await your fixup patch of the remaining MSVC warnings :-)

thanks,

gert

--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--Kjn60822oUuI93ff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaaf8lAAoJEB2Cnv7KVigS1UsL/RPkqLGf8xS5cg0FYQbVTY47
TwrzRifb3HPzyJtUpMd6DHFrIhLL5UsVZI9w0rVdBIIn7tMdqK8NZfp8gR1LNf1b
gLI27HOsLvKgtpkS23LlMlawko+HAQqeT3W08HuDRKsU2pw665ZX4YUk3BuaYBfB
lcv0PVtBmbVQPtlC0NLzaXJHQKzrnuAMgrWQN2K3UgRheBQ/c4Xn+PAPiUZP+zhZ
/k7Ry2cRAaMPT3EwGIWk0G2rnUNxIrBy+nI/zwPjojL5nOKU+S4fnsIktTNA1Rfk
W035UiNi3UWRIp5xGwLj7ywVcBsPvThBQf28WQ5IKgoUg59/xFZBbxTAQTXite8g
Sdf+TqqBPptolmfBrQxfwUx4wAyJJTcZAWlSx3c4TMJRzgTMqPIF+9Y2howxay+7
mTgbHYZzS7wdAF7UyUe6EB7I9OQtX0ilcg/gotupx6KNT+EyJlNyY0sVGpD6yxpb
iAi3Z8VeMOx1po5g1Cpu/x9GpjHqZnV6wi3xqjvEyA==
=T9tH
-----END PGP SIGNATURE-----

--Kjn60822oUuI93ff--

