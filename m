From: Peter Sagerson <psagers@...1829...>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_AF11EB8B-A59A-4534-A7B7-184021A7A1CB";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <710EB8C1-E1E5-4A1C-9CDC-70B475E27545@...1829...>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Date: Sun, 16 Jun 2013 15:21:33 -0700
References: <5C629764-6A77-4E0D-8B27-AF0AE8B29025@...1829...>
	<51BCF5D1.6070407@...1227...>
	<BC613B74-D9A7-48B9-94B3-2AFF99BF8847@...1829...>
	<51BE2AA0.7060908@...1227...>
In-Reply-To: <51BE2AA0.7060908@...1227...>
Subject: Re: [Openvpn-devel] Native OS X tunnels
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--Apple-Mail=_AF11EB8B-A59A-4534-A7B7-184021A7A1CB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Defaulting to it in unreleased builds also sounds like a fine idea. I don't=
 know how large your pre-release testing population is. The speed and direc=
tness of a utun migration is really a judgement call. Naturally I defer to =
those who are more involved in the project; it sounds like things are well =
in hand.

I'll leave my fork up for a while in case any part of my diff is helpful. I=
 get the impression that 2.4 is not a date-driven release, so if it's not i=
mminent, there's a possibility that we'll begin releasing the functionality=
 in our own product before it's more widely available.

Thanks,
Peter


On Jun 16, 2013, at 2:14 PM, Arne Schwabe <arne@...1227...> wrote:

> Am 16.06.13 01:41, schrieb Peter Sagerson:
>> Nice, glad to see I'm not the only one working on this. Apple has been p=
retty clear that they're aware of the kext conflicts but don't have much in=
terest in addressing the situation. If we can get native tunnel support in =
one way or another, we can stop the insanity.
>>=20
>> I toyed with the idea of various auto-detect or fallback modes, but I en=
ded up opting for explicit behavior and backward compatibility. With the in=
herent uncertainties in a change like this, my inclination would be to star=
t with a release that calls it an experimental feature, which users can tur=
n on if they want to. Given the substantial benefits of not having to deal =
with kernel extensions, I think we would see both users and vendors promoti=
ng its use. If all goes well, the question of making it the default behavio=
r probably belongs in the context of a major release.
>=20
> I think using utun as default at least for -master and 2.4rc candidates i=
s a good way to get the feature tested. I hope there is time in the next Op=
enVPN developer IRC meeting to decide if my or your patch should be include=
d.
>=20
> Arne
>=20


--Apple-Mail=_AF11EB8B-A59A-4534-A7B7-184021A7A1CB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.19 (Darwin)

iQIcBAEBAgAGBQJRvjptAAoJENfXJ2LQ+g52nNwP/3r2VCHwTVLyXCOaCu+LyB/j
bZUbZjMU19HQeLxUKwzyhvP08oPJPzaDYEGmcuM4RA+wptx5gTrKAPWKvhD36JhM
HSXa1U/jzA0VrSBQMnli55cMXoXdar4dufcCkneHiiiKmK8mvQh/6YvbhtfBhvmd
HUW49QQjrUtJw3Bg3eE8ZaMvJVN1rppfsGGyPXBedRJVBWfp5rP4GkCDHz2AOGjm
h56QgxMSmyqnnXv8kGsy+4tJ7xKIyxhFnUDlXLlCkmKvTwklRrBgVv4SKEoV6tYu
OXLR4xfH3TL9oFvk85Ud0PUQMXGbehxD6WvcIzsgAwMuIQAjvUn+ltYcnuYH8Pf0
VUu3wtIday78KHlZWENZRNFdbTSBqk4L5enLjsD7IDxBxi1L30HwDE3RTBemr95V
8fepU7JRHIOSEp0bdTrNGUCrYxkSSp2/XWMISBbUzhXr0Ja0+MdGxeiaeVuMZzsI
x4yHKM2fNmefSgkk+MEggL9rNnYu4XHaXBKe20hjUlXQIvJDnRFnc3EmoXsXbjJG
+Z9SjG09HFGDuQfhqB1+U9H2/ubW2P0BUKva6mnnpB/s2uZIf5Pxhyg++OFoRuxg
SMTmx1PoXUMVTF7TBTPLz9Sfb2ElGJ69kd90FKZcnH8LO7PFQEOsS3b1M2AQdbfd
dYxrKLtTmns/H9xETiT4
=GWzn
-----END PGP SIGNATURE-----

--Apple-Mail=_AF11EB8B-A59A-4534-A7B7-184021A7A1CB--

