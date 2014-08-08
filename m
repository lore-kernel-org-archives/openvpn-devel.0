Date: Fri, 8 Aug 2014 11:56:17 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140808095617.GY1118@...1296...>
References: <1407453032-588-1-git-send-email-gavin.shrubbery@...277...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZLRdPLWYXRI0d11o"
Content-Disposition: inline
In-Reply-To: <1407453032-588-1-git-send-email-gavin.shrubbery@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Tease apart ipv6 and ipv4 ifconfig code.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gavin Shrubbery <gavin.shrubbery@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--ZLRdPLWYXRI0d11o
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 08, 2014 at 11:10:32AM +1200, Gavin Shrubbery wrote:
> This change makes it possible to configure an IPv6 address on a
> tunnel without also having an IPv4 address.

Thanks.  Could you please rebase this on git master?  tun.c has changed a=20
bit since 2.3, and your patch looks like it's based on 2.3 (the AIX bits
are missing, which is a giveaway).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ZLRdPLWYXRI0d11o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU+SewakuBuNlUUl1AQJ7JAQAhkRzxfrf+RMjYpY7TfIRT8+sL4d65po7
xuKUGvlXt6K8tvBhm0ggSANiuwpMcnRTED+McUoL8xA5QGFeR/R2xSQFOUUv+Ug+
kZ89eRWMn5cK8dSj2WVbo27aDr85TCFP/W1EuZJIWQZjWo+RQv/47f3MSSR+aCdq
DurwSsjvBUY=
=cUs+
-----END PGP SIGNATURE-----

--ZLRdPLWYXRI0d11o--

