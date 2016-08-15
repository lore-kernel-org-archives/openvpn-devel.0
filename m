MIME-Version: 1.0
In-Reply-To: <43ba7b4d-2c78-d748-97b9-bf1fdaed3379@...2080...>
References: <1470684488-21307-1-git-send-email-davids@...515...>
	<1470684488-21307-2-git-send-email-davids@...515...>
	<CAKuzo_ggo2A5hFwe3u=+fwAWBoRQxhRvf_LDTCsSTrSLU+AZCA@...278...>
	<43ba7b4d-2c78-d748-97b9-bf1fdaed3379@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 15 Aug 2016 12:19:13 -0400
Message-ID: <CAKuzo_h8=W1P08ACD-khUeP5g9b4hMxQbbiyLJK3yACA7ndstw@...278...>
Content-Type: multipart/alternative; boundary=94eb2c124e34fdf903053a1e9858
Subject: Re: [Openvpn-devel] [PATCH v4 1/4] Rework the user input interface
 to make it more modular
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c124e34fdf903053a1e9858
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon, Aug 15, 2016 at 6:49 AM, David Sommerseth <
openvpn@...2080...> wrote:

>
> > if (username_from_stdin && !(flags & GET_USER_PASS_PASSWORD_ONLY))
> > { -                 if (!get_console_input (BSTR (&user_prompt),
> > true, up->username, USER_PASS_LEN)) -                   msg
> > (M_FATAL, "ERROR: could not read %s username from stdin", prefix);
> > +                 query_user_add (BSTR(&user_prompt),
> > BLEN(&user_prompt), +
> > up->username, USER_PASS_LEN,
> true);
> > +               } + +             query_user_add
> > (BSTR(&pass_prompt),
> BLEN(&pass_prompt),
> > +                              up->password, USER_PASS_LEN,
> > false);
> >
> >
> > The above call should be conditional on "if
> > (password_from_stdin)". Else it will get called even after reading
> > password from a file. Unfortunately get_user_pass_cr() has become
> > so fragile after repeated hacks, its so easy to break it...
>
> Good catch!  I've noticed that in some very few configurations git
> master already behaves somewhat odd with systemd enabled.  I think
> what you've spotted here is one of the issues I've seen but not had
> time to investigate yet.  This week I'm fairly tied up in some other
> projects, but I'll dig into this and test these things.  You've
> pointed me into a very sane code path, though.
>

I too saw some systemd weirdness when openvpn is started from init scripts:
the password prompt came up before username followed by password again. But
that was before fixing the CLEAR(*input) bug in 2/4. Now the patchset
appears to behave fine (except for the above bug) on my test setups (Debian
jessie and stretch/sid).



> > The following may sound harsh, but that's not the intention. I've
> > spent hours on these patches now, so just trying to get the best
> > out of it: In the end, I'm not sure what is achieved by this new
> > framework. I see multiple queries can be combined into one exec
> > call, but the way its used in get_user_pass_cr() does not make full
> > use of it. Sure, username and password are prompted in one call,
> > but static challenge is still handled by an additional call. FWIW,
> > to be true to the spirit of the implementation, a request for
> > username/password/static-challenge-response should result in only
> > one call to query_user_exec, not two. Only then one can even
> > remotely hope to have a way prompting the user for all that info in
> > one dialog by some future ask-password agent.  Unless you set a
> > clear style and guidance here, over time  this will degenerate into
> > something logically identical to the original code except for
> > different function names and twice the function calls.
>
> Fair point!  The thing is that *currently* systemd-ask-password isn't
> clever at all.  I've been discussing this with a few upstream systemd
> developers already, and basically they are going to re-write much of
> the systemd-ask-password stuff to be far more intelligent.  But much

of that work has halted as a new approach is planned to use DBus.
> That again creates other challenges at boot time as DBus might not be
> running when systemd-ask-password is called.  This will be resolved
> once the kdbus work gets into an upstream kernel, then things can
> start to move forward too.
>
> > Even with one exec call, finally systemd-ask-password has to be
> > called multiple times and it seems currently there are no agents
> > that could take multiple queries and prompt the user in one dialog,
> > for example.
>
> And these patches are just the first step.  First we need a more sane
> API to work with, then we can start juggling things more around.  My
> plan is to move as much of these user query calls as early as possible
> during the init phase.  Then depending on the backend (standard
> console, systemd, dbus, whatever fancy someone else writes), the user
> is queried for this information as efficiently as possible.
>

