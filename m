MIME-Version: 1.0
In-Reply-To: <20160212131529.GQ24952@...1296...>
References: <56B86D5C.5070506@...515...> <56BCB9ED.7050802@...515...>
	<CAKuzo_ik33R9uXhY6OKdC6EnEQNJa7CxjSZL_Jjp9H4-mhrftg@...278...>
	<56BD9D87.4070909@...515...> <20160212131529.GQ24952@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 12 Feb 2016 09:29:39 -0500
Message-ID: <CAKuzo_i_hFgxESdQ6JxKEAg=Y5V96rZBEXjr=UZCz0+wcpf=kw@...278...>
Content-Type: multipart/alternative; boundary=089e011762d174a625052b9380d0
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

--089e011762d174a625052b9380d0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 12, 2016 at 8:15 AM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Fri, Feb 12, 2016 at 10:53:27AM +0200, Samuli Sepp=C3=A4nen wrote:
> > That would be good. We also need to warn about lack of permissions on
> > the config files. Right now GUI just hangs if it can't read the OpenVPN
> > config file.
>
> This is a more fundamental issue, I think - if there is something wrong
> with the config file (like: syntax error, file not found, ...) OpenVPN
> will exit right away, and the GUI will wait for OpenVPN's management
> interface to show up, to read back the log.
>
> Since we know where we're sending the log file to, some enhancement to
> the GUI to just go read that file in case the management interface fails
> to connect (after <x> seconds?) would be good for troubleshooting.
>

This is tricky..First, if the config is not readable, log file is not set
at that time and log goes to stdout (mapped to "/dev/null" by the GUI).
Even otherwise  parsing the log to figure out what went wrong is not always
an easy task for a program.

However, the GUI does timeout after 10 seconds or so, if the management
interface doesn't come up. But the log will be empty if openvpn exited
before stdout was redirected.

Selva

--089e011762d174a625052b9380d0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div><div class=3D"gmail_extra"><br><div class=3D"g=
mail_quote">On Fri, Feb 12, 2016 at 8:15 AM, Gert Doering <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span><br>
On Fri, Feb 12, 2016 at 10:53:27AM +0200, Samuli Sepp=C3=A4nen wrote:<br>
&gt; That would be good. We also need to warn about lack of permissions on<=
br>
&gt; the config files. Right now GUI just hangs if it can&#39;t read the Op=
enVPN<br>
&gt; config file.<br>
<br>
</span>This is a more fundamental issue, I think - if there is something wr=
ong<br>
with the config file (like: syntax error, file not found, ...) OpenVPN<br>
will exit right away, and the GUI will wait for OpenVPN&#39;s management<br>
interface to show up, to read back the log.<br>
<br>
Since we know where we&#39;re sending the log file to, some enhancement to<=
br>
the GUI to just go read that file in case the management interface fails<br>
to connect (after &lt;x&gt; seconds?) would be good for troubleshooting.<br=
></blockquote><div><br>This is tricky..First, if the config is not readable=
, log file is not set at that time and log goes to stdout (mapped to &quot;=
/dev/null&quot; by the GUI). Even otherwise=C2=A0 parsing the log to figure=
 out what went wrong is not always an easy task for a program. <br><br>Howe=
ver, the GUI does timeout after 10 seconds or so, if the management interfa=
ce doesn&#39;t come up. But the log will be empty if openvpn exited before =
stdout was redirected.<br><br></div><div>Selva<br></div></div></div></div><=
/div>

--089e011762d174a625052b9380d0--

