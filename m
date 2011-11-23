From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 23 Nov 2011 16:14:35 +0100
Message-ID: <8817069.bUavoJz72o@...1526...>
In-Reply-To: <CAOazyz0mAOkx5VBBM2WDiCBQ-S6ikV++9ixQpdg4LCCJ0D1sLg@...278...>
References: <1322057655-15463-1-git-send-email-heiko.hund@...1489...>
	<CAOazyz0mAOkx5VBBM2WDiCBQ-S6ikV++9ixQpdg4LCCJ0D1sLg@...278...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] UTF-8 X.509 distinguished names
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Wednesday 23 November 2011 14:53:06 Alon Bar-Lev wrote:
> As this is inserted into environment, what happens if locale is not
> unicode enabled?

Then the script will receive funny looking strings depending on your locale=
's=20
code page. However, this is nothing that's being introduced with this patch=
,=20
as mentioned in the commit message 2627335 already puts UTF-8 user names an=
d=20
passwords into the environment.

> I think this may break some configurations.

Aren't the environments lacking UTF-8 locales broken with regards to non-AS=
CII=20
characters anyways? As UTF-8 encoding doesn't change any character < 128 no=
n-
ASCII DNs, user names and password will be passed to scripts just like in t=
he=20
good old days.

Regards
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


