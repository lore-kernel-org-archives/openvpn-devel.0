Date: Wed, 25 Jul 2018 23:43:34 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180725214334.GE55859@...1296...>
References: <1516833453-18991-1-git-send-email-selva.nair@...277...>
 <1532486093-24793-1-git-send-email-selva.nair@...277...>
 <CAC+mqbndu79SZhVuL0aX3Jfar4WgPc_JkUdCv1=8s-Lj7vCqrw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="FlxqdQUIXA+HMkrt"
Content-Disposition: inline
In-Reply-To: <CAC+mqbndu79SZhVuL0aX3Jfar4WgPc_JkUdCv1=8s-Lj7vCqrw@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] Parse static challenge response in
 auth-pam plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Joe Bell <joeaintexas@...277...>
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel@lists.sourceforge.net

--FlxqdQUIXA+HMkrt
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jul 25, 2018 at 04:31:05PM -0500, Joe Bell wrote:
> I don't know if it is appropriate to reply to this post in this manner,=20

It is and it helps :-)

We want test reports, as in "I am using this, because it is a useful
feature for me, and it works fine!" - not as strong as a full code
review, but an indication that something is beneficial at least.

[..]
> If there is anything I can do to provide a list of testcases, write-up on
> its configuration and usage, etc., in aide of getting the patch merged and
> released, please let me know.

If you could find a few spare weeks for me, that would help quite a bit :-)

Jokes aside, a bit of writeup how this looks in the client config, how
the client prompts will then look, and how you configure the server would
be nice - just here on the list, so google can find it.

Actually, this is something useful for $payingcustomer, so I hope to
find time to review and test it myself "soonish"...  unfortunately,=20
$otherpayingcustomers are screaming more loudly for me to get other stuff
done first, with a hard deadline next Tuesday...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--FlxqdQUIXA+HMkrt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbWO8GAAoJEB2Cnv7KVigS1v4MAKyldKgyqg0uxHyOFe5UtfiZ
XUp4UkkwjcXa81h2Pk4PUIFBZYfdwN/EUhL5je4JHQgY+u16Tz5Y2k7c13HlNjBg
DW8x8joDpmv1ZmsaTTf7pQFiwRqiAkoRJscDVWej1VPnSEDDD4YY2CXe95WgPMS3
pDauf2r0YlcmgGkPtWCvWKJC5pHgiU7KJNN1AGEMdtLG/cYgccbVnDftSdUx4OtO
2RHeI/fQ9PKxIkbXBcGsMmrJWSK+27YMuRMtz4lJDRwTTr8C/nIEuKJJdcqzZzfJ
djaT6Ft+FOdg306yVd8z4ulfgMKJEU5EWCIiX4hkBocEIKi9O5D8iijRzbzaLMB4
9aqvPJFdnVCa92U21zf+/rqZisMeAo1POxNoT2LxyRN3i298dTz1JC9EkIylhW/t
EzCEosHpXh2BN/ReLkp0423/m5fu7L2jf4NzxaduRKZwxyrT0vrOlRkSwimcJIXW
a56I6vZ9exxacG2NdwpGfo2U6ukTIC6375xmOirrzg==
=lkzn
-----END PGP SIGNATURE-----

--FlxqdQUIXA+HMkrt--

