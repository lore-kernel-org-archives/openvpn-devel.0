Message-Id: <200207011050.AA00026@...29...>
From: TANABE Hiroyasu <h@...28...>
MIME-Version: 1.0
Subject: [Openvpn-devel] --cert and --key
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
Date: Mon Jul  1 03:51:02 2002
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hello all,

I'm confusing with TLS Mode Options.

in Man Page:
	--cert file  Peer's signed certificate in .pem 
	--key file   My private key in .pem 
but in Example 3:
	openvpn ... --cert client.crt --key client.key ...
	openvpn ... --cert server.crt --key server.key ...

OpenVPN 1.2.1 works fine with the example, 
but I don't know which is appropriate description for SSL security.
Which is right?

Thanks in advance,

TANABE Hiroyasu

