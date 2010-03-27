MIME-Version: 1.0
Date: Sun, 28 Mar 2010 00:28:29 +0800
Message-ID: <49002b821003270928t1ab96816q59bfcefe4d0ad945@...278...>
From: d tbsky <tbskyd@...277...>
Content-Type: multipart/mixed; boundary=000e0cd72316304bfe0482cac5de
Subject: [Openvpn-devel] windows script to work with openvpn-gui 1.0.3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

--000e0cd72316304bfe0482cac5de
Content-Type: text/plain; charset=ISO-8859-1

Hi:
   our company use openvpn 2.0.x + windows gui 1.0.3 for several
years. they work great.

   we want to switch to 2.1.1 this year. however we found the windows
build lack some function.it can not hide the tap device,and won't
start openvpn gui when boot. so I wrote scripts to ease the job. the
script can hide tap device and start openvpn-gui when boot. it can
also bind the tap interface to first priority of windows tcp/ip, so
users always use dns servers from openvpn interface after vpn
connection. (we have users have vpn problem because their windows
didn't use correct dns server)

    I wrote both gui version(for user) and vbs version(for
administrator deployment). they are testing under windows xp with
openvpn 2.0.9 and 2.1.1.

    these are public domain. I would be happy if they can be included
in windows build.

Regards,
tbskyd

--000e0cd72316304bfe0482cac5de
Content-Type: application/octet-stream; name="vpn-tune.7z"
Content-Disposition: attachment; filename="vpn-tune.7z"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g7amxfq51

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
REb3AAA=
--000e0cd72316304bfe0482cac5de--

