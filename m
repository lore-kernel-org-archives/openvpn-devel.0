From: "James Yonan" <jim@...41...>
Message-ID: <twig.1086623003.57884@...41...>
In-Reply-To: <C696C5C5-B865-11D8-846A-000A95B96B84@...228...>
References: <twig.1086485727.92671@...41...>, <twig.1086485727.92671@...41...>
Subject: [Openvpn-devel] Re: Still Assertion failed at event.c:399 (was Re: [Openvpn-users] OpenVPN 2.0-beta3 released
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
Date: Mon Jun  7 08:44:12 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jon Bendtsen <jon.bendtsen@...228...>, James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Jon,

Have you considered the possibility that there might be breakage in your
compilation environment, such as a mismatch between header files and shared
libraries?

I am saying this because I haven't seen any other reports of similar assertion
failures.  If you are the only one seeing the problem, there must be something
that is unique about your particular configuration.

Do you get assertion failures from pre-built executables, such as from the
Windows install?

James

Jon Bendtsen <jon.bendtsen@...228...> said:

> I still have my assertion error with openvpn beta3, just much sooner, 
> and it is a different place.
> The server is still linux, and the client is still macosx. I will go 
> and test windows in a few seconds.
> 
> 
> [Jon-Bendtsens-computer:~/openvpn-2.0_beta3] jonbendt% ./openvpn 
> --config ../etc/openvpn/client.conf
> ...
> Mon Jun  7 11:21:31 2004 OpenVPN 2.0_beta3 powerpc-apple-darwin7.4.0 
> [SSL] [LZO] built on Jun  7 2004
> Mon Jun  7 11:21:31 2004 WARNING: file 'sample-keys/client.key' is 
> group or others accessible
> Mon Jun  7 11:21:31 2004 Control Channel MTU parms [ L:1541 D:138 EF:38 
> EB:0 ET:0 EL:0 ]
> Mon Jun  7 11:21:31 2004 Data Channel MTU parms [ L:1541 D:1450 EF:41 
> EB:0 ET:0 EL:0 ]
> Mon Jun  7 11:21:31 2004 Local Options String: 'V3,dev-type 
> tun,link-mtu 1541,tun-mtu 1500,proto UDPv4,cipher BF-CBC,auth 
> SHA1,keysize 128,key-method 2,tls-client'
> Mon Jun  7 11:21:31 2004 Expected Remote Options String: 'V3,dev-type 
> tun,link-mtu 1541,tun-mtu 1500,proto UDPv4,cipher BF-CBC,auth 
> SHA1,keysize 128,key-method 2,tls-server'
> Mon Jun  7 11:21:31 2004 Local Options hash (VER=V3): 'a0f1c7ed'
> Mon Jun  7 11:21:31 2004 Expected Remote Options hash (VER=V3): 
> 'b319fa3e'
> Mon Jun  7 11:21:31 2004 Socket Buffers: R=[42080->65536] 
> S=[9216->65536]
> Mon Jun  7 11:21:31 2004 UDPv4 link local (bound): [undef]:5000
> Mon Jun  7 11:21:31 2004 UDPv4 link remote: 192.168.119.135:5000
> Mon Jun  7 11:21:31 2004 TLS: Initial packet from 192.168.119.135:5000, 
> sid=1ce6aa53 b7120113
> Mon Jun  7 11:21:31 2004 Assertion failed at event.c:399
> Mon Jun  7 11:21:31 2004 Exiting
> 
> It makes no difference if i specify the local address, the client.conf 
> file looks like this:
> 
> 
> [Jon-Bendtsens-computer:~/openvpn-2.0_beta3] jonbendt% less 
> ../etc/openvpn/client.conf
> #########################################
> # Sample client-side OpenVPN config file
> # for connecting to multi-client server.
> #
> # The server can be pinged at 10.8.0.1.
> #
> # This configuration can be used by multiple
> # clients, however each client should have
> # its own cert and key files.
> #
> # tun-style tunnel
> 
> port 5000
> dev tun0
> remote aragorn
> 
> # TLS parms
> 
> tls-client
> ca sample-keys/tmp-ca.crt
> cert sample-keys/client.crt
> key sample-keys/client.key
> 
> # This parm is required for connecting
> # to a multi-client server.  It tells
> # the client to accept options which
> # the server pushes to us.
> pull
> 
> verb 4
> 
> 
> and the server:
> ########################################
> # Sample OpenVPN config file for
> # multi-client udp server
> #
> # tun-style tunnel
> 
> port 5000
> dev tun
> 
> # TLS parms
> 
> tls-server
> ca sample-keys/tmp-ca.crt
> cert sample-keys/server.crt
> key sample-keys/server.key
> dh sample-keys/dh1024.pem
> 
> # Tell OpenVPN to be a multi-client udp server
> mode server
> 
> # openvpn data are not swapped to disk
> #mlock
> # allow clients to connect to each other faster
> #client-to-client
> 
> # The server's virtual endpoints
> ifconfig 10.8.0.1 10.8.0.2
> 
> # Pool of /30 subnets to be allocated to clients.
> # When a client connects, an --ifconfig command
> # will be automatically generated and pushed back to
> # the client.
> ifconfig-pool 10.8.0.4 10.8.0.255
> 
> # Push route to client to bind it to our local
> # virtual endpoint.
> push "route 10.8.0.1 255.255.255.255"
> 
> # Delete client instances after some period
> # of inactivity.
> inactive 600
> # ping once every minute when there is no trafic
> ping 60
> 
> # Route the --ifconfig pool range into the
> # OpenVPN server.
> route 10.8.0.0 255.255.255.0
> 
> # The server doesn't need privileges
> user nobody
> group nogroup
> 
> 
> 
> JonB
> 



-- 




