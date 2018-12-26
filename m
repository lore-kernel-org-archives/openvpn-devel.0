Date: Wed, 26 Dec 2018 19:36:21 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20181226183620.GF962@...1296...>
References: <20181218140945.GU962@...1296...>
 <8d921fbc-7baa-62c7-5689-ccfc9bf16240@...2181...>
 <5769657c-ee4a-435b-9938-16700c8079d8@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="pcmljBH2FJ74AkRI"
Content-Disposition: inline
In-Reply-To: <5769657c-ee4a-435b-9938-16700c8079d8@...1856...>
Subject: Re: [Openvpn-devel] RfD: printing of port numbers on v6 addresses
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--pcmljBH2FJ74AkRI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Dec 26, 2018 at 11:07:18AM +0100, Steffan Karger wrote:
> On 19-12-18 00:09, Antonio Quartulli wrote:
> > I personally prefer the rfc3986 notation because it is more widespread
> > and, therefore, easier to understand/recognize.
>=20
> +1

It's about the most ugly way possible, so "best IETF style"... :-)

How shall we print a single IPv6 address without a port?  Always using

  [2001:db8::1]

is not exactly making the log lines shorter...  and having the code
decide whether or not to include [] around the v6 address depending on
whether or not to print a port isn't improving readability either.

I find "2001:db8::1#80" to be actually fairly nice, as it doesn't add
extra characters, is clear enough with and without port number, and is=20
permitted by RFC5952 as well...  (RFC3986 is mostly concerned about URIs,
which have their own ":" already for the protocol part).


But if you all want brackets, so shall it be.  Always, or "just when
there are port numbers to be added"?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--pcmljBH2FJ74AkRI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJcI8okAAoJEB2Cnv7KVigS2yEMAImygm74iC0nPa1BkQMI2+ZF
yv2nhS603588h761UYdJZJgRr8Nw1kLn3lwVA8NulbNW/bsxRHWo9djGAxR7Vur3
RYVkZoyhCqgGeh/Ape0Nc66aShCRhr76MUyccVjexN9ovtRBVZHw2jWWJt8AQ9PF
8dXdxd8aH0RDunNKgsNEUu3TJZSL9s+cAXQcR7fSnVRWYw67iKNafl512IkKuv29
AIa3lr97LYd7PCGG35RzXeIEtibuiG731GwZKmKiU/1nC3bpTUohrEV5SyyhGCKK
vyuxN63wr/TpaOeijWeVUW2sB5T6HwHAZb8ZgamvN311viJ8xrA3EvCI8zBTJO1W
5dcTRoWwTMokCdYRWHUlWA9WZgEHlYee0p71XmMe5Ch0aktkXJOCp1/LIBuZku00
ZIWIZ7YIHuZRWBF6QAAi7Pi0PtErCugvIvhqtzsy0MPCmL/WMulq4bE1g3ZjsOpi
B1hZeknQ6pp4XIHjlCSEuHe4FPct4DqYFWYC5YlNag==
=8Ltq
-----END PGP SIGNATURE-----

--pcmljBH2FJ74AkRI--

