Subject: Re: [Openvpn-devel] More BSD TUN info.
From: Janne Johansson <jan.johansson@...1...>
In-Reply-To: <01ba01c1dbb5$2a3367a0$1000000a@...4...>
References: <1017760165.9891.85.camel@...2...>
	<008901c1da97$e4ce0b70$1000000a@...4...> <1017818817.1524.56.camel@...2...> 
	<01ba01c1dbb5$2a3367a0$1000000a@...4...>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-RaVcK4Q6SuSx/vbmkMgh"
Message-Id: <1017910625.1562.14.camel@...2...>
Mime-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Thu Apr  4 00:58:13 2002
To: James Yonan <jim@...3...>
Cc: openvpn-devel@lists.sourceforge.net

--=-RaVcK4Q6SuSx/vbmkMgh
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2002-04-04 at 10:46, James Yonan wrote:
> >I don't know the openvpn data format, but if 45000054 is some sort of
> openvtun identifier, you/we/I could add some code that checked for
> 00000002 followed by 45000054 and then strip the first u_int_32 from
> the packet and go on. Perhaps a --remote-is-bsd or something similar?
>=20
> Openvpn doesn't look at the tunnel data... it just encrypts, decrypts,
> forwards etc.  The 45000054 is the beginning of the IP header of the pack=
ets
> going over the tunnel.

Dang. =3D)
(Sorry for mistyping it as openvtun)
Still, it's just as well, since that data would look different when
encrypted anyway.

> Yeah, an option might be right thing.  So --remote-is-bsd would remove the
> AF_INET from incoming packets and add them to outgoing packets.  A bit of=
 a
> kludge.

Yes, but since BSD wont let you choose if you want it or not, and the
chance of changing Linux-TUN-drivers now is slim, I guess it has to be
the application that takes care of this. I'll try to make a patch and
test it, and send you the diff later.

I'll also try to make a diff to let BSD tun devices ioctl away that
particurlar u_int_32.

BTW, is it just me or is the sourceforge lists slow?
The turnaround time seems like hours to me.

--=20
Janne Johansson
jan.johansson@...1...
BioMat Systems AB
Klarabergsg 37 3tr
111 21 Stockholm


--=-RaVcK4Q6SuSx/vbmkMgh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8rBVhNJYxu+mj1OkRAkL+AKCwyJOjc2wXy+FUyTzEPkC9EOVtbACfUwWo
KqYBs5202gPkNZBzETpmISc=
=P7gt
-----END PGP SIGNATURE-----

--=-RaVcK4Q6SuSx/vbmkMgh--


