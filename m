MIME-Version: 1.0
References: <20220914185937.31423-1-a@...2181...>
 <20220914185937.31423-2-a@...2181...>
In-Reply-To: <20220914185937.31423-2-a@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 14 Sep 2022 15:26:52 -0400
Message-ID: <CAKuzo_j_yNVkYW1mra2yPnOU3gWSjWSZKk7qkSk3Xjabmc=roA@...278...>
Content-Type: multipart/alternative; boundary="000000000000f9923005e8a81fbb"
Subject: Re: [Openvpn-devel] [PATCH 2/2] get_user_pass_cr: get password from
 stdin if missing inline
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000f9923005e8a81fbb
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 14, 2022 at 3:02 PM Antonio Quartulli <a@...2181...> wrote:

> Until now, when HTTP proxy user and password were specified inline,
> it was assumed that both creds were specified. A missing password would
> result in an empty password being stored.
>
> This behaviour is not ideal, as we want to allow the user to store the
> username, but let the password be entered via stdin.
>
> This affects both http proxy and authentication inline'd creds.
>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  Changes.rst        | 4 +++-
>  src/openvpn/misc.c | 5 +++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/Changes.rst b/Changes.rst
> index 2967533a..2daa97fb 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -89,7 +89,9 @@ Data channel offloading with ovpn-dco
>
>  Inline auth username and password
>      Username and password can now be specified inline in the
> configuration file
> -    within the <auth-user-pass></auth-user-pass> tags.
> +    within the <auth-user-pass></auth-user-pass> tags. If the password is
> +    missing OpenVPN will prompt for input via stdin. This applies to
> inline'd
> +    http-proxy-user-pass too.
>
>
>  Deprecated features
> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
> index 07f6e202..50f7f975 100644
> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -197,6 +197,11 @@ get_user_pass_cr(struct user_pass *up,
>                  buf_parse(&buf, '\n', up->username, USER_PASS_LEN);
>              }
>              buf_parse(&buf, '\n', up->password, USER_PASS_LEN);
> +
> +            if (strlen(up->password) == 0)
> +            {
> +                password_from_stdin = 1;
>

This works when stdin is available, but reading username from file and
password from the management interface is still not possible. Currently, if
--management-query-passwords and --auth-user-pass are used, the file must
contain username and password (management i/f not queried). This patch
allows username only files, but only if reading from stdin is possible.

It may be a bit tricky to prompt the management interface in such cases,
but if we are improving the UX, this is a good opportunity to do a better
job.

Selva



> +            }
>          }
>          /*
>           * Read from auth file unless this is a dynamic challenge request.
> --
> 2.35.1
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000f9923005e8a81fbb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 14, 2022 at 3:02 PM Anton=
io Quartulli &lt;<a href=3D"mailto:a@...2181...">a@...2181...</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Until now, whe=
n HTTP proxy user and password were specified inline,<br>
it was assumed that both creds were specified. A missing password would<br>
result in an empty password being stored.<br>
<br>
This behaviour is not ideal, as we want to allow the user to store the<br>
username, but let the password be entered via stdin.<br>
<br>
This affects both http proxy and authentication inline&#39;d creds.<br>
<br>
Signed-off-by: Antonio Quartulli &lt;<a href=3D"mailto:a@...2181..." target=
=3D"_blank">a@...2181...</a>&gt;<br>
---<br>
=C2=A0Changes.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 4 +++-<br>
=C2=A0src/openvpn/misc.c | 5 +++++<br>
=C2=A02 files changed, 8 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/Changes.rst b/Changes.rst<br>
index 2967533a..2daa97fb 100644<br>
--- a/Changes.rst<br>
+++ b/Changes.rst<br>
@@ -89,7 +89,9 @@ Data channel offloading with ovpn-dco<br>
<br>
=C2=A0Inline auth username and password<br>
=C2=A0 =C2=A0 =C2=A0Username and password can now be specified inline in th=
e configuration file<br>
-=C2=A0 =C2=A0 within the &lt;auth-user-pass&gt;&lt;/auth-user-pass&gt; tag=
s.<br>
+=C2=A0 =C2=A0 within the &lt;auth-user-pass&gt;&lt;/auth-user-pass&gt; tag=
s. If the password is<br>
+=C2=A0 =C2=A0 missing OpenVPN will prompt for input via stdin. This applie=
s to inline&#39;d<br>
+=C2=A0 =C2=A0 http-proxy-user-pass too.<br>
<br>
<br>
=C2=A0Deprecated features<br>
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c<br>
index 07f6e202..50f7f975 100644<br>
--- a/src/openvpn/misc.c<br>
+++ b/src/openvpn/misc.c<br>
@@ -197,6 +197,11 @@ get_user_pass_cr(struct user_pass *up,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_parse(&am=
p;buf, &#39;\n&#39;, up-&gt;username, USER_PASS_LEN);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_parse(&amp;buf, &#39;\n=
&#39;, up-&gt;password, USER_PASS_LEN);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strlen(up-&gt;password) =3D=
=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 password_from_stdi=
n =3D 1;<br></blockquote><div><br></div><div>This works when stdin is avail=
able, but reading username from file and password from the management inter=
face is still not possible. Currently, if --management-query-passwords and =
--auth-user-pass are used, the file must contain username and password (man=
agement i/f not queried). This patch allows username only files, but only i=
f reading from stdin is possible.</div><div><br></div><div>It may be a bit =
tricky to prompt=C2=A0the management=C2=A0interface in such cases, but if w=
e are improving the UX, this is a good opportunity to do a better job.</div=
><div><br></div><div>Selva</div><div><br></div><div>=C2=A0=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Read from auth file unless this is a d=
ynamic challenge request.<br>
-- <br>
2.35.1<br>
<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div></div>

--000000000000f9923005e8a81fbb--

