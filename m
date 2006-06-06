Message-ID: <44853D9F.40001@...177...>
Date: Tue, 06 Jun 2006 10:32:31 +0200
From: Farkas Levente <lfarkas@...177...>
MIME-Version: 1.0
Subject: [Openvpn-devel] a few problem/comment/bug with version 2.1.x
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

hi,
we now try to migrate from openvpn 1.x to 2.1 topology and we's a few
problems and comments about the new versions and a few questions.
we would like to give each client a fixed ip addresses and some of them
have an own subnet behind it. the server use the
server 192.168.254.0 255.255.255.0
topology subnet
client-to-client

my questions:
- why not accept among the server.conf's push the following options:
  - persist-remote-ip
  - keepalive
  this has a good reason or just forget to include. imho it'd useful.
  "Options error: option 'persist-remote-ip' cannot be used in this context
   Options error: option 'keepalive' cannot be used in this context"

- even if i set among the server's push option
  - push "comp-lzo"
  i've got the warning:
  "WARNING: 'comp-lzo' is present in remote config but missing in local
config, remote='comp-lzo'"
  and don't see among the "OPTIONS IMPORT". is this normal or a bug?
  at the same time i've got a lots of such messages on the server:
  Bad LZO decompression header byte: 69

- neither on the server nor in the client we set any mtu. but we got
  this warning:
  WARNING: 'link-mtu' is used inconsistently, local='link-mtu 1541',
remote='link-mtu 1542'
  is it normal, a bug, or just a warning? should i have to fix it?
  ie. define link-mtu on both end?

- if i set the above server network then i've got in the log file:
  "IFCONFIG POOL: base=192.168.254.2 size=252
   IFCONFIG POOL LIST"
  in this case i still can use in the ccd/* files eg. the following:
  ifconfig-push 192.168.254.2 255.255.255.0
  or i should have to use different network for the fixed ip? or?

- if there is a network behind the client eg. 192.168.253.0/24 then i
  have to set in the ccd/client file:
  iroute 192.168.253.0 255.255.255.0
  but if i also would like to allow client-to-client i've to set in the
  server.conf:
  route 192.168.253.0 255.255.255.0 192.168.254.2
  is it true? and in the example server.conf it's stated also a
  push "route 192.168.253.0 255.255.255.0 192.168.254.2"
  required. but in this case this route be pushed to the given clients
  itself and gives a duplicate route error when try to add.
  on the other hand the example conf files do not contains the third
  parameters, but without it the route command has no gateway! does this
  example files are wrong or i misunderstood something?
  anyway why i have to add these two lines?
  wouldn't it be much better, cleaner and easier if the client-to-client
  defined and an iroute in the ccd/* files also 'generate' the above
  route command and push command for all clients except the ones who
  owns the network?

- if i choose "topology subnet" and in the ccd/client file a:
  ifconfig-push 192.168.254.2 255.255.255.0
  then why i see on the client:
tun0      Link encap:UNSPEC  HWaddr
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
          inet addr:192.168.254.2  P-t-P:192.168.254.2  Mask:255.255.255.0
          UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

shouldn't the P-t-P:192.168.254.1 is the right settings?


-- 
  Levente                               "Si vis pacem para bellum!"

