From: Charles Duffy <cduffy@...294...>
Message-ID: <pan.2004.11.24.23.07.15.415488@...294...>
References: <loom.20041123T220422-499@...171...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Re: HTTP CONNECT Vs. HTTP POST & GET
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
Date: Wed Nov 24 15:08:02 2004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

James has stated that he intends OpenVPN to support no features which
would have it masquerade as another protocol. AIUI, implementing GET or
POST methods would be effectively doing just that.

You could presumably just run OpenVPN through httptunnel without making
any changes to OpenVPN's source at all.

http://article.gmane.org/gmane.network.openvpn.user/6394/


