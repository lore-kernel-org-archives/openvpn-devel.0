Message-ID: <44338363.8050008@...41...>
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.0.6 released
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
Date: Wed Apr  5 01:45:04 2006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: 'openvpn-users' <openvpn-users@lists.sourceforge.net>, OpenVPN devel <openvpn-devel@lists.sourceforge.net>

2006.04.05 -- Version 2.0.6

* Security Vulnerability affecting OpenVPN 2.0 through 2.0.5.
  An OpenVPN client connecting to a
  malicious or compromised server could potentially receive
  "setenv" configuration directives from the server which could
  cause arbitrary code execution on the client via a LD_PRELOAD
  attack.  A successful attack appears to require that (a) the
  client has agreed to allow the server to push configuration
  directives to it by including "pull" or the macro "client" in
  its configuration file, (b) the client configuration file uses
  a scripting directive such as "up" or "down", (c) the client
  successfully authenticates the server, (d) the server is
  malicious or has been compromised and is under the control of
  the attacker, and (e) the attacker has at least some level of
  pre-existing control over files on the client (this might be
  accomplished by having the server respond to a client web
  request with a specially crafted file). Credit: Hendrik Weimer.
  The fix is to disallow "setenv" to be pushed to clients from
  the server.  For those who need this capability, OpenVPN
  2.1 supports a new "setenv-safe" directive which is free
  of this vulnerability.

  A patch is available to fix the vulnerability for all
  affected OpenVPN versions (2.0 -> 2.0.5):

  http://openvpn.net/patch/2.0.6-security-patches/setenv.patch

* When deleting routes under Linux, use the route metric
  as a differentiator to ensure that the route teardown
  process only deletes the identical route which was originally
  added via the "route" directive (Roy Marples).

* Fix the t_cltsrv.sh file in FreeBSD 4 jails
  (Matthias Andree, Dirk Meyer, Vasil Dimov).

* Extended tun device configure code to support ethernet
  bridging on NetBSD (Emmanuel Kasper).

James


