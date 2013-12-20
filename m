Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
From: Abdullah Alshalan <aalshala@...1837...>
In-Reply-To: <20131220081922.GT161@...1296...>
Date: Fri, 20 Dec 2013 13:34:52 -0700
Message-Id: <ABAB1979-6B56-4F4F-97FA-FD311A98EC62@...1837...>
References: <D9FC2C20-7EBE-4C8E-98DF-A48BE87936C4@...1837...>
	<20131220081922.GT161@...1296...>
Subject: Re: [Openvpn-devel] question about openvpn_ethhdr and openvpn_iphdr
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Thank you Gert, no wonder my code was working when I used the tab interface=
. Now that I'm using tun interface, my code worked by eliminating the ether=
net header processing.
Thanks again!

- Abdullah
On Dec 20, 2013, at 1:19 AM, Gert Doering <gert@...1296...> wrote:

> Hi,
>=20
> On Thu, Dec 19, 2013 at 06:56:19PM -0700, Abdullah Alshalan wrote:
>> I tried to print out the ethernet and IP headers of the packets in the i=
ncoming_tun buffer. The methods that does the printing is mentioned below.
>> I run the modified openvpn code and established a VPN tunnel.. I establi=
shed an FTP connection between machine A (running openvpn client and ftp cl=
ient ) tun ip is 10.0.8.2 and machine B running FTP server whose IP is 10.0=
.0.2.
>=20
> If it's a *tun* interface, it won't have ethernet headers.  That's just
> plain IP(v6), no ethernet.
>=20
>> The printed packet info showed incorrect mac addresses, incorrect SRC an=
d DEST IPs.The only thing that was printed correctly was the IP protocol. i=
t's always showing 20 or 21.
>=20
> IP protocol should be "6" for TCP.=20=20
>=20
> 20/21 would be the tcp port numbers for FTP.
>=20
> gert
> --=20
> USENET is *not* the non-clickable part of WWW!
>                                                           //www.muc.de/~g=
ert/
> Gert Doering - Munich, Germany                             gert@...1296...
> fax: +49-89-35655025                        gert@...1297...


