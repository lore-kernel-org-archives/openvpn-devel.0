References: <1481251952-30704-1-git-send-email-davids@...515...>
	<20161209081535.GT78624@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <f69da83d-83b7-09b0-8b1c-e37003611946@...2080...>
Date: Fri, 9 Dec 2016 13:20:03 +0100
MIME-Version: 1.0
In-Reply-To: <20161209081535.GT78624@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="xA07Rf8bS2a4XnDBxAhERADr9W2GsijVm"
Subject: Re: [Openvpn-devel] [PATCH] Improve ifconfig_sanity_check()
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
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xA07Rf8bS2a4XnDBxAhERADr9W2GsijVm
Content-Type: multipart/mixed; boundary="D8U2UdHTADkPHMTPSAGJj7NoRP01bFuhb";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <f69da83d-83b7-09b0-8b1c-e37003611946@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Improve ifconfig_sanity_check()
References: <1481251952-30704-1-git-send-email-davids@...515...>
	<20161209081535.GT78624@...1296...>
In-Reply-To: <20161209081535.GT78624@...1296...>

--D8U2UdHTADkPHMTPSAGJj7NoRP01bFuhb
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 09/12/16 09:15, Gert Doering wrote:
> Hi,
>=20
> On Fri, Dec 09, 2016 at 03:52:32AM +0100, David Sommerseth wrote:
>> - Instead of checking the complete in_addr_t (which lacked proper htonl(=
)),
>>   just do a simple peek at the last byte which contains the first octet
>>   of an IP address or subnet mask.
>=20
> Have you *tested* this on a non-intel platform?
>=20
> I know that I said on IRC that we might do it that way, but looking
> at stuff like print_in_addr_t() I'm not sure our usage of in_addr_t is
> consistant with "normal usage of it" (namely, always in network byte
> order).

I don't have access to any big-endian machines.  I might still have
access to a virtual POWER8 machine, but that is configured in
little-endian mode - so no difference from the Intel platform.

After I sent this patch, I started to ponder on if there were any
performance reasons why to change the in_addr_t check.  And I've come to
the conclusion I doubt it makes much of a difference.

First of all, an IPv4 address is 32-bits, which is the smallest CPU
variants we do support.  So 0xff000000 or 0xff will just be copied into
a 32-bit register anyway.  Secondly, checking for just 0xff will remove
one AND operation on the CPU and the mov(e) operation will just be
slightly different as it only loads 8 bits from a memory region vs 32
bits.  So we might end up with or without saving just a couple of CPU
cycles.  And when considering that this is code paths which is not
called very often, it starts to smell very much like pointless
micro-optimization.


I suggest we leave the in_addr_t parsing unchanged, and fix the message
handling to differentiate between --ifconfig and --ifconfig-push.  And
after 2.4.0, we can look at the in_addr_t tackling to see if it behaves
correctly on both big- and little-endian.  If it doesn't behave well
then we'll fix it.

Thoughts?


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--D8U2UdHTADkPHMTPSAGJj7NoRP01bFuhb--

--xA07Rf8bS2a4XnDBxAhERADr9W2GsijVm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYSqFzAAoJEIbPlEyWcf3ybWIP/jbPExEmclr6NMscgsKi5LWx
FPlIa6yoeP48yMa63615wX55nnsWL01oG069LXf8MUlUzmhw0YP2UGec98IgnLI+
3dzef0MkymSfl8NJxYmVrzF4BWShulpdVXJFQ6GEkvGks4lKvanTWNIHl3zvQm88
vMAn0fePS+PkayOgbZM5x2jA8x/gTjqIFXbwWLeCsnvd/oXYYfjd9QJ71jUTPN/b
JXzE+e97IZo9oOdUKc+ZnM1+2qFoMLchxpjoW3cY40ciweRCecwYNtvBOA/eb5+V
fuOL3U5ns2DyPEtwDXTMSSdTXF4fI/acAqqsvgxtvEAiFDjqszTmie8hEUc0Bs4b
RgYZa3cSA86iMKdiRkVTYJtIl3U3pz3JgEY4J54yTJb8fp4L1utyz081rzCcs5Wg
09cAgv6HTyoStZOnzRS7x84gByyrDYz0inEMI6X4Ti0GbdP9m2AZRWM/epHHFcJc
6PC5qwuouR/XXf62vTpErA8AGPelyB5gDkRJTSVl8QTYwbxE5/oZKpXnaxSnGQRv
Eqdn9d9WK2qtiUBWJW2D6xu6uxzzejUovSvzFpxXQmbUc+mfJHLrNEsMLu2MbwIb
l/ky1o9VXkbd+EfFXCYN7rlSWv6dc/k1Q19OlWiYvL98hgu/sVhsnVRIeRw45xYz
zubceHjFnpoQRyhNSCm0
=XUoP
-----END PGP SIGNATURE-----

--xA07Rf8bS2a4XnDBxAhERADr9W2GsijVm--

