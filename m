MIME-Version: 1.0
In-Reply-To: <1477650469-32431-1-git-send-email-janjust@...1147...>
References: <1477650469-32431-1-git-send-email-janjust@...1147...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 28 Oct 2016 13:50:57 -0400
Message-ID: <CAKuzo_ibmkh=zoEzaVCYFFkYXE0hpnOCN5VvQnP+JGdq7_+kUQ@...278...>
Content-Type: multipart/alternative; boundary=94eb2c0455124e5fdf053ff08194
Subject: Re: [Openvpn-devel] [PATCH] Allow "setenv opt" to be pushed from
 server to client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c0455124e5fdf053ff08194
Content-Type: text/plain; charset=UTF-8

Hi,

On Fri, Oct 28, 2016 at 6:27 AM, Jan Just Keijser <janjust@...1147...> wrote:

> ---
>  src/openvpn/options.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
>
As Arne pointed out the utility of allowing setenv opt in push is
questionable. "setenv opt bad-option" in config file logs a warning and
continues. "push bad-option" logs an error and continues. The end result is
that both avoids fatal errors with unrecognized/unknown options.

That apart, NAK to this patch as its not correct


> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 281ef0b..dbb926d 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -5616,7 +5616,14 @@ add_option (struct options *options,
>      }
>    else if (streq (p[0], "setenv") && p[1] && !p[3])
>      {
> -      VERIFY_PERMISSION (OPT_P_GENERAL);
>

First, "setenv opt" has nothing to do with setenv, so its better not
handled here.


> +      if (streq (p[1], "opt"))
> +       {
> +          VERIFY_PERMISSION (OPT_P_SETENV);
>

This will only result in defining/redefining an env variable "opt = xxx"
which is not what is desired.

+       }
> +      else
> +       {
> +          VERIFY_PERMISSION (OPT_P_GENERAL);
> +       }
>        if (streq (p[1], "REMOTE_RANDOM_HOSTNAME") && !p[2])
>         {
>           options->sockflags |= SF_HOST_RANDOMIZE;
>

If we really want to allow push "setenv opt ..", the way to do this would
be at the top of the function add_option(), where the words "setenv" and
"opt" are removed by "p += 2" so that the rest gets parsed as a normal
option at a non-fatal msglevel. Make that apply even when pull_mode is
true. Also the man page needs update/correction: remove "--setenv" from
allowed push options list and add "--setenv opt".

Even then its no better than a simple push unless msglevel_fc is changed to
a high verbosity level than M_WARN as well.

Selva

--94eb2c0455124e5fdf053ff08194
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Fri, Oct 28, 2016 at 6:27 AM, Jan Ju=
st Keijser <span dir=3D"ltr">&lt;<a href=3D"mailto:janjust@...1147..." targ=
et=3D"_blank">janjust@...1147...</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">=
<div id=3D"m_9136747121534352gmail-:1ty" class=3D"m_9136747121534352gmail-a=
3s m_9136747121534352gmail-aXjCH m_9136747121534352gmail-m1580ad8799e1f731"=
>---<br>
=C2=A0src/openvpn/options.c | 9 ++++++++-<br>
=C2=A01 file changed, 8 insertions(+), 1 deletion(-)<br>
<br></div></blockquote><div><br></div><div>As Arne pointed out the utility =
of allowing setenv opt in push is questionable. &quot;setenv opt bad-option=
&quot; in config file logs a warning and continues. &quot;push bad-option&q=
uot; logs an error and continues. The end result is that both avoids fatal =
errors with unrecognized/unknown options.=C2=A0</div><div><br></div><div>Th=
at apart, NAK to this patch as its not correct</div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-w=
idth:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding=
-left:1ex"><div id=3D"m_9136747121534352gmail-:1ty" class=3D"m_913674712153=
4352gmail-a3s m_9136747121534352gmail-aXjCH m_9136747121534352gmail-m1580ad=
8799e1f731">
diff --git a/src/openvpn/options.c b/src/openvpn/options.c<br>
index 281ef0b..dbb926d 100644<br>
--- a/src/openvpn/options.c<br>
+++ b/src/openvpn/options.c<br>
@@ -5616,7 +5616,14 @@ add_option (struct options *options,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0else if (streq (p[0], &quot;setenv&quot;) &amp;&amp; p[1] &amp=
;&amp; !p[3])<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 VERIFY_PERMISSION (OPT_P_GENERAL);<br></div></blockqu=
ote><div><br></div><div>First, &quot;setenv opt&quot; has nothing to do wit=
h setenv, so its better not handled here.</div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:=
1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left=
:1ex"><div id=3D"m_9136747121534352gmail-:1ty" class=3D"m_9136747121534352g=
mail-a3s m_9136747121534352gmail-aXjCH m_9136747121534352gmail-m1580ad8799e=
1f731">
+=C2=A0 =C2=A0 =C2=A0 if (streq (p[1], &quot;opt&quot;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VERIFY_PERMISSION (OPT_P_SETENV);</div>=
</blockquote><div><br></div><div>This will only result in defining/redefini=
ng an env variable &quot;opt =3D xxx&quot; which is not what is desired.</d=
iv><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-=
left-style:solid;padding-left:1ex"><div id=3D"m_9136747121534352gmail-:1ty"=
 class=3D"m_9136747121534352gmail-a3s m_9136747121534352gmail-aXjCH m_91367=
47121534352gmail-m1580ad8799e1f731">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VERIFY_PERMISSION (OPT_P_GENERAL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (streq (p[1], &quot;REMOTE_RANDOM_HOSTNAME&qu=
ot;) &amp;&amp; !p[2])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;sockflags |=3D SF_HOST_RANDO=
MIZE;</div></blockquote><div><br></div><div>If we really want to allow push=
 &quot;setenv opt ..&quot;, the way to do this would be at the top of the f=
unction add_option(), where the words &quot;setenv&quot; and &quot;opt&quot=
; are removed by &quot;p +=3D 2&quot; so that the rest gets parsed as a nor=
mal option at a non-fatal msglevel. Make that apply even when pull_mode is =
true. Also the man page needs update/correction: remove &quot;--setenv&quot=
; from allowed push options list and add &quot;--setenv opt&quot;.=C2=A0</d=
iv><div><br></div><div>Even then its no better than a simple push unless ms=
glevel_fc is changed to a high verbosity level than M_WARN as well.<br></di=
v><div><br></div><div>Selva</div><div><br></div></div></div></div>

--94eb2c0455124e5fdf053ff08194--

