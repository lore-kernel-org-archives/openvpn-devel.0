MIME-Version: 1.0
In-Reply-To: <20160614071342.GR62247@...1296...>
References: <1465871689-13533-1-git-send-email-selva.nair@...277...>
	<20160614071342.GR62247@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 14 Jun 2016 23:40:44 -0400
Message-ID: <CAKuzo_hVKtfdkncmqg5hKX18WYGpFWu1GRxD6dnM=3PfHnQiLw@...278...>
Content-Type: multipart/alternative; boundary=001a11c04ca81406a9053548e475
Subject: Re: [Openvpn-devel] [PATCH] Promptly close the netcmd_semaphore
 handle after use
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

--001a11c04ca81406a9053548e475
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue, Jun 14, 2016 at 3:13 AM, Gert Doering <gert@...1296...> wrote:

> On Mon, Jun 13, 2016 at 10:34:49PM -0400, Selva Nair wrote:
> > @@ -759,6 +762,8 @@ void
> >  netcmd_semaphore_release (void)
> >  {
> >    semaphore_release (&netcmd_semaphore);
> > +  /* netcmd_semaphore has max count of 1 - safe to close after release
> */
> > +  semaphore_close (&netcmd_semaphore);
> >  }
>
> This should work, but it is more "aggressive" than I had in mind -
> releasing
> the semaphore afer every single call, so when setting up lots of routes
> with
> netsh.exe, we might end up opening and closing the semaphore "dozens" of
> times.
>


> How expensive / slow is this?  Has this significant impact?
>
My idea was to close the semaphore when the initialization phase is over,
> like in init.c, initialization_sequence_completed(), in the existing
> WIN32 block
>
> #ifdef WIN32
>   netcmd_semaphore_close();                     /* release handles */
>   fork_register_dns_action (c->c1.tuntap);
> #endif
>
> or something like that.  Keeping your change to the "lock" call so it
> is then reopened at tunnel teardown, but is not open while openvpn is
> running in steady state.
>

If we go this route we'll also need a netcmd_semaphore_close() when the
SIGUSR1 loop exits, as a restart before initialization_completed could wait
at management-hold with an open handle.

Or a SIGHUP will open the semaphore to delete routes and the restart could
end up in management hold.


> But I'm open to "semaphores are cheap, we can just open/lock/release/close
> it on every call" arguments :-)
>

Very unlikely to be a drag on performance -- I think createprocess will be
where time is spent [*].

That said, calling semaphore_close() inside netcmd_semaphore_unlock() is
not a style to be proud of.  So I'm kind of inclined to do a version 2
along the lines you suggested but some testing will be needed to get it
right.

Selva

P.S:
[*] FWIW, I did a timing test: Run using a modified openvpn that just does
openvpn_execve of a route add and route delete inside a for loop. The times
below are for a loop count of 100.

No semaphore: 2.45 to 2.49 seconds
With semaphore lock/unlock : 2.52 to 2.53 seconds
With semaphore closed after reach unlock: 2.52 to 2.54 seconds

(Not enough statistics to give a precise number, but the overhead of using
the semaphore is small and the open/close appears to make little
difference). I'm surprised that it takes 2.5 seconds to add and delete a
route just 100 times. Never use --route-method exe

Note that all times are real time, not CPU time. And the times are for just
the for loop and scales linearly -- tested with 200 and 300 counts as well.

--001a11c04ca81406a9053548e475
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Tue, Jun 14, 2016 at 3:13 AM, Gert D=
oering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_=
blank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex"><div><span>On Mon, Jun 13, 2016 at 10:34:49PM -0400, Selva Nair wrote:<=
br>
&gt; @@ -759,6 +762,8 @@ void<br>
&gt;=C2=A0 netcmd_semaphore_release (void)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 semaphore_release (&amp;netcmd_semaphore);<br>
&gt; +=C2=A0 /* netcmd_semaphore has max count of 1 - safe to close after r=
elease */<br>
&gt; +=C2=A0 semaphore_close (&amp;netcmd_semaphore);<br>
&gt;=C2=A0 }<br>
<br>
</span>This should work, but it is more &quot;aggressive&quot; than I had i=
n mind - releasing<br>
the semaphore afer every single call, so when setting up lots of routes wit=
h<br>
netsh.exe, we might end up opening and closing the semaphore &quot;dozens&q=
uot; of<br>
times.<br></div></blockquote><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
"><div>
How expensive / slow is this?=C2=A0 Has this significant impact? <br></div>=
</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"><div>
My idea was to close the semaphore when the initialization phase is over,<b=
r>
like in init.c, initialization_sequence_completed(), in the existing<br>
WIN32 block<br>
<br>
#ifdef WIN32<br>
=C2=A0 netcmd_semaphore_close();=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* release handles */<br>
=C2=A0 fork_register_dns_action (c-&gt;c1.tuntap);<br>
#endif<br>
<br>
or something like that.=C2=A0 Keeping your change to the &quot;lock&quot; c=
all so it<br>
is then reopened at tunnel teardown, but is not open while openvpn is<br>
running in steady state.<br></div></blockquote><div><br></div><div>If we go=
 this route we&#39;ll also need a netcmd_semaphore_close() when the SIGUSR1=
 loop exits, as a restart before initialization_completed could wait at man=
agement-hold with an open handle.</div><div><br></div><div>Or a SIGHUP will=
 open the semaphore to delete routes and the restart could end up in manage=
ment hold.<br><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div>
<br>
But I&#39;m open to &quot;semaphores are cheap, we can just open/lock/relea=
se/close<br>
it on every call&quot; arguments :-)</div></blockquote></div><br>Very unlik=
ely to be a drag on performance -- I think createprocess will be where time=
 is spent [*].<br><br>That said, calling semaphore_close() inside netcmd_se=
maphore_unlock() is not a style to be proud of.=C2=A0 So I&#39;m kind of in=
clined to do a version 2 along the lines you suggested but some testing wil=
l be needed to get it right.<br></div><div class=3D"gmail_extra"><br></div>=
<div class=3D"gmail_extra">Selva<br><br></div><div class=3D"gmail_extra">P.=
S:<br></div><div class=3D"gmail_extra">[*] FWIW, I did a timing test: Run u=
sing a modified openvpn that just does openvpn_execve of a route add and ro=
ute delete inside a for loop. The times below are for a loop count of 100.<=
br><br></div><div class=3D"gmail_extra">No semaphore: 2.45 to 2.49 seconds<=
br></div><div class=3D"gmail_extra">With semaphore lock/unlock : 2.52 to 2.=
53 seconds<br></div><div class=3D"gmail_extra">With semaphore closed after =
reach unlock: 2.52 to 2.54 seconds<br><br></div><div class=3D"gmail_extra">=
(Not enough statistics to give a precise number, but the overhead of using =
the semaphore is small and the open/close appears to make little difference=
). I&#39;m surprised that it takes 2.5 seconds to add and delete a route ju=
st 100 times. Never use --route-method exe<br><br></div><div class=3D"gmail=
_extra">Note that all times are real time, not CPU time. And the times are =
for just the for loop and scales linearly -- tested with 200 and 300 counts=
 as well.<br></div><div class=3D"gmail_extra"><br></div></div>

--001a11c04ca81406a9053548e475--

