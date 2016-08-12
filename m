References: <4489a66e-428f-493d-6dc9-1dde62c2c731@...2080...>
	<CAKuzo_jhiRWMucS+Xm6jnJDY6U6Kfk2AKxDqzrsc_mH1d=YLdg@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <1e5adffb-e485-0d1c-3e3e-4c4df9d2e55b@...2080...>
Date: Fri, 12 Aug 2016 11:57:41 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jhiRWMucS+Xm6jnJDY6U6Kfk2AKxDqzrsc_mH1d=YLdg@...278...>
Subject: Re: [Openvpn-devel] autoconf/automake warnings
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/08/16 22:44, Selva Nair wrote:
> Hi,
>=20
> You are right, it was me who introduced reference to sources in
> subdir to avoid duplication when block-dns support was added to the
> interactive service.
>=20
> On Thu, Aug 11, 2016 at 2:50 PM, David Sommerseth=20
> <openvpn@...2080...=20
> <mailto:openvpn@...2080...>> wrote:
>=20
> Hi,
>=20
> I noticed a few errors today when building OpenVPN on Fedora 23.
> The attached patch resolves this.  But it breaks 'make' when it
> reaches ./src/openvpnserv:
>=20
> Makefile:505: ../../src/openvpn/.deps/openvpnserv-block_dns.Po: No=20
> such file or directory
>=20
>=20
> Looks like a bug that was reported in automake 1.15 and fixed
> later. Does this happen on later version of automake as well?

My current tests was on an updated Fedora 23.  I can grab a an updated
F24 image and try building there.

> Except of that, the patch removes the warnings on Fedora 23 [1]
> and causes no other issues on Scientific Linux 7.2 [2] or CentOS
> 5.11 [3].
>=20
>=20
> And some comments to the patch.
>=20
> * The subdir-objects option was needed to avoid a warning with=20
> automake-1.15.
>=20
>=20
> * AM_PROG_CC_C_O is needed with automake-1.9.6 when the
> subdir-objects option is enabled.
>=20
>=20
> I thought AM_PROG_CC_C_O was deprecated a long time ago. When did
> it make a come back?

I dunno if it's deprecated, but I remember reading yesterday it
shouldn't be needed since 1.13 (IIRC).  But as we need to ensure
OpenVPN can be fully built on RHEL5 (which is the oldest supported
distribution we officially support).   And RHEL5 ships with automake-1.9
.

A related discussion we of course can make is if we will change our
build support policy slightly.  Currently we support building from git
on RHEL5 (hence autoreconf is needed to be run).  But we could change
our policy to only support building on RHEL5 using tarballs (greated
by 'make dist' and related variants).  In this case, autotools doesn't
even need to be installed (with the exception of libtool, iirc) ...
but that's a discussion outside this mail-thread, though.


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAletnZUACgkQDC186MBRfrqt3wCfT+fo+9haooMUHZ2MUxlekWeY
ex8AnRcCNQey/fEbTakJSbrgUqzeULP2
=3DbN9r
-----END PGP SIGNATURE-----

