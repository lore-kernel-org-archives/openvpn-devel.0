MIME-Version: 1.0
In-Reply-To: <b2e1af67-2b5c-44ba-e8db-4d325d6e1e0b@...2080...>
References: <1494327032-3035-1-git-send-email-steffan.karger@...1435...>
	<b2e1af67-2b5c-44ba-e8db-4d325d6e1e0b@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 9 May 2017 14:08:56 -0400
Message-ID: <CAKuzo_iVrROZsuU+DhHfuu6m6jKutftqfqNB2WW5d4fV5YH7Pw@...278...>
Content-Type: multipart/alternative; boundary=001a11406f22fb11ff054f1b407b
Subject: Re: [Openvpn-devel] [PATCH] Always clear username/password from
 memory on error
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11406f22fb11ff054f1b407b
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue, May 9, 2017 at 1:47 PM, David Sommerseth <openvpn@...2142...
topphemmelig.net> wrote:

> That said, I think we should fix secure_memzero() to just return if the
> input pointer is NULL.  And even though most compilers do initialize
> variables, I think it's good to be defensive here and initialize `up` too.
>

No, compiler will not initialize such non-static local variables. In fact
in this case gcc will warn (with -Wall) that "up" may be used uninitalized
because of code paths where "up" is not allocated as you pointed out.

In that sense its better not to initialize such variables as initialization
can hide errors.

Selva

--001a11406f22fb11ff054f1b407b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Tue, May 9, 2017 at 1:47 PM, Dav=
id Sommerseth <span dir=3D"ltr">&lt;<a href=3D"mailto:openvpn@...2080..." t=
arget=3D"_blank">openvpn@...2142...<wbr>topphemmelig.net</a>&gt;</span> wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><div id=3D"m_-925956235477434549:8vv"=
 class=3D"m_-925956235477434549a3s m_-925956235477434549aXjCH m_-9259562354=
77434549m15bee54b49118a0e">That said, I think we should fix secure_memzero(=
) to just return if the<br>
input pointer is NULL.=C2=A0 And even though most compilers do initialize<b=
r>
variables, I think it&#39;s good to be defensive here and initialize `up` t=
oo.</div></blockquote></div><br></div><div class=3D"gmail_extra">No, compil=
er will not initialize such non-static local variables. In fact in this cas=
e gcc will warn (with -Wall) that &quot;up&quot; may be used uninitalized b=
ecause of code paths where &quot;up&quot; is not allocated as you pointed o=
ut.<br><br>In that sense its better not to initialize such variables as ini=
tialization can hide errors.<br><br></div><div class=3D"gmail_extra">Selva<=
br></div></div>

--001a11406f22fb11ff054f1b407b--

