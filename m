Message-ID: <001b01c429d0$434a0f80$0a0aef0a@...202...>
From: "Derek Burdick" <derek@...201...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Windows and Shaper
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
Date: Sat Apr 24 00:49:08 2004
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

    I was browsing the online CVS repository and noticed the
config-win32.h.in says that HAVE_GETTIMEOFDAY is specified in misc.c.  When
I look in misc.c, I don't see the file.  Is the latest version just not
checked in?  I also implemented a gettimeofday for windows.  It is based on
QueryPerformanceCounter. If you are interested in this version let me know.
If somebody knows the correct status of gettimeofday for the cvs code, I
would appreciate an update.

Thanks,
    Derek Burdick


