MIME-Version: 1.0
In-Reply-To: <1465388443-15484-5-git-send-email-steffan@...1856...>
References: <1465388443-15484-1-git-send-email-steffan@...1856...>
	<1465388443-15484-5-git-send-email-steffan@...1856...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 8 Jun 2016 11:53:23 -0400
Message-ID: <CAKuzo_jskO41boC19osX6tQaVYHio4XFPUyROEWeQuFmuLCf7Q@...278...>
Content-Type: multipart/alternative; boundary=001a113e30b65bcb2b0534c64fe2
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

--001a113e30b65bcb2b0534c64fe2
Content-Type: text/plain; charset=UTF-8

On Wed, Jun 8, 2016 at 8:20 AM, Steffan Karger <steffan@...1856...> wrote:

> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -239,11 +239,21 @@ incoming_push_message (struct context *c, const
> struct buffer *buffer)
>      {
>        c->options.push_option_types_found |= option_types_found;
>
> +      /* delay bringing tun/tap up until --push parms received from
> remote */
>        if (status == PUSH_MSG_REPLY)
> -       do_up (c, true, c->options.push_option_types_found ); /* delay
> bringing tun/tap up until --push parms received from remote */
> +       {
> +         if (!do_up (c, true, c->options.push_option_types_found))
> +           {
> +             msg (D_PUSH_ERRORS, "Failed to open tun/tap interface");
> +             c->sig->signal_received = SIGUSR1; /* connection reset */
> +             c->sig->signal_text = "open-tuntap-failed";
>

Please try to avoid that potential overwrite of a pending signal --- as
this runs on the client, c->sig here is a pointer to the global
siginfo_static.

Use register_signal (c, SIGUSR1, "open-tuntap-failed") instead  -- it will
at least protect SIGTERM. I'm looking into how to prioritize signals, and
it would help to have all signals set through a few functions such as
register_signal, throw_signal_soft etc ..

By the way "open-tun-tap failed" may be a confusing as a real open tun/tap
error would have resulted in a  FATAL exit -- the error handled here could
happen even if tun/tap has been successfully opened, isn't it?

Selva

--001a113e30b65bcb2b0534c64fe2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Jun 8, 2016 at 8:20 AM, <span style=3D"background:yellow">Steffan</=
span> <span style=3D"background:yellow">Karger</span> <span dir=3D"ltr">&lt=
;<a href=3D"mailto:steffan@...1856..." target=3D"_blank"><span style=3D"bac=
kground:yellow">steffan</span>@<span style=3D"background:yellow">karger</sp=
an>.me</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,20=
4,204);border-left-style:solid;padding-left:1ex"><div>--- a/src/openvpn/pus=
h.c<br>
+++ b/src/openvpn/push.c<br>
@@ -239,11 +239,21 @@ incoming_push_message (struct context *c, const struc=
t buffer *buffer)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;options.push_option_types_found |=3D optio=
n_types_found;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 /* delay bringing tun/tap up until --push parms recei=
ved from remote */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (status =3D=3D PUSH_MSG_REPLY)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0do_up (c, true, c-&gt;options.push_option_types=
_found ); /* delay bringing tun/tap up until --push parms received from rem=
ote */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!do_up (c, true, c-&gt;options.push_=
option_types_found))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (D_PUSH_ERRORS, &quot;=
Failed to open tun/tap interface&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;sig-&gt;signal_recei=
ved =3D SIGUSR1; /* connection reset */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;sig-&gt;signal_text =
=3D &quot;open-tuntap-failed&quot;;</div></blockquote><div>=C2=A0</div></di=
v>Please try to avoid that potential overwrite of a pending signal --- as t=
his runs on the client, c-&gt;sig here is a pointer to the global siginfo_s=
tatic.</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"=
>Use register_signal (c, SIGUSR1,=C2=A0&quot;open-<span style=3D"background=
:yellow">tuntap</span>-failed&quot;) instead =C2=A0-- it will at least prot=
ect SIGTERM. I&#39;m looking into how to prioritize signals, and it would h=
elp to have all signals set through a few functions such as register_signal=
, throw_signal_soft etc ..=C2=A0</div><div class=3D"gmail_extra"><br></div>=
<div class=3D"gmail_extra">By the way &quot;open-tun-tap failed&quot; may b=
e a confusing as a real open tun/tap error would have resulted in a =C2=A0F=
ATAL exit -- the error handled here could happen even if tun/tap has been s=
uccessfully opened, isn&#39;t it?</div><div class=3D"gmail_extra"><br></div=
><div class=3D"gmail_extra"><span style=3D"background:yellow">Selva</span><=
/div></div>

--001a113e30b65bcb2b0534c64fe2--

