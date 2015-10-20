References: <56211F0D.2010806@...515...> <18065708.JIrWLiTMeq@...2001...>
	<ac7rqc.nwgq22.2u3ktu-qmf@...2076...>
	<2892922.l0hsuaC9oU@...2001...>
	<SN1PR08MB1391C6A8CA4653A464FAC48EB93A0@...2065...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <56260084.50903@...515...>
Date: Tue, 20 Oct 2015 11:51:16 +0300
MIME-Version: 1.0
In-Reply-To: <SN1PR08MB1391C6A8CA4653A464FAC48EB93A0@...2065...>
Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Morris, Russell" <rmorris@...1315...>, Heiko Hund <heiko.hund@...1489...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi all,

This response is not really a response - please bear with me.

Regarding Windows GUIs... The situation with them is similar to the=20
situation we had with OpenVPN back in 2009. Back then, the main=20
repository (SVN) was managed by James, but he did not have time to=20
review or merge community patches. This had created several "islands" of=20
activity, for example IPv6 patchsets from Gert and Juanjo and Eurephia=20
from David. The OpenVPN forums were also "external", i.e. not managed by=20
the main OpenVPN project. There was also little to no coordination=20
between these islands. We merged these islands and slowly took over=20
project's responsibilities from James. By 2.3-alpha/beta-something the=20
takeover was complete. The OpenVPN project had become our playground,=20
something which we as a community owned and shared responsibility of.

However, the Windows part has always remained "external" to the main=20
project. There is a fairly large number of people working on various=20
aspects of Windows - here's a crude list of the top of my hat:

- Me (openvpn-build, "the buildslave", openvpnserv.exe replacement)
- Heiko (OpenVPN-GUI, cygwin builds?, interactive service)
- Steffan (openvpn-build)
- Lev (msvc builds)
- ValdikSS (msvc builds?, Win10 DNS fix)
- James (msvc builds, OpenVPN Connect, fixes here and there)
- People interested in joining the Windows team (a few already)
- All the "other" GUI authors and their contributors

We've had #openvpn-devel and this development mailing list for ages, and=20
we're still struggling to get people to work on Windows. There are=20
basically two explanations for this:

a) The current model is not working
b) There simply are no people who want to work on Windows

The meat of my proposal is to create a (semi)separate playground for all=20
those who want to help OpenVPN for Windows to be as pleasant an=20
experience as possible. If a "Windows team" eventually emerges, fine. If=20
it does not, we can scrap the idea and go on as if nothing had happened.

The actual steps towards enabling the "Windows team" to emerge would be:

1) #openvpn-windows IRC channel

A Windows-specific IRC channel would attract people who run OpenVPN on=20
Windows. This exact thing happened when we created the #openvpn-as chat:=20
two of the current OpenVPN Tech employees were actually recruited from=20
this channel. So the model itself is highly likely to work. It probably=20
makes sense to keep #openvpn the official support channel, but forward=20
the more tricky Windows questions to #openvpn-windows.

2) Windows-specific forum board

A quick look at the forums shows that about 1/5 of topics are related to=20
Windows, just based on the topic name. Obviously people will post=20
non-Windows questions to a Windows board, but moving threads from one=20
board to another happens all the time anyways. Moreover, now people post=20
their Windows client TAP-Windows questions to "Server administration"=20
board, so the current situation is unlikely to get any worse.

3) Adding OpenVPN-GUI to OpenVPN's GitHub page

This was proposed by someone else earlier. If nothing else, it would=20
allow sharing responsibility of OpenVPN-GUI development among more=20
people, like what happened with easy-rsa, openvpn-build, etc. earlier. I=20
actually created my own GitHub fork a while back to make my work easier,=20
as well as to be able to merge trivial patches (e.g. language fixes)=20
more easily. The versioning in my OpenVPN-GUI tree had diverged from the=20
"official" one a long time before that.

---

All of the three above are proposals, which probably help us get more=20
people working on the Windows part of OpenVPN _in the long run_. I=20
obviously have to present the proposals with the people who actually get=20
affected by them, i.e. people on #openvpn and the forums.

The way I see it, none of the above can actually harm the project, so=20
trying this out should be safe. If you disagree or have constructive=20
suggestions, please speak now or forever hold your peace :).

