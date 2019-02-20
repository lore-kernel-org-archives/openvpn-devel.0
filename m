MIME-Version: 1.0
References: <1550368541-10402-1-git-send-email-selva.nair@...277...>
 <ad1a285d-fa22-54b0-01ac-9a066e752065@...2080...>
In-Reply-To: <ad1a285d-fa22-54b0-01ac-9a066e752065@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 19 Feb 2019 20:55:59 -0500
Message-ID: <CAKuzo_hWz6qKZgYjrW8d=y0ifxkwEws+xGFjmH_1hO4xOHxfLA@...278...>
Content-Type: multipart/alternative; boundary="000000000000cb4f49058249a985"
Subject: Re: [Openvpn-devel] [PATCH] Better error message when script fails
 due to script-security setting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000cb4f49058249a985
Content-Type: text/plain; charset="UTF-8"

Hi,

Thanks for the review.

On Tue, Feb 19, 2019 at 12:39 PM David Sommerseth <
openvpn@...2080...> wrote:

> On 17/02/2019 02:55, selva.nair@...277... wrote:
> > From: Selva Nair <selva.nair@...277...>
> >
> > - Add a new return value (-2) for openvpn_execve() when external
> > program execution is not allowed due to a low script-security
> > setting.
> >
> > - Add a corresponding error message
> >
> > Errors and warnings in such cases will now display as
> > "WARNING: failed running command (<cmd>) :" followed by
> >
> > "disallowed by script-security setting" on all platforms
> >
> > instead of the current
> >
> > "external program did not execute -- returned error code -1"
> > on Windows and
> > "external program fork failed" on other platforms.
> >
> > The error is FATAL for some scripts and that behaviour is unchanged.
> >
> > This helps the Windows GUI to detect when a connection failure
> > results from a safer script-security setting enforced by the GUI,
> > and show a relevant message.
> >
> > Signed-off-by: Selva Nair <selva.nair@...277...>
> > ---
> > This is being presented as a better alternative for patch 684.
> > A separate patch may be needed for 2.4 -- will do if this is found
> > acceptable.
>
> Generally speaking, this looks much better and should avoid changing the
> behaviour.  It just clarifies the error better.  Feature-ACK from me.
>
>
> [...]
> > diff --git a/src/openvpn/run_command.c b/src/openvpn/run_command.c
> > index 2d75a3e..7df7576 100644
> > --- a/src/openvpn/run_command.c
> > +++ b/src/openvpn/run_command.c
> > @@ -65,12 +65,23 @@ system_error_message(int stat, struct gc_arena *gc)
> >      {
> >          buf_printf(&out, "external program did not execute -- ");
> >      }
> > -    buf_printf(&out, "returned error code %d", stat);
> > +    if (stat == -2)
> > +    {
> > +        buf_printf(&out, "disallowed by script-security setting");
> > +    }
> > +    else
> > +    {
> > +        buf_printf(&out, "returned error code %d", stat);
> > +    }
>
> Perhaps we could swap out the -1 and -2 values with macro constants, for
> code
> clarity?  Also, perhaps it would look more structured if using a switch()
> instead of if()/else if().


Because of branching based on if (WIFEXITED(stat)) etc., switch() may be
only
marginally cleaner and cause some deep indentation. But will give it a go.


> Otherwise, the code looks good.
>
> Another interesting are which most likely quite seldom fails, but we
> actually
> have yet another "undocumented" exit code ...  This is not this patch's
> fault,
> but should probably be reviewed a bit more carefully.
>
> In run_command.c:149-153:
> --------------------------------------------------------------------
>             pid = fork();
>             if (pid == (pid_t)0) /* child side */
>             {
>                 execve(cmd, argv, envp);
>                 exit(127);
>             }
> --------------------------------------------------------------------
>
> If execve() fails, the exit code is 127.  That would normally be caught by
> the
> waitpid() later on and this exit code would be returned by
> openvpn_execve().
>
> This should be improved in a separate patch though, but is not of high
> urgency.  I don't expect most setups having a high execve() failure rate.
> But
> catching it and reporting this error path would be good.
>

In fact its easy to trigger this -- just have a shebang with a non-existent
path like
#!/bin/sh1 and child will exit with 127. In system_error_message() we
translate that as
"could not execute external program"

This "could not" instead of "did not" is a good choice of words, but would
be better
if we somehow marshal the actual errno set by execve (in this case ENOENT)
to the parent. Its lost in the current implementation. But that's beyond
this patch,
as you say.

I'll just add a macro for this 127 as well and leave it at that.

Selva

--000000000000cb4f49058249a985
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div><div>Thanks for the rev=
iew.</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gm=
ail_attr">On Tue, Feb 19, 2019 at 12:39 PM David Sommerseth &lt;<a href=3D"=
mailto:openvpn@...2080...">openvpn@...2080...</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">On 17/02/2019 02:55, <a href=
=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>=
 wrote:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt; <br>