Yes, that's all what I meant by this being ahead of its time. Which is
fine..

Irrespective of future plans, its pretty easy to combine the prompt for
username/password/static-challenge into one query_exec call.


> I've also started to ponder how we can make use of this via the
> management interface too, for the current GUIs we have around.  Which
> means that an end user can be asked for private key password or
> PKCS#11 PIN, username and password in one go - as OpenVPN can now tell
> the UI what it needs to establish a connection.  This could also give
> some benefits to the OpenVPN plug-in in NetworkManager too.
>

Actually the management interface (MI) works pretty well as is. I think
most GUI's use the MI and can, at least in principle, prompt for user-auth
and challenge response together --- see the Windows GUI as an example.
Dynamic challenge has to be prompted for in a follow-up dialog as the
challenge is not known in advance. Add to that GUI's ability to remember
passwords, all that has to be repeatedly prompted for, in many cases, is
the challenge response (static or dynamic). Of course there is room for
improvement along the lines of query user by having a uniform way of
passing all user-input request to the management.

If someone sees a better approach for resolving this, then I'm willing
> to look into that ... but considering this process have been going on
> for over a year without too much fuzz around this approach, the
> barrier to redesign everything from scratch again is quite high.


I have no idea for a better approach and the design of query_user looks
good to me. I only wanted to point out some minor ways in which the patch
set could be improved. And to indicate that only when user-input agents
that can make full use of it becomes available we'll know whether the
design needs further tweaks or not.

Best,

Selva

--94eb2c124e34fdf903053a1e9858
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Mon, Aug 15, 2016 at 6:49 AM, David Sommerseth <span dir=3D"ltr">=
&lt;<a href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2158...=
...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,2=
04);border-left-style:solid;padding-left:1ex"><div><div class=3D"gmail-h5">=
<br>
&gt; if (username_from_stdin &amp;&amp; !(flags &amp; GET_USER_PASS_PASSWOR=
D_ONLY))<br>
&gt; { -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!=
get_console_input (BSTR (&amp;user_prompt),<br>
&gt; true, up-&gt;username, USER_PASS_LEN)) -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg<br>
&gt; (M_FATAL, &quot;ERROR: could not read %s username from stdin&quot;, pr=
efix);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0query_u=
ser_add (BSTR(&amp;user_prompt),<br>
&gt; BLEN(&amp;user_prompt), +<br>
&gt; up-&gt;username, USER_PASS_LEN,<br>
true);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} + +=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0query_user_add<br>
&gt; (BSTR(&amp;pass_prompt),<br>
BLEN(&amp;pass_prompt),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 up-&gt;password, USER_PASS_LEN,<br>
&gt; false);<br>
&gt;<br>
&gt;<br>
&gt; The above call should be conditional on &quot;if<br>
&gt; (password_from_stdin)&quot;. Else it will get called even after readin=
g<br>
&gt; password from a file. Unfortunately get_user_pass_cr() has become<br>
&gt; so fragile after repeated hacks, its so easy to break it...<br>
<br>
</div></div>Good catch!=C2=A0 I&#39;ve noticed that in some very few config=
urations git<br>
master already behaves somewhat odd with systemd enabled.=C2=A0 I think<br>
what you&#39;ve spotted here is one of the issues I&#39;ve seen but not had=
<br>
time to investigate yet.=C2=A0 This week I&#39;m fairly tied up in some oth=
er<br>
projects, but I&#39;ll dig into this and test these things.=C2=A0 You&#39;v=
e<br>
pointed me into a very sane code path, though.<br></blockquote><div><br></d=
iv><div>I too saw some systemd weirdness when openvpn is started from init =
scripts: the password prompt came up before username followed by password a=
gain. But that was before fixing the CLEAR(*input) bug in 2/4. Now the patc=
hset appears to behave fine (except for the above bug) on my test setups (D=
ebian jessie and stretch/sid).</div><div><br></div><div><br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-widt=
h:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-le=
ft:1ex">
<span class=3D"gmail-"><br>
&gt; The following may sound harsh, but that&#39;s not the intention. I&#39=
;ve<br>
&gt; spent hours on these patches now, so just trying to get the best<br>
&gt; out of it: In the end, I&#39;m not sure what is achieved by this new<b=
r>
&gt; framework. I see multiple queries can be combined into one exec<br>
&gt; call, but the way its used in get_user_pass_cr() does not make full<br>
&gt; use of it. Sure, username and password are prompted in one call,<br>
&gt; but static challenge is still handled by an additional call. FWIW,<br>
&gt; to be true to the spirit of the implementation, a request for<br>
&gt; username/password/static-<wbr>challenge-response should result in only=
<br>
&gt; one call to query_user_exec, not two. Only then one can even<br>
&gt; remotely hope to have a way prompting the user for all that info in<br>
&gt; one dialog by some future ask-password agent.=C2=A0 Unless you set a<b=
r>
&gt; clear style and guidance here, over time=C2=A0 this will degenerate in=
to<br>
&gt; something logically identical to the original code except for<br>
&gt; different function names and twice the function calls.<br>
<br>
</span>Fair point!=C2=A0 The thing is that *currently* systemd-ask-password=
 isn&#39;t<br>
