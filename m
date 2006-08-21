From: Tony <kb2wjw@...277...>
Date: Mon, 21 Aug 2006 23:24:06 +0400
Message-ID: <op.tenesuv9ioehzu@...596...>
References: <op.tdco72dcioehzu@...603...>
	<eaalgv$i96$1@...165...> <op.tde7cyccioehzu@...596...>
Mime-Version: 1.0
Sender: news <news@...165...>
Subject: Re: [Openvpn-devel] A special IP address range for exclusive VPN
	usage?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="koi8-r"; delsp=yes; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

What I feared - has happened.
One of my ISPs has changed the IP-range they allocate to the GPRS-users.
Now it overlaps with my private IP =3D=3D 172.16.*.*
(This is not the first time - as most of small networks - we were=20=20
192.168.*.*, then we had to move to 10.*.*.*, finally we landed at=20=20
172.16.*.*)

I think that an introduction of some special IP-range for the exclusive=20=
=20
VPN usage - as long as IPv4 is still here - a range is very welcome.

Now I re-configure my server to allocate a client with 5.*.*.* addresses.

Tony.


