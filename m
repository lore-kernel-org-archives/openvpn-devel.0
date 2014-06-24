Date: Tue, 24 Jun 2014 22:59:39 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140624205939.GR1118@...1296...>
References: <1397645317-20116-1-git-send-email-Holger.Kummert@...1516...>
	<1397645317-20116-2-git-send-email-Holger.Kummert@...1516...>
	<20140602182009.GP1118@...1296...>
	<538F27C6.2030203@...1516...> <53A14B09.8010405@...1516...>
	<53A1FF99.1000001@...1114...> <53A9A418.2090103@...1516...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nYjNOXWpwjVqWAsU"
Content-Disposition: inline
In-Reply-To: <53A9A418.2090103@...1516...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Get NTLMv1 compatibilities and
	NTLMv2 up and running
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Holger Kummert <Holger.Kummert@...1516...>
Cc: openvpn-devel@lists.sourceforge.net

--nYjNOXWpwjVqWAsU
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 24, 2014 at 06:15:20PM +0200, Holger Kummert wrote:
> So the vote goes clearly to #defines, right?

Yes, please.  Not because it's necessarily "better", but because it's what=
=20
the rest of the code currently uses.  (As with all styleguides, personal
taste will differ in places... I wouldn't *ever* use this particular=20
indentation style, for example, but "as the code is what it is", we all=20
stick to it... hard enough to maintain, even so).

> I'm going to change the code and test it. If it works, the change will
> be included in the next patch.

Thanks.  And I like the way this has become an actual discussion among
people that understand NTLM auth :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--nYjNOXWpwjVqWAsU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU6nmu6kuBuNlUUl1AQJ5DQP/dBV2d+uVP+iZ6NW4n1uxUaewyb3lNBBG
FFt9ysEb9kP8L54p4ecPGWccYVnE5tYWylEFt89ZnH5RU0cjO7cirzTh2zkQ1GM2
0bk/DanE8figopLTAbb/TwNt0u5Y4DUZcnSYPnhLJpH3XwIeOhyzm3+iPMxTdOGH
sCegDaz9SQo=
=jZqq
-----END PGP SIGNATURE-----

--nYjNOXWpwjVqWAsU--

