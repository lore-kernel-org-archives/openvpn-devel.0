Date: Mon, 14 Sep 2020 12:16:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200914101633.GQ75094@...1296...>
References: <20200909183012.7504-1-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="SS2glZ7foAr3Pi97"
Content-Disposition: inline
In-Reply-To: <20200909183012.7504-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] man: Improve --remote entry
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--SS2glZ7foAr3Pi97
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Sep 09, 2020 at 08:30:12PM +0200, David Sommerseth wrote:
> +  *Note:*
> +     Since UDP is connectionless, connection failure is defined by
> +     the ``--ping`` and ``--ping-restart`` options.

While this is what the openvpn.8 man page used to say, it's technically
only valid for some variants of "peer2peer --secret" mode.  In TLS
mode, "connection failure" is defined by inability to establish a=20
TLS handshake in the timeout time.

I'm going to merge this anyway ("because this is not new text"), but
we should come back and revisit these notes.  All these notes.  One day.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--SS2glZ7foAr3Pi97
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfX0MAAAoJEB2Cnv7KVigSg24L/3UrLKec1TRtUbLKe7KcLZhB
7JW9AZZjX9qDJoz3BAKy+wBqeA9ed/Q2ui9SGJh+jxTTkrXapYJ5Oe7U45tshyL7
oMxUIuv/NVxI8n4xcuMAoJCx7CUorwxTD/OSrMOEzsvw/CZUW1RU6alArEli5FNF
cA+viiSpBJ9NIg3j/uhTh3rMu6k350zdQUnTyNW70WTdaEIanJm/V7bmMwCVu2ht
OeKMqDNidXJeuz/79bvhwfCg03qCzNVx8DKnv/RMh0SJBwptfrRG3zVPwCLtwkz1
N3yQkmAWzrZ/tl+tlkui6hVRI7WGJVJ8SEyB+KyjBqHgeeKc11lxFj87SiXoqRq1
ZDKncwHtZCtboA0r11UXmJWv5avLEqHF19Z3gxQMytWNcXKThqJ+xTcuSLHxoBm6
yTPgJdGCo6etetfHRdi1V8OUc/qiKwKwVwkR/RuQ9e7TSfTdrRxtSgFg4QN2dcPb
D1AV+XCYE6z0YG6sNfa3EY5EfBlsn1nBWSN7K7OWEw==
=2JIw
-----END PGP SIGNATURE-----

--SS2glZ7foAr3Pi97--

