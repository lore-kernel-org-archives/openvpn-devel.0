References: <10719981480674741@...2206...>
	<8e0f7ca4-a790-2143-ccfa-8e6ab6114955@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <f2823a74-9494-b4a8-cf2e-a1ccab56b609@...2080...>
Date: Fri, 2 Dec 2016 14:26:28 +0100
MIME-Version: 1.0
In-Reply-To: <8e0f7ca4-a790-2143-ccfa-8e6ab6114955@...277...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Q9EEf1cU5O3gwbxjCrvdtFCAaraKQgfie"
Subject: Re: [Openvpn-devel] Enable FIPS encryption
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q9EEf1cU5O3gwbxjCrvdtFCAaraKQgfie
Content-Type: multipart/mixed; boundary="l7rAPCrO7me1AQlVEp1BCihEFE7W2Re53";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <f2823a74-9494-b4a8-cf2e-a1ccab56b609@...2080...>
Subject: Re: [Openvpn-devel] Enable FIPS encryption
References: <10719981480674741@...2206...>
	<8e0f7ca4-a790-2143-ccfa-8e6ab6114955@...277...>
In-Reply-To: <8e0f7ca4-a790-2143-ccfa-8e6ab6114955@...277...>

--l7rAPCrO7me1AQlVEp1BCihEFE7W2Re53
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 02/12/16 13:55, debbie10t wrote:
> Hi,
>=20
> On 02/12/16 10:32, boxartst@...1411... wrote:
>> Hi!
>>
>> I would like to know if it's possible to enable fips  enabled encryption=
 on my vpn server?
>> Here is a link to fips user guide https://www.openssl.org/docs/fips/User=
Guide-2.0.pdf .
>> It looks like I'd have to change source code and compile it myself to ma=
ke it FIPS compliant.
>> Any help or advice would be very much appreciated.
>>
>=20
> Without very much effort it is possible to build openvpn with openssl
> FIPS support on CentOS7:
>=20
> OpenVPN 2.4_beta2 [git:master/1c587a1112220618+]=20
> x86_64-unknown-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL]=20
> [MH/PKTINFO] [AEAD] built on Dec  1 2016
> library versions: OpenSSL 1.0.1e-fips 11 Feb 2013, LZO 2.06
>=20
> OpenSSL 1.0.1e-fips appears to be the default openssl developer library
> in CentOS7.
>=20
> I do not know enough about FIPS certification to advise if *only* this
> change is sufficient to cover you for real world certification.

This is partially right.  But the system is at this point not in FIPS
mode, so the hardening FIPS provides is still not active.  You need to
reboot the system into FIPS mode, which then disables several algorithms
in OpenSSL which OpenVPN depends on - which makes OpenVPN fail.

For more info:
<https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/h=
tml/Security_Guide/chap-Federal_Standards_and_Regulations.html#sect-Federal=
_Information_Processing_Standard>


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--l7rAPCrO7me1AQlVEp1BCihEFE7W2Re53--

--Q9EEf1cU5O3gwbxjCrvdtFCAaraKQgfie
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYQXaEAAoJEIbPlEyWcf3ykF4P/3xH+VlwdAtn+7fn0Feu/6pl
w0ihOjEYCQwEgZ1tMufytTIf+LDsc5g95vqVJAzYEiTwtBQf8hOcl4PohGTcTJXN
CpWef5le0xMjgvTPbzlc4FbiYSdjiJLeSioKsUyZDI8nPU1+8q825BbOOIQLQ3VQ
/ABUxTi7ljJWNGBTv6QWL+UXwiis9XRpv0N34o4U8JhTWtXCpfjLNV17TvzpH720
3K+OKmLCeEwU/b0r2z0FdhZACed68pFEO80UqImxfKQYNij96EmuEJ9TEh8HB1yu
VT16B9I5I/2zlQ3GXT93deNOEkwdf10Gq3tBDvmHNwsiKAd1xcb5CUna9Uhm45UV
Q07lrYAVSv0lyuJpENiMZiAbCE/d4PE14bx/J+jxqwe/ClVyY0xKSwH993jBDAl8
DgjeckS/508VWg6ljhbwXFwAvocrBY3xxMcLutUSfSmOBN85iBhg9GvNQmO4Tt/8
hZ6uyfebv1v/H+TxRCH0nu9T8onQsXdUdbUkaGrY5Fv/zFMtytQNDRzd+IlWZCOX
kDulciTP2XFJb0L7H8TWUtH3bKbLa3c6AwoPCakiFUXUrNLRGdc8wNqNEEqk+G3d
m9YAPKM5/63yCtbtIy0FnfEZNu9sYMEwxV8ad/jFyBlRHO2/lhdrTnWu3UqKnQRG
7/JA8VvsijLWqPY4JfMU
=aZ2m
-----END PGP SIGNATURE-----

--Q9EEf1cU5O3gwbxjCrvdtFCAaraKQgfie--

