MIME-Version: 1.0
In-Reply-To: <20160607070649.GJ53051@...1296...>
References: <1465274660-11009-1-git-send-email-selva.nair@...277...>
	<1465274660-11009-2-git-send-email-selva.nair@...277...>
	<20160607070649.GJ53051@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 7 Jun 2016 10:47:37 -0400
Message-ID: <CAKuzo_hK=hQe4qM-VhTDdm3+L+Oef7ma0dfXiUANcM2ZVF9Quw@...278...>
Content-Type: multipart/alternative; boundary=001a1147f47e4e3e860534b14648
Subject: Re: [Openvpn-devel] [PATCH 1/1] Ignore SIGUSR1/SIGHUP during exit
	notification
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

--001a1147f47e4e3e860534b14648
Content-Type: text/plain; charset=UTF-8

On Tue, Jun 7, 2016 at 3:06 AM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Tue, Jun 07, 2016 at 12:44:20AM -0400, Selva Nair wrote:
> > This allows exit notification to complete and finally trigger SIGTERM.
> > The current practice of allowing a restart in this state clears
> > the exit notification timer data and thus loses the SIGTERM.
>
> This is along the lines I was thinking as well, so I like it better than
> the first try (which was sort of fiddling with the symptoms, but not with
> the underlying signal handling problem).
>
> What if SIGTERM+SIGUSR1 are received in very quick succession, so that
> we haven't even entered "explicit_exit_notification_interval" yet?
>

This patch only addresses the issue of restart if exit notify is ongoing.
The second problem of signals getting overwritten before getting processed
has to be addressed independently. I am not yet sure how best to do this as
there are many places and many ways this can happen.


>
> I'm not sure if I understand the full chain of events that happen on
> a (soft or hard) SIGTERM, what state ->signal_received has when the
> exit notification timer is active, and under which circumstances
> get_signal() is called to collect signal info into the context... this
> is magic stuff...
>

In most cases, the signal gets noticed through the EVENT_LOOP_CHECK_SIG
(same as P2P_CHECK_SIG) which breaks the loop or through 'if (IS_SIG)
return'.
When exit notification is ongoing, signal_received is zero: SIGTERM
received --> processed --> removed and exit-notify started. This is needed
to make sure we don't exit until the notification is completed. The SIGTERM
gets re-instated (signal_received = SIGTERM) when the notification
completes and then we'll exit the next time the signal is checked.

This patch handles only the period when exit-notify is ongoing so a SIGTERM
is impending.


> My original idea was "the place that sets signal_received will not do
> that for SIGUSR1 if a SIGTERM has already been received" (so, de-coupled
> from the exit notification timer), but it seems that this is not easy
> to do.  So maybe your patch is the pragmatic way to solve this.
>

We still have to do something like that but as you say its hard as the
signal is set in different ways -- through throw_signal, register_signal,
directly over-writing signal_received etc.. And no solution is going to be
perfect as checking and setting the signal needs two operations during
which a hard signal may be delivered. But that is something we can live
with, I suppose -- I do not mind having to press ctrl-c twice to get
noticed. But we should make sure soft signals (those internally generated
or received through the management interface) are never lost or
over-written by lower priority signals.

Selva

--001a1147f47e4e3e860534b14648
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Jun 7, 2016 at 3:06 AM, Gert <span class=3D"" id=3D":71l.1" tabinde=
x=3D"-1">Doering</span> <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1826...=
6..." target=3D"_blank"><span class=3D"" id=3D":71l.2" tabindex=3D"-1">gert=
</span>@<span class=3D"" id=3D":71l.3" tabindex=3D"-1">greenie</span>.<span=
 class=3D"" id=3D":71l.4" tabindex=3D"-1">muc</span>.<span class=3D"" id=3D=
