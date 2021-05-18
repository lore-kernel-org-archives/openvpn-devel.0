Date: Tue, 18 May 2021 14:41:57 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210518124157.GO976@...1296...>
References: <TGB05j2zTgH3-jDRcHubPFmTAQrG1hHgF4XtWb8Ytc14RY1RFusKL-QJFkyzi6H849DfuoutjhVZfRkiqAhGyHs9lLnI5tnWKDpaOrRfQv8=@protonmail.com>
 <20210517153133.GH976@...1296...>
 <25d67947-a760-3e9c-7567-2e1b29837e0a@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Y8YDpR2YEIbalRv4"
Content-Disposition: inline
In-Reply-To: <25d67947-a760-3e9c-7567-2e1b29837e0a@...1227...>
Subject: Re: [Openvpn-devel] Feature request - Allow comments inside
 <peer-fingerprint> markers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, tincantech <tincantech@...2282...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--Y8YDpR2YEIbalRv4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, May 18, 2021 at 02:19:10PM +0200, Arne Schwabe wrote:
> We could implement it in the hash parser to skip the lines starting with =
#.

Ah, right.  This should be very easy, actually, without affecting anything
else that does <inline> stuff.

Let's see if I can find time :-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Y8YDpR2YEIbalRv4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgo7YVAAoJEB2Cnv7KVigSYagMAITY061l1hEpXhg8ZBmf/OA6
h5RZ/9+/nlfxBRjQVaQrs6X6MWrJiRjsNr0dU5kauV9nw/G8Ev8/iNJyrHaNBpQ3
59idKJtSz9O8ruuKjprNNui5nUCXPyVbuDQQdqildW++5mcA1J8Qls6BVxnAIWwA
ulOQwpRFqo5qQ2arl2T3HIIoarm2XBaKrTESk2mDgW1bmWqWw8ySEejn/R/EzVU3
aIFi2W3zVqXwlwsK5oIl8gZoJApKsN6XAqqo1gvVSpjXUBtqO43WL8hTi79qljyE
hBbv70HA/CYMPNHoWcVI+y3JTJhmcRWSDiP4fvHtRg4CJyq1OBmljpfWmwLeXaWj
QL+eSbM1cbmH2X6TOmtCJ4diwDxnC3lAa7POsGWadMAqwER0i1X8WKgSTDT7UXG8
svsmYNiKnL6IzFhDChx2s9NkLpiTXA5AMUFU+LqhH0p9GvPMdoDvHDm0scBlZAJN
CPhYZP1KVHRLjrhg/3zmWCBOkw5yWKBVUhoZn1T+AQ==
=pTbm
-----END PGP SIGNATURE-----

--Y8YDpR2YEIbalRv4--

