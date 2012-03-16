Message-ID: <4F632647.30603@...515...>
Date: Fri, 16 Mar 2012 13:38:47 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] New generic buildsystem: lzo enabled or disabled by
	default?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi all,

In yesterday's meeting we reviewed this patch

PATCH 39/52 build: proper lzo detection and usage
 URL: http://thread.gmane.org/gmane.network.openvpn.devel/5772/focus=3D5811

The patch was ACKed, but there was disagreement whether LZO should be enabl=
ed or disabled by default. Whichever the case, it will only affect people b=
uilding OpenVPN, not the end-users. Official builds will continue to have L=
ZO support.

Opinions?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


