Date: Fri, 2 Apr 2021 20:57:20 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210402185720.GS976@...1296...>
References: <20210402134529.27866-1-gert@...1296...>
 <b92f02afa4d8156edd55c2126ae6352c.squirrel@...2260...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="qZ/dPbTGSNMhBBty"
Content-Disposition: inline
In-Reply-To: <b92f02afa4d8156edd55c2126ae6352c.squirrel@...2260...>
Subject: Re: [Openvpn-devel] [PATCH] Fix 'compress migrate' for 2.2 clients.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Matter <simon.matter@...2249...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--qZ/dPbTGSNMhBBty
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Apr 02, 2021 at 08:35:36PM +0200, Simon Matter wrote:
> What I'm still wondering is why is compression so dangerous with OpenVPN
> but not so with things like SSH or SCP?

The problem is adversary-controlled traffic in a VPN tunnel, like
"you surf on a web site, and there is java script that makes your
browser send carefully crafted requests while someone looks at your
VPN tunnel from the outside".

If compression is active, an attacker can see if "the parts of the
header that he can not see" are similar to "the parts that the java
script creates", due to compression making the resulting packets=20
smaller if sequences are identical.

Supposedly you can use this to steal stuff like session cookies,=20
which java script would normally not be able to see.


Now, I personally find this all a bit unrealistic in practice - it's
quite a number of "ifs", and even then, it's unclear if possible in
practice, or even interesting enough, given the myriard of easier to
exploit attack vectors.=20=20

But it *is* a possible attack, and if weighting "is this a good feature?"=20
against maintenance effort and possible security effects, compression=20
starts drifting towards the negative side (because most traffic inside=20
VPNs is already compressed or encrypted anyway today, so compression won't=
=20
have a big effect).


Now, in ssh, you copy files of your own choice.  Compression is useful
there, if the files are not already compressed.  An attacker won't be
able to manipulate just *part* of one file, to see if the neighbouring
100 bytes are "similar"... so this class of attacks does not exist.

(Crypto people, correct me if I misstated something...)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--qZ/dPbTGSNMhBBty
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgZ2kPAAoJEB2Cnv7KVigSVSYL/ia1PgysQYO/3d8KwznQg18t
nxDIwTIUh+bCHia55j+J5vKqLy5LvHPtOPI6qka9DOl5nlqs5rTFa1cikakui22K
Ep32LC/wLW4UatawVtmrFL7Ik7YQNRI1zL+fCUWBThWVfZ1U5Bz7aFtAP2+e+GUt
qWYrTzpM67+5xHYDz/wUk9yUmIXr3xDNw5F/gut/gQnbLSK1XrLKARPNlWXvBWHq
BhvRkCTDb2lxtPzKGnoc8Ean9/uCg4pUFXJ9Ib68ZRhGxkXRv/cba8iSlLIwFqxt
kWZVwhZSSU37EFe2AvWFL8Mxw9SZ0tN9ro8NyU1fBND7Izr3Ao67eZ2ZwJ4VYb5/
3Q+T8G7ijc4NiNNc5gtrIwbfNPxpo+TidxEzmKGWDjcbDVUTjyv+KMKKEwJOds+X
xx+rV4QmSNPC8UvCossJ6V5qZgQtmRcnoTWfuCObShnoM46Tg/8JJ99wBOGMkIZJ
c02VGYfZLxwjix5xwuzSgV5u0d+SXB6M8O2cv/CCQg==
=nEqq
-----END PGP SIGNATURE-----

--qZ/dPbTGSNMhBBty--

