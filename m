Message-ID: <48889417.20307@...95...>
Date: Thu, 24 Jul 2008 16:39:19 +0200
From: Carsten Menke <bootsy52@...95...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Bug in 2.1rc Releases on Windows Server Editions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

I have filed BUG

http://sourceforge.net/tracker/index.php?func=detail&aid=1802952&group_id=48978&atid=454719

with information about a problem I stumbled about when installing OpenVPN 2.1rc
series on Windows Server Editions.

After System Restart you cannot ping the gateway thus a connection is
established until you log in to the machine and restart the OpenVPN daemon.

Detailed information and a workaround is in the Bug Report.

NOTE

this problem does not show up on Windows XP, just on the
Server Editions of Windows (Windows Server 2003)

Regards

Carsten

-- 
"There are two major products that came out of Berkeley: LSD and UNIX.
   We don't believe this to be a coincidence." --Jeremy S. Anderson


