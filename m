Date: Thu, 24 Apr 2014 10:17:27 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140424081727.GO16637@...1296...>
References: <53572C4E.7010701@...1901...> <20140423081058.GJ16637@...1296...>
	<53579C5D.5000902@...1435...> <5357DDFC.2010401@...1901...>
	<53581D43.6060501@...1856...> <53584B0C.8020209@...1901...>
	<20140424070116.GN16637@...1296...> <5358C5C0.6090007@...1901...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8d7qUL/9fXlnrJjF"
Content-Disposition: inline
In-Reply-To: <5358C5C0.6090007@...1901...>
Subject: Re: [Openvpn-devel] Progress on Version negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Timothe Litt <litt@...1901...>
Cc: openvpn-devel@lists.sourceforge.net

--8d7qUL/9fXlnrJjF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 24, 2014 at 04:05:20AM -0400, Timothe Litt wrote:
> >Uh, this is a double misinformation :-)
> It's good to know that cross-compiling is an option, though=20
> cross-debugging (e.g. with an interactive debugger) can be an adventure t=
oo.
>=20
> Source of my comment was:
>=20
> http://community.openvpn.net/openvpn/wiki/BuildingOnWindows, which says
> >his new build system allows building OpenVPN on Windows more easily,=20
> >but some parts of the build may r*equire a commercial version of the=20
> >Visual Studio development environment.*
> >/Visual Studio 2008 Professional/is used to build OpenVPN on Windows.=20
> >Note that the free Express edition might not work.
> >Full installation installs*/x86 cross-tools/*which *may cause nasty,=20
> >hard to debug issues*.
> (The professional tools are > $1,000 US, which is not in my budget.)
>=20
> You may want to reword that after validating your comment.  M$'s name=20
> for the 'free' tools is 'express edition'.  The license terms vary based=
=20
> on M$'s whims, the current statement is:
> >http://www.visualstudio.com/products/visual-studio-express-vs
> >Visual Studio Express products are available at no charge and may be=20
> >used for commercial, production usage subject to the license terms=20
> >provided with each product. For example, you can use Express for=20
> >Windows to create apps that you can then submit for sale in the=20
> >Windows Store.

Yeah, I think that page needs clarification (I think you need the commercial
edition to do code signing, which is not strictly required if you use
the pre-signed tap driver bundle), *and* it needs a pointer to the other
build system page.

Samuli...?


> The current version requires at least windows 7 and a 2.2GHz+=20
> processor.  (My XP laptop won't do.)
> The 2008 Express edition=20
> (http://www.microsoft.com/en-us/download/confirmation.aspx?id=3D7940) is=
=20
> also a resource hog.
> It doesn't include all of the templates and other files needed to make=20
> many kinds of applications, though it is serviceable.
>=20
> I do run these on a windows 7 machine, but can't reconfigure them just=20
> for debugging OpenVPN.

No, I wasn't suggesting that you do that, I was just trying to clarify
what build options we have.

I find "add msg() calls, build on linux, run on windows, see what breaks"
more natural to me than "build on windows" :-)


> In any case, I think that we have found root cause of this issue the=20
> old-fashioned way - code inspection based on some debugging I did on the=
=20
> server and a hint from Steffan.
>=20
> It seems that the cryptoapi interface (and probably other external key=20
> loaders, such as pkcs11 according to James) has not be updated for=20
> TLS1.2.  TLS1.2 adds some new signatures.  The error that I saw comes -=20
> I believe - from code that sanity checks the requested hash size against=
=20
> the generated hash size; cryptoapi only knows how to generate md5/sha1=20
> signatures.

Yep, I saw the mail exchange, and I'm quite happy that we know where=20
*your* issues are coming from.  George Ross' issues are something else,
though, as he's not using windows at all...

>=20
> This makes it clear that:
>   - the key loaders need to be updated for TLS1.2  This includes the=20
> cryptoAPI on windows, pkcs11, and the cert stores on other platforms=20
> (IOS, Android, Mac - if that's ever merged).
>   - There does need to be a way to specify a maximum TLS version (1.1=20
> will do in this case)
[..]

Good points.  We're having an IRC meeting tonight, and I hope that James,
Steffan and Arne can agree on a short-term approach for 2.3.4, and a
long-term approach for master/2.4 - what you describe sounds good to
me, but I'm not the one who is going to implement and maintain it, so
I'm not deciding.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--8d7qUL/9fXlnrJjF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU1jIlqkuBuNlUUl1AQIg7AP/cOi29KB0TmJqxlanzGY4N8zfWzg/Ygf3
DU98REGJn5+BoaZ9vGUDuQpLutmjdQZcWPCLiWFP8/h7kcVY0sISokemtKB9FV6J
WFimDpkrXxYcYXRsbwlUEcWx34CzsRKl19X6FDp77/U1llns6oHhlv6tGxtgfMH2
yM/r4W3ZGzw=
=RHci
-----END PGP SIGNATURE-----

--8d7qUL/9fXlnrJjF--

