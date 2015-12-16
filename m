MIME-Version: 1.0
In-Reply-To: <1450217793-17974-1-git-send-email-wayne@...2099...>
References: <CAHSx_SuB8wu8_RWcfTfDhFQhrek89-Wu-pBo1FXbBNfHxRUTYg@...278...>
	<1450217793-17974-1-git-send-email-wayne@...2099...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 15 Dec 2015 22:09:39 -0500
Message-ID: <CAKuzo_gSB_9ET=LEJmrJpbhzzhLNCm3xFeUsgwR5HYtFH7FNqA@...278...>
Content-Type: multipart/alternative; boundary=001a1144424ed1564e0526fb3d52
Subject: Re: [Openvpn-devel] [PATCH 1/3] Fix CR prompting when user & pass
 are read from a file.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Wayne Davison <wayne@...2099...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1144424ed1564e0526fb3d52
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue, Dec 15, 2015 at 5:16 PM, Wayne Davison <wayne@...2099...> wrote:

> The code that reads the challenge response (both dynamic & static) will
> not prompt the user if the username and password information was read
> from a file.
>

Agreed this is not good and should be fixed. But the patch is broken


> In the latest code this can be fixed by simply removing
> the "if (username_from_stdin || password_from_stdin)" condition because
> all the deeper code is already conditionalized adequately to only prompt
> for the missing information.
>

This doesn't work: it messes up any response already read from the
management interface.

A simple way of doing this is to define a new variable, say, CR_from_stdin
= true if not read from management. Then add  "CR_from_stdin == true" to
those two if (auth_challenge && ..) lines. The patch will still remain only
a few lines and no changes in indentation/whitespace  needed. The logic
will stay the same as what its now too.

Thanks,

Selva

--001a1144424ed1564e0526fb3d52
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br></div><br><div><div><div class=3D"gmail_extra"=
><div class=3D"gmail_quote">On Tue, Dec 15, 2015 at 5:16 PM, Wayne Davison =
<span dir=3D"ltr">&lt;<a href=3D"mailto:wayne@...2099..." target=3D"_blank"=
>wayne@...2099...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">T=
he code that reads the challenge response (both dynamic &amp; static) will<=
br>
not prompt the user if the username and password information was read<br>
from a file.=C2=A0<br></blockquote><div><br></div><div>Agreed this is not g=
ood and should be fixed. But the patch is broken<br></div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"> In the latest code this can be fixed by sim=
ply removing<br>
the &quot;if (username_from_stdin || password_from_stdin)&quot; condition b=
ecause<br>
all the deeper code is already conditionalized adequately to only prompt<br>
for the missing information.<br></blockquote><div><br>This doesn&#39;t work=
: it messes up any response already read from the management interface.<br>=
</div><div><br></div><div>A simple way of doing this is to define a new var=
iable, say, CR_from_stdin =3D true if not read from management. Then add=C2=
=A0 &quot;CR_from_stdin =3D=3D true&quot; to those two if (auth_challenge &=
amp;&amp; ..) lines. The patch will still remain only a few lines and no ch=
anges in indentation/whitespace=C2=A0 needed. The logic will stay the same =
as what its now too.<br>=C2=A0<br></div><div>Thanks,<br><br></div><div>Selv=
a<br></div></div></div></div></div></div>

--001a1144424ed1564e0526fb3d52--

