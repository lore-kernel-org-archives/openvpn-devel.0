From: James Yonan <jim@...3...>
Message-ID: <Pine.LNX.4.44.0206081324150.13198-100000@...21...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Beta available, please test
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
Date: Sat Jun  8 15:47:50 2002
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: openvpn-users@lists.sourceforge.net

This beta is pretty close to being 1.2.1.  Let me know if there are any
problems.

Download from CVS or:

http://openvpn.sourceforge.net/beta/openvpn-1.2.0.10.tar.gz

Change Log since 1.2.0:

* Added --ping-restart option to restart
  connection on ping timeout using SIGUSR1
  logic (Matthias Andree).
* Added --persist-tun, --persist-key,
  --persist-local-ip, and --persist-remote-ip
  options for finer-grained control over SIGUSR1
  and --ping-restart restarts.  To
  replicate previous SIGUSR1 functionality,
  use --persist-remote-ip.
* Changed residual IV fetching code to take
  IV from tail of ciphertext.
* Added check to make sure that CFB or OFB
  cipher modes are only used with SSL/TLS
  authentication mode, and added a caveat
  to INSTALL.
* Changed signal handling during initialization
  (including re-initialization during restarts)
  to exit on SIGTERM or SIGINT and ignore other
  signals which would ordinarily be caught.
* Added --resolv-retry option to allow
  retries on hostname resolution.
* Expanded the --float option to also
  allow dynamic changes in source port number
  on incoming datagrams.
* Added --mute option to limit repetitive
  logging of similar message types.
* Added --group option to downgrade GID
  after initialization.
* Try to set ifconfig path automatically
  in configure.
* Successfully tested with
  OpenSSL 0.9.7 Beta 1 and AES cipher.
* Added RPM notes to INSTALL.
* Added ACX_PTHREAD (from the autoconf
  macro archive) to configure.ac
  to figure out the right pthread
  options for a given platform.
* Broke out macro definitions from
  configure.ac to acinclude.m4.
* Minor changes to docs and HOWTO.
* All changes maintain protocol compatibility
  with OpenVPN versions since 1.1.0.

James



