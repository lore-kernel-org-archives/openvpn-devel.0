Date: Wed, 11 Sep 2024 07:58:42 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZuExkhDgOb_xFzsf@...1296...>
References: <gerrit.1706186293000.I01e258e97351b5aa4b9e561f5b35ddc2318569e2@...2715...>
 <20240910163411.23119-1-gert@...1296...>
 <0c73b044-7397-4f85-9457-1d1c9d5b2019@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="shkOuo9azdpZr5PR"
Content-Disposition: inline
In-Reply-To: <0c73b044-7397-4f85-9457-1d1c9d5b2019@...1856...>
Subject: Re: [Openvpn-devel] [PATCH v11] Implement support for larger packet
 counter sizes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--shkOuo9azdpZr5PR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Sep 10, 2024 at 09:51:45PM +0200, Steffan Karger wrote:
> TL;DR: I don't think this should be merged yet.
> [..]
> So if we want to improve things for AES-GCM, we probably need other
> optimizations. I have some ideas, but was hoping to do some research and a
> write-up during the train ride to the hackathon, so we could discuss it
> further in Karlsruhe.

Thanks for having a look.  This ruins my planned work for today :-) - but
since we are not in a great hurry *and* Karlsruhe is just next week, it
will not harm to delay for a few weeks if the end result gets better.

Just for the record - I've done all the testing on v11 yesterday, and
it behaves very well interoping with "older peers" (no DATA_V3) and
also "falling back to DATA_V2 if DCO is active" (as there is no code
yet to do V3 with DCO).  master-to-master negotiates DATA_V3 and still
pings :-) - so, the code we have is good to be merged, if we decide to
keep it that way.  If not, I know what I need to test and how.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--shkOuo9azdpZr5PR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJm4TGSAAoJEB2Cnv7KVigS+jAMAK+FRTv7kAmoppk6efMnlBqA
zjdvzrWT+SsZ8UmUhHFBhExbe6cKuuE0C8NXQm2QLQ/hnuHNCcnTokoopAO9YRXZ
AHwirpgpZ0J6uMYEekyVfn5tyK2fMdnc/KFshW16cmHylfxXxaauk/k3wDpY0Prk
eN3apvAlK2IcE+CSTCTI3ht1Xn9NPT4ep1oJUikrjbvhfexsE+am2Zosd8eJNt6n
d2rNFiFThZOvECA8LfQrNWGjUXt5SjmsBu7msDrkj1r7oi1D6g4gG4d4DKDUfjXX
GJ59xbFZHY1bKUMtbQgu9bVnsRNh+maLKoygEeV+jnIrzEykrO83ICEEC8/LOYkb
iU8MnYLMjvB4DB+1tg9BVW3WKvQncsKymsfd4wu7lfOG9UzYUcX5mJWScl+IbFd/
PvxWsxnltKyem7RAbIzn2tI6BS43ZQvSqtNqrhfy7ZykIUV+amrKMqHWfSinxJs3
IbmaDWg41vbKSQ2ZF3iRfRfrIJLmIJUKMqrgrNG1BQ==
=EqOu
-----END PGP SIGNATURE-----

--shkOuo9azdpZr5PR--

