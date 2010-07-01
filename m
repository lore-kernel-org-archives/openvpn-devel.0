MIME-version: 1.0
Date: Thu, 01 Jul 2010 16:59:51 +0200
From: Till Maas <opensource@...519...>
Message-id: <20100701145951.GI4340@...1276...>
References: <4C2B07C1.9050500@...515...>
Content-type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary=Re2uCLPLNzqOLVJA
Content-disposition: inline
In-reply-to: <4C2B07C1.9050500@...515...>
Subject: Re: [Openvpn-devel] Packaging OpenVPN for various platforms?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: openvpn-owner@...1385...

--Re2uCLPLNzqOLVJA
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, Jun 30, 2010 at 12:00:49PM +0300, Samuli Sepp=E4nen wrote:

> - write packaging instructions to our Trac wiki
> (https://community.openvpn.net/openvpn/wiki)
> - convert the instructions into BuildBot code (BuildSteps)
>=20
> After this is done, we can provide the latest version of OpenVPN for
> various platforms with minimal manual effort. This helps developers as
> well as users: having the development code in wider circulation helps
> spot problems faster resulting in faster release cycle.

I am a Fedora package maintainer, but not one of OpenVPN. I CC'ed them
in case they did not notice this.

The Fedora package scripts are currently available here:
http://cvs.fedoraproject.org/viewvc/rpms/openvpn/devel/

In the not so far future this URL will not be valid, because Fedora
switches to git.

Packages for Fedora are usually build within a chroot using a helper
tool called mock[0] and I do not know how well it works on other
distributions except Fedora or RHEL/CentOS. There are also scripts
developed to easily build new rpms from SCM and afaik currently only git
is supported (I do not know what OpenVPN currently uses, but I suspect
it's SVN):
https://fedorahosted.org/fedora-packager/ticket/8

Adding support for SVN or other SCMs should not be that hard. I will try
to write something up how to put all this together to easily build new
OpenVPN Packages for Fedora using a SCM checkout.

Regards
Till

[0] http://fedoraproject.org/wiki/Projects/Mock

--Re2uCLPLNzqOLVJA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBCgAGBQJMLK1cAAoJEGo6ELMcEJUXcOAP/203ThRgmhr9W5kL3p/FP7j4
OruMXJumM6BI1IyMhgfwgNswt77PlZS7BJliZjSQcIqvFa6u6OHxiDWwtCnifvxu
CHCHhBDd1tivnuJY8S/29NObzX+9VpGb5OWLDbE1IR+aC9d5ZLfIBRn+ImvkrIZH
pudsULEBKgMdI8QeGzjgnPrJyUMu9xUaffLD36XRWaiuUQB7oZSuK4/nmSOqJLBh
ig9xLzflg4WzN+IJI90o30HtoPziG65NIQEbBscqsI8vXkoiQ+hLiDHlAnRhwQGf
EezHUrvS2S1yXau8QQqqDRG+8svOuaTLUki5U4K4SVLh73INDxl1DwfYpUmaOJze
3zmbl6pf7rmPeKC0natdR6SI86UDqKd7qOdrwgMiKSahwK35I1S5RRIKEyY52Ujr
oi6gbBLp/5PM1+LpjhiJXoicrmeNlbYnUZ69ucFmvx/u9+dALMiwHi3d/S1kDD3i
lLRL0V6onHaBmqKGb0Wagw7tyAORTaSm/svKTRAyF22fbbNfhN26teFK8CP3Cgcg
OfCL6+iDDS10JlMb8r0vDZBANXCyxj4r8J56hLYnfauUPxgAVcN+7Qj/jPNU0QcD
76kgKOT0vDLqesbx6WBZ7JQnP1cghtrO3MD6ra7S364pU68s2pEFnQ1hYYPtIwj0
zf42PVD1PZJqNTh6t1uZ
=Dg+W
-----END PGP SIGNATURE-----

--Re2uCLPLNzqOLVJA--


