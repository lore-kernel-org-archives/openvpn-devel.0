MIME-Version: 1.0
References: <20220704025840.2558-1-selva.nair@...277...>
 <0f37a675-519a-8223-70c1-23c1ef477347@...1227...>
In-Reply-To: <0f37a675-519a-8223-70c1-23c1ef477347@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 4 Jul 2022 06:35:29 -0400
Message-ID: <CAKuzo_jLwu+KrB_ovzhemjbWUGZZOcL_oJ17uZJVskNYADKCtA@...278...>
Content-Type: multipart/alternative; boundary="0000000000007c85ec05e2f84cf1"
Subject: Re: [Openvpn-devel] [PATCH] Fix auth-token usage with
 management-def-auth
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000007c85ec05e2f84cf1
Content-Type: text/plain; charset="UTF-8"

Hi

On Mon, Jul 4, 2022 at 5:50 AM Arne Schwabe <arne@...1227...> wrote:

> Am 04.07.22 um 04:58 schrieb selva.nair@...277...:
> > From: Selva Nair <selva.nair@...277...>
> >
> > When auth-token verify succeeds during a reauth, other auth
> > methods (plugin, script, management) are skipped unless
> > external-auth is in effect (skip_auth gets set to true).
> >
> > However, in this case, the status of management-def-auth
> > (ks->mda_satus) stays at its default value of ACF_PENDING
>
> ks->mda_status
>
> > and will never change. This causes TLS keys to go out of sync
> > and an eventual client disconnect.
> >
> > Further, a message saying username/password authentication is
> > "deferred" gets logged which is misleading.
> > For example:
> >
> > test/127.0.0.1:35874 TLS: Username/auth-token authentication
> >      succeeded for username 'test'
> >
> > followed by
> >
> > test/127.0.0.1:35874 TLS: Username/Password authentication
> >      deferred for username 'test' [CN SET]
> >
> > Fix by setting ks->mda_status to ACF_DISABLED, and do not
> > set ks->authenticated = KS_AUTH_DEFERRED when skip_auth is true.
> >
> > Also log a warning message when token is marked as expired on
> > missing the reneg window.
> >
> > Reported by: Connor Edwards <connor.edwards@...2680...>
> >
>
> Acked-By: Arne Schwabe <arne@...1227...>
>
> Note that you need have management enabled for this bug to trigger. If
> you go through all the effort to talk to management like this, you
> probably want to use external-auth anyway.
>

I agree. This kind of fiddling with flags like mda_status is not clean and
easy to break again. I use management-def-auth but do not use
auth-gen-token -- instead the management script keeps track of
reauth, lifetime of 2FA etc. If I were to "modernize" that setup I would
use auth-gen-token with external-auth as well.

That said, for 2.5, an easy fix like this is good enough?

Selva

--0000000000007c85ec05e2f84cf1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Jul 4, 2022 at 5:50 AM Arne Schwabe &lt;<a =
href=3D"mailto:arne@...1227...">arne@...1227...</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Am 04.07.22 um 04:58 schrieb=
 <a href=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...1664...=
7...</a>:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt; <br>
&gt; When auth-token verify succeeds during a reauth, other auth<br>
&gt; methods (plugin, script, management) are skipped unless<br>
&gt; external-auth is in effect (skip_auth gets set to true).<br>
&gt; <br>
&gt; However, in this case, the status of management-def-auth<br>
&gt; (ks-&gt;mda_satus) stays at its default value of ACF_PENDING<br>
<br>
ks-&gt;mda_status<br>
<br>
&gt; and will never change. This causes TLS keys to go out of sync<br>
&gt; and an eventual client disconnect.<br>
&gt; <br>
&gt; Further, a message saying username/password authentication is<br>
&gt; &quot;deferred&quot; gets logged which is misleading.<br>
&gt; For example:<br>
&gt; <br>
&gt; test/<a href=3D"http://127.0.0.1:35874" rel=3D"noreferrer" target=3D"_=
blank">127.0.0.1:35874</a> TLS: Username/auth-token authentication<br>
&gt;=C2=A0 =C2=A0 =C2=A0 succeeded for username &#39;test&#39;<br>
&gt; <br>
&gt; followed by<br>
&gt; <br>
&gt; test/<a href=3D"http://127.0.0.1:35874" rel=3D"noreferrer" target=3D"_=
blank">127.0.0.1:35874</a> TLS: Username/Password authentication<br>
&gt;=C2=A0 =C2=A0 =C2=A0 deferred for username &#39;test&#39; [CN SET]<br>
&gt; <br>
&gt; Fix by setting ks-&gt;mda_status to ACF_DISABLED, and do not<br>
&gt; set ks-&gt;authenticated =3D KS_AUTH_DEFERRED when skip_auth is true.<=
br>
&gt; <br>
&gt; Also log a warning message when token is marked as expired on<br>
&gt; missing the reneg window.<br>
&gt; <br>
&gt; Reported by: Connor Edwards &lt;<a href=3D"mailto:connor.edwards@...2375...=
80..." target=3D"_blank">connor.edwards@...2680...</a>&gt;<br>
&gt; <br>
<br>
Acked-By: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=3D"_bl=
ank">arne@...1227...</a>&gt;<br>
<br>
Note that you need have management enabled for this bug to trigger. If <br>
you go through all the effort to talk to management like this, you <br>
probably want to use external-auth anyway.<br></blockquote><div><br></div><=
div>I agree. This kind of fiddling with flags like mda_status is not clean =
and easy to break again. I use management-def-auth but do not use auth-gen-=
token -- instead the management script keeps track of reauth,=C2=A0lifetime=
 of 2FA etc. If I were to &quot;modernize&quot; that setup I would use auth=
-gen-token with external-auth as well.</div><div><br></div><div>That said, =
for 2.5, an easy fix like this is good enough?</div><div><br></div><div>Sel=
va</div></div></div>

--0000000000007c85ec05e2f84cf1--

