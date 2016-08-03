MIME-Version: 1.0
In-Reply-To: <57A0EE6F.4080905@...277...>
References: <57A078C9.6030309@...277...>
	<20160802112242.GW78279@...1296...>
	<57A0954A.804@...277...> <57A0BE14.3080809@...277...>
	<20160802165900.GY78279@...1296...>
	<57A0EE6F.4080905@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 2 Aug 2016 21:03:20 -0400
Message-ID: <CAKuzo_iq4x2gyCzaeQS7Z2cShzCfRr4Qz4wAce=DfYhmUH4OtQ@...278...>
Content-Type: multipart/alternative; boundary=001a1147a44875bb7e05392067c5
Subject: Re: [Openvpn-devel] Auto-create Windows Firewall Rule
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1147a44875bb7e05392067c5
Content-Type: text/plain; charset=UTF-8

On Tue, Aug 2, 2016 at 3:03 PM, debbie10t <debbie10t@...277...> wrote:

> On 02/08/16 17:59, Gert Doering wrote:
> > Hi,
> >
> > On Tue, Aug 02, 2016 at 04:36:52PM +0100, debbie10t wrote:
> >> Win10pro OVPN Server - Openvpn snapshot version
> >> 2.3_git-I601 20160518 refs/heads/master/0d8a4ffa2293dda8
> >>
> >> Mixture of clients IPv4+6 wxp/w7/w10/various linux
> >>
> >> IPv4 & IPv6 All works well!
> > Cool.  Thanks :-)
> >
> > (That snapshot is getting a bit old in the tooth, tho...)
> >
> It was not my first concern, however ..
>
> Uninstalled that version and installed this version:
> openvpn-install-release-2.3-20160726162312-d1c08ab136-x86_64.exe
> (Including TAP removal/Reinstall win10)
>
> All went well, the full un/re-install completed
> before some IRC sessions even timed-out ! Outstanding :-)
>
> Also, testing using the GUI + new Interactive service
> (tho normally I would use the old service or nssm)


Could you also test running a server using the interactive service (i.e.,
without any admin rights)? Currently the only easy way to do this is to
start a server config using the GUI. The server will get killed when the
GUI exits but good enough for testing.

I am interested in writing a launcher that uses the interactive service for
such needs. Although, in theory, it should just work, running the server
this way has hardly been tested.

Thanks,

Selva

--001a1147a44875bb7e05392067c5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Aug 2, 2016 at 3:03 PM, debbie10t <span dir=3D"ltr">&lt;<a href=3D"=
mailto:debbie10t@...277..." target=3D"_blank">debbie10t@...277...</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><span>On 02/08/16 17:59, Ger=
t Doering wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; On Tue, Aug 02, 2016 at 04:36:52PM +0100, debbie10t wrote:<br>
&gt;&gt; Win10pro OVPN Server - Openvpn snapshot version<br>
&gt;&gt; 2.3_git-I601 20160518 refs/heads/master/0d8a4ffa2293dda8<br>
&gt;&gt;<br>
&gt;&gt; Mixture of clients IPv4+6 wxp/w7/w10/various linux<br>
&gt;&gt;<br>
&gt;&gt; IPv4 &amp; IPv6 All works well!<br>
&gt; Cool.=C2=A0 Thanks :-)<br>
&gt;<br>
&gt; (That snapshot is getting a bit old in the tooth, tho...)<br>
&gt;<br>
</span>It was not my first concern, however ..<br>
<br>
Uninstalled that version and installed this version:<br>
openvpn-install-release-2.3-20160726162312-d1c08ab136-x86_64.exe<br>
(Including TAP removal/Reinstall win10)<br>
<br>
All went well, the full un/re-install completed<br>
before some IRC sessions even timed-out ! Outstanding :-)<br>
<br>
Also, testing using the GUI + new Interactive service<br>
(tho normally I would use the old service or nssm)</blockquote></div><br>Co=
uld you also test running a server using the interactive service (i.e., wit=
hout any admin rights)? Currently the only easy way to do this is to start =
a server config using the GUI. The server will get killed when the GUI exit=
s but good enough for testing.<br><br>I am interested in writing a launcher=
 that uses the interactive service for such needs. Although, in theory, it =
should just work, running the server this way has hardly been tested.<br><b=
r></div><div class=3D"gmail_extra">Thanks,</div><div class=3D"gmail_extra">=
<br></div><div class=3D"gmail_extra">Selva</div></div>

--001a1147a44875bb7e05392067c5--

