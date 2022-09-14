MIME-Version: 1.0
References: <20220914185937.31423-1-a@...2181...>
 <20220914185937.31423-2-a@...2181...>
 <CAKuzo_j_yNVkYW1mra2yPnOU3gWSjWSZKk7qkSk3Xjabmc=roA@...278...>
 <01a373b7-3a39-6d43-a398-ab5603d03ace@...2181...>
In-Reply-To: <01a373b7-3a39-6d43-a398-ab5603d03ace@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 14 Sep 2022 15:40:28 -0400
Message-ID: <CAKuzo_juNUMo_31sXvKxHE+9vAMC3vK7YS8ueUZF_OKkb5np6g@...278...>
Content-Type: multipart/alternative; boundary="00000000000099cf3f05e8a8506e"
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

--00000000000099cf3f05e8a8506e
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 14, 2022 at 3:30 PM Antonio Quartulli <a@...2181...> wrote:

> Hi,
>
> On 14/09/2022 21:26, Selva Nair wrote:
> >     diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
> >     index 07f6e202..50f7f975 100644
> >     --- a/src/openvpn/misc.c
> >     +++ b/src/openvpn/misc.c
> >     @@ -197,6 +197,11 @@ get_user_pass_cr(struct user_pass *up,
> >                       buf_parse(&buf, '\n', up->username, USER_PASS_LEN);
> >                   }
> >                   buf_parse(&buf, '\n', up->password, USER_PASS_LEN);
> >     +
> >     +            if (strlen(up->password) == 0)
> >     +            {
> >     +                password_from_stdin = 1;
> >
> >
> > This works when stdin is available, but reading username from file and
> > password from the management interface is still not possible. Currently,
> > if --management-query-passwords and --auth-user-pass are used, the file
> > must contain username and password (management i/f not queried). This
> > patch allows username only files, but only if reading from stdin is
> > possible.
>
> Just to make sure I got your comment right: this patch is not allowing
> files to have no password (this is allowed already without this patch).
> This patch is only allowing having no password when doing inline
> credentials.
>
> Does your comment still apply?
>
> If the mgmt interface has troubles with querying the password, then it
> means we already have this problem without the patch, right?
>

Yes, on re-reading the patches, my comment was not totally accurate..

The issue is long-standing one with username/password in file --- if
password is missing it's not prompted from the management interface even if
management-query-passwords is in effect. Instead it's prompted from stdin
which is generally not available when run from a GUI.

So, yes, its not a fault of this patch, except that its committing the same
"mistake" of not using the management interface instead of stdin as the
fallback when "--management-query-passwords" is in effect.

Selva

--00000000000099cf3f05e8a8506e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 14, 2022 at 3:30 PM Antonio Q=
uartulli &lt;<a href=3D"mailto:a@...2181...">a@...2181...</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On 14/09/2022 21:26, Selva Nair wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/src/openvpn/misc.c b/src/openvpn/misc.=
c<br>
&gt;=C2=A0 =C2=A0 =C2=A0index 07f6e202..50f7f975 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/src/openvpn/misc.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/src/openvpn/misc.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -197,6 +197,11 @@ get_user_pass_cr(struct user_p=
ass *up,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0buf_parse(&amp;buf, &#39;\n&#39;, up-&gt;username, USER_PASS_L=
EN);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bu=
f_parse(&amp;buf, &#39;\n&#39;, up-&gt;password, USER_PASS_LEN);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strl=
en(up-&gt;password) =3D=3D 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 password_from_stdin =3D 1;<br>
&gt; <br>
&gt; <br>
&gt; This works when stdin is available, but reading username from file and=
 <br>
&gt; password from the management interface is still not possible. Currentl=
y, <br>
&gt; if --management-query-passwords and --auth-user-pass are used, the fil=
e <br>
&gt; must contain username and password (management i/f not queried). This =
<br>
&gt; patch allows username only files, but only if reading from stdin is <b=
r>
&gt; possible.<br>
<br>
Just to make sure I got your comment right: this patch is not allowing <br>
files to have no password (this is allowed already without this patch).<br>
This patch is only allowing having no password when doing inline <br>
credentials.<br>
<br>
Does your comment still apply?<br>
<br>
If the mgmt interface has troubles with querying the password, then it <br>
means we already have this problem without the patch, right?<br></blockquot=
e><div><br></div><div>Yes, on re-reading the patches, my comment was not to=
tally accurate..=C2=A0</div><div><br></div><div>The issue is long-standing =
one with username/password in file --- if password is missing it&#39;s not =
prompted from the management interface even if management-query-passwords i=
s in effect. Instead it&#39;s prompted from stdin which is generally not av=
ailable when run from a GUI.</div><div><br></div><div>So, yes, its not a fa=
ult of this patch, except that its committing the same &quot;mistake&quot; =
of not using the management interface instead of stdin as the fallback when=
 &quot;--management-query-passwords&quot; is in effect.</div><div><br></div=
><div>Selva=C2=A0</div></div></div>

--00000000000099cf3f05e8a8506e--

