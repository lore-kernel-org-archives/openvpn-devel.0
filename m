From: Charles Duffy <cduffy@...294...>
Message-ID: <pan.2005.02.03.18.41.47.693101@...294...>
References: <42024CEA.7010908@...349...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Mesh networking, again [was Re: OpenVPN future goals]
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
Date: Thu Feb  3 10:52:27 2005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

There's been much discussion of mesh networking w/ OpenVPN before; check
the mailing list archives.

In the meantime, as long as it's a fairly small number of endpoints (3, as
in the case you mention, should be no trouble at all), you can just
simulate it w/ extra tunnels and an appropriate routing table.


