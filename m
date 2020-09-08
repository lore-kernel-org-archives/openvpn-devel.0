References: <20200908154157.13809-1-arne@...1227...>
 <f4128ade-e54c-00b4-0e16-c54e08ab0454@...2318...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <ea18a0ae-5512-ad24-ab13-48bfb8ef3a7b@...1227...>
Date: Tue, 8 Sep 2020 18:38:55 +0200
MIME-Version: 1.0
In-Reply-To: <f4128ade-e54c-00b4-0e16-c54e08ab0454@...2318...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JuxUgwNd0Rii6Iy8HJwkMbJP3x6kaNmPr"
Subject: Re: [Openvpn-devel] [PATCH 0/4] Allow setting up OpenVPN in TLS
 mode without CA
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Fran=c3=a7ois_Kooman?= <fkooman@...2318...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JuxUgwNd0Rii6Iy8HJwkMbJP3x6kaNmPr
Content-Type: multipart/mixed; boundary="6KMMeQfOQtFsadb9eE7mmRY0V3bGaXFj0"

--6KMMeQfOQtFsadb9eE7mmRY0V3bGaXFj0
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> One of the nice features of Jason's patch was that also for big(ger)
> deployments you could get rid of the CA if you have another channel to
> establish trust between client and server.

I really wonder which large deployment want to do that instead of a CA.
I really understand the need for small and simple deployments. But for
larger deployments a CA + CRL seems more useful for everything that I
can come up with.

> I guess it won't be possible to use --tls-verify (on the server) with you=
r patch and verify the fingerprint(s) there?=20
No. Currently not.

Arne


--6KMMeQfOQtFsadb9eE7mmRY0V3bGaXFj0--

--JuxUgwNd0Rii6Iy8HJwkMbJP3x6kaNmPr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl9Xs58ACgkQFRhsZwKx
RFRanhAAhMKMc0dD726J2R0FGynME/SHa7k0O9hnbJsGcdI/YDfHDRFcCIefaC0R
U3NI+iqHnVpMbuVNjwWC6JU9IHEVwfyASTOVqBwx0mhX5k2UVIBKVpYD7BbfKL2M
wlRyKcl18nwQw9ZpLO4XZ1bQ3LUrvB/XFRNHzzciXbcOBKDzLWdCNdwkeT3uJs6g
RPvPGd34c306Az381IxOyjLR0E0NnXlDeoA+NF9y++gJC3Okwwl8mOJKjzVYaNrA
SDqEEpLehFgo43cnZxoJURtXKLO04rxLMGGbSwXLdMybPUfAuJk7cve5EsJW3jwS
H1lqixzyUaEj3BDR9Gsgr9PfQTocZcuqU/oB3kJl+KwfUrJkCHFhsmF0nvWHBX+2
lCwxlV3BjxmRY9ZnyV85vvT3wsTFo7YVufK8WRvdQ0zDvpT2Lxq2BGG3BndA6gNe
8BRdifRIgFyWN+kzBMjw2+NH4vnMySQSM0bWQhUDBgMtw/Ylfm7J90EzIU29xQo3
qM+clP9t75d7GW/SGqHYaqbOKCIzE0iwtuh+dhQmhCrHjI6gxE0yuchieaShpvta
08RwfFU38WzBnEU5A+E33gKcqQmUjT2V2AsLWtGMorE7ePHsLzzd+4Ozlo77zQ5a
Grr5b+Pmhs7MLEwtaXtQ393BmSF/CKzzxZ30gUFzEdmD+GagEpw=
=wUbu
-----END PGP SIGNATURE-----

--JuxUgwNd0Rii6Iy8HJwkMbJP3x6kaNmPr--

