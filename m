From: Lisa Minogue <lminogue@...1892...>
Message-ID: <22905346.946911.1405963050383.JavaMail.root@...1893...>
In-Reply-To: <53CD0B1B.6000801@...515...>
References: <11052645.930865.1405935348844.JavaMail.root@...1893...>
	<20140721120346.GL1118@...1296...>
	<53CD0B1B.6000801@...515...>
MIME-Version: 1.0
Date: Mon, 21 Jul 2014 19:17:30 +0200 (CEST)
Subject: Re: [Openvpn-devel] OpenSSL in OpenVPN software to be replaced?
Reply-To: Lisa Minogue <lminogue@...1892...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Samuli and friends:

This is what I think.

Both of us don't know how long it will take for OpenSSL to fix the long lis=
t of bugs -some of which are significant- that have accumulated over the ye=
ars. One year or two years?

OpenVPN is in the business of providing software that enables secure commun=
ications. Can OpenVPN afford to wait one or two years for bugs to be fixed?=
 How will OpenVPN address the concerns of its Access Server's customers? Do=
 Access Server software incorporate OpenSSL or PolarSSL?

Hackers and agencies sponsored by their respective governments will have a =
field day disrupting secure communications enabled by the use of defective =
VPN software. Economic espionage will wreak havoc on the markets and create=
 unfair competition for those countries which are technically and scientifi=
cally superior. Human rights abuses will be on the increase.

I accept that substantial portions of the current software code for Windows=
 will have to be rewritten. But aren't you also doing it for Access Server =
customers? Aren't they affected by OpenSSL's bugs?

Regards.

Lisa


> ----------------------------------------
> From: Samuli Sepp=C3=A4nen <samuli@...515...>
> Sent: Mon Jul 21 14:44:11 CEST 2014
> To: Gert Doering <gert@...1296...>, Lisa Minogue <lminogue@...1892...>
> Subject: Re: [Openvpn-devel] OpenSSL in OpenVPN software to be replaced?
>=20
>=20
>=20
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
>=20
>=20
> > Hi,
> >
> > On Mon, Jul 21, 2014 at 11:35:48AM +0200, Lisa Minogue wrote:
> >> In the light of the above, do you have plans to replace OpenSSL with
> PolarSSL or LibreSSL? And how soon will new bundles of OpenVPN software
> be released that incorporate OpenSSL alternatives?
> > [..]
> >> P.S.: I apologize if the above questions have been dealt with in the
> past.
> >
> > Indeed, you could have just googled for "OpenVPN PolarSSL"...
> >
> > But anyway.  Samuli: can the build environment do windows binaries using
> > PolarSSL?  Might be nice to offer both...
> >
> > gert
> >
> The build environment for Windows would have to be modified
> significantly to support PolarSSL. Although we probably can all agree
> that the state of OpenSSL leaves a lot to be desired, it's now funded by
> the Core Infratructure Initiative:
>=20
> <http://www.linuxfoundation.org/programs/core-infrastructure-initiative>
>=20
> I don't know if money (=3Dfew full-time developers) can save the can of
> worms, but probably we should not panic quite yet. Opinions?
>=20
> - --=20
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>=20
> irc freenode net: mattock
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1
> Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/
>=20
> iEYEARECAAYFAlPNCxoACgkQwp2X7RmNIqPLVwCeJlS7jpSFGL8N1UtO/fI17Ovi
> C10An3Gzt1blQd5SrCcEE47Qid0oSGin
> =3Detcu
> -----END PGP SIGNATURE-----
>=20

-----------------------------------------------------
Mail.be, WebMail and Virtual Office
http://www.mail.be

