Message-ID: <52F6E3AF.1080400@...1030...>
Date: Sun, 09 Feb 2014 02:10:56 +0000
From: Dash Four <mr.dash.four@...1030...>
MIME-Version: 1.0
Subject: [Openvpn-devel] --local, --lport and --bind
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Currently, openvpn only accepts "bind" if both "lport" and "local" 
options are specified. Why?

Why can't I specify "local" to instruct openvpn to bind to a specific IP 
address or interface and leave it to decide a (random) port it binds to 
in the same way in which the "nobind" option currently functions? What 
is the reason for this unnecessary restriction?

