From: Tiran Kaskas <Tiran.Kaskas@...1530...>
Date: Tue, 13 Dec 2011 20:22:36 +0000
Message-ID: <A273A2F6519C0D42BFF02CA9C6A825112D005928@...1531...>
References: <A273A2F6519C0D42BFF02CA9C6A825112D003E1E@...1531...>
	<4EE52A57.1040906@...1338...>
	<A273A2F6519C0D42BFF02CA9C6A825112D003F02@...1531...>
	<A273A2F6519C0D42BFF02CA9C6A825112D003F72@...1531...>
	<20111213092241.GO18948@...1296...>
	<1CED409804E2164C8104F9E623B08B90128ACE5B0A@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B90128ACE5B0A@...1436...>
Content-Language: en-US
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
To: Adriaan de Jong <dejong@...1435...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

The problem is that the nl package was built with 2.1 version, and I have u=
sed this.

On a different topic: I found an issue, you probably want to fix that:
In reliable_pid_in_range1() function, the third parameter(extent) is an uns=
igned int.
However, this function is being called by reliable_pid_min(), passing 0x800=
00000u as the value to extent.
On a 16 bit machine (int is 16 bit) this will never work. The type of exten=
t need to change to unsigned long and not int.

Tiran

-----Original Message-----
From: Adriaan de Jong [mailto:dejong@...1435...]=20
Sent: Tuesday, December 13, 2011 11:31 AM
To: Gert Doering; Tiran Kaskas
Cc: openvpn-devel@lists.sourceforge.net
Subject: RE: [Openvpn-devel] Problem with alloc_buf_gc function

> -----Original Message-----
> From: Gert Doering [mailto:gert@...1296...]
>=20
> On Mon, Dec 12, 2011 at 09:32:51AM +0000, Tiran Kaskas wrote:
> > Is there a problem connecting a client running 2.1.4 (the one with
> polarssl) to a server running 2.0.9?
>=20
> Well, the default crypto algorithms are not compatible between polarssl
> and openssl-using openvpn.  So you'd need to change the crypto settings
> on the openssl-openvpn [--cipher] - and upgrade to 2.2, while at it.

To be a little more specific: PolarSSL doesn't support blowfish (BF-CBC), a=
 good option would be AES (AES-xxx-CBC). You can see the supported ciphers =
using --list-ciphers.

Adriaan

