References: <1345727389.42365.YahooMailNeo@...1744...>
	<50364E1E.7000109@...1114...>
	<1345828643.55420.YahooMailNeo@...1750...>
	<503A8633.5090308@...1114...>
Message-ID: <1346030651.69898.YahooMailNeo@...1752...>
Date: Mon, 27 Aug 2012 09:24:11 +0800 (SGT)
From: Amm Vpn <ammdispose-vpn@...109...>
In-Reply-To: <503A8633.5090308@...1114...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] patch for 2.2.2 to include --script-dir
Reply-To: Amm Vpn <ammdispose-vpn@...109...>
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

First I just wanted to know if you are the decision maker for OpenVPN?


Because, the reasons/scenarios you are giving do not make sense to me.
You are not at all considering the real danger (a what-if case)

(Do not take it in offensive way please)

I just wanted to make sure I am posting the patch at right place and to
right person.


I am talking about two users here, one the root user who has access to
system and other a plain admin who has access to config file only.
This is a real world scenario in most of cases where assistant just has
access to frontend and IT head has root access.



----- Original Message -----
> From: David Sommerseth <openvpn.list@...1114...>
=A0
> Having this as a runtime configuration does not add any restriction in=20
> reality.=A0 You must presume the user have the possibility to tweak the c=
onfig=20
> somehow.=A0 And the user is fully capable of discovering a way how to exe=
cute=20
> your configs directly, skipping the --scripts-dir.=A0 So you cannot trust=
 the=20
> client config.=A0 So the front-end must protect the OpenVPN executable so=
 it is=20
> the only one who can start an OpenVPN connection.

Can you tell me how user can skip script-dir in my new patch? With example
config? In my opinion I have already taken care of it, if not then I am rea=
dy to
patch that as well.


> Another scenario, if your front-end does not protect the OpenVPN binary, =
a=20
> user can also download an earlier OpenVPN and circumvent this behaviour w=
ith=20
> your own front-end.=A0 So the OpenVPN executable must be protected no mat=
ter=20
> what, and your front-end is the only thing which the user should be able =
to=20
> use.=A0 And then this front-end is the only one which truly can protect y=
ou, by=20
> sanitising the config *before* the OpenVPN executable is started - where =
your=20
> front-end is the only binary which should have access to the OpenVPN bina=
ry.

Isnt that true for any software?? That user can install unpatched binary an=
d do
whatever?? Its like saying, "Hey there is another way a thief can enter the=
 house,
so why not let all the doors open?"

And again in my case (infact in most case where root and frontend is handled
by different people) this would again not be case. As frontend guy has no r=
oot
access, so cant install unpatched version.

Thanks and regards,

AMM


