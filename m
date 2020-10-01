References: <20200927231513.27608-1-themiron@...2010...>
 <20200927233224.2859-1-themiron@...2010...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <b2adda31-c5e5-f05f-68c2-2b4d56e5174e@...1227...>
Date: Thu, 1 Oct 2020 12:47:32 +0200
MIME-Version: 1.0
In-Reply-To: <20200927233224.2859-1-themiron@...2010...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UtyLlEy0huEZEAU4VD9cQfnmzw3CfG4X5"
Subject: Re: [Openvpn-devel] [PATCH] Speedup TCP remote hosts connections
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vladislav Grishenko <themiron@...2010...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UtyLlEy0huEZEAU4VD9cQfnmzw3CfG4X5
Content-Type: multipart/mixed; boundary="LIRS4cmig4oFOiSyAj8Fs7SpHYI9YY2wN"

--LIRS4cmig4oFOiSyAj8Fs7SpHYI9YY2wN
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 28.09.20 um 01:32 schrieb Vladislav Grishenko:
> For non-blocking TCP/Unix connection, OpenVPN checks was it established in
> loop and if not - sleeps or handles management for next one second. Since
> the first check is made right after the connection attempt, it will likely
> be always unsuccessful, resulting in redundant wait for one or more secon=
ds:

Okay, I looked at the code and you are right. That code is a mess. It
basically calls select/pool with a timeout of 0, then actively does
select/pool in management for 1s and does this in a loop. That this
totally wrong indeed.

I think we should be more radical here. Always do a 1s poll/select
timeout and do a 0s management sleep/poll. That will also make the
code a bit simpler.

Arne


--LIRS4cmig4oFOiSyAj8Fs7SpHYI9YY2wN--

--UtyLlEy0huEZEAU4VD9cQfnmzw3CfG4X5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl91s8UACgkQFRhsZwKx
RFRM0A/9F2chsSWVM0fupntAgBBC3ka5+SrraJs7E9eL2FM7mBF4QZoMirmBxODe
uIaald58K9sOt8N4+KtPMdOD7uVbx3bh+Mpgcq21EYziAVWrddXAfXjiI/eW1EcJ
viLc/0+QAaYq5jYw0HSpQcu/UjuKCgXql8n6cOtKQAQNF7ANmAzDKwuxPeGIPkoe
cTi6atx61RULIECDeYqp27bgwiNOgf6HPRuKCucW5uWFFf1vtNPgXrdOoSGIm/VY
3W0Cr+bQ1XbCKfrQorNrsT2dOMKRbZe24Zo4acM9ukX+aEiTW5ox3+lo1g+eTj79
9ucMr/7xs3xzZM/ScFcYnQW8J8i8/ARS6L0QCF6pYNuXuKwKzy6ccncGkRym8c5s
0M5i0aBUCXfsZrkAVAD1O9yYu736iPakbYoG1/BRRV5JjiAjjhU/+MzhTGayauDe
ZW9cz8JVwWFte7ZfFt2MsO538AEEhBzgSguWvsr+mj0iJXnGRM9wLJj0cTuD41Pr
9bMlVG0ATSvgAcQcBqiLXbDbi3KaQRyHBH8uXV+QUrEjpSw9/a9gmN1+9rekL9dF
L9x2UE7JEWzRzwHV9ZZkZxsdUMNfiGk2G+PmEQuF/PjlFouP92VR9DDn3W1NrHJk
FxQ2Ti8jHO9607gXxQ6P/UHaZRYe0h9AXtjT9Nh4wrNxy6/JNBA=
=0eLl
-----END PGP SIGNATURE-----

--UtyLlEy0huEZEAU4VD9cQfnmzw3CfG4X5--

