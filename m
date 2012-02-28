Date: Tue, 28 Feb 2012 20:36:22 +0100
From: =?iso-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Message-ID: <19610273584.20120228203622@...449...>
In-Reply-To: <4F4D1D5F.2090208@...1114...>
References: <4F4CE4FE.3010009@...515...>
	<1848924920.20120228183103@...449...>
	<CAOazyz0x4hKsREcGi+9TGc+AO0d+i1d5qbmPJ2hQfCsUbVanNQ@...278...>
	<1111951883.20120228191750@...449...>
	<4F4D1D5F.2090208@...1114...>
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello David,

> Have you seen this document?  (management/management-notes.txt)
> <http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn-testing.git;a=blob_plain;f=management/management-notes.txt;hb=master>

No.

I connected to management interface and got this:
> Management Interface for OpenVPN 2.2.2 Win32-MSVC++ [SSL] [LZO2] [PKCS11] built on Dec 15 2011
> Commands:
> auth-retry t           : Auth failure retry mode (none,interact,nointeract).
> bytecount n            : Show bytes in/out, update every n secs (0=off).
> echo [on|off] [N|all]  : Like log, but only show messages in echo buffer.
> exit|quit              : Close management session.
> forget-passwords       : Forget passwords entered so far.
> help                   : Print this message.
> hold [on|off|release]  : Set/show hold flag to on/off state, or
>                          release current hold and start tunnel.
> kill cn                : Kill the client instance(s) having common name cn.
> kill IP:port           : Kill the client instance connecting from IP:port.
> load-stats             : Show global server load stats.
> log [on|off] [N|all]   : Turn on/off realtime log display
>                          + show last N lines or 'all' for entire history.
> mute [n]               : Set log mute level to n, or show level if n is absent.
> needok type action     : Enter confirmation for NEED-OK request of 'type',
>                          where action = 'ok' or 'cancel'.
> needstr type action    : Enter confirmation for NEED-STR request of 'type',
>                          where action is reply string.
> net                    : (Windows only) Show network info and routing table.
> password type p        : Enter password p for a queried OpenVPN password.
> pid                    : Show process ID of the current OpenVPN process.
> pkcs11-id-count        : Get number of available PKCS#11 identities.
> pkcs11-id-get index    : Get PKCS#11 identity at index.
> signal s               : Send signal s to daemon,
>                          s = SIGHUP|SIGTERM|SIGUSR1|SIGUSR2.
> state [on|off] [N|all] : Like log, but show state history.
> status [n]             : Show current daemon status info using format #n.
> test n                 : Produce n lines of output for testing/debugging.
> username type u        : Enter username u for a queried OpenVPN username.
> verb [n]               : Set log verbosity level to n, or show if n is absent.
> version                : Show current version number.
> http-proxy-fallback <server> <port> [flags] : Enter dynamic HTTP proxy fallback info.
> http-proxy-fallback-disable : Disable HTTP proxy fallback.
> END

I don't see a command to connect openvpn to a host.

I'd like to install openvpn on windows, install it as a service

-----------mini_client.ovpn----------------
management localhost 7505
remote myremote.mydomain
dev tun
ifconfig 10.8.0.2 10.8.0.1
secret static.key
-----------mini_client.ovpn----------------

and than telnet to localhost 7505 and send something like "connect mini_client"

or if it's more complex
-----------complex_client.ovpn----------------
management localhost 7505
remote myremote.mydomain
dev tun

client
auth-user-pass

ca ca.pem
-----------complex_client.ovpn----------------

telnet localhost 7505
connect complex_client
u carsten
p test

greetings
Carsten


