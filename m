MIME-Version: 1.0
In-Reply-To: <20180605184024.GO57262@...1296...>
References: <CAJY0qZKNO_aamQfi56BG_XK2vrOCyPAQf-My1N56qqV7TsUG7A@...278...>
 <eaae68e6-e30d-f63b-59c5-64515c8f8bcd@...1147...>
 <e4a2d28a-ff8d-4797-e0af-3bcf98828cb3@...1856...>
 <CAJY0qZKw+HgQ1vS-W13nw2=gj8d-uxeOqyZia4-gEbaGNTyFLQ@...278...>
 <03a13b39-7b85-0b67-cc94-7b219e6b209f@...1147...>
 <49b53be0-a301-8447-2a0e-0534435e5e87@...1147...>
 <CAJY0qZ+_kEVS_41oOHNX=Wp47LnNhL0HKRZvR75eg7JNW3tLkQ@...278...>
 <20180605184024.GO57262@...1296...>
From: Derek Zimmer <derek@...2095...>
Date: Tue, 5 Jun 2018 20:05:40 -0500
Message-ID: <CAJY0qZ+r_fHPW-+BAmj2=2qS=k7vQS+Bto0aHE7EDwcgtdaniA@...278...>
Content-Type: multipart/alternative; boundary="000000000000f2affb056deec3a6"
Subject: Re: [Openvpn-devel] Does the OpenVPN protocol itself handle
 windowing?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Jan Just Keijser <janjust@...1147...>, openvpn-devel@lists.sourceforge.net

--000000000000f2affb056deec3a6
Content-Type: text/plain; charset="UTF-8"

Gert,

The openvpn protocol does error checking and recovery on the data channel,
right? How is that handled? Or am I mistaken and it is all handled through
the regular TCP protocol that is operating inside of the VPN tunnel.

Derek Zimmer
Chief Executive Officer
Open Source Technology Improvement Fund

On Tue, Jun 5, 2018 at 1:40 PM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Tue, Jun 05, 2018 at 10:23:29AM -0500, Derek Zimmer wrote:
> > OpenVPN in UDP mode is still operating a TCP windowing layer
> > somewhere, right?
>
> Not for data packets - they get sent off as they come in from the
> tun file descriptor and vice versa.  No pacing (unless configured),
> no windowing, no retransmits.
>
> Of course the OS' TCP layer still applies, but that one *should* not
> scale (much) worse via tun than via direct IP.
>
> In any case it's good to see people (who are not me) interested in
> performance measurements, and performance improvements.  You can't
> improve what you do not understand, and you can't understand what
> you do not measure...  (yes, I studied physics as well :) ).
>
> gert
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never
> doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh
> Mistress
>
> Gert Doering - Munich, Germany
> gert@...1296...
>

--000000000000f2affb056deec3a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Gert,</div><div><br></div><div>The openvpn protocol d=
oes error checking and recovery on the data channel, right? How is that han=
dled? Or am I mistaken and it is all handled through the regular TCP protoc=
ol that is operating inside of the VPN tunnel.<br></div></div><div class=3D=
"gmail_extra"><br clear=3D"all"><div><div class=3D"gmail_signature" data-sm=
artmail=3D"gmail_signature">Derek Zimmer<br>Chief Executive Officer<br>Open=
 Source Technology Improvement Fund</div></div>
<br><div class=3D"gmail_quote">On Tue, Jun 5, 2018 at 1:40 PM, Gert Doering=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank"=
>gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi=
,<br>
<span class=3D""><br>
On Tue, Jun 05, 2018 at 10:23:29AM -0500, Derek Zimmer wrote:<br>
&gt; OpenVPN in UDP mode is still operating a TCP windowing layer <br>
&gt; somewhere, right? <br>
<br>
</span>Not for data packets - they get sent off as they come in from the <b=
r>
tun file descriptor and vice versa.=C2=A0 No pacing (unless configured), <b=
r>
no windowing, no retransmits.<br>
<br>
Of course the OS&#39; TCP layer still applies, but that one *should* not<br>
scale (much) worse via tun than via direct IP.<br>
<br>
In any case it&#39;s good to see people (who are not me) interested in<br>
performance measurements, and performance improvements.=C2=A0 You can&#39;t=
<br>
improve what you do not understand, and you can&#39;t understand what<br>
you do not measure...=C2=A0 (yes, I studied physics as well :) ).<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
gert<br>
-- <br>
&quot;If was one thing all people took for granted, was conviction that if =
you <br>
=C2=A0feed honest figures into a computer, honest figures come out. Never d=
oubted <br>
=C2=A0it myself till I met a computer with a sense of humor.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Robert A. Heinlein, The Moon is a Harsh Mist=
ress<br>
<br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296...">gert@...1296...</a><br>
</font></span></blockquote></div><br></div>

--000000000000f2affb056deec3a6--

