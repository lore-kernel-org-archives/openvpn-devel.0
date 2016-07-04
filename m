MIME-Version: 1.0
In-Reply-To: <f94abd87-0113-19c7-12de-745ed1de8e42@...1227...>
References: <1467430368-25437-1-git-send-email-selva.nair@...277...>
	<1467502488-31549-1-git-send-email-selva.nair@...277...>
	<11772d2a-4877-0ed0-2484-7ef66e059737@...1227...>
	<CAKuzo_jjiW9hyVc_+Wo=2aBtAgUmmyOTuLmqCbsq7yq7PCdmGQ@...278...>
	<f94abd87-0113-19c7-12de-745ed1de8e42@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 4 Jul 2016 14:22:50 -0400
Message-ID: <CAKuzo_iJKTBzc1RSQAhA0qGA8GkJfMkjhdKhcB0SJ0QKbobKqg@...278...>
Content-Type: multipart/alternative; boundary=001a11489e4abaa8b10536d36d15
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

--001a11489e4abaa8b10536d36d15
Content-Type: text/plain; charset=UTF-8

On Mon, Jul 4, 2016 at 12:02 PM, Arne Schwabe <arne@...1227...> wrote:

> >
> > Something like this is needed to protect against overflow of the 32
> > bit int (signed int in this case). Think of the user specifying sec =
> > 2^17. Any shift by more than 14 will  make sec = 0. A more
> > sophisticated logic that counts the bits in sec before shifting is
> > possible, but this looked simple.. Now that a v3 is needed, will
> > change to an explicit check on overflow.
>


> That do that check in options.c and complain there. :)


Yes, we could limit n and m in "--connect-retry n [m]" to  < 2^16 and then
limit the shift to 15 in init.c. But that adds dependency between two
statements in widely different locations. What I propose is to leave
options.c as is and change the exponential scaling code in init.c to

if (backoff > 0)
  {
     sec = max_int (sec, 1) << min_int (backoff, 31);  /* left shifting int
by 32 or more is ill-defined */
     if (sec == 0)  /* overflow */
       sec = INT_MAX;
  }

No more confusing numbers like 16 and 15.

> +  /* Slow down reconnection after 5 retries per remote */
> > +  backoff = (c->options.unsuccessful_attempts /
> c->options.connection_list->len) - 4;
> > +  if (backoff > 0 && sec < 1<<16)
> > +    sec = max_int (sec, 1) << min_int (backoff, 15);
> > +  if (sec > c->options.ce.connect_retry_seconds_max)
> > +    sec = c->options.ce.connect_retry_seconds_max;
> > +
> >    if (c->persist.restart_sleep_seconds > 0 &&
> c->persist.restart_sleep_seconds > sec)
> >      sec = c->persist.restart_sleep_seconds;
> >    else if (c->persist.restart_sleep_seconds == -1)
> >
> I think this also needs an excempt for TCP_SERVER case. I think moving
> the TCP_SERVER if below the exponential logic will work. Otherwise
> connecting just 10 times is an effect dos for a tcp server.


I am not sure I follow. Are you referring to the possibility that the sec =
1 for TCP_SERVER may get set to zero after 5 retries if "--connect-retry 0
0" is used? The server only listens for connections so this should not
happen, would it?.

Or do you have tcp-client in mind? In case of tcp-client, before this
patch, "--connect-retry 0" will hammer the server with repeated retries.
That will be avoided as max sec defaults to 300 sec, unless the user
specifies "--connect-retry 0 0".  Shall we require that the second arg to
connect-retry should be greater than some minimum, say, at least 10 sec?

Selva

