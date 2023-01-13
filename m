Date: Fri, 13 Jan 2023 08:35:40 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y8EJzGoG6yEJaGmU@...1296...>
References: <20230111235052.24855-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="poIZU2OgQLNv1cqE"
Content-Disposition: inline
In-Reply-To: <20230111235052.24855-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] dco: print proper message in case of
 transport disconnection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, kp@...1249...

--poIZU2OgQLNv1cqE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jan 12, 2023 at 12:50:52AM +0100, Antonio Quartulli wrote:
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 77dcaa60..99123c39 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -3244,6 +3244,10 @@ process_incoming_del_peer(struct multi_context *m,=
 struct multi_instance *mi,
>              reason =3D "ovpn-dco: transport error";
>              break;
>=20=20
> +        case OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT:
> +            reason =3D "ovpn-dco: transport disconnected";
> +            break;
> +

We were too fast in ACKing and merging this "because rc2" - this breaks
compilation on FreeBSD+DCO, because it only adds the necessary enum
element for Linux.

This being an enum, I can't even add an "#ifdef ...TRANSPORT_DISCONNECT"
here, and because these codes need to be synchronized between kernel and
userland, I can't "just add it to freebsd_dco.h".

So consider me not very amused...

As a quick bandaid, I'll send a patch that adds an #ifdef TARGET_LINUX
around this clause so I can update the FreeBSD openvpn-devel port - but
that is not a really good solution either.  @kp, what would you suggest
how to handle this on the FreeBSD side?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--poIZU2OgQLNv1cqE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjwQnMAAoJEB2Cnv7KVigSYdgL/2EWJmEzb30EvxbrDOmjkwcx
NKhK3NIfv62mH92G5oTMWelinhRjkAUaPV4Qn1ReGZQVFNOrWQ4oKa50AO4gUlfQ
nYIsqe7bl9dVJi/VpONm3qlxU/Kyhbh+oJPfkroDqQc8RKysnGUYbNJX3+8d/sGc
3ioMqrdw30tAaQCQglgNzDCA7UIrrN/aVA8+NC3Bgki7DVzir8MaWWc05OJ5qNYc
Ej2KBv786l2/819G8BAA6bS7B5VK6wUHsa2+JbcjedDRxvWWcaQlyop5ndlsxNaa
QADIA1vcrirJXw1C1OiI/4wWRv6L7rONbf2h3R1q0o2Xmqm/wNAh8pFQOeOC5PYf
tyCtColN0gza61vQeEMJ17mE2YAlDwFaxBBAc6x1JOV219ywTGk8vwrRCn7X5UG6
ZRS7MIvrEw6on4p9TMCZC3hHY7VLYXotPnImU8PE83NCZOSFMTT1e+d72Csb3rVP
y8/PCB5KPjVl02laIdZ2c8f3EUPhGDevbNSOt3kZzw==
=WYYK
-----END PGP SIGNATURE-----

--poIZU2OgQLNv1cqE--

