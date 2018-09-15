From: "Morris, Russell" <rmorris@...1315...>
Date: Sat, 15 Sep 2018 15:06:43 +0000
Message-ID: <DM5PR08MB3642BFBDAEDE74DF8B297EADB9180@...2422...>
References: <DM5PR08MB3642F01D339F64AF7E9029EFB9190@...2422...>
 <20180915080020.GQ962@...1296...>
In-Reply-To: <20180915080020.GQ962@...1296...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Traffic through Cloudflare
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

OK, my misunderstanding - thanks for clarifying!

... Russell


-----Original Message-----
From: Gert Doering <gert@...1296...>=20
Sent: Saturday, September 15, 2018 3:00 AM
To: Morris, Russell <rmorris@...1315...>
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] Traffic through Cloudflare

Hi,

On Fri, Sep 14, 2018 at 09:10:12PM +0000, Morris, Russell wrote:
>=20
> Perhaps a dumb question, but I recently set up my (HTTPS) server through =
Cloudflare, enabling their proxy service. Now when I try to connect to Open=
VPN, I get the following?
>=20
> WARNING: Bad encapsulated packet length from peer (18516), which must=20
> be > 0 and <=3D 1626 - please ensure that --tun-mtu or --link-mtu is=20
> equal on both peers - this condition could also indicate a possible=20
> active attack on the TCP link - [Attempting restart...]
>=20
> Have other seen this? Is it expected?
>=20
> Thanks in advance!

OpenVPN is not using HTTPS, so you can't connect through a reverse proxy (w=
hich is what Cloudflare does).

gert

--
"If was one thing all people took for granted, was conviction that if you  =
feed honest figures into a computer, honest figures come out. Never doubted=
  it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

