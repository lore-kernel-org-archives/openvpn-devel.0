From: Mathias Sundman <mathias@...209...>
Message-ID: <Pine.LNX.4.60.0407050108360.24966@...210...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Release: OpenVPN-GUI for Windows v1.0-beta5
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
Date: Sun Jul  4 16:53:02 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net, Openvpn-users@lists.sourceforge.net

Available for download from:
http://www.nilings.se/openvpn


ChangeLog:

[v1.0-beta5 2004-07-04]
New Features:
    Menu-commands to Start/Stop/Restart the OpenVPN Service. Enable this
    feature by setting the following reg-key to 1:
    HKEY_LM\SOFTWARE\OpenVPN-GUI\allow_service

Bug Fixes:
    v1.0-beta4 always opened the registry with write-access, which made
    it imposible to start it without administator rights.


[v1.0-beta4 2004-07-04]
New Features:
    Menu-command to open a config-file for editing. Enable this feature
    by setting the following reg-key to 1:
    HKEY_LM\SOFTWARE\OpenVPN-GUI\allow_edit


[v1.0-beta3 2004-07-04]
New Features:
    Log Viewer. As default OpenVPN-GUI launches Notepad to view the log.
    The program used to view the log can be changed with this reg-key:
    HKEY_LM\SOFTWARE\OpenVPN-GUI\log-viewer

    OpenVPN-GUI now uses its own registry-keys, instead of the same as
    the service wrapper uses. It now stores its values under this key:
    HKEY_LM\SOFTWARE\OpenVPN-GUI\
    If this key does not exist, OpenVPN-GUI will create it with the same
    default values as the service-wrapper uses, so if you want to use the
    service-wrapper on config-files indepentent of the GUI you should
    change the "config-dir" key to another folder.


[v1.0-beta2 2004-07-03]
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


[v1.0-beta1 2004-07-02] Initial release
Features:
    Adds itself as a system tray icon.
    Menuitem "Connect" - Starts openvpn for all config-files it has found.



-- 
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
NILINGS AB                        X    NO HTML/RTF in e-mail
Tel: +46-(0)8-666 32 28          / \   NO Word docs in e-mail

