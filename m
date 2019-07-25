Date: Thu, 25 Jul 2019 20:20:58 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190725182058.GA1097@...1296...>
References: <aa4f4026-a684-f96d-c8cb-d4f8a3468c4c@...277...>
 <CAGyAFMVBdD6tkNSnkZXqMUd5i-zA_d-q1W-OEpPvHtA8gPkSVA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="hsoAP4Wa+/L9NF1J"
Content-Disposition: inline
In-Reply-To: <CAGyAFMVBdD6tkNSnkZXqMUd5i-zA_d-q1W-OEpPvHtA8gPkSVA@...278...>
Subject: Re: [Openvpn-devel] Wrong FILETYPE in .rc files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Gisle Vanem <gisle.vanem@...277...>, OpenVPN-dev <openvpn-devel@lists.sourceforge.net>

--hsoAP4Wa+/L9NF1J
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jul 25, 2019 at 10:44:48AM +0300, Lev Stipakov wrote:
> 1. Please fix your patch, I cannot apply it:

This might be something with your mailer at openvpn... Antonio complained
about a well-formed patch yesterday, now you complain while I can apply
the patch just fine...

$ git am /tmp/mail.eml
warning: Patch sent with format=3Dflowed; space at the end of lines might b=
e lost.
Applying: Wrong FILETYPE in .rc files

So - since I can apply the patch just fine, is the change itself ACKed?

> 3. Since you patch .rc files, could you replace rest of numeric values wi=
th
> strings, like
>=20
> FILEOS VOS_NT_WINDOWS32 instead of FILEOS 0x40004L

This would be a separate patch, I'd say - the patch here is actually
changing numbers, while your suggestion would be more of a cleanup
thing, not actually changing the result.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--hsoAP4Wa+/L9NF1J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdOfMJAAoJEB2Cnv7KVigSSY0L/A0BcuFB27ZIsjT3AqBA5yv6
+/h0qgMHXxcSs/Yj19zaUaSQvYLAVsLSMWA2f8TsDPhV0XounxFG+k7pnxAGUjGo
tmSFoya00eEzbyi7FNm2UmKrc7bKbSRFgxLNuiLJwVHJfDeU79gZnxVfm6j8Rai5
QoJd0oxbMK5+bhMRzMMTpkiqepSxiH4O8l3GvVWQndZOv99zW0bxEjVFddWKkfZa
3zlgl1NvVtrDj2OMTi/gQwVk5rXkZZaDHhvhj/koM+3gbpL6nxNv8ZGjwArHUCbz
30dzekFAH1CXneiN3nTDhTofDIFbPpdbYbOT2RFPmmPrgG36Zju1W1hqVtjB24z6
ttwmUINn32VZbN/09KHumvu7Tx+LCXZd+14thqfhY3oYCV98p1Cn96M8PoZRgrDU
0Vk/UbAnED4/lcLpWcNnMMfWEoFislc5Hqo4A5IgPwMtwQfJwBi26O9KkD5xDy9k
AQQVcpp2+nyBwFsPPY4SnB/oo31zCk2Rh7oRZTT+ww==
=1jCO
-----END PGP SIGNATURE-----

--hsoAP4Wa+/L9NF1J--

