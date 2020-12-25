Date: Fri, 25 Dec 2020 20:29:10 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20201225192910.GX976@...1296...>
References: <20201220105430.GP976@...1296...>
 <093511bd-43c0-a37c-1d8f-335d9df451d6@...1227...>
 <20201220185402.GQ976@...1296...>
 <CAKuzo_ja=a9XxHkQX5Vv2_UTT1vWNfO8S-XLvvKZ_CQ6f-U1uQ@...278...>
 <20201221070420.GW976@...1296...>
 <CAKuzo_gMh+ZJ0YovjkUdyHzDO8cLsM_2Djsk_Hrx6N3AZMPw7w@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+FZNYWTAG8fjM7ZB"
Content-Disposition: inline
In-Reply-To: <CAKuzo_gMh+ZJ0YovjkUdyHzDO8cLsM_2Djsk_Hrx6N3AZMPw7w@...278...>
Subject: Re: [Openvpn-devel] wanted: mechanism to send text messages to
 client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+FZNYWTAG8fjM7ZB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Dec 21, 2020 at 12:22:20PM -0500, Selva Nair wrote:
> > I'm sure the thread is still sitting in my mailbox... will go looking f=
or
> > it today.
>=20
> For those who have lost the original threads:
>=20
> https://sourceforge.net/p/openvpn/mailman/openvpn-users/thread/CAEsd45T%2=
Bd6FUJ9Po0KHwtHjfuL9Q2D-poG8yFtY45Qyh%2BtHjkg%40mail.gmail.com/#msg36136236
>=20
> https://sourceforge.net/p/openvpn/mailman/openvpn-devel/thread/CAKuzo_jPT=
hhvXTJAtzhqVUVOLPW1VGu6h2jQhVsHicY8P2WRqA%40mail.gmail.com/#msg36141193
>=20
> That was in Nov-Dec 2017. Actually, I was also thinking of reviving this
> only the other day when intimating users about some updates came up..

Thanks for digging these up for me.  Very interesting read, this :-)

I have tried to shape this into a "v 0.1" patch which should hit the list
"right now", also in reply-to to your e-mail.  Comments and corrections
welcome, I'll whack this as long as needed.  It's in patch form, but=20
basically a draft, inviting comments.


> Somehow such itches re-surface at the end of the year :)

Let's see if we can progress this a bit more :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--+FZNYWTAG8fjM7ZB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJf5j2GAAoJEB2Cnv7KVigSsZYL/jhtkfIcaFSKpM5QuRKUOS6R
ooxsl/4aYyc7gNffEGEyhfUflJKHZ0O4/Lh+oVelUvrbJlRKB4ZBzO3Bq6PXzArF
J4We8Bv12OhqMUvao59DXPWz/JVjZTg9+RAvWOiso6OmpDtTZjo8oib4Ls40VxTQ
z8nGZ6x4s0NSr7GNlC1TlDljeAI9eiNPlj/wvx1PJQl/WjaxuP4gUGRp/yRQnEXz
mAbUkHwjqZNOPcJHt/15269vb5UsqSD46EW2ri188CC2BOYNpz4my5ewxUq2T4T6
jHGSt30Cx9H/MNyRndcM3bUms7LOVmVQeojdx4WuUqBpXJS8ZcAYA5rQcK+K1Nm4
OfateuKPBln4wmswEMPIj2QrEzUbUWHvfyRbRUIGcJxSZFNlOWagp9/tYYfyWnzB
ABiBHax5GQvXeiFuX429bKcQtoCieMs6GmodFinbS8IZ5uwCByzrxonuR5mZDBqI
9ZIgI7U+lr3tolxL7Dyri1XcR4JTY+GYEuH5uP+6qw==
=BCHJ
-----END PGP SIGNATURE-----

--+FZNYWTAG8fjM7ZB--

