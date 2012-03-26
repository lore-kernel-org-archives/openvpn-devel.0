Date: Mon, 26 Mar 2012 13:23:00 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120326112300.GT1359@...1296...>
References: <CAOazyz1yULF1jkPRGOQriuetsdiUo5PbNVJybSURWPAKgQZMNA@...278...>
	<1332758047-30774-1-git-send-email-alon.barlev@...277...>
	<20120326110015.GS1359@...1296...>
	<CAOazyz0S4obu2XWtEFWXJiJGMJS9fk-ULdUNoXWkBriQ45vK7w@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wiP8eU6Yj5r7oh2+"
Content-Disposition: inline
In-Reply-To: <CAOazyz0S4obu2XWtEFWXJiJGMJS9fk-ULdUNoXWkBriQ45vK7w@...278...>
Subject: Re: [Openvpn-devel] [PATCH] build: assume dlfcn is available on all
	supported platforms
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: Openvpn-devel@lists.sourceforge.net

--wiP8eU6Yj5r7oh2+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 26, 2012 at 01:02:13PM +0200, Alon Bar-Lev wrote:
> > Tested on FreeBSD 7.4 -> configure works fine now, make builds, resulti=
ng
> > binary exists...
> >
> > gert@...1703...:/home/gert/alon/test$ ./src/openvpn/openvpn --version
> > OpenVPN 2.3_alpha1 amd64-unknown-freebsd7.4 [SSL (OpenSSL)] [eurephia] =
[MH] [PF_INET6] [IPv6 payload 20110522-1 (2.2.0)] built on Mar 26 2012
> >
> > (no further tests done, but this is good enough improvement to *ACK* th=
is).
>=20
> Hmmm....
> This --version is very short.... is it the full output?
> I expecting something similar to:

The complete output is similar to what you pasted, but to "just show succes=
s",
I didn't want to paste all of it.

Here's the long one:

OpenVPN 2.3_alpha1 amd64-unknown-freebsd7.4 [SSL (OpenSSL)] [eurephia] [MH]=
 [PF_INET6] [IPv6 payload 20110522-1 (2.2.0)] built on Mar 26 2012
Originally developed by James Yonan
Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
Compile time defines: enable_crypto=3Dyes enable_debug=3Dyes enable_def_aut=
h=3Dyes enable_dlopen=3Dunknown enable_dlopen_self=3Dunknown enable_dlopen_=
self_static=3Dunknown enable_eurephia=3Dyes enable_fast_install=3Dneedless =
enable_fragment=3Dyes enable_http_proxy=3Dyes enable_iproute2=3Dno enable_l=
ibtool_lock=3Dyes enable_lzo=3Dno enable_lzo_stub=3Dno enable_management=3D=
yes enable_multi=3Dyes enable_multihome=3Dyes enable_pedantic=3Dno enable_p=
f=3Dyes enable_pkcs11=3Dno enable_plugins=3Dyes enable_port_share=3Dyes ena=
ble_selinux=3Dno enable_server=3Dyes enable_shared=3Dyes enable_shared_with=
_static_runtimes=3Dno enable_small=3Dno enable_socks=3Dyes enable_ssl=3Dyes=
 enable_static=3Dyes enable_strict=3Dno enable_strict_options=3Dno enable_s=
ystemd=3Dno enable_win32_dll=3Dyes enable_x509_alt_username=3Dno with_crypt=
o_library=3Dopenssl with_gnu_ld=3Dyes with_mem_check=3Dno


thanks.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--wiP8eU6Yj5r7oh2+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT3BRk6kuBuNlUUl1AQKOcwP/bk7hTlrchbV4KsZRpgPRiMGju3uf2VnP
gXHgPtt2gYk/4H/GsTOyRGvlcM1vXsv3cWK9M8hiBE2pbWOa0kRbcbC1fjgXL/0n
CIQnWXXbO9dOCAdxkKNLUKsp9MikVFsEiNBJUpz22GTVuE2dr8g6XtWV3k7hgORh
Hu7aNTyz96k=
=WhMz
-----END PGP SIGNATURE-----

--wiP8eU6Yj5r7oh2+--

