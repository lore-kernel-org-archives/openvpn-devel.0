MIME-Version: 1.0
In-Reply-To: <SN1PR08MB13915E1863B6616C835AA9B4B9380@...2065...>
References: <mailman.84319.1445380747.12779.openvpn-devel@lists.sourceforge.net>
	<562734CD.6080706@...1420...>
	<SN1PR08MB13915E1863B6616C835AA9B4B9380@...2065...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 21 Oct 2015 23:02:05 -0400
Message-ID: <CAKuzo_gtcKODwWnRP6PJCjyQS6WiZmcb10xrfLF8wYvvJMc=8w@...278...>
Content-Type: multipart/alternative; boundary=001a1133d0427e5d2d0522a8b920
Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Morris, Russell" <rmorris@...1315...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1133d0427e5d2d0522a8b920
Content-Type: text/plain; charset=UTF-8

Hi,

On Wed, Oct 21, 2015 at 7:54 AM, Morris, Russell <rmorris@...1315...>
wrote:

> Hi,
>
> Lots of discussion on this - awesome to see! Perhaps a dumb question, but
> I can see a few different ways to go on this, as I see comments about
> services, applications, etc. ... so a couple thoughts,
> - is the intention to run a service (like NSSM?) that keeps openvpn.exe
> "alive" (restarting it as necessary), so it's always up and running? I
> admit, I somewhat like this approach, one running application for each
> config file. Then control it through the management interface. Or,
>

All said and done, I still think this is the best approach. This is also
the current approach except that the service (non-NSSM) is "crappy" and the
"official" GUI cant do much through MI if openvpn is started by the
service.  I'm saying this only based on the docs, may be the latest code is
already capable of doing this with some coaxing.

My current work-around is to use the MI-GUI and pray/hope for the service
not to crash. I only run one server on 2008R2 and a few single user desktop
clients with MI-GUI on Windows 7. This has worked well so far, but with few
users.


> - do folks prefer to have "control application" bring openvpn.exe up and
> down? I have tried this, and it's a bit messy, but it is functional also.
>

Not sure how that works and what problems it would solve. For me the main
needs are (i) a reliable way of daemonizing openvpn and keep it running on
Windows (for servers and clients) and (ii) a way to run the GUI with user
privileges. Both could be solved by NSSM + an improved GUI that speaks the
MI.


>
> Thoughts?
>
> I do believe there may also be TAP related stability issues, but that may
> be an artifact of openvpn.exe crashing - I guess the first step is to get
> openvpn.exe stable?
>

I have seldom seen openvpn.exe crash -- its more like it just exits because
of bad directives in a config file or a missing certificate/key etc.  The
problem is with the service -- a single bad config can stop it from loading
others. It sometimes goes into a weird state which can be recovered only by
a restart. It also lacks features like adding a new configs without
affecting running instances. I hear it doesn't work on Windows 10, but I
haven't tried.

So, a stable service (or NSSM) and an improved GUI for desktop clients are
needed. NSSM has many advantages in this regard as each instance is
independent of the other (is n't it?). I am not that excited about the
interactive service which lets openvpn.exe run as user but lets users push
configs. And it cant handle non-interactive uses.

In my view configs should be registered only with admin privilege, not
arbitrarily pushed by any user -- this applies to desktops and servers.
Only for day to day activities of starting and stopping a connection one
wants to avoid the "run as admin" requirement.. Running only the GUI as
user through the MI serves that purpose and looks a safer option than the
interactive service.

Thanks,

Selva

--001a1133d0427e5d2d0522a8b920
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><div class=3D"gmail_extra"><br><div class=3D"gmail=
_quote">On Wed, Oct 21, 2015 at 7:54 AM, Morris, Russell <span dir=3D"ltr">=
&lt;<a href=3D"mailto:rmorris@...1315..." target=3D"_blank"><span>rmorris</=
span>@<span>rkmorris</span>.us</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Hi,<br>
<br>
Lots of discussion on this - awesome to see! Perhaps a dumb question, but I=
 can see a few different ways to go on this, as I see comments about servic=
es, applications, etc. ... so a couple thoughts,<br>
- is the intention to run a service (like NSSM?) that keeps openvpn.exe &qu=
ot;alive&quot; (restarting it as necessary), so it&#39;s always up and runn=
ing? I admit, I somewhat like this approach, one running application for ea=
ch config file. Then control it through the management interface. Or,<br></=
blockquote><div><br></div><div>All said and done, I still think this is the=
 best approach. This is also the current approach except that the service (=
non-<span>NSSM</span>) is &quot;crappy&quot; and the &quot;official&quot; G=
UI cant do much through MI if <span>openvpn</span> is started by the servic=
e.=C2=A0 I&#39;m saying this only based on the docs, may be the latest code=
 is already capable of doing this with some coaxing.=C2=A0 <br><br>My curre=
nt work-around is to use the MI-GUI and pray/hope for the service not to cr=
ash. I only run one server on 2008R2 and a few single user desktop clients =
with MI-GUI on Windows 7. This has worked well so far, but with few users.<=
br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
- do folks prefer to have &quot;control application&quot; bring openvpn.exe=
 up and down? I have tried this, and it&#39;s a bit messy, but it is functi=
onal also.<br></blockquote><div><br></div><div>Not sure how that works and =
what problems it would solve. For me the main needs are (i) a reliable way =
of <span>daemonizing</span> <span>openvpn</span> and keep it running on Win=
dows (for servers and clients) and (ii) a way to run the GUI with user priv=
ileges. Both could be solved by <span>NSSM</span> + an improved GUI that sp=
eaks the MI.=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Thoughts?<br>
<br>
I do believe there may also be TAP related stability issues, but that may b=
e an artifact of openvpn.exe crashing - I guess the first step is to get op=
envpn.exe stable?<br></blockquote><div><br></div><div>I have seldom seen <s=
pan>openvpn</span>.<span>exe</span> crash -- its more like it just exits be=
cause of bad directives in a <span>config</span> file or a missing certific=
ate/key etc.=C2=A0 The problem is with the service -- a single bad <span>co=
nfig</span> can stop it from loading others. It sometimes goes into a weird=
 state which can be recovered only by a restart. It also lacks features lik=
e adding a new <span>configs</span> without affecting running instances. I =
hear it doesn&#39;t work on Windows 10, but I haven&#39;t tried.<br></div><=
div><br></div><div>So, a stable service (or <span>NSSM</span>) and an impro=
ved GUI for desktop clients are needed. <span>NSSM</span> has many advantag=
es in this regard as each instance is independent of the other (is <span>n&=
#39;t</span> it?). I am not that excited about the interactive service whic=
h lets <span>openvpn</span>.<span>exe</span> run as user but lets users pus=
h <span>configs</span>. And it cant handle non-interactive uses. <br><br>In=
 my view <span>configs</span> should be registered only with admin privileg=
e, not arbitrarily pushed by any user -- this applies to desktops and serve=
rs. Only for day to day activities of starting and stopping a connection on=
e wants to avoid the &quot;run as admin&quot; requirement.. Running only th=
e GUI as user through the MI serves that purpose and looks a safer option t=
han the interactive service.<br></div><div><br></div><div>Thanks,<br></div>=
<div><br><span>Selva</span>=C2=A0</div><br></div></div></div></div>

--001a1133d0427e5d2d0522a8b920--

