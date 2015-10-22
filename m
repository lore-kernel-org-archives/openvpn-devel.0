Date: Thu, 22 Oct 2015 15:51:58 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20151022135158.GG22054@...1296...>
References: <1445519360-24866-1-git-send-email-lstipakov@...277...>
	<20151022132635.GF22054@...1296...>
	<1445521155.4113.71.camel@...1866...>
	<CA+UdHn9f9reNrCCdtw8+Ei2KZ9_2beDPCL9Vb-JGs2jJ5nnrXw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9PZmzDPoqxMzCf9o"
Content-Disposition: inline
In-Reply-To: <CA+UdHn9f9reNrCCdtw8+Ei2KZ9_2beDPCL9Vb-JGs2jJ5nnrXw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Use adapter index instead of name
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Olli =?iso-8859-1?Q?M=E4nnist=F6?= <olmannisto@...277...>
Cc: openvpn-devel@lists.sourceforge.net, David Woodhouse <dwmw2@...1866...>

--9PZmzDPoqxMzCf9o
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Oct 22, 2015 at 04:47:56PM +0300, Olli M=E4nnist=F6 wrote:
> Many VPN providers like us experience these issues and have to give users
> workarounds to fix it. Here are couple of examples:
> https://community.f-secure.com/t5/F-Secure/After-a-Windows-10-upgrade/ta-=
p/72732
> https://forum.hidemyass.com/index.php/topic/18331-connection-problem/
> https://vpn.ccrypto.org/page/install-windows
>=20
> There is also workaround on Microsoft Technet forum
> (
> https://social.technet.microsoft.com/Forums/windowsserver/en-US/bb73aa66-=
34c3-49c2-8a2d-def03ee03902/element-not-found-error-when-trying-to-define-s=
tatic-ipv6-route?forum=3Dipv6)
> to use index instead of adapter name. If it's reliable that we always get
> the index figured out it doesn't need to have fallback to use adapter nam=
e.
> In our testing it seems to work well with index and fix the described iss=
ue.

So what is the underlying issue here?  Non-ASCII characters in the device
name ("this *should* have been fixed a few releases ago")?

Note that the technet forum talks about ipv6 *route*, not "set address", and
this is not part of your patch...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--9PZmzDPoqxMzCf9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVijp/akuBuNlUUl1AQKDswP7BojsjWimezLRCOM27Jj5FuEQ5QAZ8Pap
JuTdN51JVrUNy2Cor86WnjmsH5fDJ+MvsMKNVHVcqIn5XCfECYLcHhoLxSW4Ij1f
nMvTrBbbSGebQWTwOeBp1JXS+SP78J9I2UEtdU1MhP67UE3OwnWz7+ikS5RF8BXz
lC8BwqxSKPY=
=wGoZ
-----END PGP SIGNATURE-----

--9PZmzDPoqxMzCf9o--

