From: James Yonan <jim@...3...>
Message-ID: <Pine.LNX.4.44.0206122302130.26457-100000@...21...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 1.2.1 Released
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
Date: Wed Jun 12 22:08:04 2002
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

Binary RPMs are now provided for Red Hat 7.2 and 7.3 on the download page.  
Successfully tested with OpenSSL 0.9.7 Beta 1 and the AES cipher.  Revamp 
of SIGUSR1 to provide fine-grained control over resets, the goal being to 
make OpenVPN as robust as possible on dynamic networks where DHCP/Dial-in, 
NAT, and firewalls must all be negotiated in a dynamic context.  Hostname 
resolution errors are now non-fatal and can be retried.  Added --mute for 
logging verbosity control and --group for GID downgrade after 
initialization.  Smarter pthread handling in configure.  Updates to 
website and docs.

Download:

http://sourceforge.net/project/showfiles.php?group_id=48978&release_id=94530

Enjoy!

James



