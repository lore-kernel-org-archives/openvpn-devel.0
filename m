From: Alberto Gonzalez Iniesta <agi@...5...>
Message-ID: <20020625142411.GC24695@...6...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Features comments/request
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
Date: Tue Jun 25 07:26:05 2002
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi all, James,

I'd like to ask for a couple of features (little ones) added to OpenVPN.
Comments welcomed.

1) OpenVPN should refuse to start a connection based on shared secret
when the file containing that key is world readable (or writable).
Paranoia won't even like group readable :-)
Really, that's an important piece (the most?) in that kind of VPN, we 
don't want it to be public. Just imagine an (non-chrooted) anonymous
ftp server, a bad configured web server/cgi-script, a malicious user,...

2) Each OpenVPN daemon should delete its pidfile when stoping, since it
was that very same daemon that created it. 
It has no sense to have the init.d scripts deleting these files (and
stoping nonexistent daemons) since the daemon could have been killed
before the init.d script tried to stop it.

Thanks in advance for any comments. 
Best regards.


-- 
Alberto Gonzalez Iniesta       | They that give up essential liberty
agi@...5...                     | to obtain a little temporary safety
Encrypted mail preferred       | deserve neither liberty nor safety.

Key fingerprint = 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

