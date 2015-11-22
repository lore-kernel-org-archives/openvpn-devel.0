MIME-Version: 1.0
In-Reply-To: <20151122151858.GH24952@...1296...>
References: <1447271171-29141-2-git-send-email-selva.nair@...277...>
	<1447728489-14991-1-git-send-email-selva.nair@...277...>
	<20151122151858.GH24952@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 22 Nov 2015 10:49:13 -0500
Message-ID: <CAKuzo_jFMSQb98pS8mEeujbRs6WXi9a+aaFGbc6GwKa0ANyD6A@...278...>
Content-Type: multipart/alternative; boundary=001a1130cd46036d7f0525230e8e
Subject: Re: [Openvpn-devel] [PATCH] Handle ctrl-C and ctrl-break events on
	Windows
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

--001a1130cd46036d7f0525230e8e
Content-Type: text/plain; charset=UTF-8

Hi,

On Sun, Nov 22, 2015 at 10:18 AM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Mon, Nov 16, 2015 at 09:48:09PM -0500, Selva Nair wrote:
> > v2 changes
> >  - cleaner, hopefully easier to get a code review :)
> >  - handles both console mode and service mode
> > -- >8 --
> >
> > Handle ctrl-C or ctrl-Break sent to the console as a SIGTERM.
> > Depending on the console mode, windows delivers ctrl-C as a
> > keyboard input or as a signal. We handle both cases. This allows
> > graceful termination of openvpn from programs such as nssm.
> > Works in both console mode and service mode.
>
> If I read this right, the new code uses WriteConsoleInput() only to
> signal "hey, some work to do here, wake up!" without actually sending any
> keypress-to-itself, and the signal itself is sent by throw_signal()?
>

Yes, that's the idea.

This is certainly nicer :-)
>

Agree :)


>
> (Is it actually quicker as well, so does the nssm timeout still need to
> be adjusted?  Haven't seen feedback from Samuli here yet)
>

In my tests openvpn exit processing takes only a few hundred msec, but if
exit-notify is enabled that adds about 1 to 2 seconds[*]. As that option
could be pushed as well its safer to setup nssm with a delay of  2500 msec
between ctrl-C and 'kill without prejudice' (aka Terminate).

Thanks,

Selva

[*} actually with exit-notify n, it should only take n-1 seconds to send n
notifies, but integer arithmetic makes it always a little more than n-1.
And for some reason it appears to wait a second even if another notify
doesn't have to be sent. I've not looked into that part of the code
carefully...

--001a1130cd46036d7f0525230e8e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br><div class=3D"gmail_extra"><div class=3D"gmail_=
quote">On Sun, Nov 22, 2015 at 10:18 AM, Gert Doering <span dir=3D"ltr">&lt=
;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On Mon, Nov 16, 2015 at 09:48:09PM -0500, Selva Nair wrote:<br>
&gt; v2 changes<br>
&gt;=C2=A0 - cleaner, hopefully easier to get a code review :)<br>
&gt;=C2=A0 - handles both console mode and service mode<br>
&gt; -- &gt;8 --<br>
&gt;<br>
&gt; Handle ctrl-C or ctrl-Break sent to the console as a SIGTERM.<br>
&gt; Depending on the console mode, windows delivers ctrl-C as a<br>
&gt; keyboard input or as a signal. We handle both cases. This allows<br>
&gt; graceful termination of openvpn from programs such as nssm.<br>
&gt; Works in both console mode and service mode.<br>
<br>
</span>If I read this right, the new code uses WriteConsoleInput() only to<=
br>
signal &quot;hey, some work to do here, wake up!&quot; without actually sen=
ding any<br>
keypress-to-itself, and the signal itself is sent by throw_signal()?<br></b=
lockquote><div>=C2=A0<br></div><div>Yes, that&#39;s the idea.<br><br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
This is certainly nicer :-)<br></blockquote><div><br></div><div>Agree :)<br=
></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
(Is it actually quicker as well, so does the nssm timeout still need to<br>
be adjusted?=C2=A0 Haven&#39;t seen feedback from Samuli here yet)<br></blo=
ckquote><div><br></div><div>In my tests openvpn exit processing takes only =
a few hundred msec, but if exit-notify is enabled that adds about 1 to 2 se=
conds[*]. As that option could be pushed as well its safer to setup nssm wi=
th a delay of=C2=A0 2500 msec between ctrl-C and &#39;kill without prejudic=
e&#39; (aka Terminate). =C2=A0 <br><br></div><div>Thanks,<br><br></div><div=
>Selva<br><br></div><div>[*} actually with exit-notify n, it should only ta=
ke n-1 seconds to send n notifies, but integer arithmetic makes it always a=
 little more than n-1. And for some reason it appears to wait a second even=
 if another notify doesn&#39;t have to be sent. I&#39;ve not looked into th=
at part of the code carefully...<br></div><div>=C2=A0<br></div><br></div></=
div></div>

--001a1130cd46036d7f0525230e8e--

