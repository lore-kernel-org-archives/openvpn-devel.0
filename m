From: Juan Rodriguez Hervella <jrh@...176...>
MIME-Version: 1.0
Message-Id: <200403041012.55329.jrh@...176...>
Subject: [Openvpn-devel] Question about TCP forking server
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
Date: Thu Mar  4 01:20:07 2004
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hello,

I've just realized that openVPN-1.6rc1 only supports 
"inetd nowait" for the TLS case.

I understand that it is not possible to have "nowait" behaviour
for multiple clients with different secrets, but it would be still possible
to have "nowait" functionality + a single secret. Every client should
have the same secret key which is not a good way of having security,
but anyway...this could be a warning instead of the current message:
"nowait functionality is only allowed for TLS".

Even if you don't want cryptography at all, the forking server is
an interesting feature that should be let available, imho.

PS: I'm having problems to subscribe to the list, so CC to me
off-list. Thank you !

-- 
******
JFRH
******


