Date: Tue, 28 Feb 2012 23:47:56 +0100
From: =?windows-1252?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Message-ID: <425349696.20120228234756@...449...>
In-Reply-To: <CAOazyz14xa3+hWxwE1GDw7Qv_Qknbt4WBPwN66PiHwYXtThTjg@...278...>
References: <4F4CE4FE.3010009@...515...>
	<1848924920.20120228183103@...449...>
	<CAOazyz0x4hKsREcGi+9TGc+AO0d+i1d5qbmPJ2hQfCsUbVanNQ@...278...>
	<319492303.20120228213418@...449...>
	<CAOazyz14xa3+hWxwE1GDw7Qv_Qknbt4WBPwN66PiHwYXtThTjg@...278...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
Reply-To: =?windows-1252?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
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
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello Alon,

> Right. This is long existing feature, just that in Windows people
> expect to work using UI...

I don't expect a UI but usefull documentation.
management-notes.txt isn't even bundled with windows binaries :-(

I use openvpn since version 1 on windows and wasn't aware that the
management interface is working.
Why isn't there at least an example of how to use it?

For example Astaro has a windows client that seems to be not aware of
the management interface.

The guy who wrote http://openvpn.jowisoftware.de/ seems to don't
understand the management interface, too.
He uses the management interface for communication but than spawns
openvpn.exe itself instead of useing the windows service.

I would have deployed openvpn to ~300 employees, if users didn't need
admin privileges.

> Years back I wrote a simple .net to do to this...

Could you please share?
I found that openvpn.exe is extremly unstable on non perfectly friendly
behaving client ...
Now I use the Non-Sucking Service Manager ( http://nssm.cc/ ) instead of openvpnserv.exe
to spawn openvpn.exe
It restarts openvpn.exe automatically if it's crashed.

Why is it possible to send "signal SIGTERM" to openvpn.exe via
management interface?
A client could "crash" openvpn on intention.

Why isn't a clear connect/disconnect semantic included?
"hold" and "signal SIGUSR1" ???!!?!?????


@openvpn officials:
If non-admin openvpn is working on windows I could have bought OpenVPN Access Server instead of Cisco.
I wouldn't like to know how much money OpenVPN Technologies, Inc lost because of the lack of good documentation.

Please please please release immediately a minimal command line client (connect,
disconnect, ask for username&password) with example server.conf & client.conf
People have to be aware that it's working!

greetings
Carsten


