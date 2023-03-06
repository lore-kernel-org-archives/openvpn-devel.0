MIME-Version: 1.0
References: <20230306053346.796992-1-selva.nair@...277...>
 <20230306053346.796992-2-selva.nair@...277...>
In-Reply-To: <20230306053346.796992-2-selva.nair@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 6 Mar 2023 13:38:27 -0500
Message-ID: <CAKuzo_joy5D+mKffGqwub73kAynz9OKosfXsWS1aKaXUNsDQnQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000bfc96805f63f9ae8"
Subject: Re: [Openvpn-devel] [PATCH 2/2] Include supplementary groups when
 checking management-client-group
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--000000000000bfc96805f63f9ae8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

FTR, I just noticed that the patch is missing an endgrent() call:

On Mon, Mar 6, 2023 at 12:33=E2=80=AFAM <selva.nair@...277...> wrote:

>
> +    struct group *gr =3D getgrent();
> +    char **members =3D NULL;
> +    while (gr)
> +    {
> +        if (gr->gr_gid =3D=3D gid)
> +        {
> +            /* found the group -- check user is a member */
> +            members =3D gr->gr_mem;
> +            for (char *s =3D *members; s && !ret; s++)
> +            {
> +                ret =3D !strcmp(s, pw->pw_name);
> +            }
> +            break; /* out of the while loop */
> +        }
> +        gr =3D getgrent();
> +    }
>

          endgrent();


> +#endif /* if defined(HAVE_GETPWUID) && defined(HAVE_GETGRENT) */
> +    return ret;
> +}
> +
>

Will delay v2 depending on the fate of this patch.

Selva

--000000000000bfc96805f63f9ae8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><div><br></div>FTR, I just noticed that the p=
atch is missing=C2=A0an endgrent() call:<div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 6, 2023 at 12:33=E2=80=
=AFAM &lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.n=
air@...277...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex"><br>
+=C2=A0 =C2=A0 struct group *gr =3D getgrent();<br>
+=C2=A0 =C2=A0 char **members =3D NULL;<br>
+=C2=A0 =C2=A0 while (gr)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (gr-&gt;gr_gid =3D=3D gid)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* found the group -- check user=
 is a member */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 members =3D gr-&gt;gr_mem;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (char *s =3D *members; s &am=
p;&amp; !ret; s++)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D !strcmp(s,=
 pw-&gt;pw_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break; /* out of the while loop =
*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gr =3D getgrent();<br>
+=C2=A0 =C2=A0 }<br></blockquote><div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 endgrent();</div><div>=C2=A0<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
+#endif /* if defined(HAVE_GETPWUID) &amp;&amp; defined(HAVE_GETGRENT) */<b=
r>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br></blockquote></div></div><blockquote style=3D"margin:0 0 0 40px;border=
:none;padding:0px"><div><div class=3D"gmail_quote"><div><br></div></div></d=
iv></blockquote>Will delay v2 depending on the fate of this patch.<br><div>=
<div class=3D"gmail_quote"><div><br></div><div>Selva=C2=A0</div></div></div=
></div>

--000000000000bfc96805f63f9ae8--

