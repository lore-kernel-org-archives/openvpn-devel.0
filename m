From: "Abdullah Alshalan (Student)" <aalshala@...1837...>
Date: Tue, 18 Nov 2014 22:47:15 +0000
Message-ID: <3219A74B-936B-4A9B-BACF-2B61E77E425F@...2003...>
Content-Language: en-US
MIME-Version: 1.0
Subject: [Openvpn-devel] Sending packets from VPN client to VPN server
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
Content-ID: <A33494D77A2ABE41AFFC8336C5BA2C83@...2004...>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,
I was wondering if anyone can help me understanding why my code isn't worki=
ng. I'm working on  a project for fun modifying openvpn-2.2.2. What i need =
help with is this:
I have a packet cached in a buffer structure. And I want the VPN client to =
send it to the VPN server so it can reach its intended destination.

What i was trying to do is something like this:

struct buffer *buf =3D cached_buffer;
buffer_turnover(buf->data, &c->c2.buf, buf, buf);
pocess_incoming_tun(c);
process_outgoing_tun(c);

Unfortunately, when I ran Wireshark on the virtual tun of the client I don'=
t see that cached packet.

alternatively, I tried:
struct buffer *buf =3D cached_buffer;
write_tun(c->c1.tuntap, BPTR(buf), BLEN(buf));

in this case I can see the packet in Wireshark but it's never received at t=
he VPN server side.=20

Any insights or suggestion would be highly appreciated.

Thanks in advance,
Ab
