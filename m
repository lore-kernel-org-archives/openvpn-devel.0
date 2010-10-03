Date: Sun, 3 Oct 2010 13:08:34 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20101003110834.GL10703@...1296...>
References: <4CA088DD.5040607@...1410...> <4CA08C68.1080701@...1147...>
	<20100927124711.GS3275@...1355...>
	<4CA09A9F.6040009@...1147...> <4CA0B3A3.5030506@...1410...>
	<20100929220528.19467.qmail@...1287...> <4CA3D978.8080700@...1410...>
	<20100930003840.14209.qmail@...1287...>
	<20100930072438.GV3275@...1355...> <4CA4A4FB.7080203@...1410...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y7P0gPYVJgs55uY0"
Content-Disposition: inline
In-Reply-To: <4CA4A4FB.7080203@...1410...>
Subject: Re: [Openvpn-devel] HTTP Host header
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lars Hupel <hupel@...1410...>
Cc: openvpn-devel@lists.sourceforge.net

--Y7P0gPYVJgs55uY0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Sep 30, 2010 at 03:55:55PM +0100, Lars Hupel wrote:
> My expectation would be that the proxy server uses the host name given
> after GET (or CONNECT) to regulate access control (and to forward it as
> 'new' Host header) and the Host header to disambiguate between multiple
> virtual hosts (e. g. like in my case with a configuration where a normal
> web server and a proxy server have the same IP address and are
> represented by two different Apache virtual hosts). With that, both host
> fields would serve different purposes and wouldn't be redundant.

Have you been able to figure out how Apache handles this?  Is it using
the Host: header in CONNECT requests for anything, and if yes, what should
be in there?  Is that documented anywhere?

To see how "other software" does this, I've tcpdumped firefox going
to a SSL secured banking site, and that's what it does...:

CONNECT banking.postbank.de:443 HTTP/1.1
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.9) Gecko/20100=
927 Gentoo Firefox/3.6.9
Proxy-Connection: keep-alive
Host: banking.postbank.de


- so indeed, the Host: header is redundant and somewhat useless here.


Soo...: I ACK the proposed patch as well.  It does the same what web browse=
rs
do (no matter how useful or not it might be), the code has no quality issues
and conforms to OpenVPN coding conventions.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Y7P0gPYVJgs55uY0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iQCVAwUBTKhkMakuBuNlUUl1AQKJJAP/TQOzwemsqHfZiAUAq1VqyhiwZllGmv9V
lrsZJfp74tcT6EZYVtSClOmUSt5P7f1jGdL9/biynsBNmNFuVeBOPM+H6tosN3FF
WEqoAUNAou2STFWewhLgPUHAWLlS5raxhsd3PY5U2UVQH10OHdSIyl1lpV2G1jO0
FaQN62+QYhI=
=aZ14
-----END PGP SIGNATURE-----

--Y7P0gPYVJgs55uY0--

