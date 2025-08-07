Date: Thu, 7 Aug 2025 07:44:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <aJQ9IkQIdH6sFNvt@...1296...>
References: <CAOh3LPMvAFtZ7rdBVYZ2raErtNM2=F-r1WQv9+YZE+6SxRfM8Q.ref@...278...>
 <CAOh3LPMvAFtZ7rdBVYZ2raErtNM2=F-r1WQv9+YZE+6SxRfM8Q@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tquh3qprrJ+1s5Ee"
Content-Disposition: inline
In-Reply-To: <CAOh3LPMvAFtZ7rdBVYZ2raErtNM2=F-r1WQv9+YZE+6SxRfM8Q@...278...>
Subject: Re: [Openvpn-devel] Bulk mode - Feature request - Patch diff
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jon Chiappetta <root@...2904...>
Cc: openvpn-devel@lists.sourceforge.net

--tquh3qprrJ+1s5Ee
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 06, 2025 at 07:50:16PM -0400, Jon Chiappetta via Openvpn-devel =
wrote:
> I was still working on looking into some potential limited access to
> gerrit. I manually ported the diff from the 2.6 source code I was able to
> compile and run with over to the generalized master branch which doesn't
> contain any configure/makefile so I am not able to build/run that version
> at the moment (untested).=20

git clone $master_url $workdir
cd $workdir
autoreconf -vif
./configure

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--tquh3qprrJ+1s5Ee
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJolD0iAAoJEB2Cnv7KVigSN+ML/AmpAEbCvRUyJpgY1szkEZwd
8aiL2Lq/j9daH8D4bneERbMLFxs/NaxebYUhIw8Lb4fQJBPfMwPqWwiPhjyxGAsN
Psxs2fx5SGVIjLXUCqs13muPIRXbZXSmGg4mel2/iv3t9rqsttQEP+mRnTu76kov
dvCHNHukDo1kzwex2Y+n31ORXyPn9ILPwvtO2F5CaedOHRh0Xj+UttmRNJ0vSPmB
iX38/jfLmlSW+AtbIw/f8RcnuIXiuuE/KtI2v7h2RgIhgRWdRmSZjMAGCsDpocxf
iV71EKbta5G7QR70N3RPBQYgjJy6kn5H//rmvEdEgQq5HIJJKWxSmllghSyxHe4A
YnhVa43nbBtzaH9XXOADUXEPquAvFGYXcWkET6CtQqmzks2BfU0relb229MtKGfi
9nP2NrUkRqN+XmowezA1pC0c/kWSQXKwz1GN3VDIaH6OKvENXmhGXuxFvLC04Gb3
RrnzQBqI1WHiUZAcUS9HjmRQ3x1nxwW0bFEmhwLpnQ==
=v1md
-----END PGP SIGNATURE-----

--tquh3qprrJ+1s5Ee--

