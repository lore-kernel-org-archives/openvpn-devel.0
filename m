Date: Tue, 28 Mar 2017 14:21:31 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170328122131.GV93896@...1296...>
References: <ec21d010-67a3-0ff1-3c2a-d5db08039e45@...277...>
	<20170327183502.GJ93896@...1296...>
	<CAKh=nwE-U4C6CVw+XpdBE1RXjG_VOYoT=UuJDAPs2AOFOoP+jw@...278...>
	<668fd081-d9b4-1727-f506-07395cf0b475@...1435...>
	<8c8a5600-0e9a-eb04-41de-33ebfdf36bfd@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhcyhtwhiTBwkXGM"
Content-Disposition: inline
In-Reply-To: <8c8a5600-0e9a-eb04-41de-33ebfdf36bfd@...2080...>
Subject: Re: [Openvpn-devel] building HEAD + openssl 1.1 api fails @
 "crypto.c:823:32: error: invalid application of ???sizeof??? to incomplete
 type ???cipher_ctx_t"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--zhcyhtwhiTBwkXGM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 28, 2017 at 02:11:26PM +0200, David Sommerseth wrote:
> > That's great!  This way, 2.4 does not have to change it's behaviour.
> > Still, I think it makes sense to deprecate --ns-cert-type, and remove it
> > in favour or --remote-cert-tls in openvpn 2.5.
>=20
> Based on the feedback and discussions in Fedora regarding to us removing
> --tls-remote .... I actually think 2.5 is too early.=20=20

Nobody suggested removing --remote-cert-tls.

This is about --ns-cert-type.

> We need to have a
> patch very soon complaining loudly in the log files=20

Like, 57637d0f677d824dacdc83d858357ccc80723f45? :-)

> and get in touch
> with at least NetworkManager guys to ensure they have time to implement
> a solution when this goes away.  So I think 2.6 is more realistic.

Shouldn't be so hard to do a string-substitution in NM...   with
60b23236329e6921729f51e7689042a29c794a6b, this is really straightforward
(unless your certs are really, *really* weird, providing a proper=20
nsCert extention, but no proper keyUsage/extKeyUsage extentions).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--zhcyhtwhiTBwkXGM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJY2lVKAAoJEB2Cnv7KVigS17kL/AoBznyFP1KqwdRLFbUN8kIa
NJXq5uLxVBWZzFcA46CUYCjhiFvYtcj3y5ayrzCnbgAsGkAjHhOhLtNfg3nyBXyX
/ySkadywy+GkAaNhH+3VrxuoEYEqicb1wdNHmMVoSrAN06A5Ws4iBqL5nhWlz1nD
OfbCGyw+3L59OOp5Hcg0FdJTqcY+gwkS98/ZajuFWzkN9kOva5pD1GJYIPwNpNHr
ezOq3gw1VSQGQgZpMHZeyu7IUW4aimeBbvP4Vbp2R949N1o11ZAL1s4OD40nW7iM
ysWBr9E3vIHttLyryYOR/G0pG+kb3HprPRDGv5Nke00Jt61kXQzifIawQ+kITDy+
DoT1q7h7QGEQC7VzLJCMV4dkfL1slN4DIunA0ficuTf9aEa57/ZtOMtDafBM2m0q
VdYhQz14q2Iud9Q3pTEyrckNB49AelJTixBe5FBOIJf9LwQrRt0IhFjO3wDGUHuj
6Iqs75Y4O5l9WAjE1rOnbVDE3qq2O0bH5WRkrgA6Pg==
=DLRy
-----END PGP SIGNATURE-----

--zhcyhtwhiTBwkXGM--

