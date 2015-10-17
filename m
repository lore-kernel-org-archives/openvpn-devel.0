From: Heiko Hund <heiko.hund@...1489...>
Date: Sat, 17 Oct 2015 08:59:15 +0200
Message-ID: <18065708.JIrWLiTMeq@...2001...>
In-Reply-To: <56211F0D.2010806@...515...>
References: <56211F0D.2010806@...515...>
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
To: openvpn-devel@lists.sourceforge.net

Hi Samuli

On Friday 16 October 2015 19:00:13 Samuli Sepp=C3=A4nen wrote:
> - The service wrapper (openvpnserv.exe) is effectively broken for
> Windows 8 and later
> - The service wrapper has very limited functionality
> - The OpenVPN-GUI we bundle has several major issues, most related to
> having to run it as an admin

The interactive service that I posted a year ago solves all these problems.

> I'm thinking it might make sense to create a dedicated Windows team that
> could share the burden of Windows issues amongst themselves, without any
> one person gettings tagged the "Windows guy".

Judging from the review the Windows patches received I think this might be =
an
too ambitious goal. Obviously not many care besides the regulars who make a
one time exception every now and then and get their hands dirty on Windows
code if they feel it matters.

> am working on a replacement for openvpnserv.exe.

Please consider reviewing and improving the interactive service patch inste=
ad
of duplicating work.

> The Windows team could have a separate board on OpenVPN forums and maybe
> even a separate IRC channel. This is fairly typical arrangement in Linux
> distributions, which have topic- and language-specific groups. We could
> then point people with Windows issues/patches/development questions etc.
> to the Windows team.

I think that's rather counter productive. Dev work on different systems has
too much common ground to completely separate the ppl by OS.

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

