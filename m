Content-Type: multipart/signed;
	boundary="Apple-Mail=_0A423AE2-6172-402B-985E-B7E47E7D351A";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
From: Eric Crist <ecrist@...1286...>
In-Reply-To: <CAA1AbxJCv9ff7XHv1GKtCPuB-Hc5Lv33ufPfqcTraNpFnJf7fw@...278...>
Date: Sat, 29 Mar 2014 19:24:36 -0500
Message-Id: <083C1B4C-B2E2-4205-B290-9C0BB6751C48@...1286...>
References: <1396001222-5033-1-git-send-email-arne@...1227...>
	<CAA1AbxJCv9ff7XHv1GKtCPuB-Hc5Lv33ufPfqcTraNpFnJf7fw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix man page and OSCP script:
	tls_serial_{n} is decimal
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Apple-Mail=_0A423AE2-6172-402B-985E-B7E47E7D351A
X-Eric-Conspiracy: There is no conspiracy.
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Mar 29, 2014, at 18:48:37, Steffan Karger <steffan@...1856...> wrote:

> Hi,
>=20
> On Fri, Mar 28, 2014 at 11:07 AM, Arne Schwabe <arne@...1227...> wrote:
> Commit 7d5e26cbb53 fixed extracting serial but did not change the format,
> which always has been decimal. This patch fixes the manpage and
> OSCP.sh script to conform with the implementation.
> ---
> [diff]
>=20
> NACK, because glancing over the code tells me PolarSSL builds do use hex =
strings. So this fixes the inconsistency between implementation and manpage=
 for OpenSSL builds, but adds inconsistency for PolarSSL builds.
>=20
> I see three options here:
> 1 - Leave the difference, explain in the manpage.
> 2 - Change PolarSSL builds to use dec representation
> 3 - Change OpenSSL builds to use hax representation
>=20
> I tend towards "just update the manpage". Changing PolarSSL builds to dec=
 needs changes in PolarSSL, or manually parsing the serial in OpenVPN. Chan=
ging OpenSSL builds to hex is trivial but breaks backward compatibility. An=
y other opinions?
>=20
> -Steffan=20


I agree with Steffan on this.  I think it'd be better to just explain the d=
ifference in the man page and let it be.

-----
Eric F Crist

--Apple-Mail=_0A423AE2-6172-402B-985E-B7E47E7D351A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
X-Eric-Conspiracy: There is no conspiracy.
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQEcBAEBAgAGBQJTN2REAAoJEHKWQhk5DQ0ODRYIAMMY20kOM/LpwXVL78mYalo8
xOsScMT0wi3exMwrW+KDbu3n2su8vGIcEGPE52H3rQzJ+6p/toVv9bzCbRro3eGe
qyUwn60r8j3TYYEd+EIcRl9OQk73HbxcTLCbbte7zV4uYIQcVPjVg+9sQ1mkD868
WIQm2kEO3yjE2e7OHWcFRwpROnyblQPUddOsbltQckV4MTDlJ++qFNCKVaeuCxmU
mD3b0Tnzz4OffvFyAgLkDKHByzv1qTUfr1gZ2Anw+gFELbMTnb2pYXGSgEuvA0MG
zqobR5y0qvZtV9uD1IuTWOvTPLRyxLZJJjQOsutLOW27m6j9ZwsuXsKvGEm3o2Y=
=xIVp
-----END PGP SIGNATURE-----

--Apple-Mail=_0A423AE2-6172-402B-985E-B7E47E7D351A--

