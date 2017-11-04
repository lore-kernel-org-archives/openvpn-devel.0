MIME-Version: 1.0
In-Reply-To: <20171104175814.GY958@...1296...>
References: <1509192147.3021.6.camel@...2316...>
 <1509192205.3021.7.camel@...2316...>
 <CAFHpkQHXWrXn42B1xr0YuPvQUrOSvUqQU6h8RkP_EgP_iBP5Qw@...278...>
 <1509289652.3116.11.camel@...2316...>
 <72a75ffb-67df-0986-7b64-9080254cc084@...2181...>
 <1509292633.3116.16.camel@...2316...>
 <d2079a55-a8c4-95be-4385-75d164a9f8c5@...1856...>
 <20171104175814.GY958@...1296...>
From: Selva <selva.nair@...277...>
Date: Sat, 4 Nov 2017 15:34:29 -0400
Message-ID: <CAKuzo_i-CvWA0SFdTLMcN0c6DgV8DMe450NoWMSjf6iapLfcvg@...278...>
Content-Type: multipart/alternative; boundary="001a113e916496a0db055d2d50f7"
Subject: Re: [Openvpn-devel] [PATCH 1/1] openssl: add engine method for
 loading the key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Steffan Karger <steffan@...1856...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113e916496a0db055d2d50f7
Content-Type: text/plain; charset="UTF-8"

On Sat, Nov 4, 2017 at 1:58 PM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Wed, Nov 01, 2017 at 07:24:02PM +0100, Steffan Karger wrote:
> > This looks like it should use our user query wrappers from (e.g.)
> > console.h.  David, you're the expert here, what should James use to
> > query for passwords?
>
> The mechanics are "query_user_...()", most conveniently
>
> /**
>  * A plain "make Gert happy" wrapper.  Same arguments as @query_user_add
>  */
> static inline bool
> query_user_SINGLE(char *prompt, size_t prompt_len,
>                   char *resp, size_t resp_len,
>                   bool echo)
>
> (console.h)
>
> ... most notably this is important because it can use "other mechanisms"
> if console input is not available, for example, systemd querying.
>

Shouldn't this  happen automatically in this particular case as the patch
uses
SSL_CTX_get_default_passwd_cb_userdata() which would result in openssl using
to the password callback previously set in ssl_openssl.c ? And that
callback is
get_userpass() which should know whether to query the management, console or
something else.

Selva

--001a113e916496a0db055d2d50f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Sat, Nov 4, 2017 at 1:58 PM, Gert Doering <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</s=
pan> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<span class=3D"gmail-"><br>
On Wed, Nov 01, 2017 at 07:24:02PM +0100, Steffan Karger wrote:<br>
&gt; This looks like it should use our user query wrappers from (e.g.)<br>
&gt; console.h.=C2=A0 David, you&#39;re the expert here, what should James =
use to<br>
&gt; query for passwords?<br>
<br>
</span>The mechanics are &quot;query_user_...()&quot;, most conveniently<br>
<br>
/**<br>
=C2=A0* A plain &quot;make Gert happy&quot; wrapper.=C2=A0 Same arguments a=
s @query_user_add<br>
=C2=A0*/<br>
static inline bool<br>
query_user_SINGLE(char *prompt, size_t prompt_len,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *resp, =
size_t resp_len,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool echo)<b=
r>
<br>
(console.h)<br>
<br>
... most notably this is important because it can use &quot;other mechanism=
s&quot;<br>
if console input is not available, for example, systemd querying.<br></bloc=
kquote><div><br></div><div>Shouldn&#39;t this =C2=A0happen automatically in=
 this particular case as the patch uses</div><div>SSL_CTX_get_default_passw=
d_cb_userdata() which would result in openssl using</div><div>to the passwo=
rd callback previously set in ssl_openssl.c ? And that callback is</div><di=
v>get_userpass() which should know whether to query the management, console=
 or</div><div>something else.</div><div><br></div><div>Selva</div></div></d=
iv></div>

--001a113e916496a0db055d2d50f7--

