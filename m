MIME-Version: 1.0
In-Reply-To: <CAHSx_StE=b4GB28JO46Vzrdh6CYKTEZCr_sU62VzSHX6nH0r+Q@...278...>
References: <CAKuzo_gVUcS+j0jfoUjSYknd+G_wOqGttxTV60tuB=3RLakg4A@...278...>
	<CAHSx_StE=b4GB28JO46Vzrdh6CYKTEZCr_sU62VzSHX6nH0r+Q@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 18 Dec 2015 00:23:35 -0500
Message-ID: <CAKuzo_iVqWOBvfxi78pXFG3+O3+QcX6MJfO2EuokROaYX3gd8w@...278...>
Content-Type: multipart/alternative; boundary=001a1142b97a7da17705272558f4
Subject: Re: [Openvpn-devel] Issues with challenge-response when user/pass
 is read from a file
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

--001a1142b97a7da17705272558f4
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu, Dec 17, 2015 at 5:45 PM, Wayne Davison <wayne@...2099...> wrote:

> On Thu, Dec 17, 2015 at 1:22 PM, Selva Nair <selva.nair@...277...> wrote:
>
>> (a) leave as is and document that challenge-response is incompatible with
>> user and pass from file
>>
>
> If people lean this way I think the code would still need to be changed to
> fail instead of endlessly looping, sending bad answers back to the server.
>

Thanks for the comments.

Yes, incompatible options can be made to trigger an error. But only for
static-challenge, not with dynamic challenge as that is initiated by the
server. The  endless looping is due to "auth-retry interact", which means
keep trying after auth failure.


>
> (b) prompt for the response from console in both dynamic and static cases
>>
>
> That gets my vote, for what that's worth.
>
> Prompting from management works fine as long as auth-user-pass file is not
>> set.
>>
>
> I assume that would be something you'd fix (or make the program reject).
> The current code does not prompt on the management interface for a
> challenge/response if someone combines --management,
> --management-query-passwords, and an auth-user-pass file.
>

Specifying management-query-passwords and a user-pass file is obviously
ambiguous. Currently user-pass file takes precedence. So user/pass/response
will not be queried from management if a user-pass file is specified.


> Ultimately, though, I've switched over to a simple perl script I wrote
> that runs a managed openvpn and gives me full control w/o using
> --auth-user-pass (since the official release is not going to support
> reading the challenge/response from a file).
>

Hard to justify the extra code needed to support response from file. If the
response is like an OTP (ever changing), reading from file is hardly
useful. For the unusual case of a fixed response, a determined user could
make a user-pass file with password and response packed into one line as
"SCRV1:base64:base64" (assuming static challenge).

Selva

--001a1142b97a7da17705272558f4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br></div><div class=3D"gmail_extra"><div class=3D"gmail_quote">On Thu=
, Dec 17, 2015 at 5:45 PM, Wayne <span>Davison</span> <span dir=3D"ltr">&lt=
;<a href=3D"mailto:wayne@...2099..." target=3D"_blank"><span>wayne</span>@<=
span>opencoder</span>.net</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-le=
ft-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex"><span>O=
n Thu, Dec 17, 2015 at 1:22 PM, Selva Nair <span dir=3D"ltr">&lt;<a href=3D=
"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color=
:rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div><div><div><div><d=
iv><div><div>(a) leave as is and document that challenge-response is incomp=
atible with user and pass from file<br></div></div></div></div></div></div>=
</div></div></blockquote><div><br></div></span><div>If people lean this way=
 I think the code would still need to be changed to fail instead of endless=
ly looping, sending bad answers back to the server.</div></blockquote><div>=
=C2=A0</div><div>Thanks for the comments.</div><div><br></div><div>Yes, inc=
ompatible options can be made to trigger an error. But only for static-chal=
lenge, not with dynamic challenge as that is initiated by the server. The =
=C2=A0endless looping is due to &quot;auth-retry interact&quot;, which mean=
s keep trying after auth failure.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">=
<span><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-col=
or:rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div><div><div><div>=
<div><div><div></div></div></div></div>(b) prompt for the response from <sp=
an>console</span> in both dynamic and static cases</div></div></div></div><=
/blockquote><div><br></div></span><div>That gets my vote, for what that&#39=
;s worth.</div><span><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;=
border-left-color:rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>=
<div>Prompting from management works fine as long as auth-user-pass file is=
 not set.<br></div></div></div></blockquote><div><br></div></span><div>I as=
sume that would be something you&#39;d fix (or make the program reject).=C2=
=A0 The current code does not prompt on the management interface for a chal=
lenge/response if someone combines --management, --management-query-passwor=
ds, and an auth-user-pass file.</div></blockquote><div><br></div><div>Speci=
fying=C2=A0management-query-passwords and a user-pass file is obviously amb=
iguous. Currently user-pass file takes precedence. So user/pass/response wi=
ll not be queried from management if a user-pass file is specified.</div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb=
(204,204,204);padding-left:1ex"><div>Ultimately, though, I&#39;ve switched =
over to a simple perl script I wrote that runs a managed openvpn and gives =
me full control w/o using --auth-user-pass (since the official release is n=
ot going to support reading the challenge/response from a file).</div></blo=
ckquote><div><br></div><div>Hard to justify the extra code needed to suppor=
t response from file. If the response is like an OTP (ever changing), readi=
ng from file is hardly useful.=C2=A0For the unusual case of a fixed respons=
e, a determined user could make a user-pass file with password and response=
 packed into one line as &quot;SCRV1:base64:base64&quot; (assuming static c=
hallenge).<br></div><div><br></div><div><span>Selva</span></div><div><br></=
div></div></div></div>

--001a1142b97a7da17705272558f4--

