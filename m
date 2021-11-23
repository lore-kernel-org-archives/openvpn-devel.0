Date: Tue, 23 Nov 2021 11:29:02 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YZzCbiezMd/zkrAO@...1296...>
References: <BF86C1C6-216E-4D87-9D88-B5D03F84159D@...277...>
 <CAKuzo_hrpBxCT8NDosi9AbMKFCpGkCF-cE_qYVtuL3Nh-C-pCw@...278...>
 <CAGyAFMUHqDObKdOPD37T-Qau+CXyb-oCQu-NLHYtJKnwhse80g@...278...>
 <CAKuzo_hv8H6zRbvCx_g680TNhHEvoP=OvB_FbGOZAy=jmHvPvQ@...278...>
 <CAGyAFMXpBRGHsTZQjRsr2ByoGx2G2isoqUwaZnwYX6NWWwZBpA@...278...>
 <CAKuzo_ggddGKgDewDWbjv3pNGAC-SK0dmD+Ay-c2HOHcVX5psA@...278...>
 <YZwNiBRC+V/E9OeI@...1296...>
 <CAKuzo_jicUu50x-CxGYE2DJjW0pwf06DCfMkhFn5vKz1AHCrcA@...278...>
 <YZyPoyofdC4M1CqU@...1296...>
 <CAGyAFMXE61tbhW=74jvoQLwegU2SjbFi8V-5JFGcEgO5=7OK2w@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="N0P5z3hUU612Qb8C"
Content-Disposition: inline
In-Reply-To: <CAGyAFMXE61tbhW=74jvoQLwegU2SjbFi8V-5JFGcEgO5=7OK2w@...278...>
Subject: Re: [Openvpn-devel] OpenSSL build on Windows: OPENSSLDIR and
 MODULESDIR
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--N0P5z3hUU612Qb8C
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 23, 2021 at 12:19:07PM +0200, Lev Stipakov wrote:
> How should we proceed? Do we define safe conf/engines/modules locations a=
nd
>=20
>  1) build them into openssl with our own port, and

Can our installer use "custom locations", like "install all our software
to "d:\mystuff\openvpn\"?  In that case, built-in paths won't work well
(as was pointed out in the PR, to my dismay).

>  2) use env variables for openvpn and openvpn-gui ?

I think that this might be the most flexible and robust approach.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--N0P5z3hUU612Qb8C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhnMJuAAoJEB2Cnv7KVigSFskL/1rCkHa0rG+Znu+pxOItn+qy
J2v1LN1LdXdbJGtQ6VCxamRGpMZ4+AoGPPt1nb3y5TUEKCTC4HDkLIEhAJEkKED/
blCzF7Kl/gLAjNMme7iY4RRiUczYjKsLGjDtTbFwADDk7lrTXb/KEwBa5PpQ5qfA
vkoEoCfP1x4qUb/oYk4MUzjItAzFnQHnNBgr1xALRvnVYVNhyJS8ovRGB8I4sWL0
izaWlwTGdB0cZ0GPVhPFuKxc6yhPeGuQ14Bj2s9AyU2othnUIJqtsAg7CkbbpOJN
z0YV1B64WBZoz7MOwPwHbwOcfyDy5CwODF0i734BL6O/Z0lf75MSdHAK3RHCdN9A
6I2h5tws6T2UwtD3Ka6MhOHboTOxHdrBkbrrlxbQ2LIs/HUjgwXC38eucnCL/llz
DDkNT9wGMPreP0tBESxb8CURTQEzB9VjqKWSUnuWxQUz/zvTNIXMjdWPDf6zoNu0
10jJ/Bxkvg7LEa2b9T35Rf8YLK/Fquo1sHesMX3rew==
=dlqT
-----END PGP SIGNATURE-----

--N0P5z3hUU612Qb8C--

