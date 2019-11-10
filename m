MIME-Version: 1.0
References: <1573148729-27339-1-git-send-email-lstipakov@...277...>
 <1573148729-27339-5-git-send-email-lstipakov@...277...>
 <14e11aff-4107-3693-c0bc-e8f5538c007a@...1856...>
In-Reply-To: <14e11aff-4107-3693-c0bc-e8f5538c007a@...1856...>
From: Lev Stipakov <lstipakov@...277...>
Date: Sun, 10 Nov 2019 14:48:29 +0200
Message-ID: <CAGyAFMUhJ_nj8VzvXHN83TeSsKUT+xO91t42HeM7ewZ+Cih_oA@...278...>
Content-Type: multipart/alternative; boundary="00000000000045623c0596fd6fad"
Subject: Re: [Openvpn-devel] [PATCH v2 4/7] wintun: ring buffers based I/O
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000045623c0596fd6fad
Content-Type: text/plain; charset="UTF-8"

Hi,

As a general remark: could you try to stick to the 80 char line length
> limit?
>

Ok.


> > +#ifdef _WIN32
> > +    }
> >  #endif
>
> As Simon mentioned too, this code is getting more and more hard to read.
> Can we maybe do this in some cleaner way? Maybe add some helper
> function(s)?
>

Already fixed in v3.

> +#ifdef _WIN32
> > +    }
> > +#endif
>
> As above :)
>

Already fixed in v3.


> > +            if (tt->send_ring->head == tt->send_ring->tail)
> > +            {
> > +                /* nothing to read from tun -> remove tun read flag set
> by IOW_READ */
> > +                flags &= ~IOW_READ_TUN;
> > +            }
> > +        }
> > +    }
> > +#endif
>
> Looks like this should be a helper function (with a good name that helps
> understand what this does).
>


Implemented helper function tuntap_ring_empty().

> +            c->c2.event_set_status = ret;
>
> This chunk is the same as the "fast path" check above. Looks like you
> should re-arrange this code so you don't have to duplicate it.
>

Not quite (already discussed verbally).

> +#ifdef _WIN32
> > +    if (c->c1.tuntap && c->c1.tuntap->wintun)
> > +    {
> > +        if (c->c1.tuntap->send_ring->head !=
> c->c1.tuntap->send_ring->tail)
>
> Looking this deep into the tuntap struct from another module looks like
> a layering violation. Consider adding a helper function like
>

Fixed with the helper from above (tuntap_ring_empty).

> +        {
> > +            /* add ring buffer event */
> > +            struct rw_handle rw = { .read =
> c->c1.tuntap->send_tail_moved };
> > +            event_ctl(mtcp->es, &rw, EVENT_READ, MTCP_TUN);
> > +        }
>
> Can this not be done by tun_set() below? At first glance, if either
> tun_event_handle() returns tt->send_tail_moved for wintun (instaed of
> tt->rw_handle), of if tt->rw_handle would be set to send_tail_moved for
> wintun. The latter might even allow you to get rid of
> tt->send_tail_removed completely.
>

Thanks for the idea.

Indeed, I did some refactoring and reused rw_handle.read/write
instead of send/receive_tail_moved. Also got rid of wintun-specific
event_ctl calls - now it is handled in tun_set().


> > +            if (tt->send_ring->head == tt->send_ring->tail)
>
> This should use the same helper function as suggested above.
>

Done.

> +    struct tun_ring *send_ring;
> > +    struct tun_ring *receive_ring;
> > +    HANDLE send_tail_moved;
> > +    HANDLE receive_tail_moved;
>
> These are wintun-specific, right? Should we maybe clarify this by
> prefixing them with wintun_ ?
>

  *_tail_moved are gone, added "wintun_" prefix to *_ring.


> > +#define WINTUN_RING_CAPACITY 0x800000
>
> Can you explain why this is the right size? Document either in a
> comment, or in the commit message.
>

Those are from WG client, mentioned it in a comment.

-Steffan


V4 is coming!

-- 
-Lev

--00000000000045623c0596fd6fad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,=C2=A0<div><br></div></div><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">As a gen=
eral remark: could you try to stick to the 80 char line length<br>
limit?<br></blockquote><div><br></div><div>Ok.=C2=A0</div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +#ifdef _WIN32<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 #endif<br>
<br>
As Simon mentioned too, this code is getting more and more hard to read.<br>
Can we maybe do this in some cleaner way? Maybe add some helper function(s)=
?<br></blockquote><div><br></div><div>Already fixed in v3.=C2=A0</div><div>=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; +#ifdef _W=
IN32<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +#endif<br>
<br>
As above :)<br></blockquote><div><br></div><div>Already fixed in v3.=C2=A0<=
/div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tt-&gt;send_ring-&gt;h=
ead =3D=3D tt-&gt;send_ring-&gt;tail)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* nothing to=
 read from tun -&gt; remove tun read flag set by IOW_READ */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flags &amp;=
