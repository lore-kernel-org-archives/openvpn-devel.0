MIME-Version: 1.0
In-Reply-To: <1471023669-25102-1-git-send-email-gert@...1296...>
References: <1470943420-15103-1-git-send-email-gert@...1296...>
	<1471023669-25102-1-git-send-email-gert@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 12 Aug 2016 14:25:54 -0400
Message-ID: <CAKuzo_jySkzG-fHJzz79-EvScbwnaN_PwD+e4dv17=WCxpagvA@...278...>
Content-Type: multipart/alternative; boundary=94eb2c0764168792780539e404f2
Subject: Re: [Openvpn-devel] [PATCH v2] Change timestamps to ISO 8601 format.
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

--94eb2c0764168792780539e404f2
Content-Type: text/plain; charset=UTF-8

On Fri, Aug 12, 2016 at 1:41 PM, Gert Doering <gert@...1296...> wrote:

> diff --git a/Changes.rst b/Changes.rst
> index 9fcba75..ad6363e 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -135,6 +135,9 @@ User-visible Changes
>    ciphers configured in the config file.  Use --ncp-disable if you don't
> want
>    that.
>
> +- all time stamps, including log file, status file and management
> interface,
> +  are now output in ISO 8601 standard format.
> +
>

Currently the >LOG message to the management is like

>LOG:1471025385,,Closing TUN/TAP interface

with unix time as timestamp. Similarly for INFO message in response to 'log
n' request or the state message.The patch would not change those, would it?

Selva

--94eb2c0764168792780539e404f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Aug 12, 2016 at 1:41 PM, Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-s=
tyle:solid;padding-left:1ex"><div>diff --git a/Changes.rst b/Changes.rst<br>
index 9fcba75..ad6363e 100644<br>
--- a/Changes.rst<br>
+++ b/Changes.rst<br>
@@ -135,6 +135,9 @@ User-visible Changes<br>
=C2=A0 =C2=A0ciphers configured in the config file.=C2=A0 Use --ncp-disable=
 if you don&#39;t want<br>
=C2=A0 =C2=A0that.<br>
<br>
+- all time stamps, including log file, status file and management interfac=
e,<br>
+=C2=A0 are now output in ISO 8601 standard format.<br>
+<br></div></blockquote></div><br>Currently the &gt;LOG message to the mana=
gement is like</div><div class=3D"gmail_extra"><br></div><div class=3D"gmai=
l_extra">&gt;LOG:1471025385,,Closing TUN/TAP interface<br></div><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra">with unix time as tim=
estamp. Similarly for INFO message in response to &#39;log n&#39; request o=
r the state message.The patch would not change those, would it?</div><div c=
lass=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva</div></div>

--94eb2c0764168792780539e404f2--

