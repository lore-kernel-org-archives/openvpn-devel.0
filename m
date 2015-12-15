References: <1448852638-2644-1-git-send-email-fukawi2@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <56706E28.8030900@...2080...>
Date: Tue, 15 Dec 2015 20:46:48 +0100
MIME-Version: 1.0
In-Reply-To: <1448852638-2644-1-git-send-email-fukawi2@...277...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="hvLfrNS7np7PhuqbSAl639BjweLTCJdAi"
Subject: Re: [Openvpn-devel] [PATCH] Use example.com to improve clarity of
 documentation
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Phillip Smith <fukawi2@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hvLfrNS7np7PhuqbSAl639BjweLTCJdAi
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable


On 30/11/15 04:03, Phillip Smith wrote:
> This patch uses the generic "host1.example.com" and "host2.example.com" to
> replace the current "may" and "june" hostname examples. Generic names cho=
sen
> rather than other names like "server"/"client" or "head-office"/"remote-o=
ffice"
> etc which may create other unintended or implicit meanings to the reader.
> The example.com domain is set aside defined by IANA for use as documentat=
ion
> examples. Refer to: http://www.iana.org/domains/reserved
> Using this well-known domain makes comprehension of documentation easier.
>=20
> Signed-off-by: Phillip Smith <fukawi2@...277...>
> ---
>  doc/openvpn.8 | 84 +++++++++++++++++++++++++++++------------------------=
------
>  1 file changed, 42 insertions(+), 42 deletions(-)

Hi,

As this popped up in my mailbox now as Steffan replied ... just a
thought.  I also share the general Feature-ACK to use
example.{org,com,net} domains.  Which ever variant isn't important for
my part.

[...snip...]

> -.B may.kg
> +.B host1.example.com
>  and
> -.B june.kg.
> +.B host2.example.com.

Any reason changing from {may, june} to {host1, host2}?  I find
documentation to be easier to read when there are more than just one or
two letters changing.  Especially when it is related to two different
systems you want to configure to talk to each other.  For people
struggling with dyslexia, more diversity also helps a lot too.

It doesn't need to be may or june.  Could even be
"alice-laptop.example.org", "bob-workstaion.example.org" or something
more even more unique.  Just have a broader variety.

Just my 2 cents ... not trying to paint any bike sheds.


--=20
kind regards,

David Sommerseth


--hvLfrNS7np7PhuqbSAl639BjweLTCJdAi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZwbigACgkQDC186MBRfrpSyQCfeQvsx4xhzyOG3CJGvO52jxqX
bb8AoJQSSKBsBTY0HkCXbXvqz+/3aE+T
=Z6MR
-----END PGP SIGNATURE-----

--hvLfrNS7np7PhuqbSAl639BjweLTCJdAi--

