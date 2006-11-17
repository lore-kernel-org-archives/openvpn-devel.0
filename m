From: Tony <kb2wjw@...277...>
Date: Fri, 17 Nov 2006 22:24:40 +0300
Message-ID: <op.ti6djfgvioehzu@...603...>
References: <15c1dfa0611171039x3e3de194q4b69b9424986606b@...278...>
Mime-Version: 1.0
Sender: news <news@...165...>
Subject: Re: [Openvpn-devel] Patch that provides unidirectional IGMP
	snooping in the multi-client server
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

On Fri, 17 Nov 2006 21:39:57 +0300, Ulrik Mikaelsson=20=20
<ulrik.mikaelsson@...277...> wrote:
> What it does:
> ...
>  * Handles mcast-traffic flowing "downstream" on the server-side of a=20=
=20
> multi-client server.
Does it mean I (as an OpenVPN client) will be able to join a MULTICAST=20=20
group who's source is local to OpenVPN server? ("local" =3D=3D on the same =
LAN)

My OpenVPN server is a winXP-SP2 box, I use BRIDGING, will your patch work=
=20=20
for me?
Can you send me a pre-compiled version to try?

Thank you in advance.

Tony.


