Date: Sun, 13 Jan 2013 21:41:58 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20130113204158.GK22465@...1296...>
References: <1357994477-29981-1-git-send-email-matthias.andree@...68...>
	<20130112201331.GH22465@...1296...> <50F21EB9.4080401@...68...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OTIoc9zLs3Wz57k0"
Content-Disposition: inline
In-Reply-To: <50F21EB9.4080401@...68...>
Subject: Re: [Openvpn-devel] [PATCH] Enable TCP_NODELAY configuration on
	FreeBSD.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net

--OTIoc9zLs3Wz57k0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jan 13, 2013 at 03:40:57AM +0100, Matthias Andree wrote:
> > ACK, "obviously logical" - needs a build test across all other platforms
> > to check whether some obscure OS (like "Linux" or "Solaris" or "MinGW")
> > chokes if that header is included now, but I don't expect issues.
>=20
> No need for non-FreeBSD build tests, this is the wider context
> - M. Nottebrock who added the patch to Trac had added the #include in
> the "#ifdef TARGET_FREEBSD" section so it is invisible to other systems.

Ah, thanks, I did not look at the wider context.  Indeed, in that case
no need to test on other OSes.

(These sections need more cleanup - nexting autoconf-HAVE_ stuff with
#ifdef TARGET_XXX is not overly clever, as we know what FreeBSD has and
needs...  somewhere on the roadmap for 2.4)

[..]
> > 2.3.1 and master, I'd say :-)
> And 2.2.3 if that branch is still maintained.

It won't hurt to include it there as well, yes.  I'm not sure we'll do
another 2.2 release, but possibly if something "real bad" is found until
enough folks have moved to 2.3...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--OTIoc9zLs3Wz57k0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUPMcFqkuBuNlUUl1AQKTUgP/fNSF86vyh86yKAbZ0C4jpnFwrvLYQIVj
IjpSa8h6iIWOmTDZ8fa0ng0cWITnpPZ1KkdJKCklhIyim4EejAZPJI3YnND0qWcr
ohRRd00IXkxHTFJWNXRRFz+zvgViit9xor49oeySW38+pM9a1bz/cfMJPERZ0y8p
PSNZC3A8nH0=
=1bQw
-----END PGP SIGNATURE-----

--OTIoc9zLs3Wz57k0--

