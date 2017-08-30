From: Steven Haigh <netwiz@...2277...>
Date: Wed, 30 Aug 2017 20:23:20 +1000
Message-ID: <8647024.clnTTMXkck@...2289...>
In-Reply-To: <4777209f-c480-0404-91c6-cf1bd3b3f507@...1227...>
References: <CAEycoiUeA+zbn3vT9t3F3Df6yxsKp8HmAdiaHCMmLV1ew+d8Xw@...278...>
 <4777209f-c480-0404-91c6-cf1bd3b3f507@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1657499.O1gDSDKrI5";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] Please take a second look at "#2 Improve
 TCP-over-TCP performance"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-users@lists.sourceforge.net, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--nextPart1657499.O1gDSDKrI5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday, 30 August 2017 11:49:33 AM AEST Arne Schwabe wrote:
> Am 29.08.17 um 22:53 schrieb wang yu:
> > URL  https://community.openvpn.net/openvpn/ticket/2
> > <https://community.openvpn.net/openvpn/ticket/2>
> >=20
> > As I mentioned,the custom TCP protocol(I called FakeTCP) bypasses the
> > TCP over TCP performance issue.Its helpful when UDP is not
> > avaliable(being blocked or being throttled or not well supported by NAT
> > devices).
> >=20
> > This was your reply:
> >>We are not going to implement it, though. OpenVPN over TCP is needed
> >>
> > when you have nasty firewalls out there that do sequence number checking
> > and all that - and then your FakeTCP is not going to work either. If you
> > have no firewalls in the way, OpenVPN over UDP works perfectly well
> > (including "through NAT").
> >=20
> > Sorry,I cant get the logic behind the sentence.
> >=20
> > UDP not avaliable is a much more common circumstance,while a nasty
> > firewall which tracks everything of TCP is just a rare circumstance.
> >=20
> > This method solves most of the troubles when UDP is not avaliable just
> > except the nasty-firewall circumstance you mentioned.
> >=20
> > It seems like you rejected a commonly workable feature for a rare
> > circumstance.
> >=20
> > I tried to have a further discussion with you by another reply in the
> > Tracker,but you closed the issue without a word.
> >=20
> > I am okay wheter or not the feature can be implemented.I just hope its
> > well discussed and there is a convincing reason if it cant
> > be implemented.If this feature is acceptable I can make patches.
> >=20
> > If you dont have time to discuss with me,plz leave the ticket open for a
> > few days,so that I can possibly get some more convincing feedback from
> > others.
>=20
> While a fake TCP as UDP sounds like a nice idea, OpenVPN itself is
> probably the wrong place to implement it. It would mean to implement a
> TCP/IP stack in userspace, something that would complicate OpenVPN
> without much gain. Much better would be to teach the kernel to speak
> this fake TCP UDP protocol so openvpn can just set the socket options on
> its tcp socket to enable this special mode.
>=20
> Take a look at Multipath TCP to get an idea what implementing such a
> fake TCP might entail. Also OpenVSwitch implemts a STT [1], a fake TCP
> protocol but for a very different reason.
>=20
> [1]
> https://networkheresy.com/2012/03/04/network-virtualization-encapsulation=
-an
> d-stateless-tcp-transport-stt/
>=20
> In sum and I think I speak for all us, we are not against such a FakeTCP
> protocol but it should be
>=20
> a) implemented outside openvpn (the kernel)
> b) nobody of the OpenVPN core team will implement it
>=20
> This protocol will probably help only if people just block all UDP and
> allowed a few TCP protocol. You won't fool a real firewall that checks
> TCP with it.

Something like this?

https://lwn.net/Articles/614348/

--=20
Steven Haigh

=F0=9F=93=A7 netwiz@...2277...       =F0=9F=92=BB http://www.crc.id.au
=F0=9F=93=9E +61 (3) 9001 6090    =F0=9F=93=B1 0412 935 897=

--nextPart1657499.O1gDSDKrI5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEFHf0gfgNrH6ofcYGQa811Xp9MdwFAlmmkhgACgkQQa811Xp9
Mdz27Q//QMSxY4Q1PjA2w6u95OLOZUGqq6BAaAfVROAb1Cmc3dCOuMM7NDfFDHGN
NYUPZm+Eos/NHasQVIl68Nu/c4Q/sTc9Qbx4RbkQUEb0weCfK2v5GpFkjVdq1zQ0
oxEzIugeK+waTv3wBm4pyBhZNE2nrs9UAEdv3MujmY2ggXeLcqtrm5H5j/cKLXpx
9OUDRAmh5vvRY/X6VL+RQhyeOtAWIrmNTDeJ3fU+/Q/S0pwOgkMQNeJDKjerhrXe
eZ9n66I6DqLmFMz+1SrX4lbKa1fu2xwU6EXXjokXxAO0b0LfSWoSJs0iUpvFTBIG
M+mZ+6O+jrcwKAWlsZb5YvvRGnCsCi4JRixwWVMUo9i6EIFIDI+MA1qeWuIUolq4
pOOU+Wtc3jDrik8PRBxE3JwAGnyOQUHqK8QmSXmLt7pAt+4Ij8ANMHINpR8vP7vm
uIXUseEVeVVIbacJXFJuQUO/NCwc3FaZOy1jZbNsItV1qsM/yCBv59s6gtPrX0MS
UsvRPFEFATI37D/2elKK4cL703ENSjrn1Ot+3oSAFFcxgXrjvE9JMZDVhiL7qKhQ
m6fxtr1u+eXiAZ1VFLaGp2Lx2qH9PG0dVh24quzS3QSUvCD4FZVlybAfeln7Nidw
bplSa41d7VfJrzhJVOo2rv6psKEeXmRm0mhK9+JU0nqRImUxp4A=
=2B44
-----END PGP SIGNATURE-----

--nextPart1657499.O1gDSDKrI5--


