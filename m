Date: Tue, 30 Aug 2016 22:03:39 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160830200339.GA78279@...1296...>
References: <1451908945-12244-1-git-send-email-lstipakov@...277...>
	<1451911424-12970-1-git-send-email-lstipakov@...277...>
	<20160822191828.GT78279@...1296...>
	<20160823134336.GE78279@...1296...>
	<57BD5706.2080305@...1147...>
	<20160824131315.GL78279@...1296...>
	<CAGyAFMU+5HM9OhfPB2+3fAhhDOfm-Mr8GLeGnKcbMbZw43aK1Q@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uIXfmRCUCQeQUmxa"
Content-Disposition: inline
In-Reply-To: <CAGyAFMU+5HM9OhfPB2+3fAhhDOfm-Mr8GLeGnKcbMbZw43aK1Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Drop recursively routed packets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--uIXfmRCUCQeQUmxa
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 30, 2016 at 09:59:52PM +0300, Lev Stipakov wrote:
> So, following changes are required for V3:
>=20
> 1) No drop_if_recursive() call for P2P

Well, sort of.  It's useful in p2p mode as well, but it needs to check
if we already know the remote address before trying to read via the
pointer :-) - basically, this code:

+  struct openvpn_sockaddr tun_sa =3D c->c2.to_link_addr->dest;

needs to be prefixed by

   if ( c->c2.to_link_addr =3D=3D NULL ) return;	/* no remote addr known */

(maybe the same effect can be achieved by moving the drop_if_recursive()
call slightly further down in the packet processing, because something
should drop it anyway if there is no remote address)


> 2) Same for TAP

Nah, not "disable it on tap", but "look up the protocol type without
messing up the buffer" (so, not using is_ipv4() and is_ipv6()).  The
function itself is useful on tap as well.

> 3) Add an option to disable it

Yes... people using multiple routing tables will not need this check,
and it might get in the way.  (I'm not a big fan of "yet another option",
but it seems necessary)

> Sounds reasonable?

Yes.  Thanks :-) - I'm also willing to work on it, just had no time yet.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--uIXfmRCUCQeQUmxa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV8Xmm6kuBuNlUUl1AQIF6gP/Y0kmncKCeBj06YOgJYioZDFifZvpLfYi
oPr2hlakacplCB0MuCzsWrhHxFIJ4Mv35yR6F47rWU7ABVa5T5uiEx0nJm5dQd9o
Idb+qQR+KxFCTUOy0uP70sMMEfHUSQ2cVodlY8elm62rHOFVJqrevngT5AUjP55T
sEAZ2Mb0JDU=
=rllH
-----END PGP SIGNATURE-----

--uIXfmRCUCQeQUmxa--

