From: =?ISO-8859-15?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Reply-To: =?ISO-8859-15?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Message-ID: <1021309934.20050903005922@...449...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Bug: OpenVPN-Service didn't respond on WinXP SP2
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
Date: Fri Sep  2 16:00:07 2005
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hello,

I've a problem with OpenVPN 2 (2.00, 2.01, 2.02) on Windows XP SP2
(actual patchlevel).
If the server-service runs for a while a tray icon appear with the message
"ip adresse beziehen" in english "getting ip adress" (I think).
If this happens it is not possible anymore to connect from a client.
I can solve the problem only with restarting the openvpn-service.

my config:
proto tcp-server
port 62222
dev tap
ifconfig 10.3.0.1 255.255.255.0
secret key.txt
keepalive 10 120
verb 4
mute 10
auth SHA1
cipher AES-128-CBC

Can this happen due to malformed packets on the tcp-port (random
traffic)?

I use hibernate, maybe this is a problem for the tap-device?

greetings
Carsten


