From: "James Yonan" <jim@...41...>
Message-ID: <twig.1083217597.4062@...41...>
Subject: [Openvpn-devel] OpenVPN 2.0-test26 released
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
Date: Wed Apr 28 22:47:03 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Ooops... let's try that again with the correct subject line.

A new release of the 2.0 beta is available.

* One of the goals of OpenVPN 2.0 is extreme scalability, i.e. robustly
handling connections from potentially thousands of clients.  To do this, some
kind of load balancing and failover capability is needed, because a single
OpenVPN daemon running on a single processor may not be able to handle this
kind of load.  One solution is to set up a cluster of near-identically
configured OpenVPN daemons on separate machines, or multiple daemons on a
multiprocessor machine, or both.  Each daemon is running with --mode server
and can handle multiple clients.

The feature that makes this now possible is that --remote has been extended to
allow a list of remote servers and port numbers to be specified on the client
such as:

  remote server1 5000
  remote server1 5001
  remote server2 5000
  remote server2 5001
  
By default the OpenVPN client will try each host/port in the order specified.
 If the connection fails (such as triggered by --ping/--ping-restart) the
client will move to the next host in the list.  The client can also initially
randomize the list using the new --remote-random flag, to provide a basic
load-balancing capability.

The servers are configured almost identically, though each has its own port
number and --ifconfig-pool IP address range.

* Harald Roelle has observed some limitations in the current Linux 2.4 and 2.6
tun/tap driver.  Specifically, the TX queue size is set to 10 by default,
which is too small.  There is also a problem with "kicking" where a packet in
the driver may get stuck there and need another packet to come through to
"kick" it out.  This may account for the "no buffer space available" message
that some Linux users report.  To work around this problem, OpenVPN has added
a --txqueuelen option to raise the queue length to a more sane size, and now
defaults to 100.  Right now, this is a Linux-only option.  I've also added
--rcvbuf and --sndbuf to control the TCP/UDP socket buffer sizes.  Harald
Roelle and Max Krasnyansky have put together some patches which fix the Linux
tun/tap driver issues, and should (hopefully) be in the pipeline shortly for
inclusion in the mainline 2.4 and 2.6 branches.  For now, --txqueuelen will
provide a workaround.

At this point I would say that nearly all of the key features which have been
envisaged for 2.0 are in place with a few exceptions:

* TCP Support in the multi-client server -- The only way that I can see of
scalably adding TCP support (without using multiple threads or processes) is
to use an efficient multi-socket API such as epoll() which is available on
Linux 2.6 and also apparently on 2.4 via a kernel patch.

* Forking server support -- The 2.0 multi-client server model is designed for
people who want a potentially large number of clients to tunnel through a
single tun or tap interface using a single daemon process.  Some people
however might prefer the forking server model, where the server automatically
forks off a new process for each incoming client, dynamically allocating a
private tun/tap interface for that client.

* Multithreading support -- multithreading offers two key advantages: (1) it
reduces the worst-case latency of packets flowing through the tunnel and (2)
it offers the opportunity for a single daemon to utilize all the processors on
an multiprocessor machine.  Unfortunately, multithreading causes a lot of
problems including complexifying the source code and introducing
race-condition bugs which can be extremely difficult to reproduce or track
down.  My thinking at this point is that implementing multithreading may not
be worth the trouble, especially given the fact that the new load balancing
feature can allow multiple OpenVPN daemons running on multiple machines to
serve the same client pool.

* Compatibility with 1.x -- OpenVPN 2.0 tries as much as possible to be
upwardly compatible with 1.x.  The main difference is that 2.0 changes some
parameter defaults.  The tun/tap MTU has been raised to 1500, --mssfix 1450 is
now the default, and --key-method now defaults to 2.  The only feature which
has been removed is the special-purpose SSL/TLS thread feature which is
enabled on 1.x if you build OpenVPN with the --enable-pthread flag.  I might
put it back if people complain, but overall I'm not sure that it's worth the
trouble.

Change Log:

2004.04.28 -- Version 2.0-test26

* Optimized broadcast path in multi-client mode.
* Added socket buffer size options --rcvbuf & --sndbuf.
* Configure Linux tun/tap driver to use a more sensible
  txqueuelen default.  Also allow explicit setting
  via --txqueuelen option (Harald Roelle).
* The --remote option now allows the port number
  to be specified as the second parameter.  If
  unspecified, the port number defaults to the
  --rport value.
* Multiple --remote options on the client can now be
  specified for load balancing and failover.  The
  --remote-random flag can be used to initially randomize
  the --remote list for basic load balancing.
* If a remote DNS name resolves to multiple DNS addresses,
  one will be chosen by random as a kind of basic
  load-balancing feature if --remote-random is used.
* Added --connect-freq option to control maximum
  new connection frequency in multi-client mode.
* In multi-client mode, all syslog messages associated
  with a specific client now include a client-ID prefix.
* For Windows, use a gettimeofday() function based
  on QueryPerformanceCounter (Derek Burdick).
* Fixed bug in interaction between --key-method 2
  and DES ciphers, where dynamic keys would be generated
  with bad parity and then be rejected.


Download:

http://openvpn.sourceforge.net/beta/




