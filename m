Date: Sun, 6 Mar 2016 13:18:50 +0100 (CET)
Message-Id: <201603061218.u26CIoit049618@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1456996968-29472-1-git-send-email-steffan.karger@...1435...>
References: <1456996968-29472-1-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: hardening: add safe FD_SET()
	wrapper openvpn_fd_set()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.

The FD_SET() calls in event.c should all be safe as there are checks 
already, but many of the others are not checked - "usually" we're well in 
the range of FD_SETSIZE with our file descriptors, and "usually" platforms 
are using poll() anyway, but in the exceptional case, having a clear 
ASSERT() is much better than silent malfunction or a crash.

As explanation for the archives why this is #ifndef WIN32 - the windows
file handles do not follow the same "start with 0, count up" approach as
unix file descriptors, so the windows FD_SET() API is actually more similar
to unix poll() - the file descriptor is added to a list, instead of just
setting the bit in an array (of FD_SETSIZE bits) that corresponds to the 
numeric value.

Your patch has been applied to the master and release/2.3 branch.

commit e0b3fd49e2b5bba8cb57419a13cb75b56ac91b94 (master)
commit 1746908f66f5517a525ee2c114a0f7104c29dfad (release/2.3)

Author: Steffan Karger
Date:   Thu Mar 3 10:22:48 2016 +0100

     hardening: add safe FD_SET() wrapper openvpn_fd_set()

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1456996968-29472-1-git-send-email-steffan.karger@...1435...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11285
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


