Date: Sat, 20 Jun 2020 18:27:12 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200620162712.GK1431@...1296...>
References: <20200620162206.13956-1-gert@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jTe4wBx5NKohz9hV"
Content-Disposition: inline
In-Reply-To: <20200620162206.13956-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Add deferred authentication support to
 plugin-auth-pam
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--jTe4wBx5NKohz9hV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jun 20, 2020 at 06:22:06PM +0200, Gert Doering wrote:
> If OpenVPN signals deferred authentication support (by setting the
> internal environment variable "auth_control_file"), do not wait
> for PAM stack to finish.  Instead, the privileged PAM process
> returns RESPONSE_DEFER via the control socket, which gets turned
> into OPENVPN_PLUGIN_FUNC_DEFERRED towards openvpn.
[..]
> Lightly tested on Linux.

This is sort of a "v1" of this patch, knowing well that it needs some
more polishing regarding logging etc. - but it would be good to have=20
some feedback if I'm overlooking something crucial here.

"It seems to work, though" - as in "I've built a pam stack with=20
pam_auth_radius talking to a non-existing radius server, which will
always add 15 seconds of delay - and with this patch, two clients can
authenticate concurrently, TLS handshakes do work while a client is
authenticating, and pings for client A do not stop while client B is
connecting".  And, no zombie processes.

I have not tested this in anger, like "100 clients connecting at the
same time" or "let it run for two weeks with 1000 clients connecting
and disconnecting all the time".

=20
It goes on top of the patch that adds plugin_log() logging to auth-pam.c

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--jTe4wBx5NKohz9hV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe7jjgAAoJEB2Cnv7KVigSKrAL/1FDfy0Ih2m15Kc6Oqe6Vghd
1LyMSJ6IhKVilLq/2bIKVnAuAjpQnyVTLKbhjvo0Ii3Wp1qytQYYrbHS0636uj9q
a5Bm2TZ0bhmuixexpsaMeQmZIl+cBA4eyT4750ccZoUoqBYjOCj6ibawocXpQXrG
W5HdqtKu/rFJP1t2zT4Xw0pKhVlv2o0xCQDQC7o2p9gt0GiSr7M8R8IVaHkjpJct
L2wCBWatUHdJtlLv3Kh2Cn+zcNOoJFTP4NsHdGq87XbQp59ekfmWtYSvfR8B6jPk
4jhxg/txoie+ulfPQA5mdgRirOgT2ANMoV4+76rJVryNLmAj9dBNXkRUf1d0/gFb
qwjN4Tg/FM7k5j1AeFDuyqIy+pXtK81mQw5g+TBhWOxYxyjIF4mCokAoDOpxLvPp
+tuK9TEpENWq82dvWDHRqz52oX99kXhymaJdtuQpTTCagZRyJ5yKRt7vNh1z/JPY
Q0BlrDUHiqtzprWzqk7gyaMvKhaXSRNLeWtZ+uNRtg==
=TIGD
-----END PGP SIGNATURE-----

--jTe4wBx5NKohz9hV--

