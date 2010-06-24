MIME-Version: 1.0
Date: Wed, 23 Jun 2010 17:34:03 -0700
Message-ID: <AANLkTilYpS47A68hRLrkMYiyHBBZlBc14lz9HCoe9GYZ@...278...>
From: Vineet Kumar <vineet.kumar@...277...>
Subject: [Openvpn-devel] ovpn daemon not seeing my plugin thread...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,
 I am writing a plugin that creates a thread at plugin-open time. But
when I start ovpn as a daemon the ovpn code has no knowledge of that thread.
The reason is obviously the fact that the thread-creation occurred
*before* the daemon() call (that forked off a child which has no way
of inheriting a copy of that thread).
So does this mean then that the ovpn daemon infrastructure will only
work with plugins that don't do threading of their own?

If no, then pl. let me know how to get this working.
NOTE: All this works smoothly when ovpn doesn't start as a daemon.

Thanks a lot,

Vineet

