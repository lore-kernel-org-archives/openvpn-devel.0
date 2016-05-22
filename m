MIME-Version: 1.0
In-Reply-To: <20160522073101.GV53051@...1296...>
References: <CAKuzo_g1jx2JkxP2BSVYPW4axnMUQgVe=WvBSzC+x8n6LR_A9g@...278...>
	<1463892387-4793-1-git-send-email-selva.nair@...277...>
	<20160522073101.GV53051@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 22 May 2016 11:00:22 -0400
Message-ID: <CAKuzo_gcP+YiNE9tHqkW1aVtsm=wy=wg9yPf0PpUwL1_vDXuYA@...278...>
Content-Type: multipart/alternative; boundary=001a114492e86e851405336f967c
Subject: Re: [Openvpn-devel] [PATCH] Fix handling of out of memory error in
 interactive service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114492e86e851405336f967c
Content-Type: text/plain; charset=UTF-8

copy to the list...

On Sun, May 22, 2016 at 3:31 AM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Sun, May 22, 2016 at 12:46:27AM -0400, Selva Nair wrote:
> >          {
> >            size += 10;
> > -          handles = realloc (handles, size * sizeof (HANDLE));
> > -          if (handles == NULL)
> > -            return ERROR_OUTOFMEMORY;
> > +          LPHANDLE tmp = realloc (handles, size * sizeof (HANDLE));
> > +          if (tmp == NULL)
>
> ... oh, and this might actually fail MSVC compilation, due to
> "variable declared after other code parts" (size += 10)...
>

Isn't it time to deprecate support for visual studio older than 2013? MSVC
in VS-2015 supports C99 constructs and VS2013 may also do.

If not, I'll submit a version 2.


>
> >                if (error)
> >                  {
> > +                  ReturnError (pipe, error, L"Insufficient reources to
> service new clients", 1, &exit_event);
> > +                  /* Update wait handles again after removing the last
> worker thread */
> > +                  RemoveListItem (&threads, CmpHandle, thread);
> > +                  UpdateWaitHandles (&handles, &handle_count, io_event,
> exit_event, threads);
> >                    TerminateThread (thread, 1);
> >                    CloseHandleEx (&thread);
> >                    CloseHandleEx (&pipe);
> > -                  SetEvent (exit_event);
>
> So we do not exit anymore when this fails, except if WAIT_FAILED?
>

That is correct.  I tested it and works nicely -- i.e., on realloc error,
all previous connections continue while new connections get an error
message.

Selva

--001a114492e86e851405336f967c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><span class=3D"im">copy to the =
list...<br><br>On Sun, May 22, 2016 at 3:31 AM, Gert Doering <span dir=3D"l=
tr">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...2132...=
.</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">Hi,<br>
<span><br>
On Sun, May 22, 2016 at 12:46:27AM -0400, Selva Nair wrote:<br>
</span><span>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size +=3D 10;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 handles =3D realloc (handles, size=
 * sizeof (HANDLE));<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (handles =3D=3D NULL)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ERROR_OUTOFMEMORY;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LPHANDLE tmp =3D realloc (handles,=
 size * sizeof (HANDLE));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tmp =3D=3D NULL)<br>
<br>
</span>... oh, and this might actually fail MSVC compilation, due to<br>
&quot;variable declared after other code parts&quot; (size +=3D 10)...<br><=
/blockquote><div><br></div></span><div>Isn&#39;t
 it time to deprecate support for visual studio older than 2013? MSVC in
 VS-2015 supports C99 constructs and VS2013 may also do.<br><br></div><div>=
If not, I&#39;ll submit a version 2.<br></div><span class=3D"im"><div>=C2=
=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<span><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (error)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Return=
Error (pipe, error, L&quot;Insufficient reources to service new clients&quo=
t;, 1, &amp;exit_event);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Upd=
ate wait handles again after removing the last worker thread */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Remove=
ListItem (&amp;threads, CmpHandle, thread);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Update=
WaitHandles (&amp;handles, &amp;handle_count, io_event, exit_event, threads=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 T=
erminateThread (thread, 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 C=
loseHandleEx (&amp;thread);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 C=
loseHandleEx (&amp;pipe);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SetEve=
nt (exit_event);<br>
<br>
</span>So we do not exit anymore when this fails, except if WAIT_FAILED?<br=
></blockquote><div><br></div></span>That
 is correct.=C2=A0 I tested it and works nicely -- i.e., on realloc error,=
=20
all previous connections continue while new connections get an error=20
message.<br><br></div><div class=3D"gmail_extra">Selva<br></div><div class=
=3D"gmail_extra"><br></div></div>

--001a114492e86e851405336f967c--

