Date: Wed, 29 Feb 2012 12:38:17 +0100
From: =?iso-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Message-ID: <1375292789.20120229123817@...449...>
In-Reply-To: <3440230.bBsdCSzEj1@...1526...>
References: <4F4CE4FE.3010009@...515...> <4F4D2212.2020008@...1114...>
	<1945967716.20120228230913@...449...> <3440230.bBsdCSzEj1@...1526...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
Reply-To: =?iso-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

Hello Heiko,

> However it was only an example and thus
> didn't have to make any practical sense. =)

:-)

> You forgot the GUI in this picture. If the service is connected to the
> management interface the GUI can't connect anymore.

?
If I understand you correctly it works this way:

openvpnserv.exe spawns openvpn.exe
openvpnhelperserv.exe spawns openvpnhelper.exe

openvpn.exe runs with no privileges at all (local service) and
openvpnhelper.exe with priviliges to modify routing (network configuration operator)

openvpn.exe communicates via pipe to openvpnhelper.exe, for example "please add a route"

the user client (for example perl script) uses management interface to
connect to openvpn.exe (please establish connection, credentials are xyz)

> Interesting, could you elaborate?

The process needs to much rights.

AFAIK openvpnhelper.exe would than need SE_ASSIGNPRIMARYTOKEN_NAME
Why should it have so much power?

Can you explain the architeture in more detail?

Do you need it for smartcard auth? I don't know the details of Smartcard API ...

> Not users, really. More like session. So you can connect to different server
> simultaneously.

Yeah, that's a point.
But I think it would only need management commands like "connect vpn session 1"
"disconnect vpn session 1", "supply credentials for sessions 1".
Credentials could be more than username/password, for example tls key
or smartcard "connection".

>  Of course this could be used by two different users at the
> same time or different impersonations in the same session, while still running
> ovpn with the credentials of the entity who started openvpn. So the point
> isn't really that many user can connect, but that the running sessions will be
> isolated from each other by the service.

hmm, I'm unsure if you would win something.
If the network communicating process is compromised (exploited from
internet) than it could get all the credentials via normal interface
from processes that holds them.

greetings
Carsten


