From: Heiko Hund <heiko.hund@...1489...>
Date: Mon, 1 Feb 2016 17:11:07 +0100
Message-ID: <3424321.JZBnSkvBRS@...2001...>
In-Reply-To: <56A7D1F6.8030805@...515...>
References: <2215306.x9ci9DhAZ9@...2001...>
	<20160126191913.GV24952@...1296...>
	<56A7D1F6.8030805@...515...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v3] interactive service v3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi

Sorry was too busy so far to catch up reading with this thread.

On Tuesday 26 January 2016 22:07:18 Samuli Sepp=E4nen wrote:
> One question, primarily to Heiko... does the interactive service solve
> the use-case where the administrator/user wants to have persistent
> connections that come up on boot and are not closed or managed in any
> way in the meantime? In this use-case no user interaction is wanted,
> needed or expected.

As Gert put it correctly, the interactive service is just an addon service =
for=20
the interactive use case (currently a GUI). However if I understood you guy=
s=20
correctly the main feature of the other new service (v2) is that it works w=
ith=20
Windows 10 and that you can select which connections you start/stop.

Well that same thing could be achieved with the interactive service. All yo=
u'd=20
need is a little helper program that starts/stops a connection talking to t=
he=20
interactive service. Mainly the parts of the GUI that tell the iservice to=
=20
start a connection. The service itself is spawning a thread for every openv=
pn=20
tunnel it is signaled to start.

I said it could be achieved, because the iservice currently doesn't handle=
=20
restarts of openvpn. Instead it trusts the GUI to do so if it expects the=20
connection to be up when a openvpn process disappears. One benefit would=20
obviously be the shared code base and that openvpn could be run under an=20
unprivileged account as well.=20

If it makes sense to extend the iservice to handle the automatic use case i=
s a=20
different thing, who will do it yet another one on top. Someone made the po=
int=20
that the automatic service is a corner use case, most ppl will not use it. =
I=20
agree. Ppl. used it to overcome the routing issue since Vista, but it was=20
never there for this use case anyway and the interactive service solves thi=
s=20
problem.

So, having the "automatic"/"v2" service as a completely separate service or=
=20
even project is fine with me. It just has some consequences that have been=
=20
mentioned already. If you're all fine with these let's do it.

Heiko

