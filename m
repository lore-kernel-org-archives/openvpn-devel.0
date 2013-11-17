Message-ID: <528890A7.1020002@...1114...>
Date: Sun, 17 Nov 2013 10:47:19 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAN_jwOsXhs-qTqOmrqhNk+Jf6-pRSBVVTovShLGgQAKKTZkE4g@...278...>	<554440252.59882.1380270883311.JavaMail.zimbra@...1795...>	<CAN_jwOvixY5Jz7Rheq-=o40saprsoQmxRB9yn3-jdCmFa9VM0A@...278...>	<52456F61.3000104@...1114...>	<CAN_jwOt4kiM09YjZi5=jh6qFgQTpLFgPOSO1opFOF72EY8fyCw@...278...>	<CAN_jwOuJcwF-Co0r=pukUHO2z0a0ff5xtERp7_mc2PYot9yv-Q@...278...>	<CAN_jwOuQR6rxUTA5Nho9tBkvSBMU75Yzfv=PFpFUHa2Kq8=E2A@...278...>	<20131023141829.GA13900@...1296...>
	<20131023162618.GP161@...1296...>
In-Reply-To: <20131023162618.GP161@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="efLCEiaHMkNqkEHdk5VG91Xd7BqiUDgKf"
Subject: Re: [Openvpn-devel] Does openvpn 2.3.2 has memory leak?
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--efLCEiaHMkNqkEHdk5VG91Xd7BqiUDgKf
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 23. okt. 2013 18:26, Gert Doering wrote:
> Hi,
>=20
> On Wed, Oct 23, 2013 at 04:18:29PM +0200, Gert Doering wrote:
>>  - each further renegotiation leaks "a few kbyte" of memory per client,
>>    which should also be fully returned when the client disconnects - this
>>    is the issue I discovered earlier, with the GC handling of the per-cl=
ient
>>    environment set, and I'll send a patch for that "soon" (as soon as I
>>    have fully understood the code involved).
>=20
> Yeah...  Fosdem 2012 rearing it's ugly head.
>=20
> Please try the following patch to git master, it should bring back=20
> 2.1-behaviour here.

ACK on this patch:
-----------------------------------------------------------------------
--efLCEiaHMkNqkEHdk5VG91Xd7BqiUDgKf--
