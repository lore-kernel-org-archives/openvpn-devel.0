Date: Tue, 12 Mar 2013 22:14:32 +0200
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@...124...>
Message-ID: <20130312201432.GM8912@...1281...>
References: <20110713163816.GT32373@...1281...> <4E1DF85D.4010705@...515...>
	<1CED409804E2164C8104F9E623B08B90126C7D2F75@...1436...>
MIME-Version: 1.0
In-Reply-To: <1CED409804E2164C8104F9E623B08B90126C7D2F75@...1436...>
Subject: Re: [Openvpn-devel] openvpn support for challenge-response	otp
 (user+pass+otp)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Adriaan de Jong <dejong@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Thu, Jul 14, 2011 at 08:18:56AM +0200, Adriaan de Jong wrote:
> > -----Original Message-----
> > From: Samuli Sepp=E4nen [mailto:samuli@...515...]
> >=20
> > There's some support for challenge-response authentication in OpenVPN:
> >=20
> > <http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=3Dopenvpn/openvpn-
> > testing.git;a=3Dcommit;h=3D3cf9dd88fd84108eccfcce0ebf44e00f9481cd82>
> >=20
> > This code is in the "master" branch. Look here for instructions on how
> > to fetch the sources:
> >=20
> > <https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation#Main
> > developmentrepositorygit>
> >=20
>=20
> Note that this code was refactored quite heavily, and now lives in its ow=
n verification module.=20
>=20
> It lives here at the moment: https://github.com/andj/openvpn-ssl-refactor=
ing/blob/master/ssl_verify.c . The verification code is called from key_met=
hod_2_write and key_method_2_read, in ssl.c (https://github.com/andj/openvp=
n-ssl-refactoring/blob/master/ssl.c).=20
>=20

Hello!

What's the current status of OpenVPN challenge/response support?=20

I got busy with other projects and didn't test/investigate this yet,
but I'll probably get to it in the near future..

Thanks!

-- Pasi


