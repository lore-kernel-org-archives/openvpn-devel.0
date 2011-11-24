From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 24 Nov 2011 12:42:04 +0100
Message-ID: <1871019.JhjIMSm8zu@...1524...>
In-Reply-To: <CAOazyz28XMMdKP+sYJn_bnMQ8-xVDzcp6iSznx37uXT9eKLRDA@...278...>
References: <1322057655-15463-1-git-send-email-heiko.hund@...1489...>
	<8817069.bUavoJz72o@...1526...>
	<CAOazyz28XMMdKP+sYJn_bnMQ8-xVDzcp6iSznx37uXT9eKLRDA@...278...>
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

On Wednesday 23 November 2011 17:48:54 Alon Bar-Lev wrote:
> Yes, there are many none unicode environments, and I am not sure what
> this patch will behave in windows environment as it is SCS-2 not
> UTF-8.

I agree on the UCS-16 environment in Windows. Will post a patch for that so=
on,=20
as I'm almost ready with one handling UCS-16 file system related stuff. It'=
ll=20
be just a small addition to that patch.

> OpenVPN is also used in embedded systems, such as dd-wrt.com and other.
> So I guess I would like to see unicode=3Dtrue parameter on *NIX use
> UTF-8, on Windows use UCS-2.

Why would that be useful? Does it make a difference if scripts in a latin-1=
=20
environment receive "j\C3\B6rn" or "j=C3=B6rn"? Both forms won't be recogni=
zable=20
without additional effort, while being equally harmless.

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




