MIME-Version: 1.0
In-Reply-To: <1480360012-9479-1-git-send-email-gert@...1296...>
References: <1480360012-9479-1-git-send-email-gert@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 28 Nov 2016 14:18:02 -0500
Message-ID: <CAKuzo_gcmXmZ+a+LTdA78wiK+h70v1-R5Xk1FAMUbmzVLm1HJw@...278...>
Content-Type: multipart/alternative; boundary=94eb2c084cacd248ba05426155d6
Subject: Re: [Openvpn-devel] [PATCH] Fix windows path in Changes.rst
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

--94eb2c084cacd248ba05426155d6
Content-Type: text/plain; charset=UTF-8

On Mon, Nov 28, 2016 at 2:06 PM, Gert Doering <gert@...1296...> wrote:

> Escape backslash characters in windows path names.
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  Changes.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Changes.rst b/Changes.rst
> index 6d7bd69..aa80c10 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -71,12 +71,12 @@ New interactive Windows service
>
>      The interactive Windows service allows unprivileged users to start
>      OpenVPN connections in the global config directory (usually
> -    C:\Program Files\OpenVPN\config) using OpenVPN GUI without any
> +    C:\\Program Files\\OpenVPN\\config) using OpenVPN GUI without any
>      extra configuration.
>
>      Users who belong to the built-in Administrator group or to the
>      local "OpenVPN Administrator" group can also store configuration
> -    files under %USERPROFILE%\OpenVPN\config for use with the
> +    files under %USERPROFILE%\\OpenVPN\\config for use with the
>

Looks good and now Changes.rst will display nice on github :)

ACK

Selva

--94eb2c084cacd248ba05426155d6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Nov 28, 2016 at 2:06 PM, Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div id=3D":14t" class=3D"a3s aX=
jCH m158ac575537b2d7f">Escape backslash characters in windows path names.<b=
r>
<br>
Signed-off-by: Gert Doering &lt;<a href=3D"mailto:gert@...1296...">gert@...493...=
1296...</a>&gt;<br>
---<br>
=C2=A0Changes.rst | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/Changes.rst b/Changes.rst<br>
index 6d7bd69..aa80c10 100644<br>
--- a/Changes.rst<br>
+++ b/Changes.rst<br>
@@ -71,12 +71,12 @@ New interactive Windows service<br>
<br>
=C2=A0 =C2=A0 =C2=A0The interactive Windows service allows unprivileged use=
rs to start<br>
=C2=A0 =C2=A0 =C2=A0OpenVPN connections in the global config directory (usu=
ally<br>
-=C2=A0 =C2=A0 C:\Program Files\OpenVPN\config) using OpenVPN GUI without a=
ny<br>
+=C2=A0 =C2=A0 C:\\Program Files\\OpenVPN\\config) using OpenVPN GUI withou=
t any<br>
=C2=A0 =C2=A0 =C2=A0extra configuration.<br>
<br>
=C2=A0 =C2=A0 =C2=A0Users who belong to the built-in Administrator group or=
 to the<br>
=C2=A0 =C2=A0 =C2=A0local &quot;OpenVPN Administrator&quot; group can also =
store configuration<br>
-=C2=A0 =C2=A0 files under %USERPROFILE%\OpenVPN\config for use with the<br>
+=C2=A0 =C2=A0 files under %USERPROFILE%\\OpenVPN\\config for use with the<=
/div></blockquote></div><div class=3D"gmail_extra"><br></div>Looks good and=
 now Changes.rst will display nice on github :)=C2=A0</div><div class=3D"gm=
ail_extra"><br></div><div class=3D"gmail_extra">ACK</div><div class=3D"gmai=
l_extra"><br></div><div class=3D"gmail_extra">Selva</div></div>

--94eb2c084cacd248ba05426155d6--

