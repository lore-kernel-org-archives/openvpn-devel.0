From: Heiko Hund <heiko.hund@...1489...>
Date: Mon, 12 Mar 2012 12:18:11 +0100
Message-ID: <4522962.Jgi3aFRGrn@...1526...>
In-Reply-To: <CAP+U6tKQU=_6V--gFoSN68SLFGWBa+J3pTg2tA5G108+iptbFg@...278...>
References: <4F4CE4FE.3010009@...515...> <2610535.JtY05sqIlT@...1526...>
	<CAP+U6tKQU=_6V--gFoSN68SLFGWBa+J3pTg2tA5G108+iptbFg@...278...>
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

Hi Fabian,

On Friday 09 March 2012 16:34:19 Fabian Knittel wrote:
> Does your
> approach prevent the user from injecting code into the OpenVPN
> process? Or does it only prevent the user from directly accessing the
> pipe? (IIUC you would need the integrity level approach to prevent the
> former so I assume you're describing how the pipe handle will be
> protected instead.)

It tries to prevent both. While protecting the elevation pipe to the servic=
e=20
from arbitrary use is the actual goal it can only be achieved by also=20
protecting the process from modification. In Windows you can clone handles=
=20
(i.e. the pipe handle) from another process into your process if you have=20
sufficient rights. As Carsten pointed out one could also inject code into t=
he=20
openvpn.exe process and use the pipe in-process in a unintended way. I'm=20
currently uncertain if it's possible to duplicate the pipe handle if access=
 to=20
the process itself is limited down to a minimum. I guess it is.

The integrity level thing is actually just a more convenient/automatic way =
to=20
limit access to processes. Instead of limiting access manually through ACLs=
=20
Windows will take care that a process with lower integrity level has limite=
d=20
access to one with a higher level by taking away rights of the calling proc=
ess=20
on a call by call basis during runtime.

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


