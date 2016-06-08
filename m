MIME-Version: 1.0
In-Reply-To: <CAA1AbxKN5AJAmXjjZxLEkiEsFbCAQTXnjPGB6s7MLrMc1t8KNQ@...278...>
References: <1465388443-15484-1-git-send-email-steffan@...1856...>
	<1465388443-15484-5-git-send-email-steffan@...1856...>
	<CAKuzo_jskO41boC19osX6tQaVYHio4XFPUyROEWeQuFmuLCf7Q@...278...>
	<CAA1AbxKN5AJAmXjjZxLEkiEsFbCAQTXnjPGB6s7MLrMc1t8KNQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 8 Jun 2016 12:47:15 -0400
Message-ID: <CAKuzo_gqnssD6g3bP3o8VWWanALiLHFpAKiMBQB3iyMHNupkNw@...278...>
Content-Type: multipart/alternative; boundary=001a114115c2f9ad240534c70fcb
Subject: Re: [Openvpn-devel] [PATCH 4/5] Add options to restrict cipher
	negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114115c2f9ad240534c70fcb
Content-Type: text/plain; charset=UTF-8

On Wed, Jun 8, 2016 at 12:11 PM, Steffan Karger <steffan@...1856...> wrote:

> Sure, please tell me what to use.  I never had to deal with our
> signals before, so I simply copied this from a few lines below, where
> (as far as I could see) the did what I wanted it to do.
>
> I had already replaced this with
>
>    throw_signal_soft( SIGUSR1, "process-push-msg-failed" );
>

In this particular case both throw_signal_soft and register_signal does
almost the same thing, but the latter protects SIGTERM out of the box [*].
But, in general, its better to use register signal for setting signals
inside the context struct. That is, when all that one has is a pointer to a
context which could be in a multi_instance, or the top context of the
server or a the context of a client, throw_signal_soft may not be what one
wants.

Basically, register_signal set the signal_received member of sig in a
context, while throw_signal_soft sets the process-wide signal_received.
Both are the same for a client or for the top level context of the server.

Selva

[*] I don't prefer one over the other as both of those functions will have
to be improved up on once we have a clear plan for 'signal prioritization'

--001a114115c2f9ad240534c70fcb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Jun 8, 2016 at 12:11 PM, Steffan Karger <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div>Sure, please tell m=
e what to use.=C2=A0 I never had to deal with our<br>
signals before, so I simply copied this from a few lines below, where<br>
(as far as I could see) the did what I wanted it to do.<br>
<br>
I had already replaced this with<br>
<br>
=C2=A0 =C2=A0throw_signal_soft( SIGUSR1, &quot;process-push-msg-failed&quot=
; );</div></blockquote></div><br>In this particular case both throw_signal_=
soft and register_signal does almost the same thing, but the latter protect=
s SIGTERM out of the box [*]. But, in general, its better to use register s=
ignal for setting signals inside the context struct. That is, when all that=
 one has is a pointer to a context which could be in a multi_instance, or t=
he top context of the server or a the context of a client, throw_signal_sof=
t may not be what one wants.</div><div class=3D"gmail_extra"><br></div><div=
 class=3D"gmail_extra">Basically, register_signal set the signal_received m=
ember of sig in a context, while throw_signal_soft sets the process-wide si=
gnal_received. Both are the same for a client or for the top level context =
of the server.</div><div class=3D"gmail_extra"><br></div><div class=3D"gmai=
l_extra">Selva</div><div class=3D"gmail_extra"><br></div><div class=3D"gmai=
l_extra">[*] I don&#39;t prefer one over the other as both of those functio=
ns will have to be improved up on once we have a clear plan for &#39;signal=
 prioritization&#39;=C2=A0</div></div>

--001a114115c2f9ad240534c70fcb--

