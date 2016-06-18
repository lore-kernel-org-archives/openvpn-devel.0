MIME-Version: 1.0
In-Reply-To: <20160610165515.GG62247@...1296...>
References: <575AA2BD.60908@...277...> <20160610125457.GC62247@...1296...>
	<CAKuzo_jrwK47wDtoLNCZXP8-OG0izGmjZRrDb5vdT5shhY7FMQ@...278...>
	<20160610165515.GG62247@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 18 Jun 2016 15:41:22 -0400
Message-ID: <CAKuzo_gkAX-5USrRi8sMvwtbxiJxCwgoi4KTOC1qtU0fpHHTvQ@...278...>
Content-Type: multipart/alternative; boundary=001a113e30b61a7e94053592a9a4
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

--001a113e30b61a7e94053592a9a4
Content-Type: text/plain; charset=UTF-8

Hi,

On Fri, Jun 10, 2016 at 12:55 PM, Gert Doering <gert@...1296...> wrote:

> On Fri, Jun 10, 2016 at 12:43:20PM -0400, Selva Nair wrote:
> > > @Selva, Arne: can we make the reconnect logic somewhat smarter overall,
> > > like
> > > "if reconnecting to the same host, wait 30 seconds instead of 5"?
> >
> > This is possible, but the case for progressively increasing the restart
> > pause is not very strong. Can we get some feedback from people who serve
> > 1000's of users?
>
> I would generally consider it polite behaviour... (also, it might save
> the client from filled-up disks...) - didn't think of exponential back-off
> yet, but that would certainly be another approach to consider.
>
> I have no idea how complicated it would be to implement, though.


Filling up the client log with repeated retries is a concern, indeed.

Although a proper implementation needs the failed reconnect count per
ip/port combination which we do not currently keep track of, I think a
heuristic count may be good enough. One could use something like this:

n = c->options.unsuccessful_attempts
m = c->options.connection_list->len
rc = n/m   (a rough measure of retries per remote)
timeout = the_default_timeout << MIN(rc, 10)  (exponential up to ~ 5000
seconds).
throw a SIGHUP if rc exceeds some value (resets n and starts over)

The retry count will be over-stated for situations like one remote name
that resolves to many IPs, but avoiding that requires more work.. Any
thoughts?

Selva

--001a113e30b61a7e94053592a9a4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Fri, Jun 10, 2016 at 12:55 PM, G=
ert Doering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=
=3D"_blank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"><span>On Fri, Jun 10, 2016 at 12:43:20PM -0400,=
 Selva Nair wrote:<br>
&gt; &gt; @Selva, Arne: can we make the reconnect logic somewhat smarter ov=
erall,<br>
&gt; &gt; like<br>
&gt; &gt; &quot;if reconnecting to the same host, wait 30 seconds instead o=
f 5&quot;?<br>
&gt;<br>
&gt; This is possible, but the case for progressively increasing the restar=
t<br>
&gt; pause is not very strong. Can we get some feedback from people who ser=
ve<br>
&gt; 1000&#39;s of users?<br>
<br>
</span>I would generally consider it polite behaviour... (also, it might sa=
ve<br>
the client from filled-up disks...) - didn&#39;t think of exponential back-=
off<br>
yet, but that would certainly be another approach to consider.<br>
<br>
I have no idea how complicated it would be to implement, though.</blockquot=
e></div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Fil=
ling up the client log with repeated retries is a concern, indeed. <br><br>=
Although a proper implementation needs the failed reconnect count per ip/po=
rt combination which we do not currently keep track of, I think a heuristic=
 count may be good enough. One could use something like this:<br><br>n =3D =
c-&gt;options.unsuccessful_attempts<br>m =3D c-&gt;options.connection_list-=
&gt;len<br>rc =3D n/m=C2=A0=C2=A0 (a rough measure of retries per remote)<b=
r>timeout =3D the_default_timeout &lt;&lt; MIN(rc, 10)=C2=A0 (exponential u=
p to ~ 5000 seconds). <br></div><div class=3D"gmail_extra">throw a SIGHUP i=
f rc exceeds some value (resets n and starts over)<br></div></div><div clas=
s=3D"gmail_extra"><br></div><div class=3D"gmail_extra">The retry count will=
 be over-stated for situations like one remote name that resolves to many I=
Ps, but avoiding that requires more work.. Any thoughts?<br><br></div><div =
class=3D"gmail_extra">Selva<br></div></div>

--001a113e30b61a7e94053592a9a4--

