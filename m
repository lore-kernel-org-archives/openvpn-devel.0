From: Denis Vlasenko <vda@...216...>
Subject: Re: Interface with GUI agent, was: Re: [Openvpn-devel] [Patch] revoke scripts were broken
References: <40E18559.8020407@...244...> <1088881994.40e7054a0e5e6@...238...> <200407031601.24438.jim@...41...>
In-Reply-To: <200407031601.24438.jim@...41...>
MIME-Version: 1.0
Message-Id: <200407040154.49974.vda@...216...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sat Jul  3 15:55:03 2004
Content-Type: text/plain;
  charset="windows-1251"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: James Yonan <jim@...41...>, Brandon Knitter <knitterb@...237...>
Cc: openvpn-devel@lists.sourceforge.net, Mathias Sundman <mathias@...209...>, Jan Kiszka <jan.kiszka@...83...>

On Saturday 03 July 2004 23:01, James Yonan wrote:
>   management 127.0.0.1 20001
>
> This will cause OpenVPN to listen on 127.0.0.1:20001 as its management
> interface port.
>
> It's important, of course, that the management port always be local, since
> we are using it to potentially pass passwords and other sensitive data that
> should never actually touch a real network interface.
>
> Thinking ahead, the challenge/response sequence for passing authentication
> info should be open-ended to provide for future implementation of
> alternative authentication methods such as Radius, LDAP, NT Auth, etc.

Please don't do too much of that. I've seen this auth featuritis creeping
in ntp and ups tools(!). Results ain't pretty...

Reconfiguration of openvpn can always be done by editing config file
and restarting openvpn daemon. Simple. Elegant. No additional coding
- no risk of introducing bugs.

This can be done via systray app, too.
--
vda


