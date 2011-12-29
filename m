Date: Thu, 29 Dec 2011 10:38:49 -0600
From: "Karl O. Pinc" <kop@...1206...>
References: <A273A2F6519C0D42BFF02CA9C6A825112D003F02@...1531...>
	<A273A2F6519C0D42BFF02CA9C6A825112D003F72@...1531...>
	<20111213092241.GO18948@...1296...>
	<1CED409804E2164C8104F9E623B08B90128ACE5B0A@...1436...>
	<A273A2F6519C0D42BFF02CA9C6A825112D005928@...1531...>
	<4EE863A2.5010302@...1114...>
	<A273A2F6519C0D42BFF02CA9C6A825112D005B6D@...1531...>
	<0E891FB5E6304C73BB4338093E409304@...139...>
	<A273A2F6519C0D42BFF02CA9C6A825112D005C00@...1531...>
	<A273A2F6519C0D42BFF02CA9C6A825112D00A3D3@...1534...>
	<20111229142454.GV5060@...1296...>
In-Reply-To: <20111229142454.GV5060@...1296...> (from
	gert@...1296... on Thu Dec 29 08:24:54 2011)
Message-Id: <1325176729.8034.0@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Problem with alloc_buf_gc function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Tiran Kaskas <Tiran.Kaskas@...1530...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 12/29/2011 08:24:54 AM, Gert Doering wrote:

> Linux needs to know that it is to be a router:
>=20
>  # echo 1 >/proc/sys/net/ipv4/ip_forward

See /etc/sysctl.conf (man sysctl.conf) to set
forwarding at boot.


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


