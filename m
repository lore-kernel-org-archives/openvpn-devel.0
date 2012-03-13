From: Heiko Hund <heiko.hund@...1489...>
Date: Tue, 13 Mar 2012 11:07:23 +0100
Message-ID: <70094734.yG4fYDZvM3@...1526...>
In-Reply-To: <CAOazyz0mnZZVbGiMxmkn_JW5+yZ8AUeejeVWi0pMbu9okieRpw@...278...>
References: <4F4CE4FE.3010009@...515...> <4F5E08D2.2040302@...515...>
	<CAOazyz0mnZZVbGiMxmkn_JW5+yZ8AUeejeVWi0pMbu9okieRpw@...278...>
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
To: openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>, Carsten =?ISO-8859-1?Q?Kr=FCger?= <C.Krueger@...448...>

Hi

On Monday 12 March 2012 19:01:41 Alon Bar-Lev wrote:
> Although I tried to go farther... that what James suggested.
> What is the baseline? This what we should agree first...
> Should openvpn daemon be run on completely unprivileged account or not.

I don't support the idea about running openvpn.exe with elevated privileges=
.=20
It has been run as the user before and that worked fine until Microsoft=20
limited access to system resources in Vista. The service approach with the=
=20
elevation pipe solves exactly that problem.

Openvpn is very complex, running is under a privileged account is a securit=
y=20
risk in my opinion. The elevation pipe offers a very limited and well defin=
ed=20
interface to configure needed system resources only and tries hard to allow=
=20
access for openvpn.exe only. If you compare what the possibilities of an=20
attacker would be if the openvpn.exe process is compromised in both scenari=
os=20
there's not much room to argue IMO.

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


