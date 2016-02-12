MIME-Version: 1.0
In-Reply-To: <20160212151544.GW24952@...1296...>
References: <56B86D5C.5070506@...515...> <56BCB9ED.7050802@...515...>
	<CAKuzo_ik33R9uXhY6OKdC6EnEQNJa7CxjSZL_Jjp9H4-mhrftg@...278...>
	<56BD9D87.4070909@...515...> <20160212131529.GQ24952@...1296...>
	<CAKuzo_i_hFgxESdQ6JxKEAg=Y5V96rZBEXjr=UZCz0+wcpf=kw@...278...>
	<20160212143742.GV24952@...1296...>
	<CAKuzo_jYw4UrAg4FR5EtEzp+9QDviEdFjegnWtBqCBdsQQA06w@...278...>
	<20160212151544.GW24952@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 12 Feb 2016 10:46:07 -0500
Message-ID: <CAKuzo_jC5EP1sjmsociYTmAce+D3f5aNmprLfTppdyZMCsTa4g@...278...>
Content-Type: multipart/alternative; boundary=089e013a2a26eb0a5f052b9491d8
Subject: Re: [Openvpn-devel] OpenVPN installers with openvpn-gui pull
 request #13's code included
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

--089e013a2a26eb0a5f052b9491d8
Content-Type: text/plain; charset=UTF-8

On Fri, Feb 12, 2016 at 10:15 AM, Gert Doering <gert@...1296...> wrote:

> >
> > No, currently --config goes first.
>
> Which we might want to turn around, then (changes user-visible behaviour
> in case the config file has a "log mylog.txt" line)...
>

With the GUI overriding some of the user options in the config is required.
At least most --management related options in the config file have to be
reset for the GUI to work, so I suppose its ok to move log to the front
leaving others to follow --config.

Is there any option that behaves like --log (i.e., the first one wins and
subsequent ones are silently ignored) ?


> Anyway, I don't want to be actually the one who solves that, I'm just
> a user who tends to run into user-unfriendliness all the time :-)


The problem is that no active users have time or interest to contribute to
the GUI. I hardly used it until the other day (preferred NSSM + MI-GUI to
avoid runas admin). Now with iservice available, a laptop at home is
running the GUI +iservice, so a bit more motivated to hack it.

Selva

--089e013a2a26eb0a5f052b9491d8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Feb 12, 2016 at 10:15 AM, Gert Doering <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</spa=
n> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"><span>&gt;<br>
&gt; No, currently --config goes first.<br>
<br>
</span>Which we might want to turn around, then (changes user-visible behav=
iour<br>
in case the config file has a &quot;log mylog.txt&quot; line)...<br></block=
quote><div><br></div><div>With the GUI overriding some of the user options =
in the config is required. At least most --management related options in th=
e config file have to be reset for the GUI to work, so I suppose its ok to =
move log to the front leaving others to follow --config. <br><br></div><div=
>Is there any option that behaves like --log (i.e., the first one wins and =
subsequent ones are silently ignored) ?<br></div><div><br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">
<br>
Anyway, I don&#39;t want to be actually the one who solves that, I&#39;m ju=
st<br>
a user who tends to run into user-unfriendliness all the time :-)</blockquo=
te></div><br></div><div class=3D"gmail_extra">The problem is that no active=
 users have time or interest to contribute to the GUI. I hardly used it unt=
il the other day (preferred NSSM + MI-GUI to avoid runas admin). Now with i=
service available, a laptop at home is running the GUI +iservice, so a bit =
more motivated to hack it. <br><br></div><div class=3D"gmail_extra">Selva<b=
r></div></div>

--089e013a2a26eb0a5f052b9491d8--

