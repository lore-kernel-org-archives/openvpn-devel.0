From: Alberto Gonzalez Iniesta <agi@...5...>
Message-ID: <20040310160714.GA1152@...30...>
Mime-Version: 1.0
Subject: [Openvpn-devel] route option only adds route for first IP resolved for a hostname (with many)
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
Date: Wed Mar 10 08:22:28 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

Hi James et all,

I have just got this bug report [1]. The problem is: When a hostname is
given to the 'route' option, only a route to the first IP address for that
hostname is added. 

route(8) works the same way, and I don't know if this is really a bug,
or The Way is Meant to Be (tm).... Any thoughts?



[1] http://bugs.debian.org/237251

-- 
Alberto Gonzalez Iniesta   | BOFH excuse #304:
agi@(agi.as|debian.org)    | routing problems on the neural net
Encrypted mail preferred   | 

Key fingerprint = 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

