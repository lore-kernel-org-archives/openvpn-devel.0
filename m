Content-class: urn:content-classes:message
MIME-Version: 1.0
Message-ID: <B531E2D213DD4946B97797232C7C16E18DC009@...248...>
From: "Tyrone Omidi" <tyrone.omidi@...247...>
Subject: [Openvpn-devel] RE: [Openvpn-users] Release: OpenVPN-GUI for Windows v1.0-beta2
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
Date: Thu Jul  8 09:49:18 2004
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
To: Openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

How about options manage the service?

-----Original Message-----
From: openvpn-users-admin@lists.sourceforge.net
[mailto:openvpn-users-admin@lists.sourceforge.net] On Behalf Of Mathias
Sundman
Sent: 04 July 2004 00:55
To: Openvpn-users@lists.sourceforge.net;
openvpn-devel@lists.sourceforge.net
Subject: [Openvpn-users] Release: OpenVPN-GUI for Windows v1.0-beta2

I've got a new version of the GUI ready for testing.

New Features:
    Connect/Disconnect now shows a sub-menu so each connection can be
    brought up/down individually.

    Upon connect OpenVPN-GUI will wait for 3 seconds and then check if
    the openvpn process is still alive and report "Connection
successful"
    only if this is the case.

    OpenVPN-GUI monitors the openvpn processes it has started, and if a
    process is terminated before the user has chosen to take it down,
this
    will be reported to the user.

    If no config files is found when OpenVPN-GUI is started, it will
    notify the user of this and terminate.


It is available for download from here:
http://www.nilings.se/openvpn


--=20
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
NILINGS AB                        X    NO HTML/RTF in e-mail
Tel: +46-(0)8-666 32 28          / \   NO Word docs in e-mail


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 -=20
digital self defense, top technical experts, no vendor pitches,=20
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Openvpn-users mailing list
Openvpn-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-users

