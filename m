MIME-Version: 1.0
In-Reply-To: <20160126191913.GV24952@...1296...>
References: <2215306.x9ci9DhAZ9@...2001...>
	<1453835508-26119-1-git-send-email-gert@...1296...>
	<20160126191913.GV24952@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 26 Jan 2016 15:20:38 -0500
Message-ID: <CAKuzo_g3X1yTDV8MrstynxCqZWOy1GBqHyi_jTVRM+jJwU9Xog@...278...>
Content-Type: multipart/alternative; boundary=001a1137b11266e7f7052a426c32
Subject: Re: [Openvpn-devel] [PATCH v3] interactive service v3
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

--001a1137b11266e7f7052a426c32
Content-Type: text/plain; charset=UTF-8

On Tue, Jan 26, 2016 at 2:19 PM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> so, this took quite a while - barely 2.5 years, but we're getting
> there.  v3 of the patch has been rebased to git master, and all comments
> from Steffan and my earlier review have been integrated into the build
> stuff and the openvpn side of the code - so, as far as openvpn goes, I'm
> fine with merging that but would welcome an independent ACK (given that
> I modified quite a bit of Heiko's code).
>
> The service part has been *tested* - as in:
>
>  - compiles (mingw)
>  - runs on Win7  (openvpnserv -remove, copy in new binary, run
>    "openvpnvserv -install", "openvpnserv -start interactive" [or reboot])
>  - does what it says on the tin:
>     - run openvpn.exe as the user executing the GUI
>     - handles adding and removing of ipv6 address config and v4/v6 routing
>     - enables use of openvpn gui without [X] admin checkbox as a totally
>       unprivileged user
>     - openvpn log makes it clear whether netsh.exe is used or service
>
> what I have not done is a full review of the resulting code - the changes
> are large and intrusive, and given the amount of code *removal* it looks
> like "massive cleanup" happened as well.  I do not know Windows well enough
> to understand the intricacies, so a review from someone with a stronger
> Windows background would be welcome - Selva, are you still around?
>

Still alive, though things are a bit hectic at work. Its a fairly large
chunk of code and I had only glanced through parts of it in the past. Will
try to take a look.

Selva

--001a1137b11266e7f7052a426c32
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Jan 26, 2016 at 2:19 PM, Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div style=3D"overflow:hidden">H=
i,<br>
<br>
so, this took quite a while - barely 2.5 years, but we&#39;re getting<br>
there.=C2=A0 v3 of the patch has been rebased to git master, and all commen=
ts<br>
from Steffan and my earlier review have been integrated into the build<br>
stuff and the openvpn side of the code - so, as far as openvpn goes, I&#39;=
m<br>
fine with merging that but would welcome an independent ACK (given that<br>
I modified quite a bit of Heiko&#39;s code).<br>
<br>
The service part has been *tested* - as in:<br>
<br>
=C2=A0- compiles (mingw)<br>
=C2=A0- runs on Win7=C2=A0 (openvpnserv -remove, copy in new binary, run<br>
=C2=A0 =C2=A0&quot;openvpnvserv -install&quot;, &quot;openvpnserv -start in=
teractive&quot; [or reboot])<br>
=C2=A0- does what it says on the tin:<br>
=C2=A0 =C2=A0 - run openvpn.exe as the user executing the GUI<br>
=C2=A0 =C2=A0 - handles adding and removing of ipv6 address config and v4/v=
6 routing<br>
=C2=A0 =C2=A0 - enables use of openvpn gui without [X] admin checkbox as a =
totally<br>
=C2=A0 =C2=A0 =C2=A0 unprivileged user<br>
=C2=A0 =C2=A0 - openvpn log makes it clear whether netsh.exe is used or ser=
vice<br>
<br>
what I have not done is a full review of the resulting code - the changes<b=
r>
are large and intrusive, and given the amount of code *removal* it looks<br>
like &quot;massive cleanup&quot; happened as well.=C2=A0 I do not know Wind=
ows well enough<br>
to understand the intricacies, so a review from someone with a stronger<br>
Windows background would be welcome - Selva, are you still around?<br></div=
></blockquote><div><br></div><div>Still alive, though things are a bit hect=
ic at work. Its a fairly large chunk of code and I had only glanced through=
 parts of it in the past. Will try to take a look.</div><div><br></div><div=
>Selva</div></div></div></div>

--001a1137b11266e7f7052a426c32--

