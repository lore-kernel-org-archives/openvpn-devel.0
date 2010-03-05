From: Heiko Hund <hhund@...194...>
Date: Fri, 5 Mar 2010 11:44:28 +0100
References: <20100228145001.GM9556@...1296...>
	<201003050942.23706.hhund@...194...>
	<20100305091151.GI25238@...1296...>
In-Reply-To: <20100305091151.GI25238@...1296...>
MIME-Version: 1.0
Message-Id: <201003051144.28236.hhund@...194...>
Subject: Re: [Openvpn-devel] special-case code for OpenBSD - advice needed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Gert,

On Friday 05 March 2010 10:11:51 Gert Doering wrote:
> What happened exactly?  Could you ask your colleague for a log file?

Well, he couldn't ping any remote host. Nothing special in the log, really.=
 If=20
it isn't misleading it's quite obvious that the ordering is wrong:

  TUN/TAP device /dev/tun1 opened
  /sbin/ifconfig tun1 destroy
  /sbin/ifconfig tun1 create
  NOTE: Tried to delete pre-existing tun/tap instance --No Problem if failu=
re
  /sbin/ifconfig tun1 10.1.1.18 10.1.1.17 mtu 1500 netmask 255.255.255.255 =
up

Heiko
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro AG | An der RaumFabrik 33a | 76227 Karlsruhe | Germany

Executive Board: Markus Hennig, Jan Hichert, G=FCnter Junk, Dr. Frank Nelli=
ssen
Chairman of the Supervisory Board: Stanley J. Krasnow
Headquarter Location: Karlsruhe
Commercial Register: Mannheim HRB 108997