":71l.5" tabindex=3D"-1">de</span></a>&gt;</span> wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex"><div id=3D":4gi" class=3D"a3s aXjCH m15529af73a695e83">Hi,<=
br>
<span class=3D""><br>
On Tue, Jun 07, 2016 at 12:44:20AM -0400, Selva Nair wrote:<br>
&gt; This allows exit notification to complete and finally trigger SIGTERM.=
<br>
&gt; The current practice of allowing a restart in this state clears<br>
&gt; the exit notification timer data and thus loses the SIGTERM.<br>
<br>
</span>This is along the lines I was thinking as well, so I like it better =
than<br>
the first try (which was sort of fiddling with the symptoms, but not with<b=
r>
the underlying signal handling problem).<br>
<br>
What if SIGTERM+SIGUSR1 are received in very quick succession, so that<br>
we haven&#39;t even entered &quot;explicit_exit_notification_interval&quot;=
 yet?<br></div></blockquote><div><br></div><div>This patch only addresses t=
he issue of restart if exit notify is ongoing. The second problem of signal=
s getting overwritten before getting processed has to be addressed independ=
ently. I am not yet sure how best to do this as there are many places and m=
any ways this can happen.=C2=A0</div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex"><div id=3D":4gi" class=3D"a3s aXjCH m15529af73a695e83">
<br>
I&#39;m not sure if I understand the full chain of events that happen on<br>
a (soft or hard) SIGTERM, what state -&gt;signal_received has when the<br>
exit notification timer is active, and under which circumstances<br>
get_signal() is called to collect signal info into the context... this<br>
is magic stuff...<br></div></blockquote><div><br></div><div>In most cases, =
the signal gets noticed through the EVENT_LOOP_CHECK_SIG (same as P2P_CHECK=
_SIG) which breaks the loop or through &#39;if (IS_SIG) return&#39;.</div><=
div>When exit notification is ongoing, signal_received is zero: <span class=
=3D"" id=3D":71l.6" tabindex=3D"-1">SIGTERM</span> received --&gt; processe=
d --&gt; removed and exit-notify started. This is needed to make sure we do=
n&#39;t exit until the notification is completed. The <span class=3D"" id=
=3D":71l.7" tabindex=3D"-1">SIGTERM</span> gets re-instated (signal_receive=
d =3D <span class=3D"" id=3D":71l.8" tabindex=3D"-1">SIGTERM</span>) when t=
he notification completes and then we&#39;ll exit the next time the signal =
is checked.</div><div><br></div><div>This patch handles only the period whe=
n exit-notify is ongoing so a <span class=3D"" id=3D":71l.9" tabindex=3D"-1=
">SIGTERM</span> is impending.</div><div><br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex"><div id=3D":4gi" class=3D"a3s aXjCH m15529af73a695e83">
<br>
My original idea was &quot;the place that sets signal_received will not do<=
br>
that for SIGUSR1 if a SIGTERM has already been received&quot; (so, de-coupl=
ed<br>
from the exit notification timer), but it seems that this is not easy<br>
to do.=C2=A0 So maybe your patch is the pragmatic way to solve this.</div><=
/blockquote></div><div class=3D"gmail_extra"><br></div>We still have to do =
something like that but as you say its hard as the signal is set in differe=
nt ways -- through throw_signal, register_signal, directly over-writing sig=
nal_received etc.. And no solution is going to be perfect as checking and s=
etting the signal needs two operations during which a hard signal may be de=
livered. But that is something we can live with, I suppose -- I do not mind=
 having to press <span class=3D"" id=3D":71l.10" tabindex=3D"-1">ctrl</span=
>-c twice to get noticed. But we should make sure soft signals (those inter=
nally generated or received through the management interface) are never los=
t or over-written by lower priority signals.</div><div class=3D"gmail_extra=
"><br></div><div class=3D"gmail_extra"><span class=3D"" id=3D":71l.11" tabi=
ndex=3D"-1">Selva</span></div><div class=3D"gmail_extra"><br></div><div cla=
ss=3D"gmail_extra">=C2=A0<br><br></div></div>

--001a1147f47e4e3e860534b14648--

