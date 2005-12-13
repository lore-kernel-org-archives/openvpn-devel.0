From: Till Maas <opensource@...519...>
Subject: Re: [Openvpn-devel] BUG --daemon & --auth-retry interact: openvpn
 won't daemonize after interaction
In-reply-to: <439F20F1.3060005@...41...>
Message-id: <200512132100.14422.opensource@...519...>
MIME-version: 1.0
References: <200512130015.39902.opensource@...519...>
 <439F20F1.3060005@...41...>
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
Date: Tue Dec 13 12:01:01 2005
Content-type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-disposition: inline
To: openvpn-devel@lists.sourceforge.net

Am Dienstag, 13. Dezember 2005 20:28 schrieb James Yonan:

> You didn't show your config file, and you don't say whether or not you
> are using the management interface for providing the username/password.

Oh, sorry, this is my client config:
----8<----
# grep -v \# /etc/openvpn/foo.conf | grep -v ^$ | grep -v \;
client
dev tap
proto udp
remote example.com 1194
resolv-retry infinite
nobind
user openvpn
group openvpn
persist-key
persist-tun
mute-replay-warnings
ca /etc/openvpn/vpn/ca.crt
cert /etc/openvpn/vpn/till.crt
key /etc/openvpn/vpn/till.key
ns-cert-type server
tls-auth /etc/openvpn/vpn/ta.key 1
comp-lzo
verb 3
log-append /var/log/openvpn.log
mute 3
daemon
----8<----

My certificate is protected by a password. This is the password I have the 
described problem. I provide the password via stdin within a normal console.

Regards,
Till



