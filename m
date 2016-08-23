MIME-Version: 1.0
In-Reply-To: <20160823204653.GI78279@...1296...>
References: <CAKuzo_jO0FLo=xMakh1yB6_h=huE4Pqp6Xtk2QEgXikeui-F6w@...278...>
	<20160823204653.GI78279@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 23 Aug 2016 17:00:15 -0400
Message-ID: <CAKuzo_iYko1ZdGaZbUagsn5ra4FKxKfEJWvZ0XrTggD24E+O4A@...278...>
Content-Type: multipart/alternative; boundary=001a1141ca48c7648f053ac37469
Subject: Re: [Openvpn-devel] block-outside-dns and multiple tunnels
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1141ca48c7648f053ac37469
Content-Type: text/plain; charset=UTF-8

On Tue, Aug 23, 2016 at 4:46 PM, Gert Doering <gert@...1296...> wrote:

> On Sat, Aug 06, 2016 at 12:04:39AM -0400, Selva Nair wrote:
> [..]
> > 2. Add all filters to a common custom sublayer. This requires a
> pre-defined
> > UUID that could be used to define the sublayer and shared between all
> > instances of openvpn.
> >
> > For UUID,
> [..]
> > (b) hard code a UUID in the executable and use it as the sublayer key
> >
> > I prefer (b) as its simpler.
>
> 2b sounds like the way to get there with the least amount of work, and
> without interfering with other folks...
>
> Are there some sort of guidelines how "hard coded UUIDs" are to be used?
> Or
> do you just randomly pick a large number out of your hat?
>

I used uuidgen -t on my linux machine to create one. That should be unique
as -t uses timestamp and MAC address to create it. If there is a better
way, please let me know.

Selva

--001a1141ca48c7648f053ac37469
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Aug 23, 2016 at 4:46 PM, Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div id=3D":dkk" class=3D"a3s aX=
jCH m156b927e31ecee7b">On Sat, Aug 06, 2016 at 12:04:39AM -0400, Selva Nair=
 wrote:<br>
[..]<br>
<span class=3D"">&gt; 2. Add all filters to a common custom sublayer. This =
requires a pre-defined<br>
&gt; UUID that could be used to define the sublayer and shared between all<=
br>
&gt; instances of openvpn.<br>
&gt;<br>
&gt; For UUID,<br>
</span>[..]<br>
<span class=3D"">&gt; (b) hard code a UUID in the executable and use it as =
the sublayer key<br>
&gt;<br>
&gt; I prefer (b) as its simpler.<br>
<br>
</span>2b sounds like the way to get there with the least amount of work, a=
nd<br>
without interfering with other folks...<br>
<br>
Are there some sort of guidelines how &quot;hard coded UUIDs&quot; are to b=
e used?=C2=A0 Or<br>
do you just randomly pick a large number out of your hat?</div></blockquote=
></div><br>I used uuidgen -t on my linux machine to create one. That should=
 be unique as -t uses timestamp and MAC address to create it. If there is a=
 better way, please let me know.</div><div class=3D"gmail_extra"><br></div>=
<div class=3D"gmail_extra">Selva</div></div>

--001a1141ca48c7648f053ac37469--

