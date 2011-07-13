Date: Wed, 13 Jul 2011 23:22:23 +0300
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@...124...>
Message-ID: <20110713202223.GV32373@...1281...>
References: <20110713163816.GT32373@...1281...> <4E1DF85D.4010705@...515...>
MIME-Version: 1.0
In-Reply-To: <4E1DF85D.4010705@...515...>
Subject: Re: [Openvpn-devel] openvpn support for challenge-response
	otp	(user+pass+otp)
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
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Wed, Jul 13, 2011 at 12:56:13PM -0700, Samuli Sepp=E4nen wrote:
> Hi Pasi,
>=20
> There's some support for challenge-response authentication in OpenVPN:
>=20
> <http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=3Dopenvpn/openvpn-te=
sting.git;a=3Dcommit;h=3D3cf9dd88fd84108eccfcce0ebf44e00f9481cd82>
>=20

Cool! Based on the commit summary it says in "client mode".. so the server =
parts are still missing?=20

I'd probably want to use it with openvpn-auth-pam plugin, with pam-radius-p=
lugin set to do challenge-response authentication.
I'll take a look at the sources soon..

-- Pasi

> This code is in the "master" branch. Look here for instructions on how
> to fetch the sources:
>=20
> <https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation#Mainde=
velopmentrepositorygit>
>=20
> Hope this helps,
>=20
> Samuli
>=20
> > Hello,
> >
> > Has anyone implemented challenge-response support to openvpn and openvp=
n gui?
> >
> > I'd like to be able to authenticate openvpn users so that all these are=
 required:
> > 	1) x509 certificate
> > 	2) username + password
> > 	3) one time password (otp)
> >
> > So after the user gets user+pass prompt, and the password is verified t=
o be correct,=20
> > the user will get another prompt asking for a one time password.
> >
> > OTP can be delivered as sms to the user, or it could be rsa securid val=
ue from the token, or something else..
> >
> > Openvpn gui would need to be able to present additional prompt after th=
e usual user+pass prompt..
> > For example openssh supports challenge-response, so user+pass+otp is po=
ssible with it.
> >
> > Thoughts/plans?
> >
> > -- Pasi
> >
> >
> > -----------------------------------------------------------------------=
-------
> > AppSumo Presents a FREE Video for the SourceForge Community by Eric=20
> > Ries, the creator of the Lean Startup Methodology on "Lean Startup=20
> > Secrets Revealed." This video shows you how to validate your ideas,=20
> > optimize your ideas and identify your business strategy.
> > http://p.sf.net/sfu/appsumosfdev2dev
> > _______________________________________________
> > Openvpn-devel mailing list
> > Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