--001a11489e4abaa8b10536d36d15
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Jul 4, 2016 at 12:02 PM, Arne Schwabe <span dir=3D"ltr">&lt;<a href=
=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1227...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-s=
tyle:solid;padding-left:1ex"><span>&gt;<br>
&gt; Something like this is needed to protect against overflow of the 32<br>
&gt; bit int (signed int in this case). Think of the user specifying sec =
=3D<br>
&gt; 2^17. Any shift by more than 14 will=C2=A0 make sec =3D 0. A more<br>
&gt; sophisticated logic that counts the bits in sec before shifting is<br>
&gt; possible, but this looked simple.. Now that a v3 is needed, will<br>
&gt; change to an explicit check on overflow.<br></span></blockquote><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-s=
tyle:solid;padding-left:1ex"><span>
</span>That do that check in options.c and complain there. :)</blockquote><=
/div><br>Yes, we could limit n and m in &quot;--connect-retry n [m]&quot; t=
o =C2=A0&lt; 2^16 and then limit the shift to 15 in init.c. But that adds d=
ependency between two statements in widely different locations. What I prop=
ose is to leave options.c as is and change the exponential scaling code in =
init.c to</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_ext=
ra"><div class=3D"gmail_extra">if (backoff &gt; 0)</div><div class=3D"gmail=
_extra">=C2=A0 {</div><div class=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0sec =
=3D max_int (sec, 1) &lt;&lt; min_int (backoff, 31); =C2=A0/* left shifting=
 int by 32 or more is ill-defined */</div><div class=3D"gmail_extra">=C2=A0=
 =C2=A0 =C2=A0if (sec =3D=3D 0) =C2=A0/* overflow */</div><div class=3D"gma=
il_extra">=C2=A0 =C2=A0 =C2=A0 =C2=A0sec =3D INT_MAX;</div><div class=3D"gm=
ail_extra">=C2=A0 }</div><div class=3D"gmail_extra"><br></div><div class=3D=
"gmail_extra">No more confusing numbers like 16 and 15.</div><div class=3D"=
gmail_extra"><div class=3D"gmail_extra"><br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-lef=
t-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">&gt; + =
=C2=A0/* Slow down reconnection after 5 retries per remote */<br>&gt; + =C2=
=A0backoff =3D (c-&gt;options.unsuccessful_attempts / c-&gt;options.connect=
ion_list-&gt;len) - 4;<br>&gt; + =C2=A0if (backoff &gt; 0 &amp;&amp; sec &l=
t; 1&lt;&lt;16)<br>&gt; + =C2=A0 =C2=A0sec =3D max_int (sec, 1) &lt;&lt; mi=
n_int (backoff, 15);<br>&gt; + =C2=A0if (sec &gt; c-&gt;options.ce.connect_=
retry_seconds_max)<br>&gt; + =C2=A0 =C2=A0sec =3D c-&gt;options.ce.connect_=
retry_seconds_max;<br>&gt; +<br>&gt; =C2=A0 =C2=A0if (c-&gt;persist.restart=
_sleep_seconds &gt; 0 &amp;&amp; c-&gt;persist.restart_sleep_seconds &gt; s=
ec)<br>&gt; =C2=A0 =C2=A0 =C2=A0sec =3D c-&gt;persist.restart_sleep_seconds=
;<br>&gt; =C2=A0 =C2=A0else if (c-&gt;persist.restart_sleep_seconds =3D=3D =
-1)<br>&gt;<br>I think this also needs an excempt for TCP_SERVER case. I th=
ink moving<br>the TCP_SERVER if below the exponential logic will work. Othe=
rwise<br>connecting just 10 times is an effect dos for a tcp server.</block=
quote><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">I am =
not sure I follow. Are you referring to the possibility that the sec =3D 1 =
for TCP_SERVER may get set to zero after 5 retries if &quot;--connect-retry=
 0 0&quot; is used? The server only listens for connections so this should =
not happen, would it?.</div><div class=3D"gmail_extra"><br></div><div class=
=3D"gmail_extra">Or do you have tcp-client in mind? In case of tcp-client, =
before this patch, &quot;--connect-retry 0&quot; will hammer the server wit=
h repeated retries.=C2=A0 That will be avoided as max sec defaults to 300 s=
ec, unless the user specifies &quot;--connect-retry 0 0&quot;.=C2=A0 Shall =
we require that the second arg to connect-retry should be greater than some=
 minimum, say, at least 10 sec?=C2=A0</div></div><div class=3D"gmail_extra"=
><br></div><div class=3D"gmail_extra">Selva</div></div></div>

--001a11489e4abaa8b10536d36d15--

