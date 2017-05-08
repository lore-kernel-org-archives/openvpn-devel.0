From: Farkas Levente <lfarkas@...193...>
Message-ID: <15905c0a-8735-f447-f81a-750c834e46d7@...193...>
Date: Mon, 8 May 2017 17:26:12 +0200
MIME-Version: 1.0
Content-Language: en-US
Subject: [Openvpn-devel] regressions in openvpn 2.4.1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

hi,
after we upgrade our servers and client to 2.4.1 we detect many regressions.

- first was that with this the server no longer works and the server
restart fail after upgrade. imho it's not a safe behavior. but it was
easy to fix at least.
script-security 2 system

- then the new systemd unit files (ie openvpn-server and openvpn-client)
not working. ie if i move all th config file from /etc/openvpn to
/etc/openvpn/server then the server fail to start. and still not found
any other solution then move back the config files. i open a bugzilla:
https://bugzilla.redhat.com/show_bug.cgi?id=1446795

- but the most annoying on is that if the server runs and a client
already connected but reboot the client then in most case it's not able
to reconnect. on the server log we see this error message:

Sun May  7 23:46:57 2017 .. PUSH: client wants to negotiate cipher
(NCP), but server has already generated data channel keys, ignoring
client request
Sun May  7 23:46:57 2017 ... AEAD Decrypt error: cipher final failed
Sun May  7 23:47:02 2017 ... AEAD Decrypt error: cipher final failed

but if i restart the server then everything working perfectly and a the
clients can reconnect.
relevant part of the server config:

proto udp
dev-type tun
dev vpn-udp

remote-cert-tls client
cipher		AES-256-CBC
auth		SHA256
tls-cipher
TLS-ECDHE-ECDSA-WITH-AES-128-GCM-SHA256:TLS-ECDHE-ECDSA-WITH-AES-256-GCM-SHA384:TLS-ECDHE-RSA-WITH-AES-128-GCM-SHA256:TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384:TLS-DHE-RSA-WITH-AES-256-CBC-SHA256:TLS-DHE-RSA-WITH-AES-256-CBC-SHA

topology subnet
client-to-client
comp-lzo no
persist-tun
persist-key
persist-local-ip
keepalive 10 120
push "comp-lzo no"
push "persist-tun"
push "persist-key"

nobody has the same problems?
thanks

-- 
  Levente                               "Si vis pacem para bellum!"

