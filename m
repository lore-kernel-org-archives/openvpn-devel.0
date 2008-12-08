From: Ralf =?utf-8?q?L=C3=BCbben?= <ralfluebben@...68...>
Date: Mon, 8 Dec 2008 21:49:33 +0100
MIME-Version: 1.0
Message-Id: <200812082149.33596.ralfluebben@...68...>
Subject: [Openvpn-devel] Async Authentication
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

I got to know about the new return value OPENVPN_PLUGIN_FUNC_DEFERRED for 
asynchronous authentication and I want to update my radius plugin soon.

But I have still some questions how AUTH_USER_PASS_VERIFY, CLIENT_CONNECT and 
CLIENT_DISCONNECT events handled inside OpenVPN:

1) Is the data of the user forwarded during the key renegoiation phase when 
OPENVPN_PLUGIN_FUNC_DEFERRED is used?

2) Does OpenVPN forward the data during the plugin calls CLIENT_CONNECT and 
CLIENT_DISCONNECT?

3) If not, are there also plans to implement asynchronous calls for 
CLIENT_CONNECT and CLIENT_DISCONNECT?

Thanks a lot.

Regards
Ralf