Thanks,

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


> Hi,
>
> Just a couple thoughts here, from a (absolutely!) non-expert ... :-(.
>
> I have been trying to develop my own "GUI" - not because the current one =
doesn't work (not at all!), but because I want a bit of an extended feature=
 set ... to be able to change Tray Icon color with traffic (Tx/Rx), and plo=
t ping timing to a remote machine over the link, and as well traffic and bi=
t rate plots in the UL and DL.
>
> That all said, I can definitely see that the network adapter (TAP) and op=
envpn.exe really are up and down (a lot!) on Windows ... :-(. I am trying t=
o use NSSM to at least keep openvpn.exe up (i.e. restart it), but the netwo=
rk connection is a challenge also - often having to be reset (disabled and =
enabled). So to the question below ... yes, Windows does need some work.
>
> I'd be happy to help out - but as above, I'm not an expert. So definitely=
 willing, but usefulness may be questionable unfortunately ... ;-).
>
> Thanks!
>
> ... Russell
>
>
>
> -----Original Message-----
> From: Heiko Hund [mailto:heiko.hund@...1489...]
> Sent: Monday, October 19, 2015 9:16 AM
> To: samuli@...515...
> Cc: openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?
>
> On Monday 19 October 2015 10:20:23 samuli@...515... wrote:
>>>> I'm thinking it might make sense to create a dedicated Windows team
>>>> that could share the burden of Windows issues amongst themselves,
>>>> without any one person gettings tagged the "Windows guy".
>>>
>>> Judging from the review the Windows patches received I think this might=
 be
>>> an  too ambitious goal. Obviously not  many care besides the regulars w=
ho
>>> make a
>>
>> Anyways, not many seemed to care about about easy-rsa before it became a
>> separate project in GitHub. Now we have easy-rsa 3 by pekster and ecrist.
>> Similarly for openvpn-build we have/had Alon, pekster, me and syzzer. I'm
>> sure more examples could be found from other projects.
>>
>> I'm also not speaking primarily of Windows patches, but also all the oth=
er
>> stuff such as debugging, user support, ticket review, packaging, etc.
>
> Ok, I think here is the main misunderstanding. My understanding was that =
you
> want a Windows development team. That I think would be counter productive=
. For
> the other topics I do not have a opinion.
>
>>>> am working on a replacement for openvpnserv.exe.
>>>
>>> Please consider reviewing and improving the interactive service patch
>>> instead of duplicating work.
>>
>> Are you saying that the interactive service also doubles as a Windows sy=
stem
>> service? If so, can it be  configured to autostart selected openvpn
>> connections on boot and restart them if they crash/stop?
>
> No, and I do not think that the service should take care of that. That's
> rather things that can be handled by the GUI.
>
>> Now, can anyone provide proof that having a Windows team would actually
>> _hurt_ the project? If not, what does it matter if it fails? We could ju=
st
>> scrap the idea retroactively.
>
> Hehe nice turn demanding proof, that'll shut up ppl. =3D)
>
> Heiko
>
>
> Sophos Technology GmbH, Amalienbadstra=E1=BA=9Ee 41/Bau 52, D-76227 Karls=
ruhe, Deutschland
> Tel +49 (0)721 25516 0 Fax +49 (0)721 25516 200 E-Mail info@...2075... ww=
w.sophos.de
> Sitz der Gesellschaft: Karlsruhe, Amtsgericht Mannheim HRB 712658
> Gesch=C3=A4ftsf=C3=BChrer: Nicholas Bray, Pino von Kienlin, Wolfgang Hilp=
ert, Jennifer Onslow.
> Sophos GmbH, Gustav-Stresemann-Ring 1, 65189 Wiesbaden, Deutschland
> Tel +49 (0) 611 5858-0 Fax +49 (0) 611 5858-1042 E-Mail info@...2075... w=
ww.sophos.de
> Sitz der Gesellschaft: Wiesbaden, Amtsgericht Wiesbaden HRB 25915 Gesch=
=C3=A4ftsf=C3=BChrer: Nicholas Bray, Wolfgang Hilpert, Pino von Kienlin, Je=
nnifer Onslow
>
> -------------------------------------------------------------------------=
-----
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>