&gt; - Add a new return value (-2) for openvpn_execve() when external<br>
&gt; program execution is not allowed due to a low script-security<br>
&gt; setting.<br>
&gt; <br>
&gt; - Add a corresponding error message<br>
&gt; <br>
&gt; Errors and warnings in such cases will now display as<br>
&gt; &quot;WARNING: failed running command (&lt;cmd&gt;) :&quot; followed b=
y<br>
&gt; <br>
&gt; &quot;disallowed by script-security setting&quot; on all platforms<br>
&gt; <br>
&gt; instead of the current<br>
&gt; <br>
&gt; &quot;external program did not execute -- returned error code -1&quot;=
<br>
&gt; on Windows and<br>
&gt; &quot;external program fork failed&quot; on other platforms.<br>
&gt; <br>
&gt; The error is FATAL for some scripts and that behaviour is unchanged.<b=
r>
&gt; <br>
&gt; This helps the Windows GUI to detect when a connection failure<br>
&gt; results from a safer script-security setting enforced by the GUI,<br>
&gt; and show a relevant message.<br>
&gt; <br>
&gt; Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." =
target=3D"_blank">selva.nair@...277...</a>&gt;<br>
&gt; ---<br>
&gt; This is being presented as a better alternative for patch 684.<br>
&gt; A separate patch may be needed for 2.4 -- will do if this is found<br>
&gt; acceptable.<br>
<br>
Generally speaking, this looks much better and should avoid changing the<br>
behaviour.=C2=A0 It just clarifies the error better.=C2=A0 Feature-ACK from=
 me.<br>
<br>
<br>
[...]<br>
&gt; diff --git a/src/openvpn/run_command.c b/src/openvpn/run_command.c<br>
&gt; index 2d75a3e..7df7576 100644<br>
&gt; --- a/src/openvpn/run_command.c<br>
&gt; +++ b/src/openvpn/run_command.c<br>
&gt; @@ -65,12 +65,23 @@ system_error_message(int stat, struct gc_arena *gc=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf_printf(&amp;out, &quot;external =
program did not execute -- &quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 buf_printf(&amp;out, &quot;returned error code %d&quot;=
, stat);<br>
&gt; +=C2=A0 =C2=A0 if (stat =3D=3D -2)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 buf_printf(&amp;out, &quot;disallowed by =
script-security setting&quot;);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 buf_printf(&amp;out, &quot;returned error=
 code %d&quot;, stat);<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
Perhaps we could swap out the -1 and -2 values with macro constants, for co=
de<br>
clarity?=C2=A0 Also, perhaps it would look more structured if using a switc=
h()<br>
instead of if()/else if().</blockquote><div>=C2=A0</div><div>Because of bra=
nching based on if (WIFEXITED(stat)) etc., switch() may be only</div><div>m=
arginally cleaner and cause some deep indentation. But will give it a go.</=
div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Otherwise, the code looks good.<br>
<br>
Another interesting are which most likely quite seldom fails, but we actual=
ly<br>
have yet another &quot;undocumented&quot; exit code ...=C2=A0 This is not t=
his patch&#39;s fault,<br>
but should probably be reviewed a bit more carefully.<br>
<br>
In run_command.c:149-153:<br>
--------------------------------------------------------------------<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pid =3D fork();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pid =3D=3D (pid_t)0) /* child=
 side */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 execve(cmd, argv, e=
nvp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(127);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
--------------------------------------------------------------------<br>
<br>
If execve() fails, the exit code is 127.=C2=A0 That would normally be caugh=
t by the<br>
waitpid() later on and this exit code would be returned by openvpn_execve()=
.<br>
<br>
This should be improved in a separate patch though, but is not of high<br>
urgency.=C2=A0 I don&#39;t expect most setups having a high execve() failur=
e rate.=C2=A0 But<br>
catching it and reporting this error path would be good.<br></blockquote><d=
iv><br></div><div>In fact its easy to trigger this -- just have a shebang w=
ith a non-existent path like</div><div>#!/bin/sh1 and child will exit with =
127. In system_error_message() we translate that as</div><div>&quot;could n=
ot execute external program&quot;</div><div><br></div><div>This &quot;could=
 not&quot; instead of &quot;did not&quot; is a good choice of words, but wo=
uld be better</div><div>if we somehow marshal the actual errno set by execv=
e (in this case ENOENT)</div><div>to the parent. Its lost in the current im=
plementation. But that&#39;s beyond this patch,</div><div>as you say.</div>=
<div><br></div><div>I&#39;ll just add a macro for this 127 as well and leav=
e it at that.</div><div><br></div><div>Selva</div></div></div>

--000000000000cb4f49058249a985--

