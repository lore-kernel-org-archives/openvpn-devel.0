Date: Sun, 18 Apr 2021 12:11:27 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210418101127.GX976@...1296...>
References: <20201215164221.5995-1-arne@...1227...>
 <20210328120241.27605-1-arne@...1227...>
 <20210328120241.27605-2-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="T5CAswkh6pll9syd"
Content-Disposition: inline
In-Reply-To: <20210328120241.27605-2-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/2] Fix condition to generate
 session keys
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

--T5CAswkh6pll9syd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 28, 2021 at 02:02:41PM +0200, Arne Schwabe wrote:
[..]
> @@ -2240,7 +2240,8 @@ error:
>   * to the TLS control channel (cleartext).
>   */
>  static bool
> -key_method_2_write(struct buffer *buf, struct tls_session *session)
> +key_method_2_write(struct buffer *buf, struct tls_multi *multi,
> +                   struct tls_session *session)
>  {

For master, this conflicts with commit 8fa8a17528c (compress migrate),
which already introduces the "multi" parameter.  Master only needs the
second hunk (documentation plus CAS_SUCCEEDED check).

For release/2.5, this should be fine.

How do we want to proceed?  Take this as "for 2.5", and you send a v3
"for master"?


I have tested this patch for master, on top of "1666 with the=20
ENABLE_ASYNC_PUSH fixed", and it passes the server side test rig...

Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2g 2d 2e 2f 2z1 2z2 3 4 4a=
 4b 5 5a 5b 5c 5d 5v1 5v2 5v3 5w1 5w2 5w3 5w4 5x1 5x2 5x3 5x4 6 7 7x 7y 8 8=
a 9 9a.

... and also the "I have a client with --bind and renegotiate and then
reconnect right after ctrl-c" test...  so this looks ready to go.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--T5CAswkh6pll9syd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgfAXOAAoJEB2Cnv7KVigStMkL/jcXDywNBK9/io5nVYwEbznS
1H20nZOQ8RKPYUiwhPyZou+7Jb3OZg1X11NoPtMT4bksYQ3qwCJj78uZudC1qBpK
Qo3h3F+ZjMnALCCatQcTbd9z7EyCsT28AE7CRW2evJDPjHZT6Y/v9bn2Od1e0fct
u5vebQElhk2jSfgD5IDs1mvWedOia0Jot+PE/PimOwGRZJz/7M9S+dm9Xq+Q6lI3
TW/dyRnb3WpwW40M+Vip9wccatOp81ddnRWJKDLehzgMxnQpEZLx6XbhgWCkhViH
e6XF79X8xZZUGi8joQcxkJeg/mW757l9qhiNOxu2yISMyQ3zZzuSYMdvDncWXEof
gVL36JtkvFOKrzBR213Zl7dXV+TFAQQTYhTQM+T7Adda4AoPyWih1CitomxgE6j/
rNr3uvN3Cct1QKMYheSVTDMw360eNC/HMLjUHhnAzsS5Pv8pXBJcUtToxGxGHpeX
MPBR81YUXgaUMeRe5yf4HVjGmvXpcwTCXMetGmymoQ==
=ZkPc
-----END PGP SIGNATURE-----

--T5CAswkh6pll9syd--

