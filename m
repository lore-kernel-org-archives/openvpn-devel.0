Date: Tue, 26 Jun 2012 08:35:46 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120626063546.GQ1059@...1296...>
References: <CAAhp1KBzkQyGqFPWqT5N0kKXsGvBLj8KLsZY_C9wWnuwFAQHdQ@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OGdp5inFq4AVlqlU"
Content-Disposition: inline
In-Reply-To: <CAAhp1KBzkQyGqFPWqT5N0kKXsGvBLj8KLsZY_C9wWnuwFAQHdQ@...278...>
Subject: Re: [Openvpn-devel] After compiling openVPN 2.3 alpha. I get R6034
	error on execution
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gauri Bhave <gaurib123@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--OGdp5inFq4AVlqlU
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 26, 2012 at 11:16:31AM +0530, Gauri Bhave wrote:
> I downloaded the openvpn-2.3-alpha1.zip from openvpn.net and successfully
> compiled it for windows using the Python build system. But when I run the
> application I get following runtime error for openvpn.exe. R6034 An
> application has made an attempt to load the c runtime library incorrectly.
> Please contact application support team for more information.

Any specific reason you're not using Samuli's pre-built windows binary?

To answer your question: no idea whether the Python build system currently
works or not - it's not the preferred build system for 2.3, that is
"cross building with MinGW64 from linux", or building with cygwin/mingw
on windows.  Samuli knows more details.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--OGdp5inFq4AVlqlU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBT+lYQqkuBuNlUUl1AQLTYwP8Cwtpjaw6/0PiuCYA/0JIcD0mz1g0Iqy6
wYUb5QURVFj573dWF/D3AewgUWMrrWKNYDdZWct8j9ydeAfM/EiK31iUZ+vYbwJW
w79gyc2Lg4pk47IftmNuR/1dN+pcGU9wzALV4Y4tOojvXoZofPib2F0XiNd+FAtx
KvdSXGXKpGc=
=One+
-----END PGP SIGNATURE-----

--OGdp5inFq4AVlqlU--

