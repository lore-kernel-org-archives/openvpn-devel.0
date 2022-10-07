Date: Fri, 7 Oct 2022 11:56:52 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yz/35K6JddVNg9F9@...1296...>
References: <20220812134154.16729-3-kprovost@...2661...>
 <202208201401.27KE12Cm014083@...2054...>
 <YwDwvG++hK0nJI2F@...1296...>
 <21B552DE-38FE-41F0-8FC7-606EA4C06093@...1376...>
 <Yz72rrCsJCjBgE4T@...1296...>
 <3B9F182D-0936-4799-B1B0-D269DBB3C2E6@...1376...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="LAV26f8pfMMCa7fI"
Content-Disposition: inline
In-Reply-To: <3B9F182D-0936-4799-B1B0-D269DBB3C2E6@...1376...>
Subject: Re: [Openvpn-devel] route/iroute handling on FreeBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kristof Provost <kp@...1249...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--LAV26f8pfMMCa7fI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Oct 07, 2022 at 10:47:08AM +0100, Kristof Provost wrote:
> On 6 Oct 2022, at 16:39, Gert Doering wrote:
> > FreeBSD DCO has the open issue of "iroute with the same netmask as
> > route, so we want metric/weight/... to differenciate"
> I???ll try to dig into that, but it???ll be late next week at the earlies=
t.

Thanks.

I'll dig into the POINTTOPOINT issue... configure a real MULTIPOINT
interface for --topology subnet (which is something I've always avoided
so far, because "we know the other stuff works")

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--LAV26f8pfMMCa7fI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjP/fkAAoJEB2Cnv7KVigSToEL/RbMZL62EuNVZUI/rTqtHU/r
T0vdPAWp+5NQ6KGPDtaChI6qAiV6P/1x1gv4MnPiLDtsKfXe54fjB0Upq2FNrmqh
rOqRK8tP/V2pOpvfwQWbnuNoDA9iu7fW9YDXg2gav2GAhR6l8Zcn9AYOQqfjcB6y
17K7bPFD0BbX/SWFBQmW/2jtxeC68t25pVkEYoAcByFUXQnytBdSsO7WdhEKvOEV
ZU2xaqrs9B/sgEHCkFXgifx/VBCMW5edbEFoUp02Pqo1Xu3CePFyv9iS/iTi+1iL
fulcKUijhFDDtJI2we02Ak30PgtMvM8bBcp1VmZHUf+iA1SOOjGmHCmMTKeeBzB2
Um50qbGXx2OsKavEoPoXp/+YcZXeFXnHT+3O/1AquL0D+Q4/UuK8E8eBIFnTj6E/
5OiOHvDovVs1hnqFjYpPl6YI4EPrfegz7Rsga1G/oDdPHGbh82keKBeGjgDvul+b
/OsIqwN8FhsoxUozDx6yi2G9h9myM0gv6kGg1CBv1g==
=U8JP
-----END PGP SIGNATURE-----

--LAV26f8pfMMCa7fI--

