MIME-Version: 1.0
In-Reply-To: <20160623175201.GJ79504@...1296...>
References: <575AA2BD.60908@...277...> <20160610125457.GC62247@...1296...>
	<CAKuzo_jrwK47wDtoLNCZXP8-OG0izGmjZRrDb5vdT5shhY7FMQ@...278...>
	<20160610165515.GG62247@...1296...>
	<CAKuzo_gkAX-5USrRi8sMvwtbxiJxCwgoi4KTOC1qtU0fpHHTvQ@...278...>
	<20160623175201.GJ79504@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 23 Jun 2016 14:42:18 -0400
Message-ID: <CAKuzo_hrvARGvhShR5NK2SB6pG0qtvnXQr_S+G17LXrGzfqD7g@...278...>
Content-Type: multipart/alternative; boundary=94eb2c09593e150caf0535f66b0a
Subject: Re: [Openvpn-devel] pull-filter reject = server hammering !
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

--94eb2c09593e150caf0535f66b0a
Content-Type: text/plain; charset=UTF-8

On Thu, Jun 23, 2016 at 1:52 PM, Gert Doering <gert@...1296...> wrote:

> On Sat, Jun 18, 2016 at 03:41:22PM -0400, Selva Nair wrote:
> > > > This is possible, but the case for progressively increasing the
> restart
> > > > pause is not very strong. Can we get some feedback from people who
> serve
> > > > 1000's of users?
> > >
> > > I would generally consider it polite behaviour... (also, it might save
> > > the client from filled-up disks...) - didn't think of exponential
> back-off
> > > yet, but that would certainly be another approach to consider.
> > >
> > > I have no idea how complicated it would be to implement, though.
> >
> > Filling up the client log with repeated retries is a concern, indeed.
> >
> > Although a proper implementation needs the failed reconnect count per
> > ip/port combination which we do not currently keep track of, I think a
> > heuristic count may be good enough. One could use something like this:
> >
> > n = c->options.unsuccessful_attempts
> > m = c->options.connection_list->len
> > rc = n/m   (a rough measure of retries per remote)
> > timeout = the_default_timeout << MIN(rc, 10)  (exponential up to ~ 5000
> > seconds).
> > throw a SIGHUP if rc exceeds some value (resets n and starts over)
> >
> > The retry count will be over-stated for situations like one remote name
> > that resolves to many IPs, but avoiding that requires more work.. Any
> > thoughts?
>
> I'm not sure I understand the math.  Let me try to reword.
>
> So it would increase "n" for each failed attempt, setting it to "0" if
> one succeeds (so the reconnect after a session aborts would start "fresh").
>

Yes it gets reset to zero in intialization_sequence_completed(). Or after a
SIGHUP.


>
> Leaving out "m" for the time being, "retry time" would then get scaled by
> 2^rc (capped by 2^10), so the initial 5s would become 10s, 20s, ... 5000s
> (this is not "timeout" as in "the unified TCP connection timeout" but the
> retry timer firing after one connection attempt is aborted).
>

timeout was a poorly chose name, its the startup pause time -- controlled
by variables like
connect_retry_seconds or restart_sleep_seconds. It gets passed to
openvpn_sleep.


>
>
> So, now we have 4 different remotes.  You're scaling the exponent by 1/4
> here, so the retry timer would be
>
>   5s 5s 5s 5s 10s 10s 10s 10s 20s 20s 20s 20s ...
>
> then (or, phrased differently, "one round uses the unscaled timer, the
> next round across all remotes uses 2^1, the third round uses 2^2").
>
>
> If I understood the math right, I think this would be useful behaviour ;-)
> - fast failover if multiple remotes are there, exponentially slowing down
> if all remotes have been tried.  Plus, fairly easy to implement as nearly
> all needed values are already around.


Yes, the book-keeping variables are already there.

To avoid aggressive slowing down, may be we could start the scaling after
rc has reached a threshold. Say don't do anything until rc = 5 and then
start scaling the timer until rc reaches 15.

Selva

