From: Heiko Hund <heiko.hund@...1489...>
Date: Mon, 19 Oct 2015 16:15:55 +0200
Message-ID: <2892922.l0hsuaC9oU@...2001...>
In-Reply-To: <ac7rqc.nwgq22.2u3ktu-qmf@...2076...>
References: <56211F0D.2010806@...515...> <18065708.JIrWLiTMeq@...2001...>
	<ac7rqc.nwgq22.2u3ktu-qmf@...2076...>
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
To: samuli@...515...
Cc: openvpn-devel@lists.sourceforge.net

On Monday 19 October 2015 10:20:23 samuli@...515... wrote:
> > > I'm thinking it might make sense to create a dedicated Windows team
> > > that could share the burden of Windows issues amongst themselves,
> > > without any one person gettings tagged the "Windows guy".
> >
> > Judging from the review the Windows patches received I think this might=
 be
> > an  too ambitious goal. Obviously not  many care besides the regulars w=
ho
> > make a
>
> Anyways, not many seemed to care about about easy-rsa before it became a
> separate project in GitHub. Now we have easy-rsa 3 by pekster and ecrist.
> Similarly for openvpn-build we have/had Alon, pekster, me and syzzer. I'm
> sure more examples could be found from other projects.
>
> I'm also not speaking primarily of Windows patches, but also all the other
> stuff such as debugging, user support, ticket review, packaging, etc.

Ok, I think here is the main misunderstanding. My understanding was that you
want a Windows development team. That I think would be counter productive. =
For
the other topics I do not have a opinion.

> > > am working on a replacement for openvpnserv.exe.
> >
> > Please consider reviewing and improving the interactive service patch
> > instead of duplicating work.
>
> Are you saying that the interactive service also doubles as a Windows sys=
tem
> service? If so, can it be  configured to autostart selected openvpn
> connections on boot and restart them if they crash/stop?

No, and I do not think that the service should take care of that. That's
rather things that can be handled by the GUI.

> Now, can anyone provide proof that having a Windows team would actually
> _hurt_ the project? If not, what does it matter if it fails? We could just
> scrap the idea retroactively.

Hehe nice turn demanding proof, that'll shut up ppl. =3D)

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

