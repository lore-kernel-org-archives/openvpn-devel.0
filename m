From: Adriaan de Jong <dejong@...1435...>
Date: Wed, 8 Dec 2010 16:15:39 +0100
Message-ID: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3C7E@...1436...>
References: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3C60@...1436...>
	<BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3C64@...1436...>
	<4CFF9CE0.7020900@...68...>
In-Reply-To: <4CFF9CE0.7020900@...68...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Patch] OpenVPN PolarSSL PKCS #11 Support
 Preview [8/8]
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
To: Matthias Andree <matthias.andree@...68...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Matthias,

As some of these patches started life quite some time ago, they're based on=
 an internal mercurial image of 2.1.4, using mercurial queues. One of the g=
oals of this project is to rebase them on the 2.2 branch. I'm holding off u=
ntil I get the go ahead on the stability of the tree though :).

Adriaan

> -----Original Message-----
> From: Matthias Andree [mailto:matthias.andree@...68...]
> Sent: woensdag 8 december 2010 15:58
> To: openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] [Patch] OpenVPN PolarSSL PKCS #11 Support
> Preview [8/8]
>=20
> Am 08.12.2010 15:33, schrieb Adriaan de Jong:
> > Manually adding patches is such a joy. =BC failure rate.
>=20
> Hi Adriaan,
>=20
> you can use git format-patch and git send-email. Be sure to state the
> base
> revision you've diffed against, just in case git am fails due to
> intermediate
> patches.
>=20
> HTH - feel free to ask details if you can't get to terms with the Git
> tutorials
> or my comments.
>=20
> Best regards
>=20
> --
> Matthias Andree
>=20
> -----------------------------------------------------------------------
> -------
> What happens now with your Lotus Notes apps - do you make another
> costly
> upgrade, or settle for being marooned without product support? Time to
> move
> off Lotus Notes and onto the cloud with Force.com, apps are easier to
> build,
> use, and manage than apps on traditional platforms. Sign up for the
> Lotus
> Notes Migration Kit to learn more. http://p.sf.net/sfu/salesforce-d2d
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

