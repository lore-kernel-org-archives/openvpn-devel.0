Date: Sun, 3 Sep 2023 22:46:55 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZPTwv4K9qDjk3oCE@...1296...>
References: <20230903142947.20906-1-orbea@...2744...>
 <c0ecc754-7dda-313f-8cd2-047ebd1ae8cd@...2181...>
 <20230903091721.4a810beb@...2745...> <20230903095545.0f6d9d03@...2745...>
 <5e877862-457b-7241-f9fd-086adb9fe518@...2181...>
 <ZPTc50Xjm8Eqmger@...1296...> <20230903134413.090a03ec@...2745...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="cN7kGPmXZsixc2DJ"
Content-Disposition: inline
In-Reply-To: <20230903134413.090a03ec@...2745...>
Subject: Re: [Openvpn-devel] [PATCH] configure: disable engines if
 OPENSSL_NO_ENGINE is defined
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: orbea <orbea@...2744...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--cN7kGPmXZsixc2DJ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Sep 03, 2023 at 01:44:13PM -0700, orbea wrote:
> Thank you, the patch was generated with 'git format-patch' so I would
> think 'git am' can consume it, but please let me know if there is
> anything else I can change.

For the sake of the archives (so, nothing to do for you now) - what
we usually do is, for a v2 of the patch, to tag it as such, and use
git-send-email to send it

  $ git-send-email -v2 --in-reply-to=3D$original-message-id -1

this will make it show up with a nice "[PATCH v2]" on the list, threaded
to the original v1.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--cN7kGPmXZsixc2DJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJk9PC/AAoJEB2Cnv7KVigSdGYMALNGPAwaXu0SA9jpgU8i/54c
6NTCUyEYsueRjxFyb7XPfn7KPblPu5AeorKkD2cFQrETOyZX2ToNdWkKDSP5DNfq
aqVte4d149PYTZJ24SlaywDoDxlOC/oX6md6Qi7zg0h7xYPsS95uRHZtguyJJxXd
hXrnH4LIzbKBD8k2nZEO1b+AC2ZEEMa7I0GaGdTT1rKlnbN9R/JMC/C1AtI2oIXA
JAStUc96XfIKR0NIQd2ScauEbaNUHvYOHoy2G7S2hNhBG/d55uGsR8ofd3NoXlWz
OtUqtuwEvP0EBirngYi8liOWmPhuBlpGN9ua7YDh1vZ1aaamdhSrhCDRWz5nnbzx
vyrLb/dcZq9R858jag08WYDXmSjcDY16V6e0YKtGv0nrgOtlgPOa/B46qjjpmccj
4CbB3VsLnqbXru7fUMw+bXqlJVs0JN7C7PLr2ecFvNavSKNjB+G28YJJ0AOfT/7X
E7uIJZMNNplyaljSFxei+LFpZaxqBFpTIGgI9oLNbg==
=T+dH
-----END PGP SIGNATURE-----

--cN7kGPmXZsixc2DJ--

