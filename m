MIME-Version: 1.0
In-Reply-To: <20160306214850.GY24952@...1296...>
References: <CAKuzo_jrTKkAWGv7gRoADPWz5VTDFPqfrHxUDppPuQ63Y+RFKA@...278...>
	<20160306214850.GY24952@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 6 Mar 2016 17:03:21 -0500
Message-ID: <CAKuzo_ic11Et-56qi4OR62hErRaE1E=qcDyyP8kuyExkecEi6g@...278...>
Content-Type: multipart/alternative; boundary=001a11c2b46458371b052d6885df
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

--001a11c2b46458371b052d6885df
Content-Type: text/plain; charset=UTF-8

On Sun, Mar 6, 2016 at 4:48 PM, Gert Doering <gert@...1296...> wrote:

> On Sun, Mar 06, 2016 at 03:17:40PM -0500, Selva Nair wrote:
> > There at least two more things on windows that the interactive service
> has
> > to support:
> >
> > (i)  register-dns
>
> Indeed, this seems to be missing today.
>
> > (ii) ipv6 address and route setup
> >
> > Is there anything else? For (ii)  can't it be done using the IP Helper
> API
> > on vista+ -- is the use of net command required? If not, it should be
> easy
> > to delegate it to the service.
>
> ... but this should all be nicely done...?


Oh, I missed that. Based on the Trac ticket (#71) discussion on fatal error
after sleep-resume, which was apparently caused by netsh failures treated
as FATAL,  and seeing some comments that ipv6 setup needs to use netsh
command, I just assumed this is not done. Sorry for jumping into that
conclusion.

Then its only register-dns that remains...

Selva

--001a11c2b46458371b052d6885df
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sun, Mar 6, 2016 at 4:48 PM, Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><span>On Sun, Mar 06, 2016 at 03=
:17:40PM -0500, Selva Nair wrote:<br>
&gt; There at least two more things on windows that the interactive service=
 has<br>
&gt; to support:<br>
&gt;<br>
&gt; (i)=C2=A0 register-dns<br>
<br>
</span>Indeed, this seems to be missing today.<br>
<span><br>
&gt; (ii) ipv6 address and route setup<br>
&gt;<br>
&gt; Is there anything else? For (ii)=C2=A0 can&#39;t it be done using the =
IP Helper API<br>
&gt; on vista+ -- is the use of net command required? If not, it should be =
easy<br>
&gt; to delegate it to the service.<br>
<br>
</span>... but this should all be nicely done...?</blockquote></div><br></d=
iv><div class=3D"gmail_extra">Oh, I missed that. Based on the Trac ticket (=
#71) discussion on fatal error after sleep-resume, which was apparently cau=
sed by netsh failures treated as FATAL,=C2=A0 and seeing some comments that=
 ipv6 setup needs to use netsh command, I just assumed this is not done. So=
rry for jumping into that conclusion.<br><br></div><div class=3D"gmail_extr=
a">Then its only register-dns that remains...<br><br></div><div class=3D"gm=
ail_extra">Selva<br></div><div class=3D"gmail_extra"><br></div></div>

--001a11c2b46458371b052d6885df--

