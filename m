From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 1 Mar 2012 10:24:34 +0100
Message-ID: <2202832.nbUQuJyuNX@...1526...>
In-Reply-To: <CAOazyz06Ba-FLzm2i15we1tt4tkvV=gzQBadh0TuhzfPWLQW9A@...278...>
References: <4F4CE4FE.3010009@...515...> <12822827.2NuMshZZBO@...1526...>
	<CAOazyz06Ba-FLzm2i15we1tt4tkvV=gzQBadh0TuhzfPWLQW9A@...278...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
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
Cc: Carsten =?ISO-8859-1?Q?Kr=FCger?= <C.Krueger@...448...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Thursday 01 March 2012 09:22:38 Alon Bar-Lev wrote:
> Also, (technically) impersonation token cannot be used for network access.
> So the solution of impersonating to user will not allow a script to
> mount remote filesystem.

You can't create a process with an impersonation token that's why a primary=
=20
token is used.

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


