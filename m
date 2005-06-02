From: Neil Brown <neilb@...253...>
MIME-Version: 1.0
Message-ID: <17055.49373.259880.456275@...253...>
Subject: [Openvpn-devel] wishlist items - management.
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
Date: Thu Jun  2 19:31:18 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

I have a small number of wishlist items.
I feel the first two are 2.0.x items, but maybe they should be 2.1 items.
I'll add them to the wiki under 2.0 unless someone suggests otherwise.

1/ When using --daemon and --management-hold, openvpn should
   daemonize before entering the 'hold' state.
  I achieved this by modifying init.c:open_management so that
  just before calling do_hold, it does
    	  if (will_hold())
		  do_init_first_time(c);
  where "will_hold" checks if the management interface would cause a
  hold. 

2/ If user/pass authentication fails, it should prompt again.
   I achieved this by setting signal_received to
   SIGUSR1 instead of SIGTERM in push.c:receive_auth_failed,
   and adding a call to auth_user_forget(), which does

     void auth_user_forget(void)
     {
	auth_user_pass.defined = 0;
     }
   in ssl.c

   Possibly this should be based on a config option, and should be
   disabled if the username/password are in a file.

3/ If the password for the private key fails to allow the 
    pem/pkcs12 file to be parsed, then prompt again
   This is much harder to fix as ssl_init currently exits (through
    'msg') rather than returning an error.


These together would make the 'give a password through the management
interface' functionality much more useful.

Thanks,
NeilBrown

