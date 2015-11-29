MIME-Version: 1.0
In-Reply-To: <1448823144-1497-1-git-send-email-arne@...1227...>
References: <CAEsd45QjsjNDWFkoHG2O0ycO2pNGxj115TH+SLiUD__jf=WWpQ@...278...>
	<1448823144-1497-1-git-send-email-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 29 Nov 2015 14:09:36 -0500
Message-ID: <CAKuzo_gG40h6JOyp4fAw39u1uK+6Zs68XSVHAABihtYEtfGrEw@...278...>
Content-Type: multipart/alternative; boundary=001a1130cd468ddde20525b2abd9
Subject: Re: [Openvpn-devel] [PATCH] Reflect enable-password-save change in
	documentation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1130cd468ddde20525b2abd9
Content-Type: text/plain; charset=UTF-8

Hi,

On Sun, Nov 29, 2015 at 1:52 PM, Arne Schwabe <arne@...1227...> wrote:

> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -3800,10 +3800,7 @@ over the client's routing table.
>  Authenticate with server using username/password.
>  .B up
>  is a file containing username/password on 2 lines. If the
> -password line is missing, OpenVPN will prompt for one. (Note: OpenVPN
> -will only read passwords from a file if it has been built
> -with the \-\-enable\-password\-save configure option, or on Windows
> -by defining ENABLE_PASSWORD_SAVE in win/settings.in).
> +password line is missing, OpenVPN will prompt for one.
>

There is a similar description relating to --askpass . That may be deleted
too.

Selva

--001a1130cd468ddde20525b2abd9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Sun, Nov 29, 2015 at 1:52 PM, Ar=
ne Schwabe <span dir=3D"ltr">&lt;<a href=3D"mailto:arne@...1227..." target=
=3D"_blank">arne@...1227...</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><div id=3D":2zf" class=3D"a3s" style=3D"overflow:hidden">--- a/doc=
/openvpn.8<br>
+++ b/doc/openvpn.8<br>
@@ -3800,10 +3800,7 @@ over the client&#39;s routing table.<br>
=C2=A0Authenticate with server using username/password.<br>
=C2=A0.B up<br>
=C2=A0is a file containing username/password on 2 lines. If the<br>
-password line is missing, OpenVPN will prompt for one. (Note: OpenVPN<br>
-will only read passwords from a file if it has been built<br>
-with the \-\-enable\-password\-save configure option, or on Windows<br>
-by defining ENABLE_PASSWORD_SAVE in win/<a href=3D"http://settings.in" rel=
=3D"noreferrer" target=3D"_blank">settings.in</a>).<br>
+password line is missing, OpenVPN will prompt for one.</div></blockquote><=
/div><br></div><div class=3D"gmail_extra">There is a similar description re=
lating to --askpass . That may be deleted too.<br><br></div><div class=3D"g=
mail_extra">Selva<br></div></div>

--001a1130cd468ddde20525b2abd9--

