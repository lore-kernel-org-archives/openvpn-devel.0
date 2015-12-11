MIME-Version: 1.0
In-Reply-To: <CADCH5Ogh2ROBNti_hmBUBcQYBz4SuHJo_-cii14_E6aj9jmj-A@...278...>
References: <CADCH5Ogh2ROBNti_hmBUBcQYBz4SuHJo_-cii14_E6aj9jmj-A@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 10 Dec 2015 19:22:22 -0500
Message-ID: <CAKuzo_i-dwD7CLQnM_Stdmg8dPOqLbBukNjPTOeXcKUAoFM5Pg@...278...>
Content-Type: multipart/alternative; boundary=001a11453cf4548c2d05269452b4
Subject: Re: [Openvpn-devel] [PATCH] Make ValdikSS's DNS leak fix platform
	agnostic
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Fish Wang <fish.thss@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a11453cf4548c2d05269452b4
Content-Type: text/plain; charset=UTF-8

Hi,

The patch is mangled by mailer (added linebreaks etc.). Could you please
resend using git send-email? While at it, one thing I noticed:

On Thu, Dec 10, 2015 at 6:48 PM, Fish Wang <fish.thss@...277...> wrote:

> -#if _WIN32_WINNT >= 0x0600
>    else if (streq (p[0], "block-outside-dns") && !p[1])
>      {
>        VERIFY_PERMISSION (OPT_P_IPWIN32);
> -      options->block_outside_dns = true;
> +      if (win_wfp_init_funcs())
> +      {
> +        options->block_outside_dns = true;
> +      }
> +      else
> +      {
> +        msg (msglevel, "Failed to enable --block-outside-dns. "
> +                       "Maybe WFP is not supported on your system?");
>

I believe msglevel_fc is more appropriate, as otherwise forward compatible
and "setenv opt" usages will not be respected.

Selva

--001a11453cf4548c2d05269452b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra">The patch is mangled by mailer (added linebreaks etc.). Could =
you please resend using git send-email? While at it, one thing I noticed:<b=
r><br></div><div class=3D"gmail_extra"><div class=3D"gmail_quote">On Thu, D=
ec 10, 2015 at 6:48 PM, Fish Wang <span dir=3D"ltr">&lt;<a href=3D"mailto:f=
ish.thss@...277..." target=3D"_blank">fish.thss@...277...</a>&gt;</span> wr=
ote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex"><div id=3D":7dm" class=3D"a3s" style=
=3D"overflow:hidden">-#if _WIN32_WINNT &gt;=3D 0x0600<br>
<span class=3D"">=C2=A0 =C2=A0else if (streq (p[0], &quot;block-outside-dns=
&quot;) &amp;&amp; !p[1])<br>
</span>=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0VERIFY_PERMISSION (OPT_P_IPWIN32);<br>
-=C2=A0 =C2=A0 =C2=A0 options-&gt;block_outside_dns =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 if (win_wfp_init_funcs())<br>
<span class=3D"">+=C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;block_outside_dns =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 else<br>
</span>+=C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (msglevel, &quot;Failed to enable --block-=
outside-dns. &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;Maybe WFP is not supported on your system?&quot;);<br>
</div></blockquote><div><br></div><div>I believe msglevel_fc is more approp=
riate, as otherwise forward compatible and &quot;setenv opt&quot; usages wi=
ll not be respected.<br><br></div><div>Selva<br></div></div><br></div></div>

--001a11453cf4548c2d05269452b4--

