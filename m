From: Christof Meerwald <cmeerw@...83...>
Message-ID: <20030511173347.GA7940@...85...>
Mime-Version: 1.0
Subject: [Openvpn-devel] "extended socket error capability" and setting "verb 0"
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun May 11 10:35:02 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

there is a problem with OpenVPN 1.4.0 (at least on Linux 2.4.20) when
"EXTENDED_SOCKET_ERROR_CAPABILITY" is enabled and "verb" is set to 0. In
this case openvpn will consume 100 % CPU in it's select loop when an error
is reported because select indicates that there is data available on the UDP
socket, but the data is never read (with recvmsg(..., MSG_ERRQUEUE)) because
format_extended_socket_error isn't called.


bye, Christof

-- 
http://cmeerw.org                                 JID: cmeerw@...84...
mailto cmeerw at web.de

