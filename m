Message-ID: <417D1FAC.5050809@...255...>
From: Didier Conchaudron <didier@...255...>
MIME-Version: 1.0
Subject: [Openvpn-devel] fdopen with winsock on win32
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
Date: Mon Oct 25 08:38:05 2004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi all,

I'm trying to add non-admin mode via a service wrapper for openvpn on 
win32 and I actually have some problems while opening a socket like a 
file descriptor.

Seems like fdopen doesn't run on socket at all because winsock doesn't 
work like on POSIX and BTW Mingw haven't any sys/socket.h because it 
can't due to non-POSIX.

Is there someone having an idea to solve this?

Cheers,

Didier

