Message-ID: <526636AA.50402@...1847...>
Date: Tue, 22 Oct 2013 10:26:18 +0200
From: =?UTF-8?B?QW5kcsOpIFZhbGVudGlu?= <avalentin@...1847...>
MIME-Version: 1.0
References: <8c01c399-7f0c-477d-9bbe-dab589231ffc@...1848...>
In-Reply-To: <8c01c399-7f0c-477d-9bbe-dab589231ffc@...1848...>
Subject: Re: [Openvpn-devel] [PATCH] Floating: Add support for floating in
 TLS mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,

no comments for this patch? It is really cool if you roam from wifi to edge=
 on mobiles,
you are immediately reconnected to your vpn after a connection change. No 1=
 minute wait
for openvpn to complete the openvpn authentication. (cause is the ~1s GSM E=
DGE roundtrip
time) If you travel in a train through, this will enhance your experience d=
rastically.

I would really appreciate any comments on this, or if you have any hints.

With kind regards,

Andr=C3=A9

On 14.10.2013 23:20, Andr=C3=A9 Valentin wrote:
> Add support for floating in tls mode using the HMAC of a packet. It costs
> a roundtrip through the clients. Because it is based on the HMAC, it is
> secure in ways of cryptography. Before the iteration starts, some sanity
> checks are done.

