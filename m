Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Tue, 3 Jul 2007 12:59:27 -0400
Message-ID: <C0170D0AF1277849A4B4518034F855DD0328177D@...916...>
From: "Harris, Jeff" <JeffH@...925...>
Subject: [Openvpn-devel] Multi Cache TTL Usage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Does anyone know the effect of lowering the MULTI_CACHE_ROUTE_TTL
constant in multi.h from 60 seconds to say 10?  Will it cause extra
network traffic or anything if the routes are purged more often?

I am trying to work around an issue I'm seeing with spikes in the number
of multi_instance objects.  I have 125 connected clients and after a
number of restarts of all the clients, the number of multi_instance
objects on my server spikes to over 600 leading to an eventual
exhaustion of memory.  I am using keep-alive settings of 5 second pings
and 30 seconds of inactivity.

Lowering the value to 30 seems to hold off the spikes for a bit.  With a
value of 10 I have not seen the spikes.

Any help would be appreciated.

Thanks,
Jeff

