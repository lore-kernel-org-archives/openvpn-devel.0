MIME-Version: 1.0
In-Reply-To: <f9668ae4-0e98-53af-35d1-db3006ce308d@...515...>
References: <CAKuzo_hFT3vXnNn46ubhQiV0zwjg_0uyyMyVtNq2OZeYsq3TuQ@...278...>
	<08d5f483-cc64-b708-a54c-29cfb2c7880e@...277...>
	<CAKuzo_jFHw1k0M0WfU8WsiTaZDYNE9+K=2=41g_oHqLikydo1w@...278...>
	<ad8c62af-5534-79d7-11ff-56cf51888615@...277...>
	<CAKuzo_iBnazFOMGaCDO-ga_ONCN=wb6818syt+S66S_OKZDoCw@...278...>
	<f9668ae4-0e98-53af-35d1-db3006ce308d@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 12 Dec 2016 13:14:41 +0500
Message-ID: <CAFHpkQEnak3u_E7_p0o+sxUM5W1_miVWMbsVjeZo1gT=h4iPpg@...278...>
Content-Type: multipart/alternative; boundary=001a11417a9a1a0718054371b297
Subject: Re: [Openvpn-devel] On saving passwords
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11417a9a1a0718054371b297
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2016-12-12 13:09 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

> Il 11/12/2016 19:52, Selva Nair ha scritto:
> >
> > On Sun, Dec 11, 2016 at 12:00 PM, debbie10t <debbie10t@...277...
> > <mailto:debbie10t@...277...>> wrote:
> >
> >     What happens if a remote user, who has admin access to their own
> >     computer, connects to a work VPN but they decide to change said
> config ?
> >
> >
> > A user who has admin access to their own computer can do anything to it:
> > including saving VPN passwords. Why would openvpn stop them doing that?
> > The question was about a sysadmin of an office not allowing their users
> > to save their openvpn passwords in an automated way. There is no way of
> > ensuring that if the user has admin access on their devices. Note that
> > password is saved on the client, not the server.
>
> There are many ways to circumvent password saving restrictions if the
> enforcement is supposed to happen on the client side.
>
> Some years back I used xdotool[1] to manage keyboard input and mouse
> movements to automate otherwise unautomateable things. While it's a
> crude approach, it could be easily used to automate password typing and
> mouse clicks. I'm sure similar tools are available for Windows.
>

https://www.autoitscript.com/site/autoit/


>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
> [1] <http://semicomplete.com/projects/xdotool>
>
>
> ------------------------------------------------------------
> ------------------
> Developer Access Program for Intel Xeon Phi Processors
> Access to Intel Xeon Phi processor-based developer platforms.
> With one year of Intel Parallel Studio XE.
> Training and support from Colfax.
> Order your platform today.http://sdm.link/xeonphi
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--001a11417a9a1a0718054371b297
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-12-12 13:09 GMT+05:00 Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<=
a target=3D"_blank" href=3D"mailto:samuli@...515...">samuli@...515...</a>&g=
t;</span>:<br><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote">Il 11/12/20=
16 19:52, Selva Nair ha scritto:<br>
&gt;<br>
&gt; On Sun, Dec 11, 2016 at 12:00 PM, debbie10t &lt;<a href=3D"mailto:debb=
ie10t@...277...">debbie10t@...277...</a><br>
&gt; &lt;mailto:<a href=3D"mailto:debbie10t@...277...">debbie10t@...277...<=
/a>&gt;&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0What happens if a remote user, who has admin access=
 to their own<br>
&gt;=C2=A0 =C2=A0 =C2=A0computer, connects to a work VPN but they decide to=
 change said config ?<br>
&gt;<br>
&gt;<br>
&gt; A user who has admin access to their own computer can do anything to i=
t:<br>
&gt; including saving VPN passwords. Why would openvpn stop them doing that=
?<br>
&gt; The question was about a sysadmin of an office not allowing their user=
s<br>
&gt; to save their openvpn passwords in an automated way. There is no way o=
f<br>
&gt; ensuring that if the user has admin access on their devices. Note that=
<br>
&gt; password is saved on the client, not the server.<br>
<br>
There are many ways to circumvent password saving restrictions if the<br>
enforcement is supposed to happen on the client side.<br>
<br>
Some years back I used xdotool[1] to manage keyboard input and mouse<br>
movements to automate otherwise unautomateable things. While it&#39;s a<br>
crude approach, it could be easily used to automate password typing and<br>
mouse clicks. I&#39;m sure similar tools are available for Windows.<br></bl=
ockquote><div><br><a href=3D"https://www.autoitscript.com/site/autoit/">htt=
ps://www.autoitscript.com/site/autoit/</a><br>=C2=A0</div><blockquote style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex" class=3D"gmail_quote">
<br>
--<br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
<br>
[1] &lt;<a target=3D"_blank" rel=3D"noreferrer" href=3D"http://semicomplete=
.com/projects/xdotool">http://semicomplete.com/<wbr>projects/xdotool</a>&gt=
;<br>
<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
Developer Access Program for Intel Xeon Phi Processors<br>
Access to Intel Xeon Phi processor-based developer platforms.<br>
With one year of Intel Parallel Studio XE.<br>
Training and support from Colfax.<br>
Order your platform today.<a target=3D"_blank" rel=3D"noreferrer" href=3D"h=
ttp://sdm.link/xeonphi">http://sdm.link/xeonphi</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a target=3D"_blank" rel=3D"noreferrer" href=3D"https://lists.sourceforge.n=
et/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/<wbr>lists/l=
istinfo/openvpn-devel</a><br>
</blockquote></div><br></div></div>

--001a11417a9a1a0718054371b297--

