From: Adriaan de Jong <dejong@...1435...>
Date: Thu, 21 Mar 2013 08:16:14 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B9013B9050044@...1436...>
References: <1363624652-7001-1-git-send-email-steffan.karger@...1435...>
	<1363624652-7001-2-git-send-email-steffan.karger@...1435...>
	<20130319142655.GX953@...1296...>
	<1CED409804E2164C8104F9E623B08B9013B904FFD9@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B9013B904FFD9@...1436...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 1/5] PolarSSL-1.2 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Steffan Karger <steffan.karger@...1435...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Ack, I think this solves the PolarSSL with/without PKCS11-helper problem.

> -----Original Message-----
> From: Steffan Karger [mailto:steffan.karger@...1435...]
> Sent: woensdag 20 maart 2013 19:53
> To: Gert Doering
> Cc: openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] [PATCH 1/5] PolarSSL-1.2 support
>=20
> Hi,
>=20
> Attached a patch for the second point you make. It was a pre-existing
> bug where the autoconf script was not equipped to detect incorrectly
> compiled polarssl builds, e.g. without pkcs11 support.
>=20
> I'm still working on the first (polarssl-blowfish) point, need to do
> some more testing first on that one.
>=20
> Regards,
> -Steffan
>=20
> -----Original Message-----
> From: Gert Doering [mailto:gert@...1296...]
> Sent: dinsdag 19 maart 2013 15:27
> To: Steffan Karger
> Cc: openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] [PATCH 1/5] PolarSSL-1.2 support
>=20
> Hi,
>=20
> On Mon, Mar 18, 2013 at 05:37:28PM +0100, steffan.karger@...1435...
> wrote:
> > From: Steffan Karger <steffan.karger@...1435...>
> >
> > Add support for PolarSSL-1.2, which has changed the API in several
> places.
> > This is a minimal port, new features have not been enabled. Only
> > PolarSSL
> > 1.2.5 and newer are accepted, as earlier versions contain unresolved
> > (security) issues.
>=20
> NAK, actually, for two reasons:
>=20
>  - there is "something wrong" with the blowfish support - patching
>    release/2.3 in git with these 5 patches and compiling with polar
> 1.2.5
>    creates a binary that is not interoperating with openssl-compiled
>    openvpn (cipher blowfish-cbc on the polar side, bf-cbc on openssl) -
> it
>    negotiates just fine, but data packets cannot be decrypted
>=20
> 14:23 <@dazo> Tue Mar 19 14:16:08 2013 Authenticate/Decrypt packet
> error:
>               cipher final failed
>=20
>  - when configuring with --enable-pkcs11, compilation fails
>=20
> 14:17 <@dazo> ssl_polarssl.h:69:5: error: expected specifier-qualifier-
> list
>               before \u2018pkcs11_context\u2019
>=20
> (I'm just relaying, David did the actual testing... my buildbot box is
> still busy trying to compile polar 1.2.6...)
>=20
> gert
> --
> USENET is *not* the non-clickable part of WWW!
>=20
> //www.muc.de/~gert/
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025                        gert@...1816...
> muenchen.de

