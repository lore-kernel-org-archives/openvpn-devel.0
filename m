From: Charles Duffy <cduffy@...294...>
Message-ID: <pan.2004.12.01.04.17.16.247658@...294...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Management interface -- null-terminated lines
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
Date: Tue Nov 30 20:18:07 2004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

James,

I notice that the management interface terminates its lines \0d \0a \00.

Is the null termination intentional? If so, would you mind documenting it?
It caused a few subtle issues until I figured out what was going on, so I
wouldn't exactly mind if it went away.

(I'm working on a CLR-based library, and maybe when it works a Gtk#
frontend, for interacting w/ OpenVPN via said interface).


