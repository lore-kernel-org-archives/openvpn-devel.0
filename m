MIME-Version: 1.0
In-Reply-To: <11772d2a-4877-0ed0-2484-7ef66e059737@...1227...>
References: <1467430368-25437-1-git-send-email-selva.nair@...277...>
	<1467502488-31549-1-git-send-email-selva.nair@...277...>
	<11772d2a-4877-0ed0-2484-7ef66e059737@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 4 Jul 2016 11:43:13 -0400
Message-ID: <CAKuzo_jjiW9hyVc_+Wo=2aBtAgUmmyOTuLmqCbsq7yq7PCdmGQ@...278...>
Content-Type: multipart/alternative; boundary=001a1147b672e0e4030536d132a4
Subject: Re: [Openvpn-devel] [PATCH v2] Exponentially back off on repeated
 connect retries
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1147b672e0e4030536d132a4
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon, Jul 4, 2016 at 5:23 AM, Arne Schwabe <arne@...1227...> wrote:

>  - sndbuf and recvbuf default now to OS default instead of 64k
> >
> > @@ -120,6 +120,10 @@ User-visible Changes
> >  - --http-proxy-retry and --sock-proxy-retry have been removed. Proxy
> connections
> >      will now behave like regular connection entries and generate a USR1
> on failure.
> >
> > +- --connect-retry gets a optional third argument that specifies the
> maximum
> > +  time in seconds to wait between reconnection attempts when an
> exponential
> > +  backoff is triggered due to repeated retries. Default = 300 seconds.
> Shouldn't that be 2nd argument?


Ugh... should be 2nd. Will do a v3..

> +  backoff = (c->options.unsuccessful_attempts /
> c->options.connection_list->len) - 4;
> > +  if (backoff > 0 && sec < 1<<16)
> the 1<<16 seems a bit random here. Could you at least add a comment of
> why? I don't see any valid reason here since sec is limited between 1 and
> connect_retry_seconds_max by the next two lines anyway.
> > +    sec = max_int (sec, 1) << min_int (backoff, 15);
> The 15 here is the same. Both lines seem to only make sense with 16 bit
> integers.
>

Something like this is needed to protect against overflow of the 32 bit int
(signed int in this case). Think of the user specifying sec = 2^17. Any
shift by more than 14 will  make sec = 0. A more sophisticated logic that
counts the bits in sec before shifting is possible, but this looked
simple.. Now that a v3 is needed, will change to an explicit check on
overflow.

> +  if (sec > c->options.ce.connect_retry_seconds_max)
> > +    sec = c->options.ce.connect_retry_seconds_max;
> Oh, my suggestion made the max time time configurable per connection
> entry. We should address that in a seperate patch. I think connect-retry
> as a whole can be made a non connection config entry. (connect-retry
> traditionally was the time between tcp connects for a tcp connection
> which looped on its own before the dual stack patch if anyone wonders
> why it was connection specific).


It can still be specified as a common number outside connection entries, so
leaving it as a connection-specific number looks fine to me.

Selva

--001a1147b672e0e4030536d132a4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Mon, Jul 4, 2016 at 5:23 AM, Arn=
e Schwabe <span dir=3D"ltr">&lt;<a href=3D"mailto:arne@...1227..." target=
=3D"_blank">arne@...1227...</a>&gt;</span> wrote:</div><div class=3D"gmail_=
quote"><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-l=
eft-style:solid;padding-left:1ex">&gt; =C2=A0- sndbuf and recvbuf default n=
ow to OS default instead of 64k<br>&gt;<br>&gt; @@ -120,6 +120,10 @@ User-v=
isible Changes<br>&gt; =C2=A0- --http-proxy-retry and --sock-proxy-retry ha=
ve been removed. Proxy connections<br>&gt; =C2=A0 =C2=A0 =C2=A0will now beh=
ave like regular connection entries and generate a USR1 on failure.<br>&gt;=
<br>&gt; +- --connect-retry gets a optional third argument that specifies t=
he maximum<br>&gt; + =C2=A0time in seconds to wait between reconnection att=
empts when an exponential<br>&gt; + =C2=A0backoff is triggered due to repea=
ted retries. Default =3D 300 seconds.<br>Shouldn&#39;t that be 2nd argument=
?</blockquote><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quot=
e">Ugh... should be 2nd. Will do a v3..</div><div class=3D"gmail_quote"><br=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;=
padding-left:1ex"><span>&gt; +=C2=A0 backoff =3D (c-&gt;options.unsuccessfu=
l_attempts / c-&gt;options.connection_list-&gt;len) - 4;<br>
&gt; +=C2=A0 if (backoff &gt; 0 &amp;&amp; sec &lt; 1&lt;&lt;16)<br>
</span>the 1&lt;&lt;16 seems a bit random here. Could you at least add a co=
mment of<br>
why? I don&#39;t see any valid reason here since sec is limited between 1 a=
nd<br>
connect_retry_seconds_max by the next two lines anyway.<br>
<span>&gt; +=C2=A0 =C2=A0 sec =3D max_int (sec, 1) &lt;&lt; min_int (backof=
f, 15);<br>
</span>The 15 here is the same. Both lines seem to only make sense with 16 =
bit<br>
integers.<br></blockquote><div><br></div><div>Something like this is needed=
 to protect against overflow of the 32 bit int (signed int in this case). T=
hink of the user specifying sec =3D 2^17. Any shift by more than 14 will=C2=
=A0 make sec =3D 0. A more sophisticated logic that counts the bits in sec =
before shifting is possible, but this looked simple.. Now that a v3 is need=
ed, will change to an explicit check on overflow.<br><br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1=
px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:=
1ex">
<span>&gt; +=C2=A0 if (sec &gt; c-&gt;options.ce.connect_retry_seconds_max)=
<br>
&gt; +=C2=A0 =C2=A0 sec =3D c-&gt;options.ce.connect_retry_seconds_max;<br>
</span>Oh, my suggestion made the max time time configurable per connection=
<br>
entry. We should address that in a seperate patch. I think connect-retry<br>
as a whole can be made a non connection config entry. (connect-retry<br>
traditionally was the time between tcp connects for a tcp connection<br>
which looped on its own before the dual stack patch if anyone wonders<br>
why it was connection specific).</blockquote></div><br></div><div class=3D"=
gmail_extra">It can still be specified as a common number outside connectio=
n entries, so leaving it as a connection-specific number looks fine to me.<=
br><br></div><div class=3D"gmail_extra">Selva<br></div><div class=3D"gmail_=
extra"><br><br></div></div>

--001a1147b672e0e4030536d132a4--

