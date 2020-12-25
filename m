Date: Fri, 25 Dec 2020 21:03:35 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20201225200335.GA976@...1296...>
References: <20201220105430.GP976@...1296...>
 <093511bd-43c0-a37c-1d8f-335d9df451d6@...1227...>
 <20201220185402.GQ976@...1296...>
 <CAKuzo_ja=a9XxHkQX5Vv2_UTT1vWNfO8S-XLvvKZ_CQ6f-U1uQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6ID7XVqUnZs1hKFT"
Content-Disposition: inline
In-Reply-To: <CAKuzo_ja=a9XxHkQX5Vv2_UTT1vWNfO8S-XLvvKZ_CQ6f-U1uQ@...278...>
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
Cc: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6ID7XVqUnZs1hKFT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Dec 20, 2020 at 07:31:42PM -0500, Selva Nair wrote:
> Here is the link again.
> https://github.com/selvanair/openvpn-gui/releases/tag/v11-echo-msg
> I got no feedback then nor now.

I have stared at the code a bit, and it seems to make sense.  The part
"store a digest + timestamp, and avoid repeating the same message for
<n> hours" is a good idea.

I can see that "echo_msg_clear()" has a bool parameter to clear the
message history but I can not see a call with "true" - what did you=20
have in mind?  A button to clear the messages history?  Or "if changing
to a different profile"?

I have not tested the binary.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--6ID7XVqUnZs1hKFT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJf5kWXAAoJEB2Cnv7KVigSKTIL+QEZqCiOCfnCKxehonJwupFJ
ZqnNYSw1l1ZmJgyJ71bzggzhmjREQWdyr/XkQB9li9spXyCcu6dK3wt2wS161RQh
5KgtC1j0OeX6FYx2jWFzQKkBx1BoUxZxvkrY1ZaTEE31XNiLL4GwI/dcflYWY2Wm
tRabI7PMD3eXE+X2tmC2zwI1/fBtJIxT+tITD4na2IZPbq+HBC9S0knymniG4DV0
hCAQRfmtMDSasAvuc8V3d2TcQA28KkyPo63QA5YWpJXRaeeaYCLyNYON1Ipa0sgm
dT3bL/EOyX91KT3Ih7SQVwZAXSlXxhyxNUCtTs7AncDKzDuHZpLoLNqblmV8X8Qm
GRo01XECLqrs6r9dm8cvWYpnqLED4uZwMUvqax/bG4PlAvHtkEl5k8ePOCQiT/GD
0eqcGCHGHdOGnG+DEEbalVAp9sJ9D7192QyVszk9G7RMe7DgPptwE01cxaZxQOXe
jXb1HpiOdCrXdQiv87aCu6Lst4RIfckkP4jeCsRq4g==
=XNlf
-----END PGP SIGNATURE-----

--6ID7XVqUnZs1hKFT--

