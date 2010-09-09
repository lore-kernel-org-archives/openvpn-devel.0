From: <openvpn@...1315...>
Date: Thu, 09 Sep 2010 18:32:14 -0500
Message-id: <1284075134535506500@...1315...>
MIME-version: 1.0
Subject: [Openvpn-devel] TCP Window Size - Impact on Data Throughput
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

I can't explain the information below, but hopefully someone a whole bunch =
smarter than me understands it - as it seems to help with TCP throughput in=
 OpenVPN (the holy grail??? ... :-)).

I have added some plots and details to an open OpenVPN ticket, located here=
 ... https://community.openvpn.net/openvpn/ticket/2. And, here is the expla=
nation to go with it,

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Here are some results, between two machines in my network. The results note=
d as "direct" are exactly that - a link between the two machines, without O=
penVPN running. The "OpenVPN" results are then of course with OpenVPN runni=
ng (between the same two machines, but traffic over OpenVPN).
Note the significant impact that the TCP Window size has on OpenVPN perform=
ance ... any thoughts?

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

As above, does anyone understand the huge (5-10x or more) impact TCP Window=
 Size has on OpenVPN throughput? And perhaps more relevant - how do we use =
this to improve TCP throughput in OpenVPN?

Thanks!

... Russell


