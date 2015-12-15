MIME-Version: 1.0
In-Reply-To: <CAHSx_SuDffEw7Ufn6ehXJpjLvh8HPtaTxVnnaMBcKMHA5qRuZA@...278...>
References: <CAHSx_StWk=Es9qg9TSq6yXACPhTLneeeUWNDDaKqp06S0x6R=w@...278...>
	<1449766646-3519-1-git-send-email-wayne@...2099...>
	<CAHSx_SuDffEw7Ufn6ehXJpjLvh8HPtaTxVnnaMBcKMHA5qRuZA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 14 Dec 2015 19:10:58 -0500
Message-ID: <CAKuzo_i9gn_0f0cvKAgp2t3Gi2UL5GcLJRrUiZDEZYLpHM=RWA@...278...>
Content-Type: multipart/alternative; boundary=001a1148ce1cec81ff0526e4a04b
Subject: Re: [Openvpn-devel] [PATCH] Improve stdin prompting section,
 fixing CR prompting.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Wayne Davison <wayne@...2099...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1148ce1cec81ff0526e4a04b
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon, Dec 14, 2015 at 4:56 PM, Wayne Davison <wayne@...2099...> wrote:

>
> On Thu, Dec 10, 2015 at 8:57 AM, Wayne Davison <wayne@...2099...>
> wrote:
>
>>  src/openvpn/misc.c | 119
>> +++++++++++++++++++++++++----------------------------
>>  1 file changed, 57 insertions(+), 62 deletions(-)
>>
>
> Any questions I can answer about this patch?  This is such a
> straight-forward bug with a simple fix that I'd hope that it makes it into
> the upcoming release. (The patch is mainly re-indenting, which bloats it a
> good bit.)
>

I took a quick look and it seems a simplified patch that addresses
the most critical-sounding issue (challenge/reponse not prompted for
from stdin) may be more useful.

From the cover-letter to the patches:

There is a bug in the challenge/response code when the username & password
> is read from a file -- the response is never prompted for.  This bug
> affects
> older versions, including 2.3.8.
>

A patch that fixes that and only that is easier to review.

I also added code to read the response out of the --auth-user-pass file if
> there is a 3rd line present.  This is particularly useful for an 2FA setup
> where the response is unchanging (in my case it is always "push" for a Duo
> Push).
>

I see no compelling reason to read response to a challenge from a file.
If the response is unchanging, its a misuse of challenge/response.
Implemet the check on the server such that it doesn't have to hear
"push" every time from the client. In case of, duo it could be an
out-of-band way to add user preferences on the sever saying user1
prefers push, user2 phone,  user3 sms etc. Or send it attached to
the username or password and parse it in the server-side user-pass-verify
script or in a custom pam_module, for example. This is a custom use
case trying to exploit CR for something else. Nothing wrong with that, but
may be done without adding a new "feature" into OpenVPN.

Selva

--001a1148ce1cec81ff0526e4a04b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div><div class=3D"gmail_extra"><br><div class=3D"g=
mail_quote">On Mon, Dec 14, 2015 at 4:56 PM, Wayne Davison <span dir=3D"ltr=
">&lt;<a href=3D"mailto:wayne@...2099..." target=3D"_blank">wayne@...2107...=
.</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote=
">On Thu, Dec 10, 2015 at 8:57 AM, Wayne Davison <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:wayne@...2099..." target=3D"_blank">wayne@...2099...</a>&gt;<=
/span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0sr=
c/openvpn/misc.c | 119 +++++++++++++++++++++++++---------------------------=
-<br>
=C2=A01 file changed, 57 insertions(+), 62 deletions(-)<br></blockquote><di=
v><br></div><div>Any questions I can answer about this patch?=C2=A0 This is=
 such a straight-forward bug with a simple fix that I&#39;d hope that it ma=
kes it into the upcoming release. (The patch is mainly re-indenting, which =
bloats it a good bit.)=C2=A0</div></div></div></div></blockquote><div><br><=
/div><div>I took a quick look and it seems a simplified patch that addresse=
s<br></div><div>the most critical-sounding issue (challenge/reponse not pro=
mpted for <br>from stdin) may be more useful.<br> </div><div><br>From the c=
over-letter to the patches:<br><br><blockquote style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex" class=3D"gma=
il_quote">There is a bug in the challenge/response code when the username &=
amp; password<br>
is read from a file -- the response is never prompted for.=C2=A0 This bug a=
ffects<br>
older versions, including 2.3.8.=C2=A0 <br></blockquote><div><br></div><div=
>A patch that fixes that and only that is easier to review.<br></div>
<br><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb=
(204,204,204);padding-left:1ex" class=3D"gmail_quote">
I also added code to read the response out of the --auth-user-pass file if<=
br>
there is a 3rd line present.=C2=A0 This is particularly useful for an 2FA s=
etup<br>
where the response is unchanging (in my case it is always &quot;push&quot; =
for a Duo<br>
Push).<br></blockquote>
<br>I see no compelling reason to read response to a challenge from a file.=
 <br>If the response is unchanging, its a misuse of challenge/response.=C2=
=A0 <br>Implemet the check on the server such that it doesn&#39;t have to h=
ear <br>&quot;push&quot; every time from the client. In case of, duo it cou=
ld be an <br>out-of-band way to add user preferences on the sever saying us=
er1 <br>prefers push, user2 phone,=C2=A0 user3 sms etc. Or send it attached=
 to <br>the username or password and parse it in the server-side user-pass-=
verify <br>script or in a custom pam_module, for example. This is a custom =
use <br>case trying to exploit CR for something else. Nothing wrong with th=
at, but <br>may be done without adding a new &quot;feature&quot; into OpenV=
PN.<br></div><div><br></div></div><div class=3D"gmail_quote">Selva<br></div=
></div></div></div>

--001a1148ce1cec81ff0526e4a04b--

