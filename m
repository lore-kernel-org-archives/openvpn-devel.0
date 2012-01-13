Message-ID: <4F0FE1E1.6050808@...515...>
Date: Fri, 13 Jan 2012 09:48:49 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN apt/yum repos now available
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
To: "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi all,

We now have several apt/yum repositories for OpenVPN:

<https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos>

Currently the following operating systems are supported, both on i386
and amd64/x86_64 architectures:

- Fedora 16
- CentOS 6
- Ubuntu 10.04
- Debian 5
- Debian 6

At the moment, there are three kinds of repositories/packages:

- "stable" : official OpenVPN releases (e.g. 2.2.2, only for Debian/Ubuntu)
- "snapshots" : OpenVPN builds based on Git "master" branch, rebuilt
weekly/bi-weekly
- "as" : official Access Server releases

For further details and usage instructions, please refer to the above link.

NOTE: If you started using OpenVPN apt repos prior to 2.2.2 release,
you're probably using the old repository server. If so, please take a
look here:

<https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos#Upgradingf=
rombuild.openvpn.net>

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


