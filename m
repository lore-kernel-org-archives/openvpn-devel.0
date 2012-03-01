From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 1 Mar 2012 11:58:39 +0100
Message-ID: <1677482.aKjq4FLfA1@...1526...>
In-Reply-To: <CAP+U6t+pQXzvU-kGWDSZo6cQB6mf+LPd3LyLaowdB0xakbzjAQ@...278...>
References: <4F4CE4FE.3010009@...515...>
	<20120229154604.GA7024@...1296...>
	<CAP+U6t+pQXzvU-kGWDSZo6cQB6mf+LPd3LyLaowdB0xakbzjAQ@...278...>
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
To: Fabian Knittel <fabian.knittel@...1547...>
Cc: Carsten =?ISO-8859-1?Q?Kr=FCger?= <C.Krueger@...448...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Wednesday 29 February 2012 16:59:03 Fabian Knittel wrote:
> If users can manipulate their openvpn session to do whatever they want
> they can also manipulate what gets sent over the named pipe. (I'm not
> necessarily talking about malformed messages; I'm talking about
> manipulating the routing tables, etc. to contain arbitrary settings.)

That's good thinking there. I've ignored the fact that one can simply add=20
--route options to the config. However, just checked the man page, these=20
routes will get set after a connection is established. So this can't be use=
d=20
to manipulate the routing table without establishing a connection first. Th=
e=20
whole point about this exercise is to keep users from setting arbitrary rou=
tes=20
without openvpn having it's fingers in the process. So, I think this is the=
=20
best we can do here, in the end we want openvpn to be able to set routes.

> Either I'm misunderstanding Heiko's plans or you two aren't in sync
> regarding this point. AFAIU, Heiko intends to safe-guard access to the
> named pipe as much as possible, with the underlying assumption that
> only a trusted OpenVPN process should be allowed to send somewhat
> trusted commands over the pipe.

We're slightly out of sync. I do believe we should protect the elevation pi=
pe=20
as good as possible, just to make it harder to sneak in a route.

> In my opinion, this implies that the
> openvpn config would need to be restricted to safe settings in some
> way. I'm not (yet?) convinced that this approach can be secure without
> crippling the type of tunnels that you can create.

Well, it's kind of hard to determine what's a save setting here. Even if th=
e=20
local configs are safely locked down one can still just add --route options=
=20
the the command line. I guess it's a general discussion if --route on the=20
client is defined as "secure because we said so" or if it should be removed=
.=20
Is there a use case for --route on the client?

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


