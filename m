MIME-Version: 1.0
References: <20230101215109.1521549-5-selva.nair@...277...>
 <20230102194156.1560195-1-selva.nair@...277...>
 <CAGyAFMU30BuPUVyjebLj=JDZaNLzAPkHhb8JGvFt1FHuQCVfkw@...278...>
In-Reply-To: <CAGyAFMU30BuPUVyjebLj=JDZaNLzAPkHhb8JGvFt1FHuQCVfkw@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 5 Jan 2023 12:18:00 -0500
Message-ID: <CAKuzo_iXw5TJSLdScp-Wf8g-sG6n3bUuE+BYWxqAs4CJFncZcQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000008c120e05f1877c95"
Subject: Re: [Openvpn-devel] [PATCH v2 4/5] Fix signal handling on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--0000000000008c120e05f1877c95
Content-Type: text/plain; charset="UTF-8"

Hi,

Thanks for the careful review

On Thu, Jan 5, 2023 at 11:20 AM Lev Stipakov <lstipakov@...277...> wrote:

> Hi,
>
> > -    else if (n > 0)
> > +    else
> >      {
> > -        sleep(n);
> > +#ifdef _WIN32
> > +        win32_sleep(n);
> > +#else
> > +        if (n > 0)
> > +        {
> > +            sleep(n);
>
>
> My understanding is that we want to have interruptible sleep. In this case,
> what is the point of calling win32_sleep(0) ?

I understand that
> management_sleep(0)
> is required to service possible management commands even if we don't
> need a delay,
> but shouldn't it be a no-op without management?
>

Right, I'm going beyond the original which does nothing for
management_sleep(0) if management is not active or enabled.

I want to err on the side of checking windows signal rather than missing
it. In case of unix/linux OS signals do get delivered out of band into the
global signal_received. In the case of Windows, it has to be picked up
(except for the obscure ctrl-Break).

Note that management_sleep(0) when management is enabled does call
get_signal()==win32_signal_get and picks up Windows signals, not just
management commands.  win32_sleep(0) also calls win32_signal_get() even if
there is no time to pause.


>
> > +void
> > +win32_sleep(const int n)
> > +{
> > +    if (n < 0)
> > +    {
> > +        return;
> > +    }
>
> Why not <= 0 ?
>

See above.


>
> > +    /* Sleep() is not interruptible. Use a WAIT_OBJECT to catch signal
> */
> > +    if (HANDLE_DEFINED(win32_signal.in.read))
> > +    {
>
> I would reverse this condition, and do just
>
>     Sleep(n*1000);
>     return;


> This way we get rid of the indentation level.
>
> > +        time_t expire = 0;
> > +        update_time();
> > +        expire = now + n;
>
> I would declare and initialize time_t expire after update_time().


> > +            DWORD status = WaitForSingleObject(win32_signal.in.read,
> (expire - now)*1000);
> > +            if (win32_signal_get(&win32_signal) || status ==
> WAIT_TIMEOUT)
> > +            {
> > +                return;
> > +            }
>
> Shouldn't we call win32_signal_get() only if status == WAIT_OBJECT_0 ?
>

To ensure the signal is checked at least once in all cases including n = 0.
Not sure whether status will be WAIT_TIMEOUT or WAIT_OBJECT_0 in case n = 0
and there is a signal to pickup.


>
> Under what circumstances are we supposed to do the waiting again? If
> we get a signal, we bail out.
> If the wait times out, we bail out. If wait fails, we do Sleep
> (although at this point we probably have a bigger issue).
>

Probably never -- there is a WAIT_ABANDONED which may not apply here. But,
sometimes windows functions do exit with error codes not listed in the
docs. As the loop is slowed down by a Sleep(1000), this can't hurt, can it?

The common thread in all of the above is that I'm trying to err on the side
of checking for signals an extra round as opposed to missing it. Can do a
v3 if you think it's warranted.

Thanks,

Selva

--0000000000008c120e05f1877c95
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>Thanks for the careful r=
eview</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_a=
ttr">On Thu, Jan 5, 2023 at 11:20 AM Lev Stipakov &lt;<a href=3D"mailto:lst=
ipakov@...277...">lstipakov@...277...</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
&gt; -=C2=A0 =C2=A0 else if (n &gt; 0)<br>
&gt; +=C2=A0 =C2=A0 else<br>
&gt;=C2=A0 =C2=A0 =C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sleep(n);<br>
&gt; +#ifdef _WIN32<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 win32_sleep(n);<br>
&gt; +#else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n &gt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sleep(n);<br>
<br>
<br>
My understanding is that we want to have interruptible sleep. In this case,=
<br>
what is the point of calling win32_sleep(0) ?</blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">I understand that<br>
management_sleep(0)<br>
is required to service possible management commands even if we don&#39;t<br>
need a delay,<br>
but shouldn&#39;t it be a no-op without management?<br></blockquote><div><b=
r></div><div>Right, I&#39;m going beyond the original which does=C2=A0nothi=
ng for management_sleep(0) if management is not active or enabled.</div><di=
v>=C2=A0</div><div>I want to err on the side of checking windows signal rat=
her than missing it. In case of unix/linux OS signals do get delivered out =
of band into the global signal_received. In the case of Windows, it has to =
be picked up (except for the obscure ctrl-Break).</div><div><br></div><div>=
Note that management_sleep(0) when management is enabled does call get_sign=
al()=3D=3Dwin32_signal_get and picks up Windows signals, not just managemen=
t commands.=C2=A0 win32_sleep(0) also calls win32_signal_get() even if ther=
e is no time to pause.<br></div><div>=C2=A0 =C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
&gt; +void<br>
&gt; +win32_sleep(const int n)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (n &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
Why not &lt;=3D 0 ?<br></blockquote><div><br></div><div>See above.</div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 /* Sleep() is not interruptible. Use a WAIT_OBJECT to c=
atch signal */<br>
&gt; +=C2=A0 =C2=A0 if (HANDLE_DEFINED(win32_signal.in.read))<br>
&gt; +=C2=A0 =C2=A0 {<br>
<br>
I would reverse this condition, and do just<br>
<br>
=C2=A0 =C2=A0 Sleep(n*1000);<br>
=C2=A0 =C2=A0 return;=C2=A0</blockquote><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
<br>
This way we get rid of the indentation level.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 time_t expire =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 update_time();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 expire =3D now + n;<br>
<br>
I would declare and initialize time_t expire after update_time().=C2=A0</bl=
ockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DWORD status =3D WaitForSin=
gleObject(win32_signal.in.read, (expire - now)*1000);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (win32_signal_get(&amp;w=
in32_signal) || status =3D=3D WAIT_TIMEOUT)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
Shouldn&#39;t we call win32_signal_get() only if status =3D=3D WAIT_OBJECT_=
0 ?<br></blockquote><div><br></div><div>To ensure the signal is checked at =
least once in all cases including n =3D 0. Not sure whether status will be =
WAIT_TIMEOUT or WAIT_OBJECT_0 in case n =3D 0 and there is a signal to pick=
up.=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
<br>
Under what circumstances are we supposed to do the waiting again? If<br>
we get a signal, we bail out.<br>
If the wait times out, we bail out. If wait fails, we do Sleep<br>
(although at this point we probably have a bigger issue).<br></blockquote><=
div><br></div><div>Probably never -- there is a WAIT_ABANDONED which may no=
t apply here. But, sometimes windows functions do exit with error codes not=
 listed in the docs. As the loop is slowed down by a Sleep(1000), this can&=
#39;t=C2=A0hurt, can it?</div><div><br></div><div>The common thread in all =
of the above is that I&#39;m trying to err on the side of checking for sign=
als an extra round as opposed to missing it. Can do a v3 if you think it&#3=
9;s=C2=A0warranted.</div><div><br></div><div>Thanks,</div><div><br></div><d=
iv>Selva</div></div></div>

--0000000000008c120e05f1877c95--

