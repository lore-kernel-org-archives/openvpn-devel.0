From: Charles Duffy <cduffy@...294...>
Message-ID: <pan.2004.11.10.00.13.04.776012@...294...>
References: <twig.1100040511.60533@...41...> <20041110000335.GB17347@...307...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Re: [Openvpn-users] IANA has approved a unique port number for OpenVPN
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
Date: Tue Nov  9 16:14:01 2004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: openvpn-users@lists.sourceforge.net

On Wed, 10 Nov 2004 01:03:35 +0100, Stefan `Sec` Zehl wrote:
> Can the server support listening on two ports at the same time? This
> would make migration much easier.

It should be straightforward enough to have your firewall redirect
incoming connections from the old port to the new.


