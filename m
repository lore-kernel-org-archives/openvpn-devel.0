MIME-Version: 1.0
References: <CAKuzo_gRebSz5GObVLJodQvxV2x1XvxFoXoBxe6RuC3fb3eJog@...278...>
 <Y1BkbnMzpOPVsx3v@...1296...>
In-Reply-To: <Y1BkbnMzpOPVsx3v@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 20 Oct 2022 12:35:53 -0400
Message-ID: <CAKuzo_jT-NN+jq3iq0g8bzRsKn9yPabFaU2GQ9X82Mpqr7gCpA@...278...>
Content-Type: multipart/alternative; boundary="00000000000033051805eb79ecfd"
Subject: Re: [Openvpn-devel] Is auth-nocache broken?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000033051805eb79ecfd
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, Oct 19, 2022 at 4:56 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Wed, Oct 19, 2022 at 02:33:27PM -0400, Selva Nair wrote:
> > Using --auth-user-pass, --auth-nocache and --reneg-sec <a small value>,
> no
> > auth-tokens in use, I see that username/password is prompted on the first
> > connection attempt and at first renegotiation. After that reneg completes
> > without prompting for user/pass.
>
> It's possibly we broke that by trying to repair all the corner cases
> with either pushing tokens from the server, or *not* using auth-nocache.
>
> I assume you tested with master?
>
> (Unfortunately my automated tests all use "username + passwords are
> coming from a file", which means "send the same one as before" and
> "go read the file again" both produce the same effect... having
> a management-interface driven client test would help here... no
> time yet to write one)


This is broken for a while now -- since commit
dfd624b52bce7ddd0eeaab516df9848e432f3242
(*2.4 and 2.5 are also affected*)
That commit changed the earlier delayed purge logic to

-        if (!auth_user_pass.wait_for_push)
+        if (!session->opt->pull)
         {
             purge_user_pass(&auth_user_pass, false);
         }

In clients that pull, "wait_push" used to be set to false on completing the
first
negotiation, but after this change we are not purging user/pass at all at
this
point.
Purging still happens on first negotiation in "set_auth_token()" as before,
but that will not get called during renegs unless auth-token is in use and
a new token gets pushed after expiry.

Not clearing the username has been rejected in the past although, somehow,
retaining it with the token has been found acceptable. Instead, we went for
a convoluted logic that has proven itself to be hard to get right.

A compromise is to continue to clear username in the auth_user_pass struct
for
appearances sake (for nocache contract), but always retain it in the
auth_token
struct.That would considerably simplify the logic as well
(see e.g.,
https://github.com/selvanair/openvpn/commit/e9bf3c8227e365099deaadc11d31ac8a0c7668d7
)

Selva

--00000000000033051805eb79ecfd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Wed, Oct 19, 2022 at 4:56 PM Gert Doering &lt;<=
a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Wed, Oct 19, 2022 at 02:33:27PM -0400, Selva Nair wrote:<br>
&gt; Using --auth-user-pass, --auth-nocache and --reneg-sec &lt;a small val=
ue&gt;, no<br>
&gt; auth-tokens in use, I see that username/password is prompted on the fi=
rst<br>
&gt; connection attempt and at first renegotiation. After that reneg comple=
tes<br>
&gt; without prompting for user/pass.<br>
<br>
It&#39;s possibly we broke that by trying to repair all the corner cases<br>
with either pushing tokens from the server, or *not* using auth-nocache.<br>
<br>
I assume you tested with master?<br>
<br>
(Unfortunately my automated tests all use &quot;username + passwords are<br>
coming from a file&quot;, which means &quot;send the same one as before&quo=
t; and<br>
&quot;go read the file again&quot; both produce the same effect... having<b=
r>
a management-interface driven client test would help here... no<br>
time yet to write one)</blockquote><div><br></div><div>This is broken for a=
 while now -- since commit dfd624b52bce7ddd0eeaab516df9848e432f3242</div><d=
iv>(<b>2.4 and 2.5 are also affected</b>)=C2=A0</div><div>That commit chang=
ed the earlier delayed purge logic to</div><div><br></div><div>- =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (!auth_user_pass.wait_for_push)<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!session-&gt;opt-&gt;pull)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0purge_user_pass(&am=
p;auth_user_pass, false);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br></div><=
div><br></div><div>In clients that pull, &quot;wait_push&quot; used to be s=
et to false on completing the first=C2=A0</div><div>negotiation, but after =
this change we are not purging user/pass at all at this</div><div>point.=C2=
=A0</div><div>Purging still happens on first negotiation in &quot;set_auth_=
token()&quot; as before,=C2=A0<br></div><div>but that will not get called=
=C2=A0during renegs=C2=A0unless auth-token is in use and</div><div>a new to=
ken gets pushed after expiry.=C2=A0</div><div><br></div><div>Not clearing t=
he username has been rejected in the past although, somehow,</div><div>reta=
ining it with the token has been found acceptable. Instead, we went for=C2=
=A0</div><div>a convoluted logic that has=C2=A0proven itself to be hard to =
get right.</div><div><br></div><div>A compromise is to continue to clear us=
ername in the auth_user_pass struct for</div><div>appearances sake (for noc=
ache contract), but always retain it in the auth_token</div><div>struct.Tha=
t would considerably simplify the logic as well</div><div>(see e.g.,=C2=A0<=
a href=3D"https://github.com/selvanair/openvpn/commit/e9bf3c8227e365099deaa=
dc11d31ac8a0c7668d7">https://github.com/selvanair/openvpn/commit/e9bf3c8227=
e365099deaadc11d31ac8a0c7668d7</a>)</div><div><br></div><div>Selva</div></d=
iv>
</div>

--00000000000033051805eb79ecfd--

