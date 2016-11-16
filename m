Date: Wed, 16 Nov 2016 19:28:54 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161116182854.GJ28918@...1296...>
References: <1479163508-19435-1-git-send-email-davids@...515...>
	<c4d87247-460c-0860-5748-a62f0304653a@...1435...>
	<3ec6b9c8-7dcd-038c-6bbf-4b136a2e4507@...2080...>
	<ea910160-9005-8ca6-1af5-8594113944e2@...1435...>
	<CAKuzo_iw72bdL3hdfDkPeo6bMjA3-3z+oR0Bh40PjJQgWyTr_A@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0gFnDpSB5uMBYCoe"
Content-Disposition: inline
In-Reply-To: <CAKuzo_iw72bdL3hdfDkPeo6bMjA3-3z+oR0Bh40PjJQgWyTr_A@...278...>
Subject: Re: [Openvpn-devel] [PATCH] file checks: Merge
 warn_if_group_others_accessible() into check_file_access()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--0gFnDpSB5uMBYCoe
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 16, 2016 at 12:27:05PM -0500, Selva Nair wrote:
> On Wed, Nov 16, 2016 at 11:07 AM, Steffan Karger <steffan.karger@...2191...=
..>
> wrote:
>=20
> > > I do not have any Windows test environments, so I'll admit that's a
> > > bold (and risky) move of me.  However, as you've identified,
> > > S_IRWXG|S_IRWXO is not set so shouldn't cause any issues.
> >
> > Combined with a compile-test I just this and the fact that the worst
> > thing that could happen is an incorrect warning (Windows builds never
> > warned before), I feel confident enough to ACK this:
> >
> > ACK.
>=20
> But the question is will this compile for windows? I doubt it will unless
> we add some dummy defines for S_IRWXG etc..

As Selva was afraid, it breaks windows compilation.


i686-w64-mingw32-gcc -DHAVE_CONFIG_H -I. -I../.. -I../../include  -I../../i=
nclude -I../../src/compat -DWIN32_LEAN_AND_MEAN -DNTDDI_VERSION=3DNTDDI_VIS=
TA -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA -I/home/samuli/buildtest/openvpn-bui=
ld/windows-nsis/tmp/image-i686/openvpn/include -I/home/samuli/buildtest/ope=
nvpn-build/windows-nsis/tmp/image-i686/openvpn/include -I/home/samuli/build=
test/openvpn-build/windows-nsis/tmp/image-i686/openvpn/include  -I/home/sam=
uli/buildtest/openvpn-build/windows-nsis/tmp/image-i686/openvpn/include -mu=
nicode -UUNICODE -std=3Dc99 -MT options.o -MD -MP -MF .deps/options.Tpo -c =
-o options.o options.c
options.c: In function 'check_file_access':
options.c:2743:22: error: 'S_IRWXG' undeclared (first use in this function)
    if (st.st_mode & (S_IRWXG|S_IRWXO))
                      ^
options.c:2743:22: note: each undeclared identifier is reported only once f=
or each function it appears in
options.c:2743:30: error: 'S_IRWXO' undeclared (first use in this function)
    if (st.st_mode & (S_IRWXG|S_IRWXO))
                              ^

"I do not have a windows test environment, so I'll boldly and risky=20
commit something which is not a must-have for 2.4_beta1 but just a=20
code shuffling-around, and which breaks platforms" is not a very good=20
strategy.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--0gFnDpSB5uMBYCoe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWCylZqkuBuNlUUl1AQIJAwP+M0I3GNh2BD1D5ejZmf+nZAsp8CWjsXp2
U6NcmjjUZHoNeT9XoN+yjRWGj5taUn4gfoc7L86Y/SxHpxQjv8LS1GIxleAqt1M2
sdvjfuK61bvYgQaStqXTlT/CfOecoIAERwHs5pZI57RjQY5N23512nAlYmH/HRkW
vaN7dpGdK6g=
=JjCT
-----END PGP SIGNATURE-----

--0gFnDpSB5uMBYCoe--

