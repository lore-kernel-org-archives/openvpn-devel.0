From: dumas@...26... (Patrice DUMAS - DOCT)
Message-ID: <20020621200138.J4523@...27...>
Mime-Version: 1.0
Subject: [Openvpn-devel] add a server feature to openvpn to share udp ports ?
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
Date: Fri Jun 21 11:07:02 2002
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

I would like to use openvpn to secure nfs on my network. However, as it is
strictly peer to peer I would have to specify an udp port for every 
client-server nfs relationships. I would have liked to avoid that. Thus I
though it could be a nice addition to openvpn if it ws possible to settle
it as a server, which forks for any childs.

Does it conflicts with the design of openvpn, or could it accepted as a
feature ?

Pat

