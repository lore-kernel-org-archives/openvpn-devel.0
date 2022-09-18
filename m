MIME-Version: 1.0
References: <20220917140818.6155-1-a@...2181...>
In-Reply-To: <20220917140818.6155-1-a@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 18 Sep 2022 14:30:14 -0400
Message-ID: <CAKuzo_ihm3qrRXE6z=A3hz4bGzmaWpK11pjf_WqHGORQEfsP=A@...278...>
Content-Type: multipart/alternative; boundary="000000000000ffc62205e8f7cc0a"
Subject: Re: [Openvpn-devel] [PATCH] Add common_name to the conv method.
 This allows the common_name to be accessible in PAM.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Michael Karvan <Michael.Karvan@...277...>

--000000000000ffc62205e8f7cc0a
Content-Type: text/plain; charset="UTF-8"

On Sat, Sep 17, 2022 at 10:09 AM Antonio Quartulli <a@...2181...> wrote:

> From: Michael Karvan <Michael.Karvan@...277...>
>
> Signed-off-by: Michael Karvan <Michael.Karvan@...277...>
> ---
>  src/plugins/auth-pam/auth-pam.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/src/plugins/auth-pam/auth-pam.c
> b/src/plugins/auth-pam/auth-pam.c
> index 70339445..9f37c8c0 100644
> --- a/src/plugins/auth-pam/auth-pam.c
> +++ b/src/plugins/auth-pam/auth-pam.c
> @@ -746,8 +746,15 @@ my_conv(int n, const struct pam_message **msg_array,
>                      }
>                      break;
>
> -                case PAM_ERROR_MSG:
>                  case PAM_TEXT_INFO:
> +                    aresp[i].resp = strdup(up->common_name);
> +                    if (aresp[i].resp == NULL)
> +                    {
> +                        ret = PAM_CONV_ERR;
> +                    }
> +                    break;
> +
> +                case PAM_ERROR_MSG:
>                      break;
>
>
To add to what Gert's comment, we already support COMMONNAME in addition to
USERNAME, PASSWORD and
OTP via text replacements for pam prompts specified in the config file.
Like:

 plugin openvpn-auth-pam.so "openvpn user USERNAME password PASSWORD cn
COMMONNAME"

and have the PAM module prompt for "user', "password" and "cn", for example.

So why do we need this non-standard stuff ?

In fact, IMO, we should be getting rid of this whole "else {}" clause
starting line 728 that tries to guess the prompts based on echo-off ( to
mean password) echo-on (to mean username) etc. Instead, require that the
plugin line in the config file must specify expected prompts and
replacement strings as above.

Selva

--000000000000ffc62205e8f7cc0a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Sep 17, 2022 at 10:09 AM Anto=
nio Quartulli &lt;<a href=3D"mailto:a@...2181...">a@...2181...</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Michael=
 Karvan &lt;<a href=3D"mailto:Michael.Karvan@...277..." target=3D"_blank">M=
ichael.Karvan@...277...</a>&gt;<br>
<br>
Signed-off-by: Michael Karvan &lt;<a href=3D"mailto:Michael.Karvan@...1663...=
." target=3D"_blank">Michael.Karvan@...277...</a>&gt;<br>
---<br>
=C2=A0src/plugins/auth-pam/auth-pam.c | 9 ++++++++-<br>
=C2=A01 file changed, 8 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pa=
m.c<br>
index 70339445..9f37c8c0 100644<br>
--- a/src/plugins/auth-pam/auth-pam.c<br>
+++ b/src/plugins/auth-pam/auth-pam.c<br>
@@ -746,8 +746,15 @@ my_conv(int n, const struct pam_message **msg_array,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0break;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case PAM_ERROR_MSG=
:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case PAM_TEXT=
_INFO:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ares=
p[i].resp =3D strdup(up-&gt;common_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
aresp[i].resp =3D=3D NULL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ret =3D PAM_CONV_ERR;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 brea=
k;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case PAM_ERROR_MSG=
:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0break;<br>
<br></blockquote><div><br></div><div>To add to what Gert&#39;s comment, we =
already support COMMONNAME=C2=A0in addition to USERNAME, PASSWORD and</div>=
<div>OTP via text replacements for pam prompts specified in the config file=
. Like:</div><div><br></div><div>=C2=A0plugin openvpn-auth-pam.so &quot;ope=
nvpn user USERNAME password PASSWORD cn COMMONNAME&quot;</div><div><br></di=
v><div>and have the PAM module prompt for &quot;user&#39;, &quot;password&q=
uot; and &quot;cn&quot;, for example.</div><div><br></div><div>So why do we=
 need this non-standard stuff ?=C2=A0</div><div><br></div><div>In fact, IMO=
, we should be getting rid of this whole &quot;else {}&quot; clause startin=
g line 728 that tries to guess the prompts based on echo-off ( to mean pass=
word) echo-on (to mean username) etc. Instead, require that the plugin line=
 in the config file must specify expected prompts and replacement strings a=
s above.</div><div><br></div><div>Selva=C2=A0</div></div></div>

--000000000000ffc62205e8f7cc0a--

