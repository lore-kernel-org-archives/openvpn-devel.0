From: Janne Johansson <jan.johansson@...1...>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-EEtqSMD5wJauP5xXvaMx"
Message-Id: <1017825803.1524.134.camel@...2...>
Mime-Version: 1.0
Subject: [Openvpn-devel] More on BSD vs Linux tun devices.
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Wed Apr  3 12:10:06 2002
To: openvpn-devel@lists.sourceforge.net

--=-EEtqSMD5wJauP5xXvaMx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

There isn't an option to remove the AF_INET attachment on tun packets
on OpenBSD at least, although there are ioctl's to add more "junk" at
the beginning, such as the sender ip address.

After checking the Linux kernel source, there seems to be an
option that MIGHT add info to packets, called "IFF_NO_PI",
which you set, meaning that you remove the PI-option and
don't add info to packets.

Now, I don't know what this PI stuff is for, the comments around it
are sparse, to say the least. ;-)

Here is a snippet from your code, on the 2.4 dynamic tun-stuff:

int
open_tun (const char *dev, char *actual, int size)
{
  <..cut some lines away...>
  ifr.ifr_flags =3D IFF_NO_PI;


And the corresponding Linux kernel code that gets to run
if IFF_NO_PI is not set (the flag name is TUN_NO_PI):

/* Get packet from user space buffer(already verified) */
static __inline__ ssize_t tun_get_user(struct tun_struct *tun, const
char *buf, size_t count)
{
	struct tun_pi pi =3D { 0, __constant_htons(ETH_P_IP) };
	register const char *ptr =3D buf;=20
	register int len =3D count;
	struct sk_buff *skb;

	if (!(tun->flags & TUN_NO_PI)) {
		if ((len -=3D sizeof(pi)) < 0)
			return -EINVAL;

		copy_from_user(&pi, ptr, sizeof(pi));
		ptr +=3D sizeof(pi);
	}


This seems (to me) to mean:
if TUN_NO_PI is not set, and len gets sizeof(pi) subtracted but still
is larger (or eq) than 0, get a "pi" struct from userspace and copy
it to the beginning of the space that "ptr" is pointing to.

In the receive function, we see:

	struct tun_pi pi =3D { 0, skb->protocol };
	int len =3D count, total =3D 0;
	char *ptr =3D buf;

	if (!(tun->flags & TUN_NO_PI)) {
		if ((len -=3D sizeof(pi)) < 0)
			return -EINVAL;

		if (len < skb->len) {
			/* Packet will be striped */
			pi.flags |=3D TUN_PKT_STRIP;
		}
=20
		copy_to_user(ptr, &pi, sizeof(pi));

		total +=3D sizeof(pi);
		ptr +=3D sizeof(pi);
	}

Which seems to indicate that the protocol might be stored in the
tun_pi struct after all.
The tun_pi is defined to contain two unsigned shorts, one "flags" and
one "proto".
The TUN_PKT_STRIP seems to have no other effect than to just exist
so that someone might read it in the packet. But that's just my guess.

Next problem. The proto filled in by TUN is "htons(ETH_P_IP)" which
is 0x0800 in intel byte order, which would be something like
0x0008 if my htons guess is correct for a short.

So BSD and Linux say different things. BSDs say "here comes IPv4 stuff"
with AF_INET in a htonl(u_int_32) and Linux says
"here comes Ethernet IPv4 stuff" with two shorts, one containing
ETH_P_IP in intel byte order or it says nothing at all.

I think the solution would be to have openvpn disable TUN_NO_IP for
Linux tun devices and just not care about the actual value when
the packets arrive.

--=20
Janne Johansson
jan.johansson@...1...
BioMat Systems AB
Klarabergsg 37 3tr
111 21 Stockholm


--=-EEtqSMD5wJauP5xXvaMx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8qsoKNJYxu+mj1OkRAjR7AKDBBMwSffru9sQTVuMOyvK6u57PHgCfR4TP
luGFstgYyVJDLOEBYPXNPEs=
=7CeW
-----END PGP SIGNATURE-----

--=-EEtqSMD5wJauP5xXvaMx--


