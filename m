MIME-version: 1.0
From: Till Maas <opensource@...519...>
Date: Wed, 10 Dec 2008 11:05:42 +0100
References: <22886.54984.qm@...1158...>
In-reply-to: <22886.54984.qm@...1158...>
Content-type: multipart/signed; boundary=nextPart1606797.9Cq69GqnkE;
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-transfer-encoding: 7bit
Message-id: <200812101105.49308.opensource@...519...>
Subject: Re: [Openvpn-devel] Running Single OpenVPN Daemon on multiple
 (selective) interfaces
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--nextPart1606797.9Cq69GqnkE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tue December 9 2008, Keyur Pujara wrote:

> I would like to bind OpenVPN (in TCP mode) on two WAN facing interfaces
> only (not all).

> Would help if someone could comment if there is way to do this by running
> single instance of daemon.

You can bind it to one interface and use iptables with DNAT to forward the=
=20
packages from the other interface to the one, where openvpn is running. At=
=20
least this is what I believe to have done, except that I used a third=20
(virtual) interface to bind openvpn to. This makes it possible to take each=
 of=20
the other interfaces down and still provide openvpn access on the other one.

Regards,
Till

--nextPart1606797.9Cq69GqnkE
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iQIcBAABCgAGBQJJP5R9AAoJEGo6ELMcEJUXpdYP/3e2CrLo5a4pvZYYMwBtBBXf
Qn1T3ZE12MROlFvQarpxvRc+cPXlcVhIfWfI6MKCGDUVYm2A3cVGvn4vEhHYOQuC
9BWhwxSjLtoFUt/8RRGc+nOXe8kiQvraCfm/mlt5HmcxNzY7yfIWRg1KDeKMIzCI
xeU7lMQ2autJ5KXRk5qJy0OQMiWT9L19gfjPtX9mSMzp2ifTm8RTgbh4dEx/I1fu
432at4KrX850SUNVJcXARwM1bBS56kj0dZSlMK9/occXMrAK7Pdf26XEvZrEPBIs
wYM+L99OEPuTb2eUTcyRuPx9bx3XqvBGvYffwKW7rezkoniknsGEco5nnOdbpDrv
DS43a/GAiioojy1aNAJzDJDhB+XdigA+923F4lZiN3Kql2QMqElfo92Qul3HP1q6
oLLWah+do10HGPi7eS5TSr7B6xaA5rbhqHw7fdf7Nw/T25yF7gITDzOaZ8e5ed6M
H7Ij9YS5+cbvwcHyXq8gEdIuwbAr+cctxSz7xVeH4Xl7rffx4UOw/zQbqFRlUCYj
u70FnDqstTXv3tLnuRX5CuHv/OeuXNJby9KII57Rh+PKLwXgDRQFxNX5D23icrp9
TAwONxoT8HGfe5aGXlDDwb65+Xk3AtzOAI/wuc7saxEJ9Ut53oxuy7jYjpqYibuE
Z5wReoiotDCj+BWN8k26
=yofV
-----END PGP SIGNATURE-----

--nextPart1606797.9Cq69GqnkE--


