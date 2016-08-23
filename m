MIME-Version: 1.0
In-Reply-To: <CAKuzo_ihbe4TkTxxQOk60JSBB27u25wE1Fk-_iQg7qRjcYxL6A@...278...>
References: <CAKuzo_jO0FLo=xMakh1yB6_h=huE4Pqp6Xtk2QEgXikeui-F6w@...278...>
	<073f348b-77a8-3967-2874-77f2c973dbf4@...2070...>
	<CAKuzo_goKiVr4k7+eQbLK93fzQ99ZH+pkk1uVw0k2_OGb0mH4A@...278...>
	<CAKuzo_jRJcTGWRqv51O3TPc7rU=8aomQqFeib0FF_G-dtUmeQg@...278...>
	<20160823204435.GH78279@...1296...>
	<CAKuzo_ihbe4TkTxxQOk60JSBB27u25wE1Fk-_iQg7qRjcYxL6A@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 23 Aug 2016 17:01:11 -0400
Message-ID: <CAKuzo_isFN_3jGYL1jv0KgquyJzJXToiycEcB5d_zYC1eYmzaw@...278...>
Content-Type: multipart/alternative; boundary=94eb2c0a879a29ddf6053ac378cc
Subject: [Openvpn-devel] Fwd:  block-outside-dns and multiple tunnels
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c0a879a29ddf6053ac378cc
Content-Type: text/plain; charset=UTF-8

As usual forgot Cc: list

---------- Forwarded message ----------
From: Selva Nair <selva.nair@...277...>
Date: Tue, Aug 23, 2016 at 4:57 PM
Subject: Re: [Openvpn-devel] block-outside-dns and multiple tunnels
To: Gert Doering <gert@...1296...>



On Tue, Aug 23, 2016 at 4:44 PM, Gert Doering <gert@...1296...> wrote:

> On Tue, Aug 23, 2016 at 11:23:29AM -0400, Selva Nair wrote:
> > It was agreed to move this forward by looking into the approaches
> > suggested by Selva, and by giving him feedback.
> >
> > So what is the consensus? Should we support DNS through all tunnels for
> > which block-outside-dns is specified or just make sure DNS works through
> at
> > least one of the tunnels if the option is used on multiple ones?
>
> "principle of least astonishment" (POLA) would be "DNS inside the tunnels
> works, outside the tunnels doesn't, no matter which tunnel was opened
> first.  "DNS does not work at all" is the worst variant, because a normal
> user (including most "client admins") will not be able to see why this
> would be happening - I can already see this with normal users, Win10 and
> OpenVPN that they never attribute to DNS failures if "outlook does not
> work"...
>
> You had some suggestions upthread how to change the WFP stuff to make
> it cooperate (and perform) better - so "feature-ACK" on that approach :-)


I did make a patch along those lines and appears to work fine. Will do some
more testing before I post it.

Fully respecting "least surprise" is hard, though. Consider this:

1. Two tunnels both  with block-outside-dns: my approach will support dns
through both and that sounds not surprising

2. Two tunnels, one says block-outside-dns, the other doesn't: in my
planned approach the first one will block DNS thorough all interfaces
except itself, the second one will not add any firewall rules. So dns will
work through tunnel 1, not through tunnel 2. That may surprise some.

To resolve this every openvpn tunnel will have to add a "permit dns through
my tunnel interface" rule no matter block-outside-dns is specified or not.
Eventually it boils down to what is meant by "outside".

Selva

--94eb2c0a879a29ddf6053ac378cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">As usual forgot Cc: list<div><br><div class=3D"gmail_quote=
">---------- Forwarded message ----------<br>From: <b class=3D"gmail_sender=
name">Selva Nair</b> <span dir=3D"ltr">&lt;<a href=3D"mailto:selva.nair@...493...=
277...">selva.nair@...277...</a>&gt;</span><br>Date: Tue, Aug 23, 2016 at 4=
:57 PM<br>Subject: Re: [Openvpn-devel] block-outside-dns and multiple tunne=
ls<br>To: Gert Doering &lt;<a href=3D"mailto:gert@...1296...">gert@...1725...=
..</a>&gt;<br><br><br><div dir=3D"ltr"><div class=3D"gmail_extra"><span cla=
ss=3D""><br><div class=3D"gmail_quote">On Tue, Aug 23, 2016 at 4:44 PM, Ger=
t Doering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=
=3D"_blank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><span>On Tue, Aug 23, 2016 at 11:23:29AM -0400, Selva Nair wrote:<=
br>
&gt; It was agreed to move this forward by looking into the approaches<br>
&gt; suggested by Selva, and by giving him feedback.<br>
&gt;<br>
&gt; So what is the consensus? Should we support DNS through all tunnels fo=
r<br>
&gt; which block-outside-dns is specified or just make sure DNS works throu=
gh at<br>
&gt; least one of the tunnels if the option is used on multiple ones?<br>
<br>
</span>&quot;principle of least astonishment&quot; (POLA) would be &quot;DN=
S inside the tunnels<br>
works, outside the tunnels doesn&#39;t, no matter which tunnel was opened<b=
r>
first.=C2=A0 &quot;DNS does not work at all&quot; is the worst variant, bec=
ause a normal<br>
user (including most &quot;client admins&quot;) will not be able to see why=
 this<br>
would be happening - I can already see this with normal users, Win10 and<br>
OpenVPN that they never attribute to DNS failures if &quot;outlook does not=
<br>
work&quot;...<br>
<br>
You had some suggestions upthread how to change the WFP stuff to make<br>
it cooperate (and perform) better - so &quot;feature-ACK&quot; on that appr=
oach :-)</blockquote></div><br></span>I did make a patch along those lines =
and appears to work fine. Will do some more testing before I post it.</div>=
<div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Fully respe=
cting &quot;least surprise&quot; is hard, though. Consider this:</div><div =
class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">1. Two tunnels b=
oth =C2=A0with block-outside-dns: my approach will support dns through both=
 and that sounds not surprising</div><div class=3D"gmail_extra"><br></div><=
div class=3D"gmail_extra">2. Two tunnels, one says block-outside-dns, the o=
ther doesn&#39;t: in my planned approach the first one will block DNS thoro=
ugh all interfaces except itself, the second one will not add any firewall =
rules. So dns will work through tunnel 1, not through tunnel 2. That may su=
rprise some.</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_=
extra">To resolve this every openvpn tunnel will have to add a &quot;permit=
 dns through my tunnel interface&quot; rule no matter block-outside-dns is =
specified or not. Eventually it boils down to what is meant by &quot;outsid=
e&quot;.</div><span class=3D"HOEnZb"><font color=3D"#888888"><div class=3D"=
gmail_extra"><br></div><div class=3D"gmail_extra">Selva</div></font></span>=
</div>
</div><br></div></div>

--94eb2c0a879a29ddf6053ac378cc--

