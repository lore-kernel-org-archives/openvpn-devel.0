MIME-Version: 1.0
In-Reply-To: <56BDF828.4010902@...1227...>
References: <56B86D5C.5070506@...515...> <56BCB9ED.7050802@...515...>
	<CAKuzo_ik33R9uXhY6OKdC6EnEQNJa7CxjSZL_Jjp9H4-mhrftg@...278...>
	<56BD9D87.4070909@...515...> <20160212131529.GQ24952@...1296...>
	<CAKuzo_i_hFgxESdQ6JxKEAg=Y5V96rZBEXjr=UZCz0+wcpf=kw@...278...>
	<20160212143742.GV24952@...1296...>
	<CAKuzo_jYw4UrAg4FR5EtEzp+9QDviEdFjegnWtBqCBdsQQA06w@...278...>
	<20160212151544.GW24952@...1296...> <56BDF828.4010902@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 12 Feb 2016 10:31:02 -0500
Message-ID: <CAKuzo_jym9stPZmB4ghht71Q=nfiCNW9WgeJ=HhR0-cXL64O6Q@...278...>
Content-Type: multipart/alternative; boundary=001a113d54f804ed83052b945c60
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
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113d54f804ed83052b945c60
Content-Type: text/plain; charset=UTF-8

On Fri, Feb 12, 2016 at 10:20 AM, Arne Schwabe <arne@...1227...> wrote:

> > Anyway, I don't want to be actually the one who solves that, I'm just
> > a user who tends to run into user-unfriendliness all the time :-)
> >
> >
> You are too negative:
>
> Changelog:
>
> - Now honours user defined log file location



That has never been the problem. Average user just runs the GUI without any
arguments and gets the default log location which may not be writeable.

Anyway the current point of discussion is not about log file location, but
what happens when config file is not readable and the GUI just fails to
connect to management interface and sees nothing in the logs? Well, it
turns out this is due to --log not being passed as the first option.

Speaking of log file location, the patch was to make even the default
location to be in the users profile directory.

Selva

--001a113d54f804ed83052b945c60
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Feb 12, 2016 at 10:20 AM, Arne Schwabe <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1227...</a>&gt;</spa=
n> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"><span class=3D"">&gt; Anyway, I=
 don&#39;t want to be actually the one who solves that, I&#39;m just<br>
&gt; a user who tends to run into user-unfriendliness all the time :-)<br>
&gt;<br>
&gt;<br>
</span>You are too negative:<br>
<br>
Changelog:<br>
<br>
- Now honours user defined log file location</blockquote></div><br><br></di=
v><div class=3D"gmail_extra">That has never been the problem. Average user =
just runs the GUI without any arguments and gets the default log location w=
hich may not be writeable.<br><br></div><div class=3D"gmail_extra">Anyway t=
he current point of discussion is not about log file location, but what hap=
pens when config file is not readable and the GUI just fails to connect to =
management interface and sees nothing in the logs? Well, it turns out this =
is due to --log not being passed as the first option.<br><br></div><div cla=
ss=3D"gmail_extra">Speaking of log file location, the patch was to make eve=
n the default location to be in the users profile directory.<br><br></div><=
div class=3D"gmail_extra">Selva<br></div></div>

--001a113d54f804ed83052b945c60--

