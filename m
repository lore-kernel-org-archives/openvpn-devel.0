MIME-Version: 1.0
In-Reply-To: <20151126125313.GX24952@...1296...>
References: <1448514932-13023-1-git-send-email-selva.nair@...277...>
	<20151126125313.GX24952@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 26 Nov 2015 10:56:30 -0500
Message-ID: <CAKuzo_gg5+i6KHN8za4=wEpoTFNHBUo6fpBgJDbs4MaaoDCo4A@...278...>
Content-Type: multipart/alternative; boundary=001a11453cf46bd4240525739f4a
Subject: Re: [Openvpn-devel] [PATCH take2] Unbreak read username password
	from management
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11453cf46bd4240525739f4a
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu, Nov 26, 2015 at 7:53 AM, Gert Doering <gert@...1296...> wrote:

> On Thu, Nov 26, 2015 at 12:15:32AM -0500, Selva Nair wrote:
> > Commit 6e9373c846.. introduced a bug by which auth-user-pass
> > input falls back to read-from-stdin after successfully reading
> > from management.
>
> Mmmmh.  I was all willing to merge the other one -


That one fixed my use case but will break others.. Sorry, I should have
tested more before posting..


> but this one looks
> like a workable alternative as well, just tell the subsequent code
> "we're done, no need to query anymore".
>

Yeah, it ain't pretty. Who uses three bools to handle four cases? For
cleaner code I would kill the bools and get a flag. I hate bools :-) But,
that would entail extensive testing  --- I guess, leave it for some other
time when more changes are made in the context.


>
> Any other variants that could trigger this?


Tested these cases: user from file, pass from stdin; both from file, both
from stdin and both from management with retries triggered by failed auth.

But now that you ask, looked again and I suspect the NEED_OK case also may
trigger the fall back to stdin. That's used when a token is inserted right?
Will try to trigger that and see.

All this to save a feature of dubious utility[*]?

Selva

[*] Well, windows users with a 16 wchar username and two embedded spaces
but 4 char password of "test" may want to save typing username again and
again... Sorry, I'm irked by a patch that broke my vpn :-)

--001a11453cf46bd4240525739f4a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Thu, Nov 26, 2015 at 7:53 AM, Gert D=
oering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_=
blank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex"><span>On Thu, Nov 26, 2015 at 12:15:32AM -0500, Selva Nair wrote:<br>
&gt; Commit 6e9373c846.. introduced a bug by which auth-user-pass<br>
&gt; input falls back to read-from-stdin after successfully reading<br>
&gt; from management.<br>
<br>
</span>Mmmmh.=C2=A0 I was all willing to merge the other one - </blockquote=
><div><br></div><div>That one fixed my use case but will break others.. Sor=
ry, I should have tested more before posting..</div><div>=C2=A0<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">but this one looks<br>
like a workable alternative as well, just tell the subsequent code<br>
&quot;we&#39;re done, no need to query anymore&quot;.<br></blockquote><div>=
<br></div><div>Yeah, it ain&#39;t pretty. Who uses three bools to handle fo=
ur cases? For cleaner code I would kill the bools and get a flag. I hate bo=
ols :-) But, that would entail extensive testing =C2=A0--- I guess, leave i=
t for some other time when more changes are made in the context.</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
<br>
Any other variants that could trigger this?</blockquote></div><div class=3D=
"gmail_extra"><br></div>Tested these cases: user from file, pass from stdin=
; both from file, both from stdin and both from management with retries tri=
ggered by failed auth.</div><div class=3D"gmail_extra"><br></div><div class=
=3D"gmail_extra">But now that you ask, looked again and I suspect the NEED_=
OK case also may trigger the fall back to stdin. That&#39;s used when a tok=
en is inserted right? Will try to trigger that and see.</div><div class=3D"=
gmail_extra"><br></div><div class=3D"gmail_extra">All this to save a featur=
e of dubious utility[*]?<br><br></div><div class=3D"gmail_extra">Selva</div=
><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">[*] Well, =
windows users with a 16 wchar username and two embedded spaces but 4 char p=
assword of &quot;test&quot; may want to save typing username again and agai=
n... Sorry, I&#39;m irked by a patch that broke my vpn :-)</div><div class=
=3D"gmail_extra"><br></div></div>

--001a11453cf46bd4240525739f4a--

