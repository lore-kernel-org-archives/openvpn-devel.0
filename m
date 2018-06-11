Date: Mon, 11 Jun 2018 09:52:42 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180611075242.GF57262@...1296...>
References: <42bafab6-9e6f-56b5-2c44-b449ec503ce7@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="XIT9+HGZgTFaGwcE"
Content-Disposition: inline
In-Reply-To: <42bafab6-9e6f-56b5-2c44-b449ec503ce7@...515...>
Subject: Re: [Openvpn-devel] Regarding tap-windows6 driver signatures and
 driver distribution
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--XIT9+HGZgTFaGwcE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 11, 2018 at 10:30:05AM +0300, Samuli Sepp=E4nen wrote:
> Last Friday I managed to get tap-windows-9.22.1[1] attestation
> signed[2]. This means that that particular driver (64-bit variant)
> should work on any Windows 10. However, according to [2]

This is very good news :-)

Have you been able to make this into a tap6 installer that we could
throw at people that had issues getting the previous attempt to work
on win10?

[..]
> I actually lean towards 2), as that is the only way[3] to provide a
> driver that works across all Windows versions that are under "mainstream
> support". That would leave out Windows Server 2008 R2 which is under
> "extended support" that ends in early 2020:
>=20
> https://support.microsoft.com/en-us/lifecycle/search?alpha=3Dwindows%20se=
rver%202008
>=20
> So, if we want to keep on supporting Windows Server 2008 R2 while having
> just one tap-windows6 driver we (=3DI) would have to go through three
> different test suites / certifications:
>=20
> - HLK (Windows 10)
> - HCK (Windows 7/8)
> - WLK (Windows 2008 R2)

I have no idea how many people are doing Server 2008 R2 with OpenVPN,
but I'm afraid there will be "more than zero".

Wild idea: do we want to add a checkbox to the installer "submit=20
version information to OpenVPN Headquarters" (opt-in, of course) so
we can have a rough idea what people are actively using?


> Our projected deadline for the next tap-windows6 release is June 20th. I
> will start working on HLK/HCK, but I don't know how many obstacles I
> will encounter.
>=20
> However, as we can now attestation-sign drivers, even in the worst case
> we could initially release two installers (option 1 above). Then, when
> HLK/HCK/WLK are in order, we can switch back to using a single installer
> again.

This sounds like a good backup plan to get fixed drivers *out* for all=20
supported platforms, and give us (=3Dyou :) ) time to wrestle with=20
HLK/HCK/WLK...

thanks,

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--XIT9+HGZgTFaGwcE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbHipKAAoJEB2Cnv7KVigSzx8L/j9l9szp8ceoXpPqOIl0s5mY
2zOJgmsmh/wFlfKgZIHmOMz8aabTwUvfOw7oixP0Uj/l9s3AuI5rp0wM4Q2LQUIE
QkrhZHrmPRkVXeIhigGDiJXfqLZELjeYuZN/MmMjZ9yZEdTa7UlJe4Gn/At3IyUT
BtcBT+M37chfbxAyP06b59zIb2Qn+Udw7LlrUqSzBdxKk6saVuQBH7P6KJxCvFqW
Yxxh9eMlMd26ibKYA5Qn6kkhxJ+81DklOubU0JJUJr04uogrBGmg9uroaKQsZk//
H9EPKyPjmNlczadBy1bQy8xS+0dpzZJo9/8BJKx4TO7QjQhADCzNldC7yVYAsXFU
rgqVt+e4ERlLLHUF9utD3lTer1VCvO2QmVkIiWwWBcowAntOe0l8bjPdnL10HnqR
ayasMNxcCIzVkovqEaTP7c9ARwVnhRmsOucWa/d4epkhVuJavNpkgYsMODlCDQcT
lX1r15vaVkI5OIfvrb/y7JcPo7o7a0osQqTqwjm3HA==
=UMZi
-----END PGP SIGNATURE-----

--XIT9+HGZgTFaGwcE--

