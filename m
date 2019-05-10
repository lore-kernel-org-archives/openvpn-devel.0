Date: Fri, 10 May 2019 16:59:21 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190510145921.GU31008@...1296...>
References: <E1hP6kn-0001uL-T2@...2479...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fOJARmXCc2lxmu6e"
Content-Disposition: inline
In-Reply-To: <E1hP6kn-0001uL-T2@...2479...>
Subject: Re: [Openvpn-devel] message-id test
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--fOJARmXCc2lxmu6e
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, May 10, 2019 at 02:44:05PM +0000, Gert Doering wrote:
> this mail was intentionally sent without a message-id

So - if you send mail to the openvpn-devel list, and your MTA either
omits the "message-id:" header or mangles it in funky ways, Sourceforge
will add a new message-id (required by RFC822 and successors) *but*
seems to do this at a point in the processing where their MTA sees
multiple individual mails (one per receipient?) and the message-id:
seen at the receiving end is no longer unique.

This particular mail ended up with at least these message IDs...

	<E1hP6kn-0001uL-T2@...2479...>
	<E1hP6kn-0001uL-Rk@...2479...>
	<E1hP6kn-0001uL-SU@...2479...>

(so it's clear that it wasn't done by "something close to the receipient",
but somewhere in the sourceforge mailing list system)


Long story cut short: I'll check patches for such message-IDs in future,
and ask for re-sending from a less broken sending MTA.

(I'm not going to discuss this with SF - it would be way easier to just
migrate the list away than find someone there who would understand and
fix that)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--fOJARmXCc2lxmu6e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJc1ZHIAAoJEB2Cnv7KVigSUYMMAI3fo+f8qmqQZde9ueK8FKhq
uAzPH3jsFP8Qn9ScgX79M29FxX8kjzpe8REOhSnK9+JrXvV8ffnznSwgm5Nxy4F/
G1JpFrvBDrs/u/AnUsK+hD2zIpGALyJTiCYnyAFFeoS21SplMOoLMsL2i+aGYHjX
l+53+yV1zD8LbNOUT+j0R453TpbNlnHHNpPaXb5EtXTv0T2BnDPU2xjEtvGl+kpa
hzVdiBdSvjsYjvvlZSht87iYNic7yJ5lGZb9JOA8yfJPb5Qq4leP3lTMCo8XcGdG
OfTuy19YRN71RBRQIP6hawDaIDHX9gR22xsJXLsZQ4LcQurnPy3KmWOedCzZWNvR
XY5xL4j4U7DJTcFTlL3T0WVLw6RObt6bKyrhDkIJbxUTEUtG+UbhZEerl8Fwhe4d
l3QU01Ttw0DMnpzdtjE85Qak656cOaA181zpBEbitYSzdVdsSmi4jvZGv2oyA0Oy
3dQqmhYVaKUkRfSu4EQidaHXcYn87RND+KBeMKbTgw==
=JEFW
-----END PGP SIGNATURE-----

--fOJARmXCc2lxmu6e--

