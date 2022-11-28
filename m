Date: Mon, 28 Nov 2022 13:03:02 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y4SjdkeiOPhTUfVv@...1296...>
References: <Y4Shyldcb82P6An8@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="WvDKsYIL28uqvv60"
Content-Disposition: inline
In-Reply-To: <Y4Shyldcb82P6An8@...1296...>
Subject: Re: [Openvpn-devel] new P2P NCP wart...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--WvDKsYIL28uqvv60
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 28, 2022 at 12:55:54PM +0100, Gert Doering wrote:
> 2022-11-28 12:55:25 us=3D199080 ERROR: failed to negotiate cipher with pe=
er and --data-ciphers-fallback not enabled. No usable data channel cipher
> 2022-11-28 12:55:25 us=3D199092 ERROR: Failed to apply P2P negotiated pro=
tocol options

Thinking about this a bit - what I think this should do is SIGUSR1=20
itself, so reconnect (subject to the usual exponential decay) or exit,
depending on user config.

It should not just "sit there and be happy to do nothing", not even
logging the "I have no cipher so I drop your packet" fact.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--WvDKsYIL28uqvv60
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjhKN2AAoJEB2Cnv7KVigSM50MAIl5Ut/upoioM2b6Yj9o90wj
BT7IPjLC0hpaEqXSsgGTYWkH84z3ROL7IC4nYBsJcqLEOLtM/GESYUCPwj/OA8ZA
S8uOVUNc8S43M6SbKRIBmwUm2Mrs+nfCDDaCbTBMv9NRnKx0bShKn7cFKKxK5y/i
Rn1cMccsrutCgP7aBjDfaiv1be2dvWOBQ4yYFXEYSkUUK9H098pnBg3RvLQ2Cdwg
rqUVQGkRmaCTDPaMqbsS1omuneiOPn3bfFb8TX5MkJ+TAk8bApf/wAWKEgX8Q2HZ
VbJvP46bibOhc2nrFoyPaT7i/lnmJh9WqaOlLnoFqYEVsCuCnQPAbiclzFJ27QjV
GrzWQFsyTj1ba0apfw2si02tk6CzygFH+XB56kZaiqFemsZ7D/oqjlTK9ik6/xYS
DRWSbTRF01INewQH++hDKXEVaAoDHRQgpWtbqlVTW2b58av3lz5bxQsFGK0dAd/7
7k0F0I2jR2uSJ4pEl3fKRE04MnrWO5M+Ja8Lej33qw==
=Fmh/
-----END PGP SIGNATURE-----

--WvDKsYIL28uqvv60--

