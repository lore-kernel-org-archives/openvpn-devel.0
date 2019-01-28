MIME-Version: 1.0
References: <20181230112901.29241-1-a@...2181...>
In-Reply-To: <20181230112901.29241-1-a@...2181...>
From: Justin Henck <henck@...410...>
Date: Mon, 28 Jan 2019 13:09:45 -0500
Message-ID: <CAN-AkJtEbNXBezK1iNpbrQvrWKMx+QF3D+y05KS7RrZPtWzJrQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000009c709705808895e2"
Subject: Re: [Openvpn-devel] [PATCH 0/4] Transport API: offload traffic
 manipulation to plugins
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>, Brandon Wiley <brandon@...2483...>

--0000000000009c709705808895e2
Content-Type: text/plain; charset="UTF-8"

Hi all,
I just wanted to bump this to see if there is any feedback on the API?

Thanks!
Justin

Justin Henck
Product Manager
212-565-9811
google.com/jigsaw

PGP: EA8E 8C27 2D75 974D B357 482B 1039 9F2D 869A 117B


On Sun, Dec 30, 2018 at 6:30 AM Antonio Quartulli <a@...2181...> wrote:

> From: Antonio Quartulli <antonio@...515...>
>
> Dear all,
>
> This patchset implements a new API called "Transport API" which allows the
> core codebase to offload traffic/socket manipulations to an external
> plugin.
>
> To understand its potential, imagine you want to apply a specific
> "mutation" on any packet going out and apply the its inverse, on the
> receiver
> side, for any incoming packet.
> Without this patchset, achieving this result would require a big surgery
> through the OpenVPN code, and it would be the same for any new mutation one
> wants to implements. Thanks to this new API the deemed effort
> is drastically reduced.
>
> In a few words, OpenVPN becomes extendible on a new front, by cutting the
> need to touch the core codebase any longer.
>
> An easy to imagine use case for this new API would be any "traffic
> obfuscation
> technique": instead of patching the core code (like the famous "xor
> patch"), a developer is now allowed to implement an external obfuscation
> plugin and distribute/maintain it indepdendently.
>
> This patchset comes with a sample plugin (obfs-test) which can be used as
> starting point for new implementations.
>
> Any feedback is welcome!
>
> Note: the code has gone through the following tests with positive outcome:
> - uncrustify
> - GitLab-CI (with my configs)
> - openvpn community buildbots
>
> Since it is quite a change (even though most of the new code is fairly
> isolated in its own module - transport.c/h), I expect more
> comments/discussion/bugs to spark from here.
>
> In any case, please consider myself as direct contact point to discuss
> further changes and improvements (even though I am not the signer of the
> patches). I'll be in responsible for ensuring this code gets merged sooner
> rather than later.
>
> Thanks a lot!!
>
> == Credits ==
>
> This code has been developed by the Operator Foundation[1], under the
> umbrella project called "Jigsaw"[2], mainly promoted/sponsored by Google,
> Inc.
>
> Brandon, reading this email in CC, has been the contact point on
> the Operator Foundation's side, while Justin (in CC as well), managed the
> task on Google's behalf.
>
>
> OpenVPN, Inc. has offered its support to the cause by allowing its devs to
> allocate a number of hours to follow the project and ensure it could
> get all the guidance it required.
>
> [1] https://operatorfoundation.org/
> [2] https://jigsaw.google.com/
>
>
> Best Regards,
>
>
>
> Robin Tarsiger (4):
>   transport: introduce tranport API plugin codebase
>   socket: introduce INDIRECT transport protocol abstraction
>   options: add support for --transport-plugin
>   transport-plugin: add sample obfs-test plugin
>
>  configure.ac                              |   9 +
>  doc/openvpn.8                             |  40 ++
>  include/Makefile.am                       |   1 +
>  include/openvpn-plugin.h.in               |  31 +-
>  include/openvpn-transport.h               | 240 +++++++++
>  src/openvpn/Makefile.am                   |   1 +
>  src/openvpn/forward.c                     |   5 +
>  src/openvpn/init.c                        |   1 +
>  src/openvpn/options.c                     |  31 ++
>  src/openvpn/options.h                     |   1 +
>  src/openvpn/plugin.c                      |   4 +
>  src/openvpn/plugin.h                      |   1 +
>  src/openvpn/socket.c                      | 148 +++++-
>  src/openvpn/socket.h                      |  74 +++
>  src/openvpn/transport.c                   | 303 +++++++++++
>  src/openvpn/transport.h                   |  99 ++++
>  src/plugins/Makefile.am                   |   2 +-
>  src/plugins/obfs-test/Makefile.am         |  29 ++
>  src/plugins/obfs-test/README.obfs-test    |  26 +
>  src/plugins/obfs-test/obfs-test-args.c    |  60 +++
>  src/plugins/obfs-test/obfs-test-munging.c | 129 +++++
>  src/plugins/obfs-test/obfs-test-posix.c   | 207 ++++++++
>  src/plugins/obfs-test/obfs-test-win32.c   | 579 ++++++++++++++++++++++
>  src/plugins/obfs-test/obfs-test.c         |  94 ++++
>  src/plugins/obfs-test/obfs-test.exports   |   4 +
>  src/plugins/obfs-test/obfs-test.h         |  42 ++
>  26 files changed, 2155 insertions(+), 6 deletions(-)
>  create mode 100644 include/openvpn-transport.h
>  create mode 100644 src/openvpn/transport.c
>  create mode 100644 src/openvpn/transport.h
>  create mode 100644 src/plugins/obfs-test/Makefile.am
>  create mode 100644 src/plugins/obfs-test/README.obfs-test
>  create mode 100644 src/plugins/obfs-test/obfs-test-args.c
>  create mode 100644 src/plugins/obfs-test/obfs-test-munging.c
>  create mode 100644 src/plugins/obfs-test/obfs-test-posix.c
>  create mode 100644 src/plugins/obfs-test/obfs-test-win32.c
>  create mode 100644 src/plugins/obfs-test/obfs-test.c
>  create mode 100644 src/plugins/obfs-test/obfs-test.exports
>  create mode 100644 src/plugins/obfs-test/obfs-test.h
>
> --
> 2.19.2
>
>

