MIME-Version: 1.0
Date: Sun, 3 Apr 2011 05:47:04 +0400
Message-ID: <AANLkTi=G0hcUyZt78968qxHMBH-D_o=XQWvTVdQ-vDFf@...278...>
From: Wolf Ramovsky <wolf.ramovsky@...277...>
Subject: [Openvpn-devel] Using TAP Win32
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

I use TAP-device (in TUN mode) in my program. And I have one problem.
I'm opening device in non-overlapped mode, but ReadFile returns FALSE
and sets last error to ERROR_IO_PENDING. Why?