--94eb2c09593e150caf0535f66b0a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Jun 23, 2016 at 1:52 PM, Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><span>On Sat, Jun 18, 2016 at 03=
:41:22PM -0400, Selva Nair wrote:<br>
&gt; &gt; &gt; This is possible, but the case for progressively increasing =
the restart<br>
&gt; &gt; &gt; pause is not very strong. Can we get some feedback from peop=
le who serve<br>
&gt; &gt; &gt; 1000&#39;s of users?<br>
&gt; &gt;<br>
&gt; &gt; I would generally consider it polite behaviour... (also, it might=
 save<br>
&gt; &gt; the client from filled-up disks...) - didn&#39;t think of exponen=
tial back-off<br>
&gt; &gt; yet, but that would certainly be another approach to consider.<br>
&gt; &gt;<br>
&gt; &gt; I have no idea how complicated it would be to implement, though.<=
br>
&gt;<br>
&gt; Filling up the client log with repeated retries is a concern, indeed.<=
br>
&gt;<br>
&gt; Although a proper implementation needs the failed reconnect count per<=
br>
&gt; ip/port combination which we do not currently keep track of, I think a=
<br>
&gt; heuristic count may be good enough. One could use something like this:=
<br>
&gt;<br>
&gt; n =3D c-&gt;options.unsuccessful_attempts<br>
&gt; m =3D c-&gt;options.connection_list-&gt;len<br>
&gt; rc =3D n/m=C2=A0 =C2=A0(a rough measure of retries per remote)<br>
&gt; timeout =3D the_default_timeout &lt;&lt; MIN(rc, 10)=C2=A0 (exponentia=
l up to ~ 5000<br>
&gt; seconds).<br>
&gt; throw a SIGHUP if rc exceeds some value (resets n and starts over)<br>
&gt;<br>
&gt; The retry count will be over-stated for situations like one remote nam=
e<br>
&gt; that resolves to many IPs, but avoiding that requires more work.. Any<=
br>
&gt; thoughts?<br>
<br>
</span>I&#39;m not sure I understand the math.=C2=A0 Let me try to reword.<=
br>
<br>
So it would increase &quot;n&quot; for each failed attempt, setting it to &=
quot;0&quot; if<br>
one succeeds (so the reconnect after a session aborts would start &quot;fre=
sh&quot;).<br></blockquote><div><br></div><div>Yes it gets reset to zero in=
 intialization_sequence_completed(). Or after a SIGHUP.</div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">
<br>
Leaving out &quot;m&quot; for the time being, &quot;retry time&quot; would =
then get scaled by<br>
2^rc (capped by 2^10), so the initial 5s would become 10s, 20s, ... 5000s<b=
r>
(this is not &quot;timeout&quot; as in &quot;the unified TCP connection tim=
eout&quot; but the<br>
retry timer firing after one connection attempt is aborted).<br></blockquot=
e><div><br></div><div>timeout was a poorly chose name, its the startup paus=
e time -- controlled by variables like=C2=A0</div><div>connect_retry_second=
s or restart_sleep_seconds. It gets passed to openvpn_sleep.</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">
<br>
<br>
So, now we have 4 different remotes.=C2=A0 You&#39;re scaling the exponent =
by 1/4<br>
here, so the retry timer would be<br>
<br>
=C2=A0 5s 5s 5s 5s 10s 10s 10s 10s 20s 20s 20s 20s ...<br>
<br>
then (or, phrased differently, &quot;one round uses the unscaled timer, the=
<br>
next round across all remotes uses 2^1, the third round uses 2^2&quot;).<br>
<br>
<br>
If I understood the math right, I think this would be useful behaviour ;-)<=
br>
- fast failover if multiple remotes are there, exponentially slowing down<b=
r>
if all remotes have been tried.=C2=A0 Plus, fairly easy to implement as nea=
rly<br>
all needed values are already around.</blockquote></div><div class=3D"gmail=
_extra"><br></div><div class=3D"gmail_extra">Yes, the book-keeping variable=
s are already there.=C2=A0</div><div class=3D"gmail_extra"><br></div><div c=
lass=3D"gmail_extra">To avoid aggressive slowing down, may be we could star=
t the scaling after rc has reached a threshold. Say don&#39;t do anything u=
ntil rc =3D 5 and then start scaling the timer until rc reaches 15.</div><d=
iv class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva</div><b=
r></div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><br=
></div></div>

--94eb2c09593e150caf0535f66b0a--

