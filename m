From: Mathias Sundman <mathias@...209...>
Message-ID: <Pine.LNX.4.60.0407040150350.19338@...210...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Release: OpenVPN-GUI for Windows v1.0-beta2
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
Date: Sat Jul  3 16:58:00 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: Openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

I've got a new version of the GUI ready for testing.

New Features:
    Connect/Disconnect now shows a sub-menu so each connection can be
    brought up/down individually.

    Upon connect OpenVPN-GUI will wait for 3 seconds and then check if
    the openvpn process is still alive and report "Connection successful"
    only if this is the case.

    OpenVPN-GUI monitors the openvpn processes it has started, and if a
    process is terminated before the user has chosen to take it down, this
    will be reported to the user.

    If no config files is found when OpenVPN-GUI is started, it will
    notify the user of this and terminate.


It is available for download from here:
http://www.nilings.se/openvpn


-- 
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
NILINGS AB                        X    NO HTML/RTF in e-mail
Tel: +46-(0)8-666 32 28          / \   NO Word docs in e-mail

