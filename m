MIME-Version: 1.0
References: <BL0PR2101MB1058B863878E4C9740E1B125AB540@...2440...>
 <20180725180018.GA55859@...1296...>
 <BL0PR2101MB1058707381F501AFB7FFA9AAAB540@...2440...>
 <20180725181752.GC55859@...1296...>
 <BL0PR2101MB10584E9CAAA6B7E508971E00AB540@...2440...>
In-Reply-To: <BL0PR2101MB10584E9CAAA6B7E508971E00AB540@...2440...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 26 Jul 2018 01:18:19 +0500
Message-ID: <CAFHpkQEUVMg6LwZ-34FnghHGsn2KGRhBNmVPADE6+ssjxxGHdQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000001016a00571d89570"
Subject: Re: [Openvpn-devel] [PATCH] [openvpn-gui] Update system tray to
 populate Windows VPN flyout
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: kkane@...2393...
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000001016a00571d89570
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 26 =D0=B8=D1=8E=D0=BB. 2018 =D0=B3. =D0=B2 1:04, Kevin Kane v=
ia Openvpn-devel <
openvpn-devel@lists.sourceforge.net>:

> Alright, I found the SMTP server and sent the patches out again with git
> send-email. Let me know how those look.
>


looks good from patchwork point of view:

https://patchwork.openvpn.net/project/openvpn2/list/


>
> -----Original Message-----
> From: Gert Doering <gert@...1296...>
> Sent: Wednesday, July 25, 2018 11:18 AM
> To: Kevin Kane <kkane@...2393...>
> Cc: Gert Doering <gert@...1296...>; openvpn-devel <
> openvpn-devel@lists.sourceforge.net>
> Subject: Re: [Openvpn-devel] [PATCH] [openvpn-gui] Update system tray to
> populate Windows VPN flyout
>
> Hi,
>
> On Wed, Jul 25, 2018 at 06:08:19PM +0000, Kevin Kane wrote:
> > Ugh. Thanks, Outlook. I'd have to use a personal e-mail account to use
> something other than Exchange.
> >
> > The other option is for me to add the files to the e-mail as
> attachments. Is that acceptable, or do you really need the patch text to =
be
> in the message body?
>
> For applying with "git am" and for reviewing with "I can just quote parts
> of the patch and comment on it", attachments in anything that is not
> text/plain format are also not ideal, but we can try that.
>
> We've had a few patches come in recently that were attachment in a signed
> mail, and neither patchwork nor git could handle these mails in a
> satisfying way - as in: patchwork did not recognize them as "patch", and
> "git am" declared "no patch in there" - so "save patch as individual file,
> git am, manually add in-reply-to to the auto- generated "patch applied"
> reply mail, etc.
>
> It's a bit of try and error what works in a given environment.
>
> (git send-email talking SMTP to Exchange might actually work more nicely
> than outlook.  Maybe that was just one particularily weird version of
> Exchange, or "too many virus scanner plugins hooked in", given that this
> was Sophos...)
>
> gert
>
> --
> "If was one thing all people took for granted, was conviction that if you
> feed honest figures into a computer, honest figures come out. Never
> doubted  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh
> Mistress
>
> Gert Doering - Munich, Germany
> gert@...1296...
>
>
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--0000000000001016a00571d89570
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">=D1=87=
=D1=82, 26 =D0=B8=D1=8E=D0=BB. 2018 =D0=B3. =D0=B2 1:04, Kevin Kane via Ope=
nvpn-devel &lt;<a href=3D"mailto:openvpn-devel@lists.sourceforge.net">openv=
pn-devel@lists.sourceforge.net</a>&gt;:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">Alright, I found the SMTP server and sent the patch=
es out again with git send-email. Let me know how those look.<br></blockquo=
te><div><br></div><div><br></div><div>looks good from patchwork point of vi=
ew:</div><div><br></div><div><a href=3D"https://patchwork.openvpn.net/proje=
ct/openvpn2/list/">https://patchwork.openvpn.net/project/openvpn2/list/</a>=
<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
<br>
-----Original Message-----<br>
From: Gert Doering &lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank"=
>gert@...1296...</a>&gt; <br>
Sent: Wednesday, July 25, 2018 11:18 AM<br>
To: Kevin Kane &lt;<a href=3D"mailto:kkane@...2393..." target=3D"_blank">kk=
ane@...2393...</a>&gt;<br>
Cc: Gert Doering &lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">g=
ert@...1296...</a>&gt;; openvpn-devel &lt;<a href=3D"mailto:openvpn-devel@...465...=
ists.sourceforge.net" target=3D"_blank">openvpn-devel@lists.sourceforge.net=
</a>&gt;<br>
Subject: Re: [Openvpn-devel] [PATCH] [openvpn-gui] Update system tray to po=
pulate Windows VPN flyout<br>
<br>
Hi,<br>
<br>
On Wed, Jul 25, 2018 at 06:08:19PM +0000, Kevin Kane wrote:<br>
&gt; Ugh. Thanks, Outlook. I&#39;d have to use a personal e-mail account to=
 use something other than Exchange.<br>
&gt; <br>
&gt; The other option is for me to add the files to the e-mail as attachmen=
ts. Is that acceptable, or do you really need the patch text to be in the m=
essage body?<br>
<br>
For applying with &quot;git am&quot; and for reviewing with &quot;I can jus=
t quote parts of the patch and comment on it&quot;, attachments in anything=
 that is not text/plain format are also not ideal, but we can try that.<br>
<br>
We&#39;ve had a few patches come in recently that were attachment in a sign=
ed mail, and neither patchwork nor git could handle these mails in a satisf=
ying way - as in: patchwork did not recognize them as &quot;patch&quot;, an=
d &quot;git am&quot; declared &quot;no patch in there&quot; - so &quot;save=
 patch as individual file, git am, manually add in-reply-to to the auto- ge=
nerated &quot;patch applied&quot; reply mail, etc.<br>
<br>
It&#39;s a bit of try and error what works in a given environment.<br>
<br>
(git send-email talking SMTP to Exchange might actually work more nicely th=
an outlook.=C2=A0 Maybe that was just one particularily weird version of Ex=
change, or &quot;too many virus scanner plugins hooked in&quot;, given that=
 this was Sophos...)<br>
<br>
gert<br>
<br>
--<br>
&quot;If was one thing all people took for granted, was conviction that if =
you=C2=A0 feed honest figures into a computer, honest figures come out. Nev=
er doubted=C2=A0 it myself till I met a computer with a sense of humor.&quo=
t;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Robert A. Heinlein, The Moon is a Harsh Mist=
ress<br>
<br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296..." target=3D"_blank">gert@...1296...</a><br>
<br>
---------------------------------------------------------------------------=
---<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div></div>

--0000000000001016a00571d89570--

