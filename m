References: <CAKh=nwGz-NSEcSY9KhQ12gC1GNXP6XOBTEO3FdP8gyJN5VTggg@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <de60bac0-2491-44af-2a65-00654b14f55b@...2080...>
Date: Fri, 17 Feb 2017 18:18:27 +0100
MIME-Version: 1.0
In-Reply-To: <CAKh=nwGz-NSEcSY9KhQ12gC1GNXP6XOBTEO3FdP8gyJN5VTggg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QAUMUmvdnKp66B9I90Chcaq6XFnHPP0fk"
Subject: Re: [Openvpn-devel] build against openssl 1.1.0
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Emmanuel Deloget <logout@...260...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QAUMUmvdnKp66B9I90Chcaq6XFnHPP0fk
Content-Type: multipart/mixed; boundary="ROAcu9u7m8tnIJf2bVioXP0LBUD8AHl3V";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Emmanuel Deloget <logout@...260...>, openvpn-devel@lists.sourceforge.net
Message-ID: <de60bac0-2491-44af-2a65-00654b14f55b@...2080...>
Subject: Re: [Openvpn-devel] build against openssl 1.1.0
References: <CAKh=nwGz-NSEcSY9KhQ12gC1GNXP6XOBTEO3FdP8gyJN5VTggg@...278...>
In-Reply-To: <CAKh=nwGz-NSEcSY9KhQ12gC1GNXP6XOBTEO3FdP8gyJN5VTggg@...278...>

--ROAcu9u7m8tnIJf2bVioXP0LBUD8AHl3V
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 17/02/17 17:35, Emmanuel Deloget wrote:
>=20
> Now, I have a question which is related to this. The way I'm doing
> things, I will make sure that the new code is compatible with both
> OpenSSL 1.0.x and OpenSSL 1.1. There is a good chance that it will be
> compatible with version 0.9.8 as well, yet I can't stop wondering if
> this is a good thing. OpenSSL 0.9.8 has been EoL'ed 12 month ago and I
> believe it's OK to let it die. OpenVPN cannot rely on a dead SSL
> library -- unless it wants to make sure that future vulnerabilities in
> this old, deprecated version will affect it (and I'm not sure it's a
> good thing). Same goes for OpenSSL 1.0.1 which has been declared out
> of support in January 2017.

TL;DR: You can drop support for OpenSSL v1.0.1d and older, but we must
support v1.0.1e until at least June 30, 2024.


And now to why ....

One thing is what the upstream OpenSSL supports or not.  But there are
commercial Linux vendors which maintains versions after upstream drops
the support.  The most obvious Linux vendor here is Red Hat.

We have had a policy that the oldest Linux distribution we support is
what Red Hat officially supports [1].  We do not consider the "extended
support" scenarios, as that is services customers needs to pay extra for
(and is quite costly, AFAIR).  Currently, RHEL 5 (Red Hat Enterprise
Linux 5) is the oldest supported distribution, so that is what we
support.  But that support expires March 31, 2017.  So as of April 1st,
2017 RHEL 6 is the oldest distribution we support.

With that said.  Since we released OpenVPN v2.4 fairly recently (late
December), we have not considered or planned for a long-term RHEL 5
support for that distribution, as that is going EOL very soon.

[1]
<https://access.redhat.com/support/policy/updates/errata/#Life_Cycle_Dates>


> I understand that I'm the new guy in town, but can you allow me to
> make the formal request to ditch OpenSSL 0.9.8, 1.0.0 and 1.0.1 and
> require at least version 1.0.2?

So to the RHEL releases and the OpenSSL versions.  RHEL 5 ships with
openssl-0.9.8e.  Both RHEL 6 and RHEL 7 ships with openssl-1.0.1e.

The way Red Hat releases works is that versions are close to never
rebased, at least not core libraries such as OpenSSL.  But Red Hat
employs a lot of users to ensure all packages they distribute is secure
and maintained.  That means that security and important bug fixes will
be backported from newer OpenSSL releases to the openssl-1.0.1e
baseline.  And this happens for the whole life cycle of each major release.

Sometimes even features are backported as well.  But I have gotten
fairly clear signals that TLSv1.3 from openssl-1.1 will not be
backported, as the code has changed too much since the 1.0.1 baseline.
But I would be surprised if a future RHEL 8 does not ship with openssl-1.1.x


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--ROAcu9u7m8tnIJf2bVioXP0LBUD8AHl3V--

--QAUMUmvdnKp66B9I90Chcaq6XFnHPP0fk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJYpzBpAAoJEIbPlEyWcf3y2uIP/3QXiXdijl875UppY+0lwGQ5
QoFraBDT2JXkdwR82KsCwdpIMBcVMN2rqat/jTGh4HUT333nxv3Snri/nigrMaAy
XlK20NtlgYrgUHaQRIqpyv1me6GiyyRIY6HzhzIwT9ABORCGdwhV67itOCgcBrZg
vVLjGqP4LPyIug5pfIrACB221T0DEx3esye307V1xUwlNNGUOypxfTPMCDooidFE
NWi5z5PRWI72bsA1vO6Ei/YnTNiMlS1m02cDGwu4d5vMlJeExxEJZfmcC5nvfmuD
L11AHzjF8V9wDY8KqKgvjpn1Ud3nGOXX6SrnNEy9p8G+YHCdasRhLGpp/2UFaC0I
0IchX29T0xd9UWHlUro7VyKU7tlsxskPA6EsTTm/GPxO3xTjqJTWR2cjsCW2LjC8
oU3C3ohLclWF6BdMSNJhgjI9Ht9PaTYWryPhcCD3DAriDByIp7VD3UZVmj2GkVe4
PZvJ/XYjcuIcAIRJ0/gEtghz3VLnGn7VzfBLil9LV5Y2wUUt7+nS9x+iaPNIj3Eq
Vqxv/L5oQyPB+hjV4EGD+pSKuXlj3is6mnZbl5hxajGZleBmi13+URodckDGZ5iL
kGTYvv1QDCAUFW7mW8n1njJSTt+1ink0mVIZj0UKxDOFvBeVxBEv9j6VEBjeRg01
5NAlVwxmbBkT3EfU9B/x
=LI/N
-----END PGP SIGNATURE-----

--QAUMUmvdnKp66B9I90Chcaq6XFnHPP0fk--

