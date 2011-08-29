Date: Mon, 29 Aug 2011 16:06:48 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110829140648.GU8496@...1296...>
References: <4E4B873F.6080009@...515...>
	<1313652334-15914-1-git-send-email-samuli@...515...>
	<4E575276.80206@...1114...> <4E576922.8010209@...515...>
	<jwvty94e087.fsf-monnier+INBOX@...1269...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3qf/mDwmcsh6TFUi"
Content-Disposition: inline
In-Reply-To: <jwvty94e087.fsf-monnier+INBOX@...1269...>
Subject: Re: [Openvpn-devel] [PATCH] Added whitespace handling for
	$KEY_CONFIG variable in easy-rsa/2.0/vars
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Stefan Monnier <monnier@...1268...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--3qf/mDwmcsh6TFUi
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 26, 2011 at 10:07:00AM -0400, Stefan Monnier wrote:
> POSIX mandates $() so any posix shell will support it.  The issue is
> with non-POSIX shells, if you do want to support them (e.g. Solaris's
> /bin/sh).

I'd rather not go down that rat-hole.  Even Solaris has POSIX-compliant
shells today (ISTR that there is /bin/ksh).

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--3qf/mDwmcsh6TFUi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTluc+KkuBuNlUUl1AQLRGgQAn7i7frAPWAiVfHl5Gv5ZKfhHIjR7aB7l
vRIp8m0JZvodeQmkmpi6EUhwaB1e31GVvemY2L3yOBmlVGuTGq+3RPqml7UAeVdi
S9hlAYjppbkZ2MZx4sKfF1s8XKmsUsV+V8OzhSXRL/gHMolY004RR1F63HEItpBH
DcfwEmdJcvM=
=KJah
-----END PGP SIGNATURE-----

--3qf/mDwmcsh6TFUi--

