Date: Thu, 11 Nov 2021 14:34:02 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YY0bykbHVuGLY3DI@...1296...>
References: <CAAYFXLmcybkvkw0RJ5gPVhkxrYKRr4XkdPUJwB4Cm--jQjdXKQ@...278...>
 <764146725.499610.1636544169460@...2642...>
 <CAAYFXLnJSMBcrN70GnaHRfREEosTPM-J8pZFw98DtkbNaZPKSA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="JoLXeg4h9RmXIcND"
Content-Disposition: inline
In-Reply-To: <CAAYFXLnJSMBcrN70GnaHRfREEosTPM-J8pZFw98DtkbNaZPKSA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] boolean short-circuit auth upon failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Pete Nelson <petiepooo@...277...>
Cc: Frank Lichtenheld <frank@...2641...>, openvpn-devel@lists.sourceforge.net

--JoLXeg4h9RmXIcND
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Nov 11, 2021 at 01:23:43PM +0000, Pete Nelson wrote:
> Thank you, Frank.  Amended patch so it applies only to auth attempts.
>=20
> Not sure how patchwork handles this.. my intent is this amended patch
> overwrites the patch from the OP.
> -- Pete

The best way to do that is to send the patch with "git send-email" and
add a "-v2" switch to that - it won't overwrite the patch in PW, but
we can see "ah, it's a v2".

Please add a note to the commit message as well what is new on v2,
like

 v2: only apply shortcut logic to authentication plugin calls

(if that's what is new)

Please do also do "git commit -s", so we get the signed-off-by:
line.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--JoLXeg4h9RmXIcND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhjRvKAAoJEB2Cnv7KVigSB4QMAIToxxOd6n1NBhi17c+FhxdI
tOKbhQ707PmKGivdwJcrHuMJUqGocHoB3RgpdRsK/u1U/4QklLcaoT83ERQ9TPTj
E2NS8p83FaJgKa4CGlc8oSUWEDZXXXfTpxqCvgs6Tn2Waf27ilDc/xkHmB4FV18z
um9GW7/yZJjr3kNjZBg0xU4e2/fEJE+3pVxeQ7SI8zI8TYoQq+Jr4sUbrz4gPFCv
TIINsEjQ3Ho1JywwO/j8sje87sME4lBeNOOe8NPEBq8iAllADxvXd9HonY0ZNFTf
YQb7tMvHfi9u4FqWaF6BS8j3dicRl+8EMVmqajd1tBA45miNyGSteoE3JsDzaNmv
0q8Lv0qi5ha2Vvi2WJh0J0pJEldQD5xuhapmHXt8CIDt8ZocqwALmtr+QM3C8xOc
KQtIquiwEWyWDkQtNXNnOI97Mr/9ffIvKMorEIs7aeWagc9eOiIAMF7wq/8SWgjz
SOK5TAShn3ygEySCa9MuARU8spFSKWUDuzXKxRErTA==
=J3Bl
-----END PGP SIGNATURE-----

--JoLXeg4h9RmXIcND--

