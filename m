Message-ID: <003f01c2099e$ee25c290$1000000a@...4...>
From: "James Yonan" <jim@...3...>
MIME-Version: 1.0
Subject: [Openvpn-devel] New OpenVPN beta available for testing
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Sat Jun  1 12:02:19 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

This beta revamps SIGUSR1 signal processing to make it like SIGHUP except
with more fine-grained control over which OpenVPN subsystems are reset.  It
also allows a SIGUSR1 to be generated internally based on --ping
and --ping-restart.  The goal is to make OpenVPN as robust as possible on
dynamic networks where DHCP, NAT, and firewalls must all be negotiated in a
dynamic context.  The --persist-tun option allows a reset without closing
and reopening the tun device (which allows seamless connectivity through the
tunnel across DHCP resets).  The --persist-ip option allows for preservation
of remote IP address across DHCP resets.  This allows both OpenVPN peers to
be DHCP clients.

Also changed is the pthread handling in the configure script.  The script
now uses the ACX_PTHREAD macro from the autoconf macro archive to
intelligently figure out which cc/gcc option to use when building with POSIX
thread support.  Some problems were reported when trying to build OpenVPN
with pthread support using gcc3.

I expect to make a new release in a few days if no problems are encountered.

Here is the full change log:

* Added --ping-restart option to restart
  connection on ping timeout using SIGUSR1
  logic (Matthias Andree).
* Added --persist-tun and --persist-ip options
  for finer-grained control over SIGUSR1
  and --ping-restart restarts.  To
  replicate previous SIGUSR1 functionality,
  use --persist-ip.
* Changed residual IV fetching code to take
  IV from tail of ciphertext.
* Added check to make sure that CFB or OFB
  cipher modes are only used with SSL/TLS
  authentication mode, and added a caveat
  to INSTALL.
* Added RPM notes to INSTALL.
* Added ACX_PTHREAD (from the autoconf
  macro archive) to configure.ac
  to figure out the right pthread
  options for a given platform.
* Broke out macro definitions from
  configure.ac to acinclude.m4.
* All changes maintain protocol compatibility
  with 1.1.0+.

Download from CVS or:

http://openvpn.sourceforge.net/beta/openvpn-1.2.0.4.tar.gz

James



