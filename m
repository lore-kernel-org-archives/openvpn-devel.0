Date: Tue, 25 Jun 2019 22:34:14 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190625203414.GN1097@...1296...>
References: <1561491241-16380-1-git-send-email-lstipakov@...277...>
 <20190625194905.GM1097@...1296...>
 <CAKuzo_g200Ck8fBTMmTe93R5A_+FjGoK0zKNQr49i01RmHfHkw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="cMIc5PxTaUbxPQlJ"
Content-Disposition: inline
In-Reply-To: <CAKuzo_g200Ck8fBTMmTe93R5A_+FjGoK0zKNQr49i01RmHfHkw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] openvpnserv: enable interactive service
 to open tun
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, Lev Stipakov <lstipakov@...277...>, Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--cMIc5PxTaUbxPQlJ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 25, 2019 at 03:57:18PM -0400, Selva Nair wrote:
> The way interactive service structures are coded should not require
> this at all, does it? The size and message type are already in the
> header, so why do we need to pass it? The result here is a new kind of
> ack message with a different size and type and that could be checked
> by accessing the header element. Unless I'm missing something.

You could, indeed, do this inside send_msg_iservice() by looking
at "what request did we sent?  so what should be coming back?" but
I'm not sure I find this safe enough (caller allocates memory, and
maybe we shouldn't rely on "it being big enough" unless explicitly=20
told).  It would work, yes, but leaves me with a bit uneasy feeling.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--cMIc5PxTaUbxPQlJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdEoVFAAoJEB2Cnv7KVigSJqkL/ApPFrJR2E0Oq51166e/rSsa
ZA0Hk0obYvT2PLRoRBssmduKuNub3Qgh+Yr8ZRHxLRXxrihkSHbcl9T3uhkS7Yhu
dDknebO7sD0kNyGXIT5iJHI7INH/0zexkjH4UWHXxwgFeYsyb+rrcZr67Abdm8aX
LMfC+bEDCvmjREMjC1Muqb3EWd9FI9+dG808mVBsrq7NQ1K+GZYbHyiEZY6kMFMY
QKtq5tOThuA8q/hfmir64DfWXoMUA+Iuc9cXW+hOWgNkBmFIAyTFuDKXL9pnyIT0
oxFALlRUM/iUgrppWFgEky9egbhSaIJDk6XBb2RUfJwQMtf7EfXQjJgj+D9zo0b5
T7zmKelqpHFjWlhaWpEGdt372/TNxsTd0nKQiZ+XsLCjCPlkjefTvOQe8jIyBdg/
/QQz2tTCXoe+2da1S4RucTx+Xwf2RBM1czegD6hIFLv9d6ClNQ7h08RCYe5zrIwE
Lwui//D+iqs0Za8aTerEI/u6zVBKbEiSwo+90sNMDQ==
=4NXO
-----END PGP SIGNATURE-----

--cMIc5PxTaUbxPQlJ--

