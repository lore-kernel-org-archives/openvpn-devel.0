Date: Mon, 14 Apr 2014 11:39:10 +0200
From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20140414093910.GW13903@...1894...>
References: <534B98A4.7020806@...515...>
	<20140414082858.GB16637@...1296...>
	<534BA0EE.1050103@...515...>
MIME-Version: 1.0
In-Reply-To: <534BA0EE.1050103@...515...>
Subject: Re: [Openvpn-devel] OpenVPN PolarSSL builds?
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
To: openvpn-devel@lists.sourceforge.net

On Mon, Apr 14, 2014 at 11:48:46AM +0300, Samuli Sepp=E4nen wrote:
>=20
> > Hi,
> >
> > On Mon, Apr 14, 2014 at 11:13:24AM +0300, Samuli Sepp=E4nen wrote:
> >> Currently all of the binary builds we provide[*] are linked to OpenSSL.
> >> Would having both OpenSSL and PolarSSL builds make sense (e.g. starting
> >> with 2.4)?
> > I think it would be a nice option.  We could even start with 2.3.4 with
> > that, at least for windows... (if PolarSSL can be cross-compiled for
> > windows...)
> >
> I think the "cross-compile on Windows" part is the trickiest part. That
> said, on Debian/Ubuntu we'd probably need to use some package name
> tricks like:
>=20
> "openvpn" (a metapackage)
> "openvpn_openssl", provides openvpn (=3Dopenvpn+openssl)
> "openvpn_polarssl", provides openvpn (=3Dopenvpn+polarssl)
>=20
> Agi: do you have any suggestions on how to best handle this kind of
> scenario?

The same source package could produce the three packages. Build with
openssl, clean, build with polarssl. It will require some hacks, but
should be doable and clean enough. Will look at it next week. BTW,
openvpn-openssl & openvpn-polarssl (underscores not valid in package
names :-)

> Also, if we don't wish maintain our own set of PolarSSL .deb packages
> we'd have to limit ourselves to fairly recent Debian/Ubuntu versions.

When can always try to backport current polar packages to older distro
releases. Currently:
Squeeze: 1.2.9
Wheezy: 1.2.9
Jessie/sid: 1.3.4


--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
mailto/sip: agi@...64... | en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 5347 CBD8 3E30 A9EB 4D7D  4BF2 009B 3375 6B9A AA55

