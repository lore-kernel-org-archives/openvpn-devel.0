Date: Mon, 14 Apr 2014 12:20:22 +0200
From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20140414102022.GF13903@...1894...>
References: <534B98A4.7020806@...515...>
	<20140414082858.GB16637@...1296...> <534BA045.50503@...1435...>
	<534BA2CB.3030300@...515...>
	<20140414092928.GV13903@...1894...>
	<20140414094223.GH16637@...1296...>
MIME-Version: 1.0
In-Reply-To: <20140414094223.GH16637@...1296...>
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

On Mon, Apr 14, 2014 at 11:42:23AM +0200, Gert Doering wrote:
> Hi,
>=20
> On Mon, Apr 14, 2014 at 11:29:28AM +0200, Alberto Gonzalez Iniesta wrote:
> > There're already packages for PolarSSL in Debian (and thus, in Ubuntu).
> > So I don't think there's need to maintain different ones.
>=20
> What's Debian's stance on PolarSSL 1.2.x vs. 1.3.x?  This is something
> that had me worried for a while, as they are plain incompatible - so
> if we finally merge Steffan's patch for Polar 1.3.x support to git master,
> different OpenVPN versions will require different PolarSSL versions as
> well
>=20
>   openvpn 2.3.x -> needs PolarSSL 1.2.x, will not build or run with 1.3.x
>   openvpn 2.4.x -> needs PolarSSL 1.3.x, will not build or run with 1.2.x
>=20
> (the decision to not-support PolarSSL 1.2.x in parallel to 1.3.x saves
> OpenVPN a lot of #ifdefs in our code, but pushes the burden to the
> distribution maintainers)

I guess the best solution would be to go for 1.3.x support and backport
polarssl to Squeeze and Wheezy. I could contact the polarssl maintainer
to see how doable that is.


--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
mailto/sip: agi@...64... | en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 5347 CBD8 3E30 A9EB 4D7D  4BF2 009B 3375 6B9A AA55

