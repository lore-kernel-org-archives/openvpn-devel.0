Message-ID: <5267833F.1050403@...1847...>
Date: Wed, 23 Oct 2013 10:05:19 +0200
From: Andre Valentin <avalentin@...1847...>
MIME-Version: 1.0
References: <4a53f8df-5bfc-41ae-9e10-b582e3a68f82@...1848...>
In-Reply-To: <4a53f8df-5bfc-41ae-9e10-b582e3a68f82@...1848...>
Subject: Re: [Openvpn-devel] [PATCH] Floating: Add support for floating in
 TLS mode (V2)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,

please take a look at multi_find_instance_udp(), I am unsure about gc usage=
 there.

Andr=C3=A9

Am 23.10.2013 09:54, schrieb Andr=C3=A9 Valentin:
> Add support for floating in tls mode using the HMAC of a packet. It costs
> a roundtrip through the clients. Its security comes from a secret key, bo=
th
> peers have. This key and the data form the signature used, which is then
> checked againts existing peer connections. Therefore a good auth algo is
> recommended.