clever at all.=C2=A0 I&#39;ve been discussing this with a few upstream syst=
emd<br>
developers already, and basically they are going to re-write much of<br>
the systemd-ask-password stuff to be far more intelligent.=C2=A0 But much</=
blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-st=
yle:solid;padding-left:1ex">
of that work has halted as a new approach is planned to use DBus.<br>
That again creates other challenges at boot time as DBus might not be<br>
running when systemd-ask-password is called.=C2=A0 This will be resolved<br>
once the kdbus work gets into an upstream kernel, then things can<br>
start to move forward too.<br>
<span class=3D"gmail-"><br>
&gt; Even with one exec call, finally systemd-ask-password has to be<br>
&gt; called multiple times and it seems currently there are no agents<br>
&gt; that could take multiple queries and prompt the user in one dialog,<br>
&gt; for example.<br>
<br>
</span>And these patches are just the first step.=C2=A0 First we need a mor=
e sane<br>
API to work with, then we can start juggling things more around.=C2=A0 My<b=
r>
plan is to move as much of these user query calls as early as possible<br>
during the init phase.=C2=A0 Then depending on the backend (standard<br>
console, systemd, dbus, whatever fancy someone else writes), the user<br>
is queried for this information as efficiently as possible.<br></blockquote=
><div><br></div><div>Yes, that&#39;s all what I meant by this being ahead o=
f its time. Which is fine..=C2=A0</div><div><br></div><div>Irrespective of =
future plans, its pretty easy to combine the prompt for username/password/s=
tatic-challenge into one query_exec call.</div><div><br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1p=
x;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1=
ex">
<br>
I&#39;ve also started to ponder how we can make use of this via the<br>
management interface too, for the current GUIs we have around.=C2=A0 Which<=
br>
means that an end user can be asked for private key password or<br>
PKCS#11 PIN, username and password in one go - as OpenVPN can now tell<br>
the UI what it needs to establish a connection.=C2=A0 This could also give<=
br>
some benefits to the OpenVPN plug-in in NetworkManager too.<br></blockquote=
><div><br></div><div>Actually the management interface (MI) works pretty we=
ll as is. I think most GUI&#39;s use the MI and can, at least in principle,=
 prompt for user-auth and challenge response together --- see the Windows G=
UI as an example. Dynamic challenge has to be prompted for in a follow-up d=
ialog as the challenge is not known in advance. Add to that GUI&#39;s abili=
ty to remember passwords, all that has to be repeatedly prompted for, in ma=
ny cases, is the challenge response (static or dynamic). Of course there is=
 room for improvement along the lines of query user by having a uniform way=
 of passing all user-input request to the management.</div><div><br></div><=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:sol=
id;padding-left:1ex">If someone sees a better approach for resolving this, =
then I&#39;m willing<br>to look into that ... but considering this process =
have been going on<br>for over a year without too much fuzz around this app=
roach, the<br>barrier to redesign everything from scratch again is quite hi=
gh.</blockquote></div><div><br></div><div>I have no idea for a better appro=
ach and the design of query_user looks good to me. I only wanted to point o=
ut some minor ways in which the patch set could be improved. And to indicat=
e that only when user-input agents that can make full use of it becomes ava=
ilable we&#39;ll know whether the design needs further tweaks or not.=C2=A0=
</div><div><br></div><div>Best,</div><div><br></div><div>Selva</div></div><=
/div></div>

--94eb2c124e34fdf903053a1e9858--

