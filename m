Date: Wed, 31 May 2017 09:02:58 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170531070258.GC97029@...1296...>
References: <1496177444-18373-1-git-send-email-steffan@...1856...>
	<29f51139-a525-fd92-0fe1-195d308d2924@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mVonZaCXjkyW6e25"
Content-Disposition: inline
In-Reply-To: <29f51139-a525-fd92-0fe1-195d308d2924@...2080...>
Subject: Re: [Openvpn-devel] [PATCH release/2.4] configure.ac: fix building
 against static openssl
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--mVonZaCXjkyW6e25
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, May 31, 2017 at 02:31:40AM +0200, David Sommerseth wrote:
> If we really do care for supporting 0.9.8, in release/2.4 - I can give
> this an ACK.  Otherwise, I think it might be better to backport
> 039a89c331e9b7998d804 + 79ea67f77ca3afe91222f.

You are the one that objects most violently if we break users' expectations
- and I think "changing library *requirements* right in the middle of a=20
release train" is a good way to do that...  even if all *supported by the
maintainers* OS version have recent-enough OpenSSL libraries, I expect peop=
le
to happily use 2.4.2 on "something", and if 2.4.3 stops compiling there,
this is not a good thing to do.

So I'd just fix the library order (=3D go with Steffan's patch) and not=20
backport the larger changes.

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--mVonZaCXjkyW6e25
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZLmqiAAoJEB2Cnv7KVigSQS0MAKECSycSEjT/7Mj7Rozk+96r
aEghf0gMhIsx4OoE9LENvwD8ci7mQ7wSf+jMiHgOqStOnK1G00tP2LTepg3yujwx
Ev2UoDnhrr/TpqquYV0zFELrmlD/4rsVslomUc802s01q+Kc1oxarpnb0UOiVird
BRIE9+8vgNZoGXvvn50MbfrZ+djyM/l87PQZ+b5Xheowkn2C2XVBFyubkHFFRu2h
4vGNAtYMtMn4KT7FQktx2gsYzyNcf30RFB8aMqOvxNnzV0shr+bQxodsxA++sgND
b6R0kQgjv9EDGPMD8tmx64zW+K21bYiOFa+2VTN7LT9qeU3tgmLr3XAWX9esCAY0
FLeCW01bcQB36sggV3qCYhMYD5u/DoLKqADITjGMfXUw/JbSB7XdqSZ1LDPR9go5
MvH0YVMkctH+AVBf7zK9BnnXep2Snezc2P4hqIRjt9WULZFAHADlrP9WdTYBACFd
4x+bSr6o0BhSbjsOQpyirenD0/3NthB/FmY55FMD1Q==
=i1Nw
-----END PGP SIGNATURE-----

--mVonZaCXjkyW6e25--

