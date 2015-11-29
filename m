MIME-Version: 1.0
In-Reply-To: <1448825901-12294-1-git-send-email-arne@...1227...>
References: <CAEsd45QjsjNDWFkoHG2O0ycO2pNGxj115TH+SLiUD__jf=WWpQ@...278...>
	<1448825901-12294-1-git-send-email-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 29 Nov 2015 15:30:04 -0500
Message-ID: <CAKuzo_gVnEL5MO1Qvk=k5h6v=cdTd9wF-ASULUcgNA87vOMc-A@...278...>
Content-Type: multipart/alternative; boundary=001a11443d9e495f990525b3cb45
Subject: Re: [Openvpn-devel] [PATCH] Also remove second Instanz von
 enable-password-save in the manage
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

--001a11443d9e495f990525b3cb45
Content-Type: text/plain; charset=UTF-8

On Sun, Nov 29, 2015 at 2:38 PM, Arne Schwabe <arne@...1227...> wrote:

> ---
>  doc/openvpn.8 | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 3519e7d..1b9dcae 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -4886,10 +4886,7 @@ is specified, read the password from the first line
> of
>  .B file.
>  Keep in mind that storing your password in a file
>  to a certain extent invalidates the extra security provided by
> -using an encrypted key (Note: OpenVPN
> -will only read passwords from a file if it has been built
> -with the \-\-enable\-password\-save configure option, or on Windows
> -by defining ENABLE_PASSWORD_SAVE in win/settings.in).
> +using an encrypted key.


Thanks. That takes care of the manpage. The committer could correct the
typo in commit msg "manage" to "manpage" if that's ok.

Cheers,

Selva

--001a11443d9e495f990525b3cb45
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><div class=3D"gmail_quote">=
On Sun, Nov 29, 2015 at 2:38 PM, Arne Schwabe <span dir=3D"ltr">&lt;<a href=
=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1227...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">---<br>
=C2=A0doc/openvpn.8 | 5 +----<br>
=C2=A01 file changed, 1 insertion(+), 4 deletions(-)<br>
<br>
diff --git a/doc/openvpn.8 b/doc/openvpn.8<br>
index 3519e7d..1b9dcae 100644<br>
--- a/doc/openvpn.8<br>
+++ b/doc/openvpn.8<br>
@@ -4886,10 +4886,7 @@ is specified, read the password from the first line =
of<br>
=C2=A0.B file.<br>
=C2=A0Keep in mind that storing your password in a file<br>
=C2=A0to a certain extent invalidates the extra security provided by<br>
-using an encrypted key (Note: OpenVPN<br>
-will only read passwords from a file if it has been built<br>
-with the \-\-enable\-password\-save configure option, or on Windows<br>
-by defining ENABLE_PASSWORD_SAVE in win/<a href=3D"http://settings.in" rel=
=3D"noreferrer" target=3D"_blank">settings.in</a>).<br>
+using an encrypted key.<span class=3D"HOEnZb"></span></blockquote><div><br=
></div><div>Thanks. That takes care of the manpage. The committer could cor=
rect the typo in commit msg &quot;manage&quot; to &quot;manpage&quot; if th=
at&#39;s ok.<br><br></div><div>Cheers,<br><br></div><div>Selva<br></div></d=
iv></div></div>

--001a11443d9e495f990525b3cb45--

