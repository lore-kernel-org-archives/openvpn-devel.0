Date: Thu, 22 Oct 2015 19:37:01 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20151022173701.GP22054@...1296...>
References: <56211F0D.2010806@...515...> <2421664.qQJpUDo69u@...1526...>
	<56261F0D.9020208@...515...> <1921973.yRGlOPzy2x@...2001...>
	<20151022075000.GD22054@...1296...>
	<SN1PR08MB1391D82901BB0F9F4C8CB5E9B9270@...2065...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="to5DbCFSZVYx8K1H"
Content-Disposition: inline
In-Reply-To: <SN1PR08MB1391D82901BB0F9F4C8CB5E9B9270@...2065...>
Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Morris, Russell" <rmorris@...1315...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--to5DbCFSZVYx8K1H
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Oct 22, 2015 at 04:43:05PM +0000, Morris, Russell wrote:
> Sorry, catching up, but to the comments previously ... I do see openvpn.e=
xe crash quite regularly. I run it on a laptop, sleeping / resuming and mov=
ing from wired to wireless (and) back quite a bit. These tend to break open=
vpn.exe, and in some cases can hang the TAP adapter also ... :-(.

Try without local bind (--nobind in the client config)...

That should even give you seamless roaming without losing your tunnel
if the server is new enough to support peer-id (git master, no older
than about half a yaear).

gert=20

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--to5DbCFSZVYx8K1H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVikevakuBuNlUUl1AQKByQP8DiZVMXCPHXXTwu7v4hTBpfU5L5NIA/rX
K4QSGQUvm3r+/X+ioOG3dNihI1TavTj2qb0kn2rvKSZ4MfBHgCJVYB6YfmUETmQ+
9YG6aEnmMUW6fMnHvMIHnUZfwQRpIXADhLz9De9N5DMaEdns6oIJfzP9FrGru2OS
HzQQug956uA=
=mwN+
-----END PGP SIGNATURE-----

--to5DbCFSZVYx8K1H--

