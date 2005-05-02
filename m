From: Charles Duffy <cduffy@...294...>
Message-ID: <pan.2005.05.02.16.36.26.328642@...294...>
References: <1115022714.29941.47.camel@...389...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Re: client-connect script not always called ?
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
Date: Mon May  2 11:13:17 2005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

On Mon, 02 May 2005 10:31:54 +0200, Alex Ongena wrote:

> It's a proper shutdown on client side, so the client can inform
> the server. The server should call IMHO 'client-disconnect' and
> afterwards a 'client-connect', regardless if some timeouts are
> expired or not.

Do you have the "explicit-exit-notify" operative in use (ideally, pushed
to the clients from the server, such that it won't be necessary to modify
the client configs after it's replaced with something more permanent)?
Otherwise, the server finds out that the clients are down only when their
timeout expires.


