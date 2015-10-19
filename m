From: "Fish Wang" <fish.thss@...277...>
References: <56211F0D.2010806@...515...>
	<18065708.JIrWLiTMeq@...2001...>	<ac7rqc.nwgq22.2u3ktu-qmf@...2076...>	<2892922.l0hsuaC9oU@...2001...>
	<SN1PR08MB1391C6A8CA4653A464FAC48EB93A0@...2065...>
In-Reply-To: <SN1PR08MB1391C6A8CA4653A464FAC48EB93A0@...2065...>
Date: Mon, 19 Oct 2015 13:14:41 -0700
Message-ID: <001101d10aaa$ca65c3c0$5f314b40$@gmail.com>
MIME-Version: 1.0
Content-Language: zh-cn
Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: "'Morris, Russell'" <rmorris@...1315...>, 'Heiko Hund' <heiko.hund@...1489...>, samuli@...515...
Cc: openvpn-devel@lists.sourceforge.net

Regarding Windows OpenVPN GUI: I have an internal fork of this OpenVPN GUI =
(https://github.com/jochenwierum/openvpn-manager) from jochenwierum, with m=
any bug fixes and improvements, and it works fairly well on Windows. Maybe =
I should tidy my patches and open source it on github?

Best,
Fish

-----Original Message-----
From: Morris, Russell [mailto:rmorris@...1315...]=20
Sent: Monday, October 19, 2015 7:59 AM
To: Heiko Hund <heiko.hund@...1489...>; samuli@...515...
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?

Hi,

Just a couple thoughts here, from a (absolutely!) non-expert ... :-(.

I have been trying to develop my own "GUI" - not because the current one do=
esn't work (not at all!), but because I want a bit of an extended feature s=
et ... to be able to change Tray Icon color with traffic (Tx/Rx), and plot =
ping timing to a remote machine over the link, and as well traffic and bit =
rate plots in the UL and DL.

That all said, I can definitely see that the network adapter (TAP) and open=
vpn.exe really are up and down (a lot!) on Windows ... :-(. I am trying to =
use NSSM to at least keep openvpn.exe up (i.e. restart it), but the network=
 connection is a challenge also - often having to be reset (disabled and en=
abled). So to the question below ... yes, Windows does need some work.

I'd be happy to help out - but as above, I'm not an expert. So definitely w=
illing, but usefulness may be questionable unfortunately ... ;-).

Thanks!

... Russell



-----Original Message-----
From: Heiko Hund [mailto:heiko.hund@...1489...]=20
Sent: Monday, October 19, 2015 9:16 AM
To: samuli@...515...
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?

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

---------------------------------------------------------------------------=
---
_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
---------------------------------------------------------------------------=
---
_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel


