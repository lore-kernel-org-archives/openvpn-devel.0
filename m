From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 17 Aug 2011 16:11:20 +0200
References: <1313588569-18927-1-git-send-email-heiko.hund@...1489...>
	<201108171602.29222.heiko.hund@...1489...>
	<CAOazyz1aEwUdby7jFmb6k+=2ook2tgmT2vvNxPR1o9vGLMf2hg@...278...>
In-Reply-To: <CAOazyz1aEwUdby7jFmb6k+=2ook2tgmT2vvNxPR1o9vGLMf2hg@...278...>
MIME-Version: 1.0
Message-Id: <201108171611.21187.heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH 0/3] better --auto-proxy support for
	Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On Wednesday 17 August 2011 16:07:42 Alon Bar-Lev wrote:
> How do you configure Internet Explorer proxy detection for local system
> account? Or... alternatively you need to create a user for openvpn
> service, login, execute IE, set whatever.
> Quite difficult for unattended setup.
> Well, maybe find places in registry where IE stores the settings...

I don't think that's a problem. If no IE proxy configuration can be fetched=
,=20
the default config set with proxycfg will be used. And besides that there's=
=20
still the option to manually configure proxy settings in openvpn directly f=
or=20
such setups.

Heiko
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro a Sophos Company | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germ=
any
Commercial Register: Mannheim HRA 702710 | Headquarter Location: Karlsruhe
=20
Represented by the General Partner Astaro Verwaltungs GmbH
Amalienbadstra=C3=9Fe 41 Bau 52 | 76227 Karlsruhe | Germany=20
Commercial Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,
Markus Hennig, Jan Hichert, G=C3=BCnter Junk, Dr. Frank Nellissen

