From: Heiko Hund <hhund@...194...>
Date: Thu, 8 Apr 2010 09:01:35 +0200
References: <OF16C98C16.EEA12E96-ONC12576FD.006F673E-C12576FD.00713519@...1343...>
	<OF815ED8F1.B831009E-ONC12576FE.0049FAB0-C12576FE.004A9529@...1343...>
	<4BBCF086.2060005@...1147...>
In-Reply-To: <4BBCF086.2060005@...1147...>
MIME-Version: 1.0
Message-Id: <201004080901.35636.hhund@...194...>
Subject: Re: [Openvpn-devel] DNS problems with openvpn 2.1 on Windows
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
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

On Wednesday 07 April 2010 22:52:22 Jan Just Keijser wrote:
> this could be a timing issue, which could be caused by changes to the
> userspace openvpn part; did you try playing with the
>   route-delay
>   tap-sleep
>   dhcp-renew
> flags ? did that have any affect?

We've tried all of those with no effect. I even hacked the driver so it=20
responds to DHCP and ARP requests with a 500ms delay, nothing.

Heiko
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro AG | An der RaumFabrik 33a | 76227 Karlsruhe | Germany

Executive Board: Markus Hennig, Jan Hichert, G=FCnter Junk, Dr. Frank Nelli=
ssen
Chairman of the Supervisory Board: Stanley J. Krasnow
Headquarter Location: Karlsruhe
Commercial Register: Mannheim HRB 108997

