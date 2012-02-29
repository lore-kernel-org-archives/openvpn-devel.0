From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 29 Feb 2012 16:52:57 +0100
Message-ID: <5666502.2X59yaTkiW@...1526...>
In-Reply-To: <CAP+U6t+-8n=fFk+QP0Dm-H9YijcssjZjOHOpU5pwkSrXt1+qMQ@...278...>
References: <4F4CE4FE.3010009@...515...> <1404593.Apkr3x9kAi@...1526...>
	<CAP+U6t+-8n=fFk+QP0Dm-H9YijcssjZjOHOpU5pwkSrXt1+qMQ@...278...>
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

On Wednesday 29 February 2012 15:28:31 Fabian Knittel wrote:
> To ensure this in classic Linux this would mean that the OpenVPN
> process needs to run as a _different_ user than the GUI user or else
> the GUI user could freely manipulate the program using, e.g. ptrace. I
> know that similar manipulations are possible in Windows, so can you
> protect the service-started OpenVPN-executable from such
> manipulations? (And I also assume that _named_ pipes still allow you
> to hide the name from some processes of the same user?) (I'm not an
> experienced Windows programmer, so please excuse my ignorance...)

Me neither, so any guru input is very welcome. Even the not-so-guru one lik=
e=20
yours. Much appreciated!

The pipe connecting the service and openvpn is limited to one instance, whi=
ch=20
is created within the service before starting openvpn. So, no other process=
=20
can just attach this way and send commands even if it's the same user openv=
pn=20
is running as.

There is a way to use DuplicateHandle() to get the client pipe end out of t=
he=20
openvpn process if you have the rights. The GUI user has these rights, but =
I=20
think there should be a way to take them away from even her via ACLs. Guru=
=20
input requested on this topic! Starting from Vista there's also a way to ru=
n=20
GetNamedPipeClientProcessId() and compare that to the one of the openvpn=20
process before processing messages. Any other ideas to restrict access are=
=20
very welcome.
=20
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


