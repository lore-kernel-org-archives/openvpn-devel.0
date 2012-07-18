MIME-Version: 1.0
In-Reply-To: <CAOazyz15sK3xpvvRu3i86o8BXZ4hk09faxNAQJ_CHsYzdsL7kw@...278...>
References: <1340730302-3077-1-git-send-email-alon.barlev@...277...>
	<CAEsd45QsjHX19m8kFsTEixyk1O9VB7gn25rj7aarSe9vuvahXw@...278...>
	<CAOazyz15sK3xpvvRu3i86o8BXZ4hk09faxNAQJ_CHsYzdsL7kw@...278...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Wed, 18 Jul 2012 09:47:37 -0400
Message-ID: <CAEsd45Sqta=kOegU9ugRz63-hzORVsqj3uu5q8sZsdtR=ngGNA@...278...>
Content-Type: multipart/alternative; boundary=bcaec54fb0424ffd5404c51aeaff
Subject: Re: [Openvpn-devel] [PATCH] plugin: load plugin relative to
	plugindir
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--bcaec54fb0424ffd5404c51aeaff
Content-Type: text/plain; charset=UTF-8

On Wed, Jul 18, 2012 at 9:37 AM, Alon Bar-Lev <alon.barlev@...277...> wrote:

> Nobody disables the absolute path use.
> This patch permits relative use.
>

I'm sorry, I misunderstood. So a relative path will now be interpreted as
relative to the plugins directory specified a build time, rather than
whatever it is relative to now (current working directory?)

So please consider my response to have been responding to Heiko's post:

On Wed, Jul 18, 2012 at 7:44 AM, Heiko Hund <heiko.hund@...1489...> wrote:

> Specifying a custom full path is probably something we need to ban in the
> (near) future, as it imposes an attack vector for privilege escalation by
> code
> injection when openvpn is not running as another user or has access to
> privilege escalation by other means (like the yet to be submitted Windows
> interactive service).
>

--bcaec54fb0424ffd5404c51aeaff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Wed, Jul 18, 2012 at 9:37 AM, Alon Bar-Lev <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:alon.barlev@...277..." target=3D"_bla=
nk">alon.barlev@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">

Nobody disables the absolute path use.<br>
This patch permits relative use.<br></blockquote><div><br></div><div>I&#39;=
m sorry, I misunderstood. So a relative path will now be interpreted as rel=
ative to the plugins directory specified a build time, rather than whatever=
 it is relative to now (current working directory?)</div>

<div><br></div><div>So please consider my response to have been responding =
to Heiko&#39;s post:</div><div><br></div><div>On Wed, Jul 18, 2012 at 7:44 =
AM, Heiko Hund=C2=A0<span dir=3D"ltr">&lt;<a href=3D"mailto:heiko.hund@...1386...=
489..." target=3D"_blank">heiko.hund@...1489...</a>&gt;</span>=C2=A0wrote:<=
br>

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">Specifying a custom full path is probably something we nee=
d to ban in the<br>

(near) future, as it imposes an attack vector for privilege escalation by c=
ode<br>injection when openvpn is not running as another user or has access =
to<br>privilege escalation by other means (like the yet to be submitted Win=
dows<br>

interactive service).<br></blockquote></div><div>=C2=A0</div></div>

--bcaec54fb0424ffd5404c51aeaff--

