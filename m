MIME-Version: 1.0
Sender: fabian@...1547...
In-Reply-To: <20120229154604.GA7024@...1296...>
References: <4F4CE4FE.3010009@...515...> <7855235.EvfmKnZP6h@...1526...>
	<CAP+U6t+ZUA3UpYfKms0Qr=-Cn1M-GP1EJtGybG0+j+O2xnfv7g@...278...>
	<1404593.Apkr3x9kAi@...1526...>
	<CAP+U6t+-8n=fFk+QP0Dm-H9YijcssjZjOHOpU5pwkSrXt1+qMQ@...278...>
	<20120229154604.GA7024@...1296...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Wed, 29 Feb 2012 17:59:03 +0100
Message-ID: <CAP+U6t+pQXzvU-kGWDSZo6cQB6mf+LPd3LyLaowdB0xakbzjAQ@...278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: =?UTF-8?Q?Carsten_Kr=C3=BCger?= <C.Krueger@...448...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Gert,

2012/2/29 Gert Doering <gert@...1296...>:
> The model we follow is "openvpn.exe has the same permissions that you
> already have, so there is no benefit in manipulating anything".

That was my initial assumption, which would imply that there's no
reason to restrict access to the named pipe (apart from making sure
that whoever connects is running as a user with the needed
permissions).

If users can manipulate their openvpn session to do whatever they want
they can also manipulate what gets sent over the named pipe. (I'm not
necessarily talking about malformed messages; I'm talking about
manipulating the routing tables, etc. to contain arbitrary settings.)

> For those bits that need additional privileges, there's the named pipe
> to the openvpn service - with some very well-defined messages to
> add/delete routes, setup interfaces, and such.
>
> Part of the assumption here is "the user controls the openvpn config",
> and as such, he can make openvpn.exe run arbitrary scripts anyway - and
> to stop this from being a problem, just run openvpn.exe with your uid.

Either I'm misunderstanding Heiko's plans or you two aren't in sync
regarding this point. AFAIU, Heiko intends to safe-guard access to the
named pipe as much as possible, with the underlying assumption that
only a trusted OpenVPN process should be allowed to send somewhat
trusted commands over the pipe. In my opinion, this implies that the
openvpn config would need to be restricted to safe settings in some
way. I'm not (yet?) convinced that this approach can be secure without
crippling the type of tunnels that you can create.

Cheers
Fabian

