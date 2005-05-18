From: Simon Perreault <nomis80@...401...>
MIME-Version: 1.0
Message-Id: <200505180940.09835.nomis80@...401...>
Subject: [Openvpn-devel] PAM plugin doesn't daemonize correctly
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
Date: Wed May 18 08:36:25 2005
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

The close_fds_except() function in the auth-pam plugin contains a bug, but it 
seems to be by design. It doesn't close standard fds (stdin, stdout, stderr). 
This means that a program that starts openvpn and reads its stdout from a 
pipe will never receive EOF and will idle forever.

To reproduce: with a configuration using the auth-pam plugin, this command 
never returns:

/etc/init.d/openvpn start | cat

ps alx shows:

1     0  4764     1  16   0  5984 1564 -      S+   pts/19     
0:00 /usr/sbin/openvpn
5    99  4770     1  15   0  5988 1964 -      Ss   ?          
0:00 /usr/sbin/openvpn

The process with PID 4764 is the pam server because it has UID 0. Sending it a 
kill -9 makes the command return. Sending the real openvpn process (PID 4770) 
a kill -9 does not make the command return, as expected. This confirms that 
it's the pam server process that is at fault.

Solution: either
1) reopen stdin, stdout and stderr to /dev/null when --daemon option is 
specified (need a way to access options structure in the plugin)
2) start plugins after becoming a daemon in init_instance()

What do you think?

