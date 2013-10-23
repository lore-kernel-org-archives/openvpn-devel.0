Date: Wed, 23 Oct 2013 12:48:29 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20131023104829.GL161@...1296...>
References: <OF80C424FD.27405071-ONC1257C07.004692C7-C1257C07.004BC866@...1846...>
	<20131017141929.GC161@...1296...>
	<OF103608A1.B8847B78-ONC1257C0B.002E1D46-C1257C0B.002F1965@...1846...>
	<20131022114017.GD161@...1296...>
	<20131022121336.GE161@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N709L9vpgywc1qLv"
Content-Disposition: inline
In-Reply-To: <20131022121336.GE161@...1296...>
Subject: Re: [Openvpn-devel] Openvpn 2.3.2 potential memory-leak after
	24hours (addendum3)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: arno.odermatt@...1845...
Cc: openvpn-devel@lists.sourceforge.net

--N709L9vpgywc1qLv
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Oct 22, 2013 at 02:13:36PM +0200, Gert Doering wrote:
> On Tue, Oct 22, 2013 at 01:40:18PM +0200, Gert Doering wrote:

(I seem to be talking to myself a lot, lately...)

> > I could use some ideas on how to debug this further - if valgrind isn't
> > complaining, normally our memory management should be OK, but why is
> > VSZ/RSZ still growing, then...?
>=20
> Arne brought up a good point.  If we "lose" the memory inside the gc_*
> functions (as in: use the same gc block for a very long time, like
> "while OpenVPN runs", but *do* free it at the end), valgrind might not
> be able to see it - after all, we nicely cleaned up later - but we'll=20
> still grow out of bounds at runtime.

... and *that* seems to be the issue here.  I've instrumented the gc_arena
to have a creation time (time_t) and a use_count, and the only one that=20
shows up at renegotiation time is the gc inside the "environment set",
with this call chain...  (included for those that are curious :-) ).

#3  0x080714e8 in add_env_item (str=3D0x811287c "untrusted_ip6=3D::ffff:127=
.0.0.1", do_alloc=3Dtrue, list=3D0x80fc500,=20
    gc=3D0x810a65c) at ../../../openvpn-testing/src/openvpn/misc.c:553
#4  0x0807156a in env_set_add_nolock (es=3D0x80fc4fc, str=3D0x811287c "untr=
usted_ip6=3D::ffff:127.0.0.1")
    at ../../../openvpn-testing/src/openvpn/misc.c:568
#5  0x080716b2 in env_set_add (es=3D0x80fc4fc, str=3D0x811287c "untrusted_i=
p6=3D::ffff:127.0.0.1")
    at ../../../openvpn-testing/src/openvpn/misc.c:613
#6  0x08071b96 in setenv_str_ex (es=3D0x80fc4fc, name=3D0xbfffd430 "untrust=
ed_ip6",=20
    value=3D0xbfffd3b0 "::ffff:127.0.0.1", name_include=3D32772, name_exclu=
de=3D0, name_replace=3D0 '\000',=20
    value_include=3D128, value_exclude=3D0, value_replace=3D0 '\000') at ..=
/../../openvpn-testing/src/openvpn/misc.c:784
#7  0x080719d6 in setenv_str (es=3D0x80fc4fc, name=3D0xbfffd430 "untrusted_=
ip6", value=3D0xbfffd3b0 "::ffff:127.0.0.1")
    at ../../../openvpn-testing/src/openvpn/misc.c:735
#8  0x080b1a7a in setenv_sockaddr (es=3D0x80fc4fc, name_prefix=3D0x80e2139 =
"untrusted", addr=3D0x810b20c, flags=3D1)
    at ../../../openvpn-testing/src/openvpn/socket.c:2396
#9  0x080b1b7e in setenv_link_socket_actual (es=3D0x80fc4fc, name_prefix=3D=
0x80e2139 "untrusted", act=3D0x810b20c,=20
    flags=3D1) at ../../../openvpn-testing/src/openvpn/socket.c:2426
#10 0x080bde24 in setenv_untrusted (session=3D0x810b19c) at ../../../openvp=
n-testing/src/openvpn/ssl_verify.c:74
#11 0x080bf07a in verify_cert (session=3D0x810b19c, cert=3D0x812fa50, cert_=
depth=3D0)
    at ../../../openvpn-testing/src/openvpn/ssl_verify.c:667
#12 0x080c050e in verify_callback (preverify_ok=3D1, ctx=3D0xbfffd748)
    at ../../../openvpn-testing/src/openvpn/ssl_verify_openssl.c:84


Preliminary analysis: the problematic code seems to be=20

env_set_add_nolock (struct env_set *es, const char *str)
{
  remove_env_item (str, es->gc =3D=3D NULL, &es->list);
  add_env_item ((char *)str, true, &es->list, es->gc);
}

... because add_env_item() will (have to) do...

add_env_item (char *str, const bool do_alloc, struct env_item **list, struc=
t gc_arena *gc)
{
...
  ALLOC_OBJ_GC (item, struct env_item, gc);
  item->string =3D do_alloc ? string_alloc (str, gc): str;
  item->next =3D *list;
  *list =3D item;
...
}


so while the environment list itself is not growing out of bounds, the
gc_arena used for storing the local copy of the string is (because these
are only ever cleaned up if gc_free() is destroying the whole arena,=20
which for *this* one is only happening at program end).

OTOH, the whole thing looks like it would work perfectly if es->gc
were just NULL (string_alloc() would then call malloc() instead, and
remove_env_item() would call free()).  So maybe this can be solved fairly
easily without rewriting all of this...

(Doing this in a train which will arrive soon -> digging deeper on my
way back)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--N709L9vpgywc1qLv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUmepfakuBuNlUUl1AQKUNwQAjWeW/IVj/ia1rq1t63kpaT5uL9XFRBj6
lybZCTvsrAIdpoe5kAPzqdayQvcgs+YHFSf73YBCVwtF2Urp1HzIj2E81kgtaIc1
XMfaWpKFHEVUZab27oYxabK2ON606UQ7MaJ++C4KeW/PRWsnCYQsIW45IkXbB0Ma
Nnuv5GxV7oQ=
=PiFu
-----END PGP SIGNATURE-----

--N709L9vpgywc1qLv--

