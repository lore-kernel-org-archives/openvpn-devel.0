MIME-Version: 1.0
In-Reply-To: <20160212143742.GV24952@...1296...>
References: <56B86D5C.5070506@...515...> <56BCB9ED.7050802@...515...>
	<CAKuzo_ik33R9uXhY6OKdC6EnEQNJa7CxjSZL_Jjp9H4-mhrftg@...278...>
	<56BD9D87.4070909@...515...> <20160212131529.GQ24952@...1296...>
	<CAKuzo_i_hFgxESdQ6JxKEAg=Y5V96rZBEXjr=UZCz0+wcpf=kw@...278...>
	<20160212143742.GV24952@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 12 Feb 2016 09:56:15 -0500
Message-ID: <CAKuzo_jYw4UrAg4FR5EtEzp+9QDviEdFjegnWtBqCBdsQQA06w@...278...>
Content-Type: multipart/alternative; boundary=001a113dd1dc9a1678052b93dffc
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

--001a113dd1dc9a1678052b93dffc
Content-Type: text/plain; charset=UTF-8

On Fri, Feb 12, 2016 at 9:37 AM, Gert Doering <gert@...1296...> wrote:

> On Fri, Feb 12, 2016 at 09:29:39AM -0500, Selva Nair wrote:
> > > Since we know where we're sending the log file to, some enhancement to
> > > the GUI to just go read that file in case the management interface
> fails
> > > to connect (after <x> seconds?) would be good for troubleshooting.
> > >
> >
> > This is tricky..First, if the config is not readable, log file is not set
> > at that time and log goes to stdout (mapped to "/dev/null" by the GUI).
> > Even otherwise  parsing the log to figure out what went wrong is not
> always
> > an easy task for a program.
>
> I'm not sure this description is fully correct - doesn't the GUI (via
> service) pass the log file before --config with the remaining options?


No, currently --config goes first.

Selva

--001a113dd1dc9a1678052b93dffc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Feb 12, 2016 at 9:37 AM, Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><span>On Fri, Feb 12, 2016 at 09=
:29:39AM -0500, Selva Nair wrote:<br>
&gt; &gt; Since we know where we&#39;re sending the log file to, some enhan=
cement to<br>
&gt; &gt; the GUI to just go read that file in case the management interfac=
e fails<br>
&gt; &gt; to connect (after &lt;x&gt; seconds?) would be good for troublesh=
ooting.<br>
&gt; &gt;<br>
&gt;<br>
&gt; This is tricky..First, if the config is not readable, log file is not =
set<br>
&gt; at that time and log goes to stdout (mapped to &quot;/dev/null&quot; b=
y the GUI).<br>
&gt; Even otherwise=C2=A0 parsing the log to figure out what went wrong is =
not always<br>
&gt; an easy task for a program.<br>
<br>
</span>I&#39;m not sure this description is fully correct - doesn&#39;t the=
 GUI (via<br>
service) pass the log file before --config with the remaining options?</blo=
ckquote></div><br></div><div class=3D"gmail_extra">No, currently --config g=
oes first. <br><br></div><div class=3D"gmail_extra">Selva<br></div></div>

--001a113dd1dc9a1678052b93dffc--

