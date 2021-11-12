Date: Fri, 12 Nov 2021 13:56:07 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YY5kZwjLs0lCGxgz@...1296...>
References: <CAGyAFMVbX1m_LhB=rV1Kh0uqpjfgCy6WP9t1o2bLTT+dO-L9Gg@...278...>
 <20211109015927.311-1-lstipakov@...277...>
 <YY1HU85OwqH442H+@greenie.muc.de>
 <CAGyAFMXNmuHUphBCCnPtr+RJ5ygam5JNaK94VBGTU6mizkjCJw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="E02c82pHis/l9YYg"
Content-Disposition: inline
In-Reply-To: <CAGyAFMXNmuHUphBCCnPtr+RJ5ygam5JNaK94VBGTU6mizkjCJw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Use network address for emulated DHCP
 server as a default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--E02c82pHis/l9YYg
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 12, 2021 at 02:33:31PM +0200, Lev Stipakov wrote:
> How about we apply my original patch (0 for /28 and -1 for the rest)
> to 2.5 and this one to master?

I tend to go for "make it simple and consistent", which would make this
"0 everywhere, if it breaks, the option is still available to set it to -1".

But with your testing, it should be fine on all platforms we build for
(so, yes, it might break XP or Vista, or 3.1 :-))

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--E02c82pHis/l9YYg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhjmRnAAoJEB2Cnv7KVigSetAMAIenzIh6MceWmecbpGG2Zq7u
2qcACFkACpqOD7CWhD7zbbk4b+NC8yg61dRS+kQT67Bqb+bEVuk3DDG61KRC92h2
jRXr6TRU/DKxgjbIVVSNLDs7yNEM3HzW6VrhPTBXMjWhyZ3jn4Hh4KAeJLVjJofu
UuyvsIAmbZg2ZKVk4CNEmvGADiDPjFVc2JnDEqQpZi8VZkgECtci490k2Tm5Hl8C
Lx8eFgiXDpj6gB/AY6GDSxswRO9LaLz1M+4s1hJSlQxl3QUXOh3V47QY1KFkmuLu
prVg9g6aFaZOPJ46eZJ0CKpKE3LelRtn/8DOJq3lKlE8ScZ6DXtH3Gr7AoTQ++qA
/6acFv2hQdgqDmJgoX6jSDRCHMFbbyMPbZ9J75SUuLG/S+2Kex3k4+1z1sbD+5Pb
/GgfpCos2npywXXM0XmJ1uAWTca7ULLUAAQWYVWfcjCEgLdvAfp7SBTjq+D/sLaI
z2pUm/+qKARCulS+tWlYUfsTwU0mZ4uROxjiGjnyyw==
=mI0o
-----END PGP SIGNATURE-----

--E02c82pHis/l9YYg--

