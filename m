Message-ID: <3F7C8E9C.1010301@...61...>
From: julien Touche <julien.touche@...61...>
MIME-Version: 1.0
Subject: [Openvpn-devel] test win2k (1.5b9) <-> linux 2.4 (1.3)
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Oct  2 13:46:04 2003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

i have test the above conf today (with tap), but have two problems:

* first, win2k host can ping local & remote host, but linux one can only
ping itself.
a tcpdump on linux:
20:08:02.865325 arp who-has 10.0.2.2 tell 10.0.2.1
20:08:03.863142 arp who-has 10.0.2.2 tell 10.0.2.1
20:08:04.863141 arp who-has 10.0.2.2 tell 10.0.2.1
20:08:08.698015 0:ff:7b:40:37:4b > ff:ff:ff:ff:ff:ff sap e0 ui/C
>>> Unknown IPX Data: (79 bytes)
[000] FF FF 00 50 00 14 00 00  00 00 FF FF FF FF FF FF  ...P.... ........
[010] 04 55 00 00 00 00 00 FF  7B 40 37 4B 04 55 00 00  .U...... {@7K.U..
[020] 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ........ ........
[030] 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 01  ........ ........
[040] 57 4F 52 4B 47 52 4F 55  50 20 20 20 20 20 20     WORKGROU P
  len=81
20:08:09.573437 0:ff:7b:40:37:4b > ff:ff:ff:ff:ff:ff sap e0 ui/C
>>> Unknown IPX Data: (79 bytes)
[000] FF FF 00 50 00 14 00 00  00 00 FF FF FF FF FF FF  ...P.... ........
[010] 04 55 00 00 00 00 00 FF  7B 40 37 4B 04 55 00 00  .U...... {@7K.U..
[020] 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ........ ........
[030] 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 01  ........ ........
[040] 57 4F 52 4B 47 52 4F 55  50 20 20 20 20 20 20     WORKGROU P
  len=81
20:08:11.325091 0:ff:7b:40:37:4b > ff:ff:ff:ff:ff:ff sap e0 ui/C
>>> Unknown IPX Data: (79 bytes)
[000] FF FF 00 D9 00 14 00 00  00 00 FF FF FF FF FF FF  ........ ........
[010] 05 53 00 00 00 00 00 FF  7B 40 37 4B 05 53 00 00  .S...... {@7K.S..
[020] 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ........ ........
[030] 00 00 00 00 00 00 00 00  00 00 00 00 00 00 FC 02  ........ ........
[040] 00 00 57 4F 52 4B 47 52  4F 55 50 20 20 20 20     ..WORKGR OUP
  len=217
20:11:22.896976 10.0.2.1 > 10.0.2.2: icmp: echo request (DF) (ttl 64, id
0, len 84)
20:11:23.913321 10.0.2.1 > 10.0.2.2: icmp: echo request (DF) (ttl 64, id
0, len 84)
20:11:24.913382 10.0.2.1 > 10.0.2.2: icmp: echo request (DF) (ttl 64, id
0, len 84)
20:12:17.964098 0:ff:7b:40:37:4b > ff:ff:ff:ff:ff:ff sap e0 ui/C
>>> Unknown IPX Data: (79 bytes)
[000] FF FF 00 50 00 14 00 00  00 00 FF FF FF FF FF FF  ...P.... ........
[010] 04 55 00 00 00 00 00 FF  7B 40 37 4B 04 55 00 00  .U...... {@7K.U..
[020] 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ........ ........
[030] 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 01  ........ ........
[040] 57 4F 52 4B 47 52 4F 55  50 20 20 20 20 20 20     WORKGROU P
  len=81
20:12:18.839553 0:ff:7b:40:37:4b > ff:ff:ff:ff:ff:ff sap e0 ui/C
>>> Unknown IPX Data: (79 bytes)
[000] FF FF 00 50 00 14 00 00  00 00 FF FF FF FF FF FF  ...P.... ........
[010] 04 55 00 00 00 00 00 FF  7B 40 37 4B 04 55 00 00  .U...... {@7K.U..
[020] 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ........ ........
[030] 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 01  ........ ........
[040] 57 4F 52 4B 47 52 4F 55  50 20 20 20 20 20 20     WORKGROU P
  len=81
20:12:19.715179 0:ff:7b:40:37:4b > ff:ff:ff:ff:ff:ff sap e0 ui/C
>>> Unknown IPX Data: (79 bytes)
[000] FF FF 00 50 00 14 00 00  00 00 FF FF FF FF FF FF  ...P.... ........
[010] 04 55 00 00 00 00 00 FF  7B 40 37 4B 04 55 00 00  .U...... {@7K.U..
[020] 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ........ ........
[030] 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 01  ........ ........
[040] 57 4F 52 4B 47 52 4F 55  50 20 20 20 20 20 20     WORKGROU P
  len=81

arp show than the win2k mac is not listed and it is the one which
correspond in the dump. i add it manually, and then i see "echo request"
in linux->win but no reply.

* second, the two hosts are gateways and i want to link the two subnet,
say for example, 192.168.1.0, and .2.0.
normally, on unix, i only have a route to add in the up.vpn script. is
it possible also in windows with the route option in config files ?
something like
route 192.168.1.0 255.255.255.0 10.0.0.1

Regards

		Julien






