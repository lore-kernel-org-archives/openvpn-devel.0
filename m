MIME-Version: 1.0
In-Reply-To: <20160307080415.GZ24952@...1296...>
References: <CAKuzo_jrTKkAWGv7gRoADPWz5VTDFPqfrHxUDppPuQ63Y+RFKA@...278...>
	<20160306214850.GY24952@...1296...>
	<CAKuzo_ic11Et-56qi4OR62hErRaE1E=qcDyyP8kuyExkecEi6g@...278...>
	<20160307080415.GZ24952@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 7 Mar 2016 18:22:36 -0500
Message-ID: <CAKuzo_hynK=oWk2Tn2B11CvswUnqgj_p7uM9Fdqxnmdbo1eEsg@...278...>
Content-Type: multipart/alternative; boundary=001a11c2b4649d6790052d7dbe91
Subject: Re: [Openvpn-devel] operations that still require elevation on
	windows
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

--001a11c2b4649d6790052d7dbe91
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon, Mar 7, 2016 at 3:04 AM, Gert Doering <gert@...1296...> wrote:

> > Then its only register-dns that remains...
>
> Yep.  Its semantics are not totally clear to me (the code does more, like
> turn off dns cache off/on) and I have no idea whether there's a real API
> for that...


Yes, it does much more than "ipconfig /registerdns": it restarts dns
service, flushes the dns cache, and then does registerdns. Looks like
someone decided to throw everything at it. In my own very limited  tests
I've never seen anything more than registerdns needed to get the DNS server
registered. In fact, a manual "dhcp /renew" after the connection comes up
also appears to do the job: this is not the same as  the --dhcp-renew
option, though.

But I haven't tested any of this beyond a single windows 7 machine, so cant
say for use that ipconfig /registerdns or dhcp renew is enough. Considering
that many folks appear to be dependent on this option, we have to keep it
as is, I guess.

AFAIK,  there is no API for either of these. There are some undocumented
calls like DnsFlushReseolverCache in dnsapi.dll but there are no official
docs on them. The service can be started and restarted using API but its no
less pain than using "net stop" and "net start"

I suppose we need to just queue this request to the service and let it do
it asynchronously in a separate thread. Which is not very unlike the
current fork_to_self approach. It shouldn't be hard to add that to
interactive.c

Selva

--001a11c2b4649d6790052d7dbe91
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Mon, Mar 7, 2016 at 3:04 AM, Gert Do=
ering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_b=
lank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x"><span>&gt; Then its only register-dns that remains...<br>
<br>
</span>Yep.=C2=A0 Its semantics are not totally clear to me (the code does =
more, like<br>
turn off dns cache off/on) and I have no idea whether there&#39;s a real AP=
I<br>
for that...</blockquote></div><br>Yes, it does much more than &quot;ipconfi=
g /registerdns&quot;: it restarts dns service, flushes the dns cache, and t=
hen does registerdns. Looks like someone decided to throw everything at it.=
 In my own very limited =C2=A0tests I&#39;ve never seen anything more than =
registerdns needed to get the DNS server registered. In fact, a manual &quo=
t;dhcp /renew&quot; after the connection comes up also appears to do the jo=
b: this is not the same as =C2=A0the --dhcp-renew option, though.</div><div=
 class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">But I haven&#39=
;t tested any of this beyond a single windows 7 machine, so cant say for us=
e that ipconfig /registerdns or dhcp renew is enough. Considering that many=
 folks appear to be dependent on this option, we have to keep it as is, I g=
uess.</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">=
AFAIK, =C2=A0there is no API for either of these. There are some undocument=
ed calls like DnsFlushReseolverCache in dnsapi.dll but there are no officia=
l docs on them. The service can be started and restarted using API but its =
no less pain than using &quot;net stop&quot; and &quot;net start&quot;</div=
><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">I suppose =
we need to just queue this request to the service and let it do it asynchro=
nously in a separate thread. Which is not very unlike the current fork_to_s=
elf approach. It shouldn&#39;t be hard to add that to interactive.c</div><d=
iv class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva</div></=
div>

--001a11c2b4649d6790052d7dbe91--