=3D ~IOW_READ_TUN;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +#endif<br>
<br>
Looks like this should be a helper function (with a good name that helps<br>
understand what this does).<br></blockquote><div><br></div><div><br></div><=
div>Implemented helper function=C2=A0tuntap_ring_empty().=C2=A0</div><div><=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; +=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;c2.event_set_status =3D ret;<br>
<br>
This chunk is the same as the &quot;fast path&quot; check above. Looks like=
 you<br>
should re-arrange this code so you don&#39;t have to duplicate it.<br></blo=
ckquote><div><br></div><div>Not quite (already discussed verbally).=C2=A0</=
div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; +=
#ifdef _WIN32<br>
&gt; +=C2=A0 =C2=A0 if (c-&gt;c1.tuntap &amp;&amp; c-&gt;c1.tuntap-&gt;wint=
un)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (c-&gt;c1.tuntap-&gt;send_ring-&gt;hea=
d !=3D c-&gt;c1.tuntap-&gt;send_ring-&gt;tail)<br>
<br>
Looking this deep into the tuntap struct from another module looks like<br>
a layering violation. Consider adding a helper function like<br></blockquot=
e><div><br></div><div>Fixed with the helper from above (tuntap_ring_empty).=
</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* add ring buffer event */=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rw_handle rw =3D { .=
read =3D c-&gt;c1.tuntap-&gt;send_tail_moved };<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 event_ctl(mtcp-&gt;es, &amp=
;rw, EVENT_READ, MTCP_TUN);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
Can this not be done by tun_set() below? At first glance, if either<br>
tun_event_handle() returns tt-&gt;send_tail_moved for wintun (instaed of<br>
tt-&gt;rw_handle), of if tt-&gt;rw_handle would be set to send_tail_moved f=
or<br>
wintun. The latter might even allow you to get rid of<br>
tt-&gt;send_tail_removed completely.<br></blockquote><div><br></div><div>Th=
anks for the idea.</div><div><br></div><div>Indeed, I did some refactoring =
and reused rw_handle.read/write</div><div>instead of send/receive_tail_move=
d. Also got rid of wintun-specific</div><div>event_ctl calls - now it is ha=
ndled in tun_set().<br></div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tt-&gt;send_ring-&gt;he=
ad =3D=3D tt-&gt;send_ring-&gt;tail)<br>
<br>
This should use the same helper function as suggested above.<br></blockquot=
e><div><br></div><div>Done.=C2=A0</div><div><br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">&gt; +=C2=A0 =C2=A0 struct tun_ring *send_ring=
;<br>
&gt; +=C2=A0 =C2=A0 struct tun_ring *receive_ring;<br>
&gt; +=C2=A0 =C2=A0 HANDLE send_tail_moved;<br>
&gt; +=C2=A0 =C2=A0 HANDLE receive_tail_moved;<br>
<br>
These are wintun-specific, right? Should we maybe clarify this by<br>
prefixing them with wintun_ ?<br></blockquote><div><br></div><div>=C2=A0 *_=
tail_moved are gone, added &quot;wintun_&quot; prefix to *_ring.=C2=A0</div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; +#=
define WINTUN_RING_CAPACITY 0x800000<br>
<br>
Can you explain why this is the right size? Document either in a<br>
comment, or in the commit message.<br></blockquote><div><br></div><div>Thos=
e are from WG client, mentioned it in a comment.=C2=A0</div><div><br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">-Steffan</blockquote><div=
><br></div><div>V4 is coming!</div><div>=C2=A0=C2=A0</div></div>-- <br><div=
 dir=3D"ltr" class=3D"gmail_signature">-Lev</div></div>

--00000000000045623c0596fd6fad--

