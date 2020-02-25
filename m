References: <88cfd76e-a163-28a0-d4f4-d23c41f902d7@...2542...>
 <43700754-2df3-3090-7808-39fc9c081b97@...2542...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <1572a9d6-1664-019e-4eb6-e1566ef650e2@...1227...>
Date: Tue, 25 Feb 2020 11:28:54 +0100
MIME-Version: 1.0
In-Reply-To: <43700754-2df3-3090-7808-39fc9c081b97@...2542...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3NOyciWuSmjpfCvaYgDnjX5nBucSd9dUk"
Subject: Re: [Openvpn-devel] MTU auto-discovery
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Radu Hociung <radu.ovpndev@...2542...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3NOyciWuSmjpfCvaYgDnjX5nBucSd9dUk
Content-Type: multipart/mixed; boundary="8Yp0j7PJw8LRPCVKa58dqYgiURTdPzoaN"

--8Yp0j7PJw8LRPCVKa58dqYgiURTdPzoaN
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> I am developing this patch on the 2.3 branch, as that is what I use for
> my networking needs, but the files I am touching have not changed in
> incompatible ways on the master. At the moment, the "Great
> Reformatting" commit is the biggest stumbling block to rebasing this
> patch to the master.
>=20
> Also, I don't have the resources to test it on anything other than
> Linux, but I am hoping that the existing continuous integration magic
> will help overcome this limitation.
>=20
> At the moment, I expect it will take another two weeks until the patch
> is ready to be released on 2.3
>=20
> Any comments or offers to assist with testing are welcome. Specifically,
> how does this patch fit in with the release plans for 2.5 or 2.6+?


The idea sounds good. Whether it can be integrated in 2.5 or not depends
on the patch quality, how intrusive it is and some other factors. We
will need to see the patch before we can make a decision on that.

Arne


--8Yp0j7PJw8LRPCVKa58dqYgiURTdPzoaN--

--3NOyciWuSmjpfCvaYgDnjX5nBucSd9dUk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl5U9uYACgkQFRhsZwKx
RFTmvg//RuqegGGpRc4a+/2O6WofNGpdwa42l4KEqTUVmljkF8CnMtikKXEV9Rz/
cYWD5fhnecebf1BEniVtnA9XrXn/ZDct2sf2X4NE/2beIppotycIElRkQRFIxzO3
WTJiLg6tpE20Fcpzso0fdqC0FgRk/2Lv/0uziYVW0CSZsxc99lXjlf3yCRW0Ynko
eXUvLfln6qzosiMHroRR2GJY5+LnOh0ZCH+zVFsqRyAXo0wK/wOwuEsrLy59/L29
bWuyL73I5XYe1SSZC490i3Fny0YiVlTrTktikSzoRmktlPoUOpMFKK8bWOgObJMM
nJN9bTkstOTsQpVbTR+elcedUCiWP7lRHXKa3ozZsDqpdeecTuM2E5mtZjg1J3w9
yy3kjtnZfqMSMQ5NnLO+bcB30gfmZcXVfo0T/BHHJGnbxWeC+MsVXSIqDl7amPpF
/H+mm+UsEPEzBwOUvJK9DOaRErc3TvbXAAo4Rzbm8nI73Vuru2W1dREAq8Sify+G
5B8z4fWoRArORAeJjj6QWO/0/bB2snjbZPI0Vua+MTEJkqI8/FuHnJ6bOTkvoTaj
x/2ZBhR9aWxxDvwbQRN1dXXkRqklxmc+03Ibx4qecDYBdf/94mlLQ+YBJriMsYWu
Ap4mx+F6fqtTFRPzXc9S846RADVPYVfsWgHhI4GIcL1RILJ8JiA=
=F2Bt
-----END PGP SIGNATURE-----

--3NOyciWuSmjpfCvaYgDnjX5nBucSd9dUk--

