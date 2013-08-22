Message-ID: <521638B2.5080103@...1114...>
Date: Thu, 22 Aug 2013 18:13:38 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <5215D0BA.6040009@...515...> <5215E945.7080105@...1114...>
	<20130822115102.GL16543@...1296...>
In-Reply-To: <20130822115102.GL16543@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="gbM2XuM3GSTp7reCk4XmOtT5lSDjNqPTi"
Subject: Re: [Openvpn-devel] Topics for today's community meeting
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
--gbM2XuM3GSTp7reCk4XmOtT5lSDjNqPTi
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 22/08/13 13:51, Gert Doering wrote:
> Hi,
>=20
> On Thu, Aug 22, 2013 at 12:34:45PM +0200, David Sommerseth wrote:
>> * openvpn-build issues + snappy topic.
>>
>>    "The problem is that snappy pulls in a 8MB library as a dependency,
>>     increasing installer size considerably "
>>
>> Is this really a problem?  It's not a small library, but it could still
>> be worse.
>=20
> The 8MB library is libstdc++, which can be statically linked if we figure
> out how (this is on *windows*).  Libsnappy is tiny.

Ahh, that explains things better.  I understood it was libsnappy itself
which was that massive.  Then it makes sense to figure out how to
resolve that part.

> And yes, this is a relevant difference if the overall installer without
> libstdc++ is just 1.7 Mb sized today
>=20
>    1723560 Jan 18 2013  openvpn-install-2.3.0-I001-x86_64.exe
>=20
> (And no, making the installer even bigger by shipping two binaries
> *and* the huge library is not a good plan :-))

Fair enough :)


--=20
kind regards,

David Sommerseth


--gbM2XuM3GSTp7reCk4XmOtT5lSDjNqPTi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlIWOLIACgkQDC186MBRfroM1gCfRxIxIsxHHZTsfXXv7qzSwwxU
iEMAn3HFOku/jmjjd6oX8oEkY7a8uqop
=j4Zv
-----END PGP SIGNATURE-----

--gbM2XuM3GSTp7reCk4XmOtT5lSDjNqPTi--

