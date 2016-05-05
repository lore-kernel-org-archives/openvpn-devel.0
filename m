Date: Thu, 5 May 2016 13:50:50 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160505115050.GA81579@...1296...>
References: <1462126986-2686-1-git-send-email-steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <1462126986-2686-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] configure.ac: link to all mbed TLS libs
 during library detection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, May 01, 2016 at 08:23:06PM +0200, Steffan Karger wrote:
> When for some reason the dependencies of the compiled mbed TLS libaries
> (libmbedtls, libmbedcrypto and libmbedx509) are not correct, the configure
> script will fail to link against libmbedcrypto and/or libmbedx509.  This
> is reported to happen after using 'make install' to install mbedtls.
>=20
> This patch makes sure the configure tests link to all three.  The build
> process itself already did.

It originally looked good on my test systems, but I found more caveats -=20
when you have static libraries, dependency resolving only happens=20
left-to-right, and libmbedx509.a wants stuff from libmbedcrypto.a - so
we end up with

configure:28582: gcc -o conftest -g -O2   conftest.c -lmbedtls
                 -lresolv  -lmbedtls -lmbedcrypto -lmbedx509 >&5
Undefined                       first referenced
 symbol                             in file
mbedtls_pk_load_file                /usr/lib/libmbedx509.a(x509_crt.o)
mbedtls_pk_parse_subpubkey          /usr/lib/libmbedx509.a(x509_crt.o)
ld: fatal: symbol referencing errors. No output written to conftest

... unless we change the ordering.  Patch below.

(Linking the final openvpn seems to work no matter what library order,
because some .o "further to the left" already uses these functions, so
when the linker looks at libmedx509.a unresolved symbols, it already
knows where to find them.  Still changing both places to be consistent)

gert

--sdtB3X0nJg68CQEu--
