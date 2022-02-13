Date: Sun, 13 Feb 2022 15:29:32 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YgkVzDfNwJHmEWmm@...1296...>
References: <20220212003331.3483107-1-arne@...1227...>
 <202202130924.21D9OCRM040547@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fFRtrsz8d/+hLPV9"
Content-Disposition: inline
In-Reply-To: <202202130924.21D9OCRM040547@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add mtu paramter to
 --fragment and change fragment calculation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--fFRtrsz8d/+hLPV9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Feb 13, 2022 at 10:24:12AM +0100, Gert Doering wrote:
> I tried to test PMTU discovery, but I'm not sure I know how to do that
> (or our code is broken)

To track this, I have opened=20

  https://community.openvpn.net/openvpn/ticket/1452

and I intend to eventually look into this :-) - but if someone else
who understand socket APIs and "extended socket error reporting" wants
to have a go...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--fFRtrsz8d/+hLPV9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiCRXMAAoJEB2Cnv7KVigSY+YMAJ1pDj1ebMonMCVzpfyMDkq8
VJdLj91cjw9glfZCmhXwR+nHYxdSapl9SqKGgLp65F/e+j9TVNB3Dab4X3IbR2hm
0pVrC8wHN0gbDaW1K99nCToSBDSurNRLt91hwkLn4zH3GVTLLSuVbIjqd+hoZQ1N
TtGOClme291rliM1DfkknMIPLyx/noNySvQXJc7Hhx/Y9ntRDVYRB6UOEugDCcdN
81bVexq2VNIjXsvUvPxWqH7UzPC27xCqd0Yd0fQcKRJC+I4OUAiN5h5QcPq+cob3
Z9prNrEj5j87hx0oWnSNRPx5MV1opiFxMBuT2wxBhIBfPqfMSc3jGL1oWGE+WaOr
pMojojsyRRoQABAArurzu/KssaIa6s9yNIgR+skr5Dimu3h1tSBGuOhx3PgBdlmY
Q4gvRPPmCX/PMkkjxpB1QZTLwjIZUj7pLeLQOwpnesReW0lOEh/y2+xEm8qgkndO
+YQtHoidf1xPhbsgaabGXFhskTh8qSruzlMO+jnOcQ==
=hOOg
-----END PGP SIGNATURE-----

--fFRtrsz8d/+hLPV9--

