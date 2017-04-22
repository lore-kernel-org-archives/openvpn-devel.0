References: <20170413172609.29093-1-davids@...515...>
	<20170421220728.31867-1-davids@...515...>
	<258342e4-0ba9-cae0-0e23-88a4aab0eacc@...1856...>
	<20170422112928.GA30424@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <cf8eba0b-95ee-23b5-575c-43418a9a0fd6@...2080...>
Date: Sat, 22 Apr 2017 17:27:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170422112928.GA30424@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oJwHoMNepK4MTuDV621qmDqq5FSODtBDh"
Subject: Re: [Openvpn-devel] [PATCH v4] Fix broken ./configure on systems
 without openssl.pc
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oJwHoMNepK4MTuDV621qmDqq5FSODtBDh
Content-Type: multipart/mixed; boundary="B7godcMKL9BiMwHcwocp1ddfX6ufEe6hp";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <cf8eba0b-95ee-23b5-575c-43418a9a0fd6@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v4] Fix broken ./configure on systems
	without openssl.pc
References: <20170413172609.29093-1-davids@...515...>
	<20170421220728.31867-1-davids@...515...>
	<258342e4-0ba9-cae0-0e23-88a4aab0eacc@...1856...>
	<20170422112928.GA30424@...1296...>
In-Reply-To: <20170422112928.GA30424@...1296...>

--B7godcMKL9BiMwHcwocp1ddfX6ufEe6hp
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 22/04/17 13:29, Gert Doering wrote:
> Hi,
>=20
> On Sat, Apr 22, 2017 at 08:28:33AM +0200, Steffan Karger wrote:
>>> v4 - Move the CFLAGS/LDFLAGS declarations before the manual
>>>      version test; otherwise we're still testing the system install
>>>      version
> [..]
>> This looks good now, ACK.
>=20
> I'm not exactly sure what happened here in v4 - but now it's broken for
> "just run configure, with no extra WITH_OPENSSL_* arguments" (on a system=
=20
> without pkgconfig).  So, NAK, as annoying as you'll surely find me :-/
>=20
> It does the version check just fine...
>=20
> configure:16566: checking additionally if OpenSSL is available and versio=
n >=3D 1.
> 0.1
> configure:16587: cc -c -g -O2 -std=3Dc99   conftest.c >&5
> configure:16587: $? =3D 0
> configure:16588: result: ok
>=20
> ... and then it tests for SSL_CTX_new, omitting the -lssl/-lcrypto bits:
>=20
> configure:16601: checking for SSL_CTX_new
> configure:16601: cc -o conftest -g -O2 -std=3Dc99    conftest.c   >&5
> /var/tmp/conftest-e1c536.o: In function `main':
> /home/gert/src/openvpn-maint/test-build-master-fbsd/conftest.c:193: undef=
ined re
> ference to `SSL_CTX_new'
> cc: error: linker command failed with exit code 1 (use -v to see invocati=
on)
>=20
>=20
> ... failing.
>=20
> This is on FreeBSD 10.3, with the system libs, having pkg-config installe=
d,=20
> but no openssl.pc:
>=20
> configure:16509: $PKG_CONFIG --exists --print-errors "libcrypto >=3D 1.0.=
1, libssl
>  >=3D 1.0.1"
> Package libcrypto was not found in the pkg-config search path.
> Perhaps you should add the directory containing `libcrypto.pc'
> to the PKG_CONFIG_PATH environment variable
> Package 'libcrypto', required by 'virtual:world', not found
> Package 'libssl', required by 'virtual:world', not found
>=20
> (not sure if this is related, but maybe the configure code path for
> "pkg-config exists" is different from "no pkg-config found")
>=20
>=20
> On Linux, with pkg-config + openssl.pc, it works fine:
>=20
> configure:16601: checking for SSL_CTX_new
> configure:16601: gcc -o conftest -g -O2 -std=3Dc99    conftest.c  -lcrypt=
o -lssl
>> &5
> configure:16601: $? =3D 0
> configure:16601: result: yes
>=20
> (-lcrypto -lssl present, though I wonder why it's putting -lcrypto=20
> first - dependency order should have -lssl first)

I will dig further into this an submit a v5.  Gee, this autotools stuff
can be fragile.  Each time I fight with autotools, I think of migrating
to CMake.  But each time I struggle with CMake, I think of migrating to
autotools.  I so wonder if there are some sane alternatives - somewhat,
I doubt so :/


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--B7godcMKL9BiMwHcwocp1ddfX6ufEe6hp--

--oJwHoMNepK4MTuDV621qmDqq5FSODtBDh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY+3ZsAAoJEIbPlEyWcf3yzgsQALdsHbYoLMimgGiC6/umuaPU
ioHRtQTKNjPlm7o6xJOg8VKVQ7In+JfGQ1QqU2h+V2ktdSqWFvERGQo23RGsOOX7
Qj4CbqqkUl6v3VUmTKZOcBSBexEMHcjef0HVoI0ADPh8A6wriIAV33HV6WJigR6r
N+W1Uo9/oUm7z8MJBTYlKL630V8oPSwWjxZcapa8z9Z4fWacack6SbL1eSQt4MwW
rWRtemO9j9iCXohF1LErtxSwijHLPgSI1zoTDsOVll+3g+RzltLN2dJDvstpveLi
zFQNgJRIRVB4tcUIb01Ia4I7uEi3hpkfZyU8JSXj5UQKl2OVbCguPwvopakhyZbo
eH8MAGBXhqVLxJj+xl5xz+8z1e/5KUGJnB9QUaRc3DXdoRIiDxcck6NcXHZby1NN
J++Gi20PbpNgcx/bhkhIqJe24aGC4DYvQkKkC61elyUvt9xfCFo4Y4CjMWMWrTKK
RS6E1Qj2Ye0Lp1Oril7Exu9QJdwM5hbE88lGP3DQiPqZavK7KKZbSi2s7o1sBQZZ
ViOwdpKghBIiq25U8AouC13+16TR6AiT4vanezysLvP+qoRyvNEnT+HZNkkN4DRl
DAKycYL7d5maAU+nDBg/zeWBGPoHucNwyt16sZQNMU7CIwjAalS5nMDIAg6G7Rvo
0qStewAIfafhPjfAUZMU
=wsCv
-----END PGP SIGNATURE-----

--oJwHoMNepK4MTuDV621qmDqq5FSODtBDh--

