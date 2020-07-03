Date: Fri, 3 Jul 2020 20:50:41 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200703185041.GS1431@...1296...>
References: <20200626082743.15397-1-gert@...1296...>
 <d98b6023-4f57-0a8a-5b97-ed35eda8aa3c@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Kp9cd2o9uS61xHTK"
Content-Disposition: inline
In-Reply-To: <d98b6023-4f57-0a8a-5b97-ed35eda8aa3c@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] t_client.sh: correctly report all
 failed instances in summary
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--Kp9cd2o9uS61xHTK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 03, 2020 at 07:11:04PM +0200, Antonio Quartulli wrote:
> On 26/06/2020 10:27, Gert Doering wrote:
> > t_client.sh reports a summary at the end:
> >=20
> >   Test sets succeeded: none.
> >   Test sets failed: 1 2 3 4 5.
[..]
> I can't easily come up with a t_client instance that verifies this
> failure, but I trust Gert to have done so after having spotted the issue.

Actually I was wondering why my failed tests did not show up in the
summary in some cases :-) - so I had the perfect test case up front.

(How to reproduce is easy: just run one of the test VPN instances
manually before starting t_client.sh - it will fail all/most of the
test due to "these addresse must not ping before we start openvpn!")

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Kp9cd2o9uS61xHTK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe/34BAAoJEB2Cnv7KVigSkEML/20fLgyvbqqxqUdRIrlT0cec
imii6+Rt2NpTuls/P+1/5QOSYFi35z6MccoCXK/liHKsLRso+5XpWpOYDgEhhWZL
5u8Hk9XSux35HXl0sYKW/aNU1xcyZmfWHdtyIepg+A+GVbMx4Bd4HjM5rUMQ6Ll3
DxW+/H3dPRS/e+Ya9yXBuRv5kzypvGCOBPIVRuu+wRzQHshAFV1LDImGNgi9zz0p
jl7POJjvjoaxEOlPMOBcry4CffffzHFjHfK3+rKm+a3B5drmrMostnXaseVvwTEX
r8gQ/ACmuJIbtxzGKqjWdhsZzuA10G/NJjbfrxAfA2CQ+2EXxaS5b46ZZLHZhM93
iGyuoeqYz6wXxP+OJhItzAaHnvRvh+Z8hn03ozl4OfXW6sSckiaMJveQvlCmHHEZ
+KCPr5Sht/sqxEKueWWoxQDydPDv0icca9P1uTMTyq9pDqaj6vK3Fc1hOXfuWiFE
Qvqx5yUcbuz8pbOUYqJdZ+MckKUDcwcveD8k6QSfpA==
=+GhV
-----END PGP SIGNATURE-----

--Kp9cd2o9uS61xHTK--

