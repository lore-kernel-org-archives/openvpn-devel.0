From: Matt Wilks <matt@...273...>
Date: Mon, 15 Oct 2007 15:54:46 -0400
Message-ID: <ff0gil$rnf$1@...1062...>
Mime-Version: 1.0
Sender: news <news@...1062...>
Subject: [Openvpn-devel] persist-key required, even as root
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

This may be a bug in OpenVPN 2.1_rc4.  On a SIGUSR1 signal (usually by a
ping-restart), OpenVPN writes this to the log:

Mon Oct 15 15:39:55 2007 SIGUSR1[hard,] received, process restarting
Mon Oct 15 15:39:55 2007 Restart pause, 2 second(s)
Mon Oct 15 15:39:57 2007 Cannot load private key file [[INLINE]]: 
error:02001002:system library:fopen:No such file or directory: 
error:20074002:BIO routines:FILE_CTRL:system lib: error:140B0002:SSL 
routines:SSL_CTX_use_PrivateKey_file:system lib
Mon Oct 15 15:39:57 2007 Error: private key password verification failed
Mon Oct 15 15:39:57 2007 Exiting

I get this even when running OpenVPN as root.  The man page suggests
using --persist-key when this happens.  When the option is present,
everything is OK, but I don't think that OpenVPN should have trouble
re-reading the file if the process is running as root, no?

Matt.


