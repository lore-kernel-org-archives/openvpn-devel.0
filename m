From: Russell Morris <openvpn@...1315...>
Date: Thu, 05 Jul 2012 17:18:13 -0500
Message-id: <1341526693716731500@...1315...>
MIME-version: 1.0
Subject: [Openvpn-devel] Connection Bug / Issue
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-disposition: inline
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

I have an issue running OpenVPN 2.3 (occurs with both Alpha 1 and 2, but li=
kely earlier versions I'm guessing). I can connect to a Linux server just f=
ine, but when I try to connect to OpenVPN embedded in my router (Tomato fir=
mware, using OpenVPN 2.2.2), the client (on Windows) crashes (and the appli=
cation exits) on connect. Here is what happens in the log right before the =
client aborts and crashes,

Thu Jul 05 17:13:49 2012 MANAGEMENT: >STATE:1341526429,GET_CONFIG,,,
Thu Jul 05 17:13:51 2012 SENT CONTROL [server]: 'PUSH_REQUEST' (status=3D1)
Thu Jul 05 17:13:51 2012 PUSH: Received control message: 'PUSH_REPLY,route-=
gateway dhcp,ping 15,ping-restart 60'
Thu Jul 05 17:13:51 2012 OPTIONS IMPORT: timers and/or timeouts modified
Thu Jul 05 17:13:51 2012 OPTIONS IMPORT: route-related options modified
Thu Jul 05 17:13:51 2012 open_tun, tt->ipv6=3D0
Thu Jul 05 17:13:51 2012 TAP-WIN32 device [Local Area Connection 2] opened:=
 \\.\Global\{47E4A2F0-3A09-454C-A5A0-A5327B8D843E}.tap
Thu Jul 05 17:13:51 2012 TAP-Windows Driver Version 9.9=20
Thu Jul 05 17:13:51 2012 Successful ARP Flush on interface [21] {47E4A2F0-3=
A09-454C-A5A0-A5327B8D843E}

BTW, if I don't run the Windows GUI as Administrator, here is what happens,

Thu Jul 05 17:19:19 2012 MANAGEMENT: >STATE:1341526759,GET_CONFIG,,,
Thu Jul 05 17:19:20 2012 SENT CONTROL [server]: 'PUSH_REQUEST' (status=3D1)
Thu Jul 05 17:19:20 2012 PUSH: Received control message: 'PUSH_REPLY,route-=
gateway dhcp,ping 15,ping-restart 60'
Thu Jul 05 17:19:20 2012 OPTIONS IMPORT: timers and/or timeouts modified
Thu Jul 05 17:19:20 2012 OPTIONS IMPORT: route-related options modified
Thu Jul 05 17:19:20 2012 open_tun, tt->ipv6=3D0
Thu Jul 05 17:19:20 2012 TAP-WIN32 device [Local Area Connection 2] opened:=
 \\.\Global\{47E4A2F0-3A09-454C-A5A0-A5327B8D843E}.tap
Thu Jul 05 17:19:20 2012 TAP-Windows Driver Version 9.9=20
Thu Jul 05 17:19:20 2012 NOTE: FlushIpNetTable failed on interface [21] {47=
E4A2F0-3A09-454C-A5A0-A5327B8D843E} (status=3D5) : Access is denied.=20=20

Thoughts?

Thanks!

... Russell

