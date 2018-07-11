References: <20180711165918.12762-1-a@...2181...>
 <20180711170042.15154-1-a@...2181...> <20180711174957.GA989@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <12dcd8dd-58f6-3fde-6e6f-bee91fc3f580@...2181...>
Date: Thu, 12 Jul 2018 01:56:14 +0800
MIME-Version: 1.0
In-Reply-To: <20180711174957.GA989@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ggjb5JmnnrJc6qj3lRQzSpUQXI9JMQ2po"
Subject: Re: [Openvpn-devel] [PATCH v2] socket: make stream_buf_* functions
 static
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ggjb5JmnnrJc6qj3lRQzSpUQXI9JMQ2po
Content-Type: multipart/mixed; boundary="mQq3gT0YNhTw0usLgKXAaQX8X0BbGKhRk";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <12dcd8dd-58f6-3fde-6e6f-bee91fc3f580@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] socket: make stream_buf_* functions
 static
References: <20180711165918.12762-1-a@...2181...>
 <20180711170042.15154-1-a@...2181...> <20180711174957.GA989@...1296...>
In-Reply-To: <20180711174957.GA989@...1296...>

--mQq3gT0YNhTw0usLgKXAaQX8X0BbGKhRk
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 12/07/18 01:49, Gert Doering wrote:
> Hi,
>=20
> On Thu, Jul 12, 2018 at 01:00:42AM +0800, Antonio Quartulli wrote:
>> stream_buf_init(), stream_buf_close() and stream_buf_added()
>> are only used within socket.c, therefore there is noneed to
>> have them declared in socket.h.
>>
>> Make them static and remove useless declarations.
>> This change required some re-ordering of the functions to
>> ensure they were defined before being used, however, no
>> this is just a copy/paste and no function change has been
>> introduced.
>=20
> I'm not so happy about the large code move-around here, for small
> benefit (code move-around breaks "git blame" to see which commit
> introduced something, and why).
>=20
> Why not just add prototypes at the top?

Because I wanted the result to be clean code :)
Imho, prototypes should be used only if really needed (i.e. when
re-ordering is not an option).

The information about what/why was introduced can still be extracted
with a "git log -S$something_here".

I wouldn't make such a big deal of "breaking git blame" if the changes
slowly move towards cleaner code.

Actually some functions did not strictly needed to be moved, but I
wanted all the stream_buf helpers to be in the same place and not
scattered along socket.c. This can be changed if you think it's too
invasive.

my 2 cents.


Cheers,


--=20
Antonio Quartulli


--mQq3gT0YNhTw0usLgKXAaQX8X0BbGKhRk--

--Ggjb5JmnnrJc6qj3lRQzSpUQXI9JMQ2po
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAltGRL4ACgkQB6U8WA7y
zXSckBAAvL6aHQpqltcHVmAqekvVMuSdsKdzUl6Apid7FoPEqqFz94WV7vvrAIsO
OKNsMVSTv9dfcyXRBMYvBLFYWpJCGT4frumhqL/K9FSAVTnA0pqYwKaXPG/fiXp0
Lls8c9Y2bn/2lNLTE3xp/5jEHdFfRC1cMlCnN1M/16m1HAs8mlj9ANgWbdN6vKi5
XVnVxKhg1DoYclDoLqNadyfIlzPpckpFLV3RmxTMfK5gU0T5Esz8EJ8yBMaOL/f8
YJhICjmz1sBe1d9ZdnEo1i0x26M/UzzZg6jU7Bc/m2g1rg7+R1LL8OdCnm5/Gyrb
1k9pFFyFzEc1zuXoQDNTb4ieGra5N/OPhDQejGNTyadxxa/CdVpURYkRh5WIEUeG
nSPcfsLJYLiji9NF2T9TTn71fWbXvtKK/eDEfnJ1smBD+8iG/uAYNV7n9kktwfeD
GOgfkyaMdckf0YRaxnE8+kNwdi9dldGaHigrgRpZ38uAqUXw6VdxJPWxCn3yejTk
CtAJo5wlmJFUn6yzRkY0KfCWRosmiBIUyn0h31VFnAA7eMI8gdjmCVaWMVBC3b9p
SswDXTygsvpOBIBoWiY1snw3clbuNwvgw+popvOiufb72cppkWbOoAKjZW0DjcNB
VaIgoKKmvSVOSzpHP4Zk0gj49URv2lrwxWI3XQFp60w2VhOAYaU=
=6iLQ
-----END PGP SIGNATURE-----

--Ggjb5JmnnrJc6qj3lRQzSpUQXI9JMQ2po--

