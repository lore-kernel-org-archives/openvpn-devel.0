From: Heiko Hund <heiko.hund@...1489...>
Date: Tue, 20 Oct 2015 12:38:18 +0200
Message-ID: <2421664.qQJpUDo69u@...1526...>
In-Reply-To: <5625EA0A.3000908@...515...>
References: <56211F0D.2010806@...515...> <2892922.l0hsuaC9oU@...2001...>
	<5625EA0A.3000908@...515...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Samuli =?ISO-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

On Tuesday 20 October 2015 10:15:22 Samuli Sepp=C3=A4nen wrote:
> >> Are you saying that the interactive service also doubles as a Windows
> >> system service? If so, can it be  configured to autostart selected
> >> openvpn connections on boot and restart them if they crash/stop?
> >
> > No, and I do not think that the service should take care of that. That's
> > rather things that can be handled by the GUI.
>
> What about persistent connections, especially on Windows servers?

The interactive service patch doesn't remove the currently available servic=
e.
So, you still can fire up any connections the way it was before. I personal=
ly
do not care about the original service though, it may very well be that it
lacks decent functionality.

Heiko


Sophos Technology GmbH, Amalienbadstra=E1=BA=9Ee 41/Bau 52, D-76227 Karlsru=
he, Deutschland
Tel +49 (0)721 25516 0 Fax +49 (0)721 25516 200 E-Mail info@...2075... www.=
sophos.de
Sitz der Gesellschaft: Karlsruhe, Amtsgericht Mannheim HRB 712658
Gesch=C3=A4ftsf=C3=BChrer: Nicholas Bray, Pino von Kienlin, Wolfgang Hilper=
t, Jennifer Onslow.
Sophos GmbH, Gustav-Stresemann-Ring 1, 65189 Wiesbaden, Deutschland
Tel +49 (0) 611 5858-0 Fax +49 (0) 611 5858-1042 E-Mail info@...2075... www=
.sophos.de
Sitz der Gesellschaft: Wiesbaden, Amtsgericht Wiesbaden HRB 25915 Gesch=C3=
=A4ftsf=C3=BChrer: Nicholas Bray, Wolfgang Hilpert, Pino von Kienlin, Jenni=
fer Onslow

