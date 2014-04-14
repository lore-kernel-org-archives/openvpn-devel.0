Date: Mon, 14 Apr 2014 11:29:28 +0200
From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20140414092928.GV13903@...1894...>
References: <534B98A4.7020806@...515...>
	<20140414082858.GB16637@...1296...> <534BA045.50503@...1435...>
	<534BA2CB.3030300@...515...>
MIME-Version: 1.0
In-Reply-To: <534BA2CB.3030300@...515...>
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

On Mon, Apr 14, 2014 at 11:56:43AM +0300, Samuli Sepp=E4nen wrote:
>=20
> > Hi,
> >
> > On 04/14/2014 10:28 AM, Gert Doering wrote:
> >> On Mon, Apr 14, 2014 at 11:13:24AM +0300, Samuli Sepp=E4nen wrote:
> >>> Currently all of the binary builds we provide[*] are linked to OpenSS=
L.
> >>> Would having both OpenSSL and PolarSSL builds make sense (e.g. starti=
ng
> >>> with 2.4)?
> >> I think it would be a nice option.  We could even start with 2.3.4 with
> >> that, at least for windows... (if PolarSSL can be cross-compiled for
> >> windows...)
> > PolarSSL works just fine on Windows, OpenVPN-NL already ships for
> > Windows, using PolarSSL.
> >
> > I would really like to release 'vanilla' polarssl-builds too. Make it
> > easy for people to pick their favourite SSL library.
> >
> > However, what about PolarSSL itself? For Windows we just put it in the
> > installer. But what about the other platforms? It's less commonly
> > available in the distro's, and because of the (at least up to now)
> > volatile API's, the rather not unlikely that users get version clashes.
> > So, options:
> >  * Just supply openvpn builds, let users deal with polarssl versioning
> > themselves
> >  * Provide PolarSSL packages too (do we already do that for other libs?)
> >  * Statically compile in PolarSSL (like OpenVPN-NL does)
> >
> > I think providing PolarSSL packages too is the neatest, but I'm not sure
> > on the work involved in maintaining those. Samuli, any thoughts on this?
> >
> I don't think maintaining the PolarSSL packages would be as much work as
> maintaining the OpenVPN packages. The OpenVPN packages need to keep
> track of changes in the OS init systems, handle services restarts etc.
> The PolarSSL packages would basically just copy some files to directory
> and run a few commands. So I guess it would be quite easy to do. That
> said, if we start maintaining PolarSSL debs, we might as well do it
> upstream in the PolarSSL project instead of within the OpenVPN project.
> We could of course publish the PolarSSL packages in our own apt repos to
> make using them easier for our users.

There're already packages for PolarSSL in Debian (and thus, in Ubuntu).
So I don't think there's need to maintain different ones.

--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
mailto/sip: agi@...64... | en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 5347 CBD8 3E30 A9EB 4D7D  4BF2 009B 3375 6B9A AA55

