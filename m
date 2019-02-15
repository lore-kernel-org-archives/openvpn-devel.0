Date: Fri, 15 Feb 2019 21:56:21 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20190215205621.GG962@...1296...>
References: <1549917961-632-1-git-send-email-selva.nair@...277...>
 <44fea524-53ef-8125-5d81-cd8aaac0ad16@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="gPEtRQsivC9KyqIm"
Content-Disposition: inline
In-Reply-To: <44fea524-53ef-8125-5d81-cd8aaac0ad16@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Exit early when external scripts are
 specified with script-security < 2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

--gPEtRQsivC9KyqIm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Feb 15, 2019 at 09:26:50PM +0100, David Sommerseth wrote:
> So I can give this a full ACK for git master only.

I can see your line of reasoning, but there is another aspect to it - we
want to change the windows GUI to override script-security, to disarm
possibly dangerous .ovpn files that have "--up $eviltrickery" in them.

With this change, the GUI has a chance to tell people "look, this is
the problem.  If you trust the source, you can enable scripts in this
config (press <here>), if not, you better leave the ovpn alone!" -=20
without, things will silently stop working for windows users...

But we *do* want this on windows, disable script-security unless=20
explicitely activated *outside* the .ovpn file...

(I'm halfway tempted to make this an #ifdef _WIN32, but that cannot
truly be the way forward)


So - I had planned to give this an ACK both for 2.4 and master, but
since you have reservations, we need to find the best way forward.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--gPEtRQsivC9KyqIm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJcZyd0AAoJEB2Cnv7KVigSieYL/iYpl8VCCahiRcN2Y2KZOb9E
c5dTl/7iJhM3a0U940BvwOo2s3lUnJT6nDdYQiZtmBvMTukMAOEEshRxZS5bgXVr
YXN4Q4fJkhl92333uHoLT3w2XGgLhwk49v+uzLzgAZTBBDIe8yuqxOIASst7ypva
6rjd5pzOtBWFRgEtEYBS58rumKxGMw5lETYYXmgt3xq3F5EF0c3DCqxFIFHKwSrC
nHJa1FYx9Ov1MT4LgOlzPjVMgoiVZxIvOlvJ/NRj5Ulbe9scnZtRm45PYhrZnFdW
4ixEVpY1E9jaFuqcoUzVBhUHitVsWieYe3SDUpdwxRjTAz9HLDfOTTX1KV0qwPDk
k+eJI9OZwfzFmihy9oe//sObSLeeTkG45PzK2cLhN1gkPWtlX+CuTKujUPBIiGct
9YJ4OJnNQmdL8AfkOkWammSqeUoiCWAhKFzTCts9CTMsjQESmp2Aih6w+M2JtEVc
7RtSbU88plBYInG2GHumRDubQkRAnQrohZrooQjAcw==
=BMmp
-----END PGP SIGNATURE-----

--gPEtRQsivC9KyqIm--

