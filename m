Message-ID: <4BDAD39A.1030906@...515...>
Date: Fri, 30 Apr 2010 15:56:58 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [TESTING NEEDED] Using --inactive and --ping seems
 to defeat each other
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

Hi all,

In yesterday's meeting we discussed this issue:

<http://thread.gmane.org/gmane.network.openvpn.devel/3556>

In a nutshell, OpenVPN's ping packets (--ping <seconds>) keep the
connection alive even if user uses the --inactive <seconds> option to
close  inactive connections. Now, the --inactive option has an optional
<bytes> parameter, which allows closing the connection if less than
<bytes> of traffic is received in <seconds>. Setting all of these
parameters correctly should allow --inactivity to "ignore" the OpenVPN
ping traffic.

Has somebody already solved this issue by setting correct values for
--inactive and --ping parameters? Our idea is to change the code so that
the --ping and --inactive options are not mutually exclusive even if the
optional <bytes> option is not defined.

I hope I have not been too confusing :). For more information about the
--inactive and --ping options, see "man openvpn" or

<http://openvpn.net/index.php/open-source/documentation/manuals/69-openvpn-=
21.html>

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


