Date: Thu, 1 Apr 2021 14:10:14 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210401121014.GK976@...1296...>
References: <CAAUX2SVQRn4zuDC947HE9M38nDNK1oNqyUv0GKeAw2dasHo62Q@...278...>
 <ad7e8624-6f87-2874-9786-d5de521bc6a2@...2181...>
 <f10fc09e-5d7b-c678-02f8-04f80f004b24@...2181...>
 <CAAUX2SU9u8sdsN08ynDTVD15q+qP0yOF-RxMzF5hMRg-pFCWFg@...278...>
 <CAAUX2SXiT1=-5HtKzQRay-R1zreT0_7QpEvjc40H3-0U2nqcAA@...278...>
 <69feee58-499e-98c7-5fec-e78368198d4a@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="nzrgFor6yi+Cvzdw"
Content-Disposition: inline
In-Reply-To: <69feee58-499e-98c7-5fec-e78368198d4a@...1227...>
Subject: Re: [Openvpn-devel] [ovpn-dco] sudden network disconnection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Tony He <huangya90@...277...>, Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nzrgFor6yi+Cvzdw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 01, 2021 at 12:47:46PM +0200, Arne Schwabe wrote:
> In your dco to dco setup you probably
> don't have mssfix on either side unless you explicitly added iptables
> rules for that.

Ah, this is interesting and needs to be documented - "if you want feature
<a>, <b>, <c> together with DCO, it needs to be done in iptables".

(Of course it makes lots of sense to defer this to iptables etc. on
all platforms that have DCO *and* a reasonable firewall layer... dco-win
will be interesting)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--nzrgFor6yi+Cvzdw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgZbgjAAoJEB2Cnv7KVigSiNoL/2SNqqnW3TT081gqfZuXWQS/
rD14nT2e9W+aO7gSMjBZE2KhT8FcQkNkleoTZKDjxyoKixl9iDh+Aucq+6clnOto
fxajPSG29iwBOrXdjpz8FiYsXE5ZhT2wo/+MwrfokeVP6BA8Cd39QyhqoiF6z8x1
t+OMeGxiBugfxG+VAnpRW/VWqhzkV7O9X+F7CHZG+MCA4xrT5KYc2unyZHuM6DUo
muoZifVDKcaDvVGzBPYRorboAMVxDVS9py4e64eClBr3/rgaeLhnaWKbpqu6l1GF
v23+V6ExZ51KHgvrgHlRypCyB5+WWnawCvLGZJnQRIJSeJR26Rj7t2kst8kaJdbA
ydB8jYm6CeFVKkFqYCqiQ9YUZFnyXrrTXlPX3tnpXejzKeeND57K86O/985hP1qG
wn54WKCDlbQd7erB81+5FLWanl0o61+xFFC7XWMMVqpqudmvlJQQBeSXPwfiNRv2
4fvBi2GRaKGoearAbfW64JkKPt/5CNhPip8V6YVV1A==
=EnVr
-----END PGP SIGNATURE-----

--nzrgFor6yi+Cvzdw--

