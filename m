MIME-Version: 1.0
References: <CAGyAFMV36+05+TLJ4v9vQwikVv_X4xqqmvMp+Ah-Kip5oM9hjA@...278...>
 <20211119005306.624-1-lstipakov@...277...> <YZ02pLWqooAtu54O@...1296...>
In-Reply-To: <YZ02pLWqooAtu54O@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 23 Nov 2021 13:55:12 -0500
Message-ID: <CAKuzo_gy8WZUH__KcofJ3_WP4uwy9FGh5mfho-1h1TsDbQENyQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000e5fddd05d1794830"
Subject: Re: [Openvpn-devel] [PATCH v3] Load OpenSSL config on Windows from
 trusted location
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Lev Stipakov <lstipakov@...277...>, Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000e5fddd05d1794830
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 23, 2021 at 1:46 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Fri, Nov 19, 2021 at 02:53:06AM +0200, Lev Stipakov wrote:
> > +    if ((install_path[wcslen(install_path) - 1]) == L'\\')
> > +    {
> > +        install_path[wcslen(install_path) - 1] = L'\0';
> > +    }
> > +
> > +    WCHAR openssl_cnf[MAX_PATH] = {0};
> > +    WCHAR openssl_engines[MAX_PATH] = {0};
> > +    WCHAR openssl_modules[MAX_PATH] = {0};
> > +
> > +    openvpn_swprintf(openssl_cnf, _countof(install_path),
> > +        L"OPENSSL_CONF=%ls\\ssl\\openssl.cnf", install_path);
>
> This needs to be _countof(openssl_cnf) - even if they are the same
> today, they might not be tomorrow.
>
> While at it, I wonder if it is more orderly to move the swprintf()
> calls in the "if NULL" clause now...  like this:
>
>    if (_wgetenv(L"OPENSSL_CONF") == NULL)
>    {
>        WCHAR openssl_cnf[MAX_PATH] = {0};
>
>        openvpn_swprintf(openssl_cnf, _countof(openssl_cnf),
>            L"OPENSSL_CONF=%ls\\ssl\\openssl.cnf", install_path);
>        _wputenv(openssl_cnf);
>    }
>
> (I would not have brought this up for a v4, but the _countof() needs
> to be fixed anyway)
>

If you are doing a v4 you may want to consider:

static struct {
   wchar_t *name;
   wchar_t *value;
} ossl_env[] = {{L"OPENSSL_CNF", L"openssl.cnf"},
                        {"OPENSSL_ENGINES", L"engines"},
                        {..}};

and use a loop. Less local arrays, easy to add more to the env zoo later
etc..

Just saying --- I'm okay with the current style too.


> Regarding Selva's comment on the scope of the memory passed to _wputenv(),
> I checked MS documentation, and it does not say anything.
>

MS docs say _putenv is their implementation of POSIX putenv but the latter
does imply the pointer supplied by the user should be used as is. Anyway,
if it works with automatics, good for us.


>
> OTOH, it points to _wputenv_s(varname,string) which might be worth
> considering...
>

+1 to that especially if MSVC is planning to deprecate _wputenv as they
have already done for a  host of other such functions.

Selva

--000000000000e5fddd05d1794830
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 23, 2021 at 1:46 PM Gert =
Doering &lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Fri, Nov 19, 2021 at 02:53:06AM +0200, Lev Stipakov wrote:<br>
&gt; +=C2=A0 =C2=A0 if ((install_path[wcslen(install_path) - 1]) =3D=3D L&#=
39;\\&#39;)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 install_path[wcslen(install_path) - 1] =
=3D L&#39;\0&#39;;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 WCHAR openssl_cnf[MAX_PATH] =3D {0};<br>
&gt; +=C2=A0 =C2=A0 WCHAR openssl_engines[MAX_PATH] =3D {0};<br>
&gt; +=C2=A0 =C2=A0 WCHAR openssl_modules[MAX_PATH] =3D {0};<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 openvpn_swprintf(openssl_cnf, _countof(install_path),<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 L&quot;OPENSSL_CONF=3D%ls\\ssl\\openssl.c=
nf&quot;, install_path);<br>
<br>
This needs to be _countof(openssl_cnf) - even if they are the same<br>
today, they might not be tomorrow.<br>
<br>
While at it, I wonder if it is more orderly to move the swprintf()<br>
calls in the &quot;if NULL&quot; clause now...=C2=A0 like this:<br>
<br>
=C2=A0 =C2=A0if (_wgetenv(L&quot;OPENSSL_CONF&quot;) =3D=3D NULL)<br>
=C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0WCHAR openssl_cnf[MAX_PATH] =3D {0};<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0openvpn_swprintf(openssl_cnf, _countof(openssl_c=
nf),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0L&quot;OPENSSL_CONF=3D%ls\\ssl\\op=
enssl.cnf&quot;, install_path);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0_wputenv(openssl_cnf);<br>
=C2=A0 =C2=A0}<br>
<br>
(I would not have brought this up for a v4, but the _countof() needs<br>
to be fixed anyway)<br></blockquote><div><br></div><div>If you are doing a =
v4 you may want to consider:</div><div><br></div><div>static struct {</div>=
<div>=C2=A0 =C2=A0wchar_t *name;</div><div>=C2=A0 =C2=A0wchar_t *value;</di=
v><div>} ossl_env[] =3D {{L&quot;OPENSSL_CNF&quot;, L&quot;openssl.cnf&quot=
;},</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;OPENSSL_ENGINES&quot;, L&quot;engines&quot;=
},</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 {..}};</div><div><br></div><div>and use a loop. Less =
local arrays, easy to add more to the env zoo later etc..</div><div><br></d=
iv><div>Just saying --- I&#39;m okay with the current style too.=C2=A0=C2=
=A0</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Regarding Selva&#39;s comment on the scope of the memory passed to _wputenv=
(),<br>
I checked MS documentation, and it does not say anything.<br></blockquote><=
div><br></div><div>MS docs say _putenv is their implementation of POSIX=C2=
=A0putenv but the latter does imply the pointer supplied by the user should=
 be used as is. Anyway, if it works with automatics, good for us.</div><div=
>=C2=A0=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
OTOH, it points to _wputenv_s(varname,string) which might be worth<br>
considering...<br></blockquote><div><br></div><div>+1 to that especially if=
 MSVC is planning to deprecate _wputenv as they have already done for a=C2=
=A0 host of other such functions.</div><div><br></div><div>Selva</div></div=
></div>

--000000000000e5fddd05d1794830--