--0000000000009c709705808895e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div>I just wanted to bump this to see if there is =
any feedback on the API?</div><div><br>Thanks!</div><div>Justin<br clear=3D=
"all"><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gma=
il_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr">=
<div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div dir=
=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr=
"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div =
dir=3D"ltr"><br><table cellspacing=3D"0" cellpadding=3D"0" style=3D"font-fa=
mily:&quot;open sans&quot;,sans-serif"><tbody><tr style=3D"color:rgb(102,10=
2,102);font-family:sans-serif;font-size:small"><td nowrap valign=3D"top" st=
yle=3D"border:none;padding-right:22px"><img src=3D"https://www.gstatic.com/=
jigsaw/Jigsaw_logo.png" height=3D"45" width=3D"45" style=3D"height:45px;wid=
th:45px"></td><td nowrap style=3D"border:none"><span style=3D"font-weight:b=
old">Justin Henck</span>=C2=A0<br><span>Product Manager</span><span></span>=
=C2=A0<br><div style=3D"display:inline"><span>212-565-9811</span>=C2=A0<br>=
</div><a href=3D"https://google.com/jigsaw" style=3D"color:rgb(102,102,102)=
" target=3D"_blank">google.com/jigsaw</a></td></tr></tbody></table></div><d=
iv dir=3D"ltr"><div dir=3D"auto"><div><span><font color=3D"#666666"><br></f=
ont></span></div><div><span><font color=3D"#666666">PGP: EA8E 8C27 2D75 974=
D B357 482B 1039 9F2D 869A 117B</font></span></div></div></div></div></div>=
</div></div></div></div></div></div></div></div></div></div></div></div></d=
iv></div></div></div></div></div></div></div><br></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Dec 30, 2018=
 at 6:30 AM Antonio Quartulli &lt;a@...2181...&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">From: Antonio Quartulli &lt;<a hr=
ef=3D"mailto:antonio@...515..." target=3D"_blank">antonio@...515...</a>&gt;=
<br>
<br>
Dear all,<br>
<br>
This patchset implements a new API called &quot;Transport API&quot; which a=
llows the<br>
core codebase to offload traffic/socket manipulations to an external plugin=
.<br>
<br>
To understand its potential, imagine you want to apply a specific<br>
&quot;mutation&quot; on any packet going out and apply the its inverse, on =
the receiver<br>
side, for any incoming packet.<br>
Without this patchset, achieving this result would require a big surgery<br>
through the OpenVPN code, and it would be the same for any new mutation one=
<br>
wants to implements. Thanks to this new API the deemed effort<br>
is drastically reduced.<br>
<br>
In a few words, OpenVPN becomes extendible on a new front, by cutting the<b=
r>
need to touch the core codebase any longer.<br>
<br>
An easy to imagine use case for this new API would be any &quot;traffic obf=
uscation<br>
technique&quot;: instead of patching the core code (like the famous &quot;x=
or<br>
patch&quot;), a developer is now allowed to implement an external obfuscati=
on<br>
plugin and distribute/maintain it indepdendently.<br>
<br>
This patchset comes with a sample plugin (obfs-test) which can be used as<b=
r>
starting point for new implementations.<br>
<br>
Any feedback is welcome!<br>
<br>
Note: the code has gone through the following tests with positive outcome:<=
br>
- uncrustify<br>
- GitLab-CI (with my configs)<br>
- openvpn community buildbots<br>
<br>
Since it is quite a change (even though most of the new code is fairly<br>
isolated in its own module - transport.c/h), I expect more<br>
comments/discussion/bugs to spark from here.<br>
<br>
In any case, please consider myself as direct contact point to discuss<br>
further changes and improvements (even though I am not the signer of the<br>
patches). I&#39;ll be in responsible for ensuring this code gets merged soo=
ner<br>
rather than later.<br>
<br>
Thanks a lot!!<br>
<br>
=3D=3D Credits =3D=3D<br>
<br>
This code has been developed by the Operator Foundation[1], under the<br>
umbrella project called &quot;Jigsaw&quot;[2], mainly promoted/sponsored by=
 Google, Inc.<br>
