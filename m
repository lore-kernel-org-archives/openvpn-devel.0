MIME-Version: 1.0
In-Reply-To: <001101d10aaa$ca65c3c0$5f314b40$@gmail.com>
References: <56211F0D.2010806@...515...> <18065708.JIrWLiTMeq@...2001...>
	<ac7rqc.nwgq22.2u3ktu-qmf@...2076...>
	<2892922.l0hsuaC9oU@...2001...>
	<SN1PR08MB1391C6A8CA4653A464FAC48EB93A0@...2065...>
	<001101d10aaa$ca65c3c0$5f314b40$@gmail.com>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 19 Oct 2015 16:57:02 -0400
Message-ID: <CAKuzo_gOdaxDv0q5k=0mk=_gyvhtCN4w=FAanULT1fV1WVufaQ@...278...>
Content-Type: multipart/alternative; boundary=089e0122e9be496f5505227b642a
Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Fish Wang <fish.thss@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--089e0122e9be496f5505227b642a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2015 at 4:14 PM, Fish Wang <fish.thss@...277...> wrote:

> Regarding Windows OpenVPN GUI: I have an internal fork of this OpenVPN GUI
> (https://github.com/jochenwierum/openvpn-manager) from jochenwierum, with
> many bug fixes and improvements, and it works fairly well on Windows. May=
be
> I should tidy my patches and open source it on github?
>


That would be great, but eventually we need something more than bug fixes
and some improvements. The biggest problem with the present GUI is the need
to run it as administrator. A windows service exists but its not stable
enough and the GUI (I mean the official one) cannot control it in any
meaningful way. The so-called "new GUI" that is bundled with the windows
build is supposedly using the management interface but it can do that only
when the openvpn executable is started by the GUI itself.. That defeats
most of the advantages offered by the management interface.

I feel a framework such as the "interactive service" -- which is now and
again mentioned in the mailing lists but no idea what it is --- with new
GUI or a partial rewrite of the current one to effectively use the
management interface plus a stable service is needed. Alternatively the
current GUI could be adapted to use the "interactive service" if its ready
for prime time.

I can offer some coding/testing/debugging time but I've no real expertise
in windows programming or GUI in general. I'm an old style CLI guy who
wouldn't miss much if init is a symlink to vi or emacs:)

Selva


> Best,
> Fish
>
> -----Original Message-----
> From: Morris, Russell [mailto:rmorris@...1315...]
> Sent: Monday, October 19, 2015 7:59 AM
> To: Heiko Hund <heiko.hund@...1489...>; samuli@...515...
> Cc: openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?
>
> Hi,
>
> Just a couple thoughts here, from a (absolutely!) non-expert ... :-(.
>
> I have been trying to develop my own "GUI" - not because the current one
> doesn't work (not at all!), but because I want a bit of an extended featu=
re
> set ... to be able to change Tray Icon color with traffic (Tx/Rx), and pl=
ot
> ping timing to a remote machine over the link, and as well traffic and bit
> rate plots in the UL and DL.
>
> That all said, I can definitely see that the network adapter (TAP) and
> openvpn.exe really are up and down (a lot!) on Windows ... :-(. I am tryi=
ng
> to use NSSM to at least keep openvpn.exe up (i.e. restart it), but the
> network connection is a challenge also - often having to be reset (disabl=
ed
> and enabled). So to the question below ... yes, Windows does need some wo=
rk.
>
> I'd be happy to help out - but as above, I'm not an expert. So definitely
> willing, but usefulness may be questionable unfortunately ... ;-).
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
> > > > I'm thinking it might make sense to create a dedicated Windows team
> > > > that could share the burden of Windows issues amongst themselves,
> > > > without any one person gettings tagged the "Windows guy".
> > >
> > > Judging from the review the Windows patches received I think this
> might be
> > > an  too ambitious goal. Obviously not  many care besides the regulars
> who
> > > make a
> >
> > Anyways, not many seemed to care about about easy-rsa before it became a
> > separate project in GitHub. Now we have easy-rsa 3 by pekster and ecris=
t.
> > Similarly for openvpn-build we have/had Alon, pekster, me and syzzer. I=
'm
> > sure more examples could be found from other projects.
> >
> > I'm also not speaking primarily of Windows patches, but also all the
> other
> > stuff such as debugging, user support, ticket review, packaging, etc.
>
> Ok, I think here is the main misunderstanding. My understanding was that
> you
> want a Windows development team. That I think would be counter productive.
> For
> the other topics I do not have a opinion.
>
> > > > am working on a replacement for openvpnserv.exe.
> > >
> > > Please consider reviewing and improving the interactive service patch
> > > instead of duplicating work.
> >
> > Are you saying that the interactive service also doubles as a Windows
> system
> > service? If so, can it be  configured to autostart selected openvpn
> > connections on boot and restart them if they crash/stop?
>
> No, and I do not think that the service should take care of that. That's
> rather things that can be handled by the GUI.
>
> > Now, can anyone provide proof that having a Windows team would actually
> > _hurt_ the project? If not, what does it matter if it fails? We could
> just
> > scrap the idea retroactively.
>
> Hehe nice turn demanding proof, that'll shut up ppl. =3D)
>
> Heiko
>
>
> Sophos Technology GmbH, Amalienbadstra=E1=BA=9Ee 41/Bau 52, D-76227 Karls=
ruhe,
> Deutschland
> Tel +49 (0)721 25516 0 Fax +49 (0)721 25516 200 E-Mail info@...2075...
> www.sophos.de
> Sitz der Gesellschaft: Karlsruhe, Amtsgericht Mannheim HRB 712658
> Gesch=C3=A4ftsf=C3=BChrer: Nicholas Bray, Pino von Kienlin, Wolfgang Hilp=
ert,
> Jennifer Onslow.
> Sophos GmbH, Gustav-Stresemann-Ring 1, 65189 Wiesbaden, Deutschland
> Tel +49 (0) 611 5858-0 Fax +49 (0) 611 5858-1042 E-Mail info@...2075...
> www.sophos.de
> Sitz der Gesellschaft: Wiesbaden, Amtsgericht Wiesbaden HRB 25915
> Gesch=C3=A4ftsf=C3=BChrer: Nicholas Bray, Wolfgang Hilpert, Pino von Kien=
lin,
> Jennifer Onslow
>
>
> -------------------------------------------------------------------------=
-----
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
> -------------------------------------------------------------------------=
-----
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>
>
> -------------------------------------------------------------------------=
-----
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--089e0122e9be496f5505227b642a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Mon, Oct 19, 2015 at 4:14 PM, Fish Wang <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:fish.thss@...277..." target=3D"_blank">fish.thss@...277...</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Regarding Windows OpenV=
PN GUI: I have an internal fork of this OpenVPN GUI (<a href=3D"https://git=
hub.com/jochenwierum/openvpn-manager" rel=3D"noreferrer" target=3D"_blank">=
https://github.com/jochenwierum/openvpn-manager</a>) from jochenwierum, wit=
h many bug fixes and improvements, and it works fairly well on Windows. May=
be I should tidy my patches and open source it on github?<br></blockquote><=
div><br></div><div><br></div><div>That would be great, but eventually we ne=
ed something more than bug fixes and some improvements. The biggest problem=
 with the present GUI is the need to run it as administrator. A windows ser=
vice exists but its not stable enough and the GUI (I mean the official one)=
 cannot control it in any meaningful way. The so-called &quot;new GUI&quot;=
 that is bundled with the windows build is supposedly using the management =
interface but it can do that only when the openvpn executable is started by=
 the GUI itself.. That defeats most of the advantages offered by the manage=
ment interface.</div><div><br></div><div>I feel a framework such as the &qu=
ot;interactive service&quot; -- which is now and again mentioned in the mai=
ling lists but no idea what it is --- with new GUI or a partial rewrite of =
the current one to effectively use the management interface plus a stable s=
ervice is needed. Alternatively the current GUI could be adapted to use the=
 &quot;interactive service&quot; if its ready for prime time.</div><div><br=
></div><div>I can offer some coding/testing/debugging time but I&#39;ve no =
real expertise in windows programming or GUI in general. I&#39;m an old sty=
le CLI guy who wouldn&#39;t miss much if init is a symlink to vi or emacs:)=
</div><div><br></div><div>Selva</div><div><br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
<br>
Best,<br>
Fish<br>
<br>
-----Original Message-----<br>
From: Morris, Russell [mailto:<a href=3D"mailto:rmorris@...1315...">rmorris=
@...1315...</a>]<br>
Sent: Monday, October 19, 2015 7:59 AM<br>
To: Heiko Hund &lt;<a href=3D"mailto:heiko.hund@...1489...">heiko.hund@...1386...=
489...</a>&gt;; <a href=3D"mailto:samuli@...515...">samuli@...515...</a><br>
Cc: <a href=3D"mailto:openvpn-devel@lists.sourceforge.net">openvpn-devel@...1224...=
sts.sourceforge.net</a><br>
Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?<br>
<br>
Hi,<br>
<br>
Just a couple thoughts here, from a (absolutely!) non-expert ... :-(.<br>
<br>
I have been trying to develop my own &quot;GUI&quot; - not because the curr=
ent one doesn&#39;t work (not at all!), but because I want a bit of an exte=
nded feature set ... to be able to change Tray Icon color with traffic (Tx/=
Rx), and plot ping timing to a remote machine over the link, and as well tr=
affic and bit rate plots in the UL and DL.<br>
<br>
That all said, I can definitely see that the network adapter (TAP) and open=
vpn.exe really are up and down (a lot!) on Windows ... :-(. I am trying to =
use NSSM to at least keep openvpn.exe up (i.e. restart it), but the network=
 connection is a challenge also - often having to be reset (disabled and en=
abled). So to the question below ... yes, Windows does need some work.<br>
<span class=3D""><br>
I&#39;d be happy to help out - but as above, I&#39;m not an expert. So defi=
nitely willing, but usefulness may be questionable unfortunately ... ;-).<b=
r>
<br>
</span>Thanks!<br>
<br>
... Russell<br>
<br>
<br>
<br>
-----Original Message-----<br>
From: Heiko Hund [mailto:<a href=3D"mailto:heiko.hund@...1489...">heiko.hun=
d@...1489...</a>]<br>
Sent: Monday, October 19, 2015 9:16 AM<br>
To: <a href=3D"mailto:samuli@...515...">samuli@...515...</a><br>
Cc: <a href=3D"mailto:openvpn-devel@lists.sourceforge.net">openvpn-devel@...1224...=
sts.sourceforge.net</a><br>
Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?<br>
<br>
On Monday 19 October 2015 10:20:23 <a href=3D"mailto:samuli@...515...">samu=
li@...515...</a> wrote:<br>
&gt; &gt; &gt; I&#39;m thinking it might make sense to create a dedicated W=
indows team<br>
&gt; &gt; &gt; that could share the burden of Windows issues amongst themse=
lves,<br>
&gt; &gt; &gt; without any one person gettings tagged the &quot;Windows guy=
&quot;.<br>
&gt; &gt;<br>
&gt; &gt; Judging from the review the Windows patches received I think this=
 might be<br>
&gt; &gt; an=C2=A0 too ambitious goal. Obviously not=C2=A0 many care beside=
s the regulars who<br>
&gt; &gt; make a<br>
&gt;<br>
&gt; Anyways, not many seemed to care about about easy-rsa before it became=
 a<br>
&gt; separate project in GitHub. Now we have easy-rsa 3 by pekster and ecri=
st.<br>
&gt; Similarly for openvpn-build we have/had Alon, pekster, me and syzzer. =
I&#39;m<br>
&gt; sure more examples could be found from other projects.<br>
&gt;<br>
&gt; I&#39;m also not speaking primarily of Windows patches, but also all t=
he other<br>
&gt; stuff such as debugging, user support, ticket review, packaging, etc.<=
br>
<br>
Ok, I think here is the main misunderstanding. My understanding was that yo=
u<br>
want a Windows development team. That I think would be counter productive. =
For<br>
the other topics I do not have a opinion.<br>
<br>
&gt; &gt; &gt; am working on a replacement for openvpnserv.exe.<br>
&gt; &gt;<br>
&gt; &gt; Please consider reviewing and improving the interactive service p=
atch<br>
&gt; &gt; instead of duplicating work.<br>
&gt;<br>
&gt; Are you saying that the interactive service also doubles as a Windows =
system<br>
&gt; service? If so, can it be=C2=A0 configured to autostart selected openv=
pn<br>
&gt; connections on boot and restart them if they crash/stop?<br>
<br>
No, and I do not think that the service should take care of that. That&#39;=
s<br>
rather things that can be handled by the GUI.<br>
<br>
&gt; Now, can anyone provide proof that having a Windows team would actuall=
y<br>
&gt; _hurt_ the project? If not, what does it matter if it fails? We could =
just<br>
&gt; scrap the idea retroactively.<br>
<br>
Hehe nice turn demanding proof, that&#39;ll shut up ppl. =3D)<br>
<br>
Heiko<br>
<br>
<br>
Sophos Technology GmbH, Amalienbadstra=E1=BA=9Ee 41/Bau 52, D-76227 Karlsru=
he, Deutschland<br>
Tel <a href=3D"tel:%2B49%20%280%29721%2025516%200" value=3D"+49721255160">+=
49 (0)721 25516 0</a> Fax <a href=3D"tel:%2B49%20%280%29721%2025516%20200" =
value=3D"+4972125516200">+49 (0)721 25516 200</a> E-Mail <a href=3D"mailto:=
info@...2075...">info@...2075...</a> <a href=3D"http://www.sophos.de" rel=
=3D"noreferrer" target=3D"_blank">www.sophos.de</a><br>
Sitz der Gesellschaft: Karlsruhe, Amtsgericht Mannheim HRB 712658<br>
Gesch=C3=A4ftsf=C3=BChrer: Nicholas Bray, Pino von Kienlin, Wolfgang Hilper=
t, Jennifer Onslow.<br>
Sophos GmbH, Gustav-Stresemann-Ring 1, 65189 Wiesbaden, Deutschland<br>
Tel <a href=3D"tel:%2B49%20%280%29%20611%205858-0" value=3D"+4961158580">+4=
9 (0) 611 5858-0</a> Fax <a href=3D"tel:%2B49%20%280%29%20611%205858-1042" =
value=3D"+4961158581042">+49 (0) 611 5858-1042</a> E-Mail <a href=3D"mailto=
:info@...2075...">info@...2075...</a> <a href=3D"http://www.sophos.de" rel=
=3D"noreferrer" target=3D"_blank">www.sophos.de</a><br>
Sitz der Gesellschaft: Wiesbaden, Amtsgericht Wiesbaden HRB 25915 Gesch=C3=
=A4ftsf=C3=BChrer: Nicholas Bray, Wolfgang Hilpert, Pino von Kienlin, Jenni=
fer Onslow<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
---------------------------------------------------------------------------=
---<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
---------------------------------------------------------------------------=
---<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
<br>
<br>
---------------------------------------------------------------------------=
---<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</div></div></blockquote></div><br></div></div>

--089e0122e9be496f5505227b642a--

