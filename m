From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 8 Dec 2011 12:19:17 +0100
Message-ID: <33935117.ElFH2NdExu@...1526...>
In-Reply-To: <1323303229-31079-1-git-send-email-davids@...1347...>
References: <1323303229-31079-1-git-send-email-davids@...1347...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Add a wrapper for access() when
	compiling via Visual Studio
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
To: openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <davids@...1347...>

On Thursday 08 December 2011 00:13:49 David Sommerseth wrote:
> This adds the access() function as a wrapper for _access() to be
> able to compile OpenVPN via Visual Studio.  It also adds the required
> macros which used in POSIX environments (R_OK, W_OK, X_OK, F_OK).

Depending on the order this and my "Windows unicode paths" patch are merged=
=20
there needs to be some additions code here or in that patch that converts t=
he=20
path using wide_string() passing it to _waccess().

Heiko
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro a Sophos Company | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germ=
any
Commercial Register: Mannheim HRA 702710 | Headquarter Location: Karlsruhe
=20
Represented by the General Partner Astaro Verwaltungs GmbH
Amalienbadstra=DFe 41 Bau 52 | 76227 Karlsruhe | Germany=20
Commercial Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,
Markus Hennig, Jan Hichert, G=FCnter Junk, Dr. Frank Nellissen


