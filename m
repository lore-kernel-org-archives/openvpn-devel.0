Message-ID: <20100930171234.19256.qmail@...1287...>
Date: Thu, 30 Sep 2010 19:12:34 +0200
From: Peter Stuge <peter@...1287...>
References: <4CA088DD.5040607@...1410...> <4CA08C68.1080701@...1147...>
	<20100927124711.GS3275@...1355...>
	<4CA09A9F.6040009@...1147...> <4CA0B3A3.5030506@...1410...>
	<20100929220528.19467.qmail@...1287...> <4CA3D978.8080700@...1410...>
	<20100930003840.14209.qmail@...1287...>
	<20100930072438.GV3275@...1355...> <4CA4A4FB.7080203@...1410...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
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
To: openvpn-devel@lists.sourceforge.net

--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Lars Hupel wrote:
> When thinking about it, the Host header doesn't make any sense to me.

It was added to support virtual hosting in a time (20? years ago)
when the domain name wasn't included anywhere in the request, but
used only for client-side IP-adress lookup. Back then it was a
reasonable assumption that IP addresses were actually useful
identifiers for network resources.


//Peter

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFMpMUChR3Q0dhIfEgRAnujAJ9tsb2fRX9/gsM6seb/LqiCy/ls7QCeL7eh
vhn7uQSlGNfgvvO7iFLWtDE=
=XTvM
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--

