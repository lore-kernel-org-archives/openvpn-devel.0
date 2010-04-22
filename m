MIME-Version: 1.0
Content-class: urn:content-classes:message
Date: Thu, 22 Apr 2010 18:40:40 +0200
Message-ID: <7C4973E27A52DB44900D96028C07F413099FC1@...1352...>
From: =?iso-8859-1?Q?Siegfried_M=FCller_-_MB_Connect_Line_GmbH?=
	<mueller@...1351...>
Subject: [Openvpn-devel] OpenVPN 2.1.1 and "inactive". "ping" is retrigger
	the inactivity timeout!!
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Openvpn-devel@lists.sourceforge.net

Hi developers,

does anyone tried the "inactive" option with the openvpn version 2.1.1?
I step up from 2.0.1 to 2.1.1 and get the problem, that the client does not=
 disconnect after inactivity.
If i set the option "ping 0" instead of "ping 10" the inactivity works. Cou=
ld that be a problem, that the new version does retrigger the inactivity-ti=
meout with his own ping?
any ideas?

regards
siegfried

