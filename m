Message-ID: <1510159186.3121.14.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Wed, 08 Nov 2017 08:39:46 -0800
In-Reply-To: <7dc8bad3-eb19-0644-0b24-162cb0d842a1@...2080...>
References: <1509192147.3021.6.camel@...2316...>
 <1509192205.3021.7.camel@...2316...>
 <CAFHpkQHXWrXn42B1xr0YuPvQUrOSvUqQU6h8RkP_EgP_iBP5Qw@...278...>
 <1509289652.3116.11.camel@...2316...>
 <72a75ffb-67df-0986-7b64-9080254cc084@...2181...>
 <1509292633.3116.16.camel@...2316...>
 <d2079a55-a8c4-95be-4385-75d164a9f8c5@...1856...>
 <20171104175814.GY958@...1296...>
 <CAKuzo_i-CvWA0SFdTLMcN0c6DgV8DMe450NoWMSjf6iapLfcvg@...278...>
 <7dc8bad3-eb19-0644-0b24-162cb0d842a1@...2080...>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-RKuHuP38yZkxmYNOeu7u"
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 1/1] openssl: add engine method for
 loading the key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, Selva <selva.nair@...277...>, Gert Doering <gert@...1296...>

--=-RKuHuP38yZkxmYNOeu7u
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2017-11-08 at 13:27 +0100, David Sommerseth wrote:
> I need to spend a bit more time to fully grasp the UI get/set calls
> and the related implementation.=C2=A0=C2=A0But what is done in regards to
> password retrieving in ui_read() makes sense to me.

How to use UI methods is (unsurprisingly) badly documented in openssl.
I picked up my knowledge of it by giving up on the docs and reading the
source code. Basically it's a huge overkill interface for reading and
verifying a passphrase. =C2=A0There are about six overrideable methods:
opener, closer, reader, writer, flusher and prompt constructor. =C2=A0The
interface seems to be designed to give control of all aspects of user
interaction, from passwords, inputs and error outputs. =C2=A0However, it
only ever seems to be used for passwords.

The only thing I need from it is the reader method (that's what takes
input from the user) and of the five types
UIT_PROMPT/VERIFY/BOOLEAN/INPUT/ERROR I only need UIT_PROMPT because
that's asking the user for input, which duplicates what the PEM
password prompt does.

James

--=-RKuHuP38yZkxmYNOeu7u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJaAzNWAAoJEAVr7HOZEZN4ghQP/il/4YKWnyv9VylEJpxKAPtz
ykTdZg0hPYdqddl9pF4ayCC6BKe0fQUedb+kfPdkgF0vqj5SpHobQQsUt3kdf25w
UPjBGDsc/++Wk1w0fGiKY+JPdFQeu0hwphuiG6TSA3kNpZBu33/AaHGJcxKbprEj
QLnhCncJdyK19BaOlSjkvc19F65OISUgBL7/gKLHzDwGAa29jXAJir7L8xeXIRCn
st+VpaAh4iwoON3J9L8+4dVrchzZRmsJVK1r84yZ4obpJmgbpQ4wwX1MIMnKlG0Y
X3NMnGzAT5ZCH0m9Yy3qxWodIGWCop25rhPazJgab+JI/rPOlzdh2yPGE4i14OKK
uEkxDLtzGxWnRvOREryB7ExbhhonOHGG7ux3Rt9Iuf3U+D8Q/k5gYfrwWW8KbadS
53ZvGQxqXTA5Ne6+4nzgtrNsf0B2J/I/6oF9MnrxQbgNyeFqEbJl1Z7dNURvimQT
J3T2CUOjuca5Buue6FtBNDbG9UVEOk/PolC2WWmZeOkuCPBDvyzi6uQ7LpC7BSl6
QtIUHPdzoEULkM6ktT0lQBVEGdDhDcx4YeElriY4AAzTAlLvCsxV1lJPa0y71rxC
ErKf0a9/MyKouJ1ooojJ7380WS+NSf4Xjd9lFF4yH4BCzYBjOMWvGLzSURdexG51
X5jVRW1Pa2S+s8WFtoQV
=uyQe
-----END PGP SIGNATURE-----

--=-RKuHuP38yZkxmYNOeu7u--