<br>
Brandon, reading this email in CC, has been the contact point on<br>
the Operator Foundation&#39;s side, while Justin (in CC as well), managed t=
he<br>
task on Google&#39;s behalf.<br>
<br>
<br>
OpenVPN, Inc. has offered its support to the cause by allowing its devs to<=
br>
allocate a number of hours to follow the project and ensure it could<br>
get all the guidance it required.<br>
<br>
[1] <a href=3D"https://operatorfoundation.org/" rel=3D"noreferrer" target=
=3D"_blank">https://operatorfoundation.org/</a><br>
[2] <a href=3D"https://jigsaw.google.com/" rel=3D"noreferrer" target=3D"_bl=
ank">https://jigsaw.google.com/</a><br>
<br>
<br>
Best Regards,<br>
<br>
<br>
<br>
Robin Tarsiger (4):<br>
=C2=A0 transport: introduce tranport API plugin codebase<br>
=C2=A0 socket: introduce INDIRECT transport protocol abstraction<br>
=C2=A0 options: add support for --transport-plugin<br>
=C2=A0 transport-plugin: add sample obfs-test plugin<br>
<br>
=C2=A0<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A09 +<br>
=C2=A0doc/openvpn.8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 40 ++<br>
=C2=A0include/Makefile.am=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0include/<a href=3D"http://openvpn-plugin.h.in" rel=3D"noreferrer" tar=
get=3D"_blank">openvpn-plugin.h.in</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 31 +-<br>
=C2=A0include/openvpn-transport.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 240 +++++++++<br>
=C2=A0src/openvpn/Makefile.am=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0src/openvpn/forward.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +<br>
=C2=A0src/openvpn/init.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0src/openvpn/options.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 31 ++<br>
=C2=A0src/openvpn/options.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0src/openvpn/plugin.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +<br>
=C2=A0src/openvpn/plugin.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0src/openvpn/socket.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 148 +++++-<br>
=C2=A0src/openvpn/socket.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 74 +++<br>
=C2=A0src/openvpn/transport.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 303 +++++++++++<br>
=C2=A0src/openvpn/transport.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 99 ++++<br>
=C2=A0src/plugins/Makefile.am=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0src/plugins/obfs-test/Makefile.am=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 29 ++<br>
=C2=A0src/plugins/obfs-test/README.obfs-test=C2=A0 =C2=A0 |=C2=A0 26 +<br>
=C2=A0src/plugins/obfs-test/obfs-test-args.c=C2=A0 =C2=A0 |=C2=A0 60 +++<br>
=C2=A0src/plugins/obfs-test/obfs-test-munging.c | 129 +++++<br>
=C2=A0src/plugins/obfs-test/obfs-test-posix.c=C2=A0 =C2=A0| 207 ++++++++<br>
=C2=A0src/plugins/obfs-test/obfs-test-win32.c=C2=A0 =C2=A0| 579 +++++++++++=
+++++++++++<br>
=C2=A0src/plugins/obfs-test/obfs-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 94 ++++<br>
=C2=A0src/plugins/obfs-test/obfs-test.exports=C2=A0 =C2=A0|=C2=A0 =C2=A04 +=
<br>
=C2=A0src/plugins/obfs-test/obfs-test.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 42 ++<br>
=C2=A026 files changed, 2155 insertions(+), 6 deletions(-)<br>
=C2=A0create mode 100644 include/openvpn-transport.h<br>
=C2=A0create mode 100644 src/openvpn/transport.c<br>
=C2=A0create mode 100644 src/openvpn/transport.h<br>
=C2=A0create mode 100644 src/plugins/obfs-test/Makefile.am<br>
=C2=A0create mode 100644 src/plugins/obfs-test/README.obfs-test<br>
=C2=A0create mode 100644 src/plugins/obfs-test/obfs-test-args.c<br>
=C2=A0create mode 100644 src/plugins/obfs-test/obfs-test-munging.c<br>
=C2=A0create mode 100644 src/plugins/obfs-test/obfs-test-posix.c<br>
=C2=A0create mode 100644 src/plugins/obfs-test/obfs-test-win32.c<br>
=C2=A0create mode 100644 src/plugins/obfs-test/obfs-test.c<br>
=C2=A0create mode 100644 src/plugins/obfs-test/obfs-test.exports<br>
=C2=A0create mode 100644 src/plugins/obfs-test/obfs-test.h<br>
<br>
-- <br>
2.19.2<br>
<br>
</blockquote></div>

--0000000000009c709705808895e2--

