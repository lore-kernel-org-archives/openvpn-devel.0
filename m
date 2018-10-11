Date: Thu, 11 Oct 2018 13:56:47 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20181011115647.GG962@...1296...>
References: <CAGyAFMULV02g3gyCbvQ1+L+cMdE4UZMmzVfey-T1g4Y0NcmKeg@...278...>
 <1539174377-2678-1-git-send-email-lstipakov@...277...>
 <20181010185023.GD962@...1296...>
 <CAGyAFMVqTChKmpfTY0XhdJB+q030LkxDCsitEwVrwV2Ui8bJdQ@...278...>
 <20181011112317.GF962@...1296...>
 <39371514-ad3a-0768-54d1-459457877e37@...1435...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="b4TJccIV73PFtYC8"
Content-Disposition: inline
In-Reply-To: <39371514-ad3a-0768-54d1-459457877e37@...1435...>
Subject: Re: [Openvpn-devel] [PATCH v2] options.c: fix broken unary minus
 usage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

--b4TJccIV73PFtYC8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Oct 11, 2018 at 01:52:37PM +0200, Steffan Karger wrote:
> > I know that Steffan likes using size_t for "things that have a size"
> > but I find it a bit questionable here :-)
>=20
> So the underlying problem is that "further down" used int to store
> sizes, but since that just is the way it is and we shouldn't pull in
> refactoring the code base for each small change, I would say either make
> both 'int', or make both 'size_t', but without changing the types of
> struct frame itself.  I of course prefer the latter ;-)

Adding or substracting a size_t from frame->extra_frame (which is an int)
will quite likely cause the same warning again...  so I'd argue for
"make it all int, and be happy with it foreverafter" :-)

(And possibly revisit our use of size_t... *cough*)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--b4TJccIV73PFtYC8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbvzp/AAoJEB2Cnv7KVigSC6kMAI4zhB6CRW+6VhILL0qOgM0J
rZApkNxPU5wfInkTcZAcZRN+bxySM0jZ2F3oj/HEORpeD3f/AmYv2bvJdKPMPstG
/+IolujQFT1++V8f7O3Oaokfu8kKyiBwqWhlDzxE61K5HlJy2n0B7RzXTDhmBgbV
Vc04Tp1p9Nm8ajheYTxYH3REtSDdWvZ/e7/ehc3V/riOpJY+wdoSeSsC59AQ6ZDM
tI2oa3hoeay5MR6mUlvbY8kUm8CV+lLB5097J63nF6yQCq0S7hZwGRYelT0axTQN
7z8hA33HmwBEcPabgVQ9zjkFtl3ar4SXfu2uFcxfPhFO3iCgFo2784JtvDpQXCKm
G7syz6H0/iVPPtQNkqg5y710w1cKP65HHIpVoXf3eUm7eTKtt/SqNCUyXcMpfvMV
RYZWbjZLvbFm+/Vh+JE69WfEadlEJDIh4H3XDEX76QKIkBBaHWR+0UfTsr3+aL1X
kGaP9gjqazZDzjYzp9OzHt3qGclsSnoCQTo+Y/2yCQ==
=+o9V
-----END PGP SIGNATURE-----

--b4TJccIV73PFtYC8--

