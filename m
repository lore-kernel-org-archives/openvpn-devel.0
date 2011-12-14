From: Adriaan de Jong <dejong@...1435...>
Date: Wed, 14 Dec 2011 10:09:13 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B90128ACE5E55@...1436...>
References: <A273A2F6519C0D42BFF02CA9C6A825112D003E1E@...1531...>
	<4EE52A57.1040906@...1338...>
	<A273A2F6519C0D42BFF02CA9C6A825112D003F02@...1531...>
	<A273A2F6519C0D42BFF02CA9C6A825112D003F72@...1531...>
	<20111213092241.GO18948@...1296...>
	<1CED409804E2164C8104F9E623B08B90128ACE5B0A@...1436...>
	<A273A2F6519C0D42BFF02CA9C6A825112D005928@...1531...>
	<4EE863A2.5010302@...1114...>
	<A273A2F6519C0D42BFF02CA9C6A825112D005B6D@...1531...>
In-Reply-To: <A273A2F6519C0D42BFF02CA9C6A825112D005B6D@...1531...>
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
To: Tiran Kaskas <Tiran.Kaskas@...1530...>, David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

I think Polar even supports 8-bit architectures, but don't quote me on that=
 :).

Adriaan

> -----Original Message-----
> From: Tiran Kaskas [mailto:Tiran.Kaskas@...1530...]
> Sent: woensdag 14 december 2011 9:54
> To: David Sommerseth
> Cc: Adriaan de Jong; Gert Doering; openvpn-devel@lists.sourceforge.net
> Subject: RE: [Openvpn-devel] Problem with alloc_buf_gc function
>=20
> Thanks.
> Already done the ssl part, only polarssl. It is working perfect and
> does support 16bit with no change.
>=20
> -----Original Message-----
> From: David Sommerseth [mailto:openvpn.list@...1114...]
> Sent: Wednesday, December 14, 2011 10:52 AM
> To: Tiran Kaskas
> Cc: Adriaan de Jong; Gert Doering; openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] Problem with alloc_buf_gc function
>=20
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> On 13/12/11 21:22, Tiran Kaskas wrote:
> > The problem is that the nl package was built with 2.1 version, and I
> > have used this.
> >
> > On a different topic: I found an issue, you probably want to fix
> > that: In reliable_pid_in_range1() function, the third
> > parameter(extent) is an unsigned int. However, this function is being
> > called by reliable_pid_min(), passing 0x80000000u as the value to
> > extent. On a 16 bit machine (int is 16 bit) this will never work. The
> > type of extent need to change to unsigned long and not int.
>=20
> As Gert already said, OpenVPN is written for minimum 32bit
> architectures.
>  The first OpenVPN release was in 2002, long after 16bit computers were
> quite irrelevant for most consumer users.  So at the moment I'm
> sceptical if we should also support 16bit.  As the int and also long
> integers will be a rats nest to review.  You probably got more data
> types which needs to be reviewed as well.
>=20
> On the 32bit platform both int and long are 4 bytes (32bit), while on
> 64bit int is 4 bytes and long is 8 bytes.  And I'm not sure how long's
> are tackled on 16bit platforms, and if this is consistent the whole way
> through.
>=20
> If we manage to fix OpenVPN to be 16bit safe as well, there are no
> guarantee that the SSL libraries will be 16bit safe.  You also got
> potentially the LZO library as well - which may be skipped.  The
> PKCS#11 support I guess is out of question on this kind of hardware.  I
> would say it's better to get started "in the other end", with the SSL
> libraries first, to be sure the SSL layer is fine and 16bit safe before
> starting modifying OpenVPN.
>=20
>=20
> kind regards,
>=20
> David Sommerseth
>=20
>=20
> > -----Original Message----- From: Adriaan de Jong
> > [mailto:dejong@...1435...] Sent: Tuesday, December 13, 2011 11:31 AM
> > To: Gert Doering; Tiran Kaskas Cc:
> > openvpn-devel@lists.sourceforge.net Subject: RE: [Openvpn-devel]
> > Problem with alloc_buf_gc function
> >
> >> -----Original Message----- From: Gert Doering
> >> [mailto:gert@...1296...]
> >>
> >> On Mon, Dec 12, 2011 at 09:32:51AM +0000, Tiran Kaskas wrote:
> >>> Is there a problem connecting a client running 2.1.4 (the one with
> >> polarssl) to a server running 2.0.9?
> >>
> >> Well, the default crypto algorithms are not compatible between
> >> polarssl and openssl-using openvpn.  So you'd need to change the
> >> crypto settings on the openssl-openvpn [--cipher] - and upgrade to
> >> 2.2, while at it.
> >
> > To be a little more specific: PolarSSL doesn't support blowfish
> > (BF-CBC), a good option would be AES (AES-xxx-CBC). You can see the
> > supported ciphers using --list-ciphers.
> >
> > Adriaan
> >
> > ---------------------------------------------------------------------
> -
> > --------
> >
> >
> Systems Optimization Self Assessment
> > Improve efficiency and utilization of IT resources. Drive out cost
> and
> > improve service delivery. Take 5 minutes to use this Systems
> > Optimization Self Assessment.
> > http://www.accelacomm.com/jaw/sdnl/114/51450054/
> > _______________________________________________ Openvpn-devel mailing
> > list Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
>=20
> iEYEARECAAYFAk7oY6AACgkQDC186MBRfrouQwCgklEb0qpSEvD/edsRAqWP6Jni
> BHcAmwWP1qIVzttpJco+N+P63DC8qi4i
> =3Dv09z
> -----END PGP SIGNATURE-----

