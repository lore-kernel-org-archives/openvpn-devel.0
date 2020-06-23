Date: Tue, 23 Jun 2020 19:19:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200623171933.GI1431@...1296...>
References: <20200622232319.8143-2-James.Bottomley@...2316...>
 <202006230628.05N6Sa3g001325@...2054...>
 <20200623072123.GA2034@...1296...>
 <1592917531.4768.4.camel@...2316...>
 <CAFHpkQF5tz91P_UJxMuNCRDUYodw8QPV8=h8mmkSTHOUH5AdfA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8hByDO4Wx/HKkX9f"
Content-Disposition: inline
In-Reply-To: <CAFHpkQF5tz91P_UJxMuNCRDUYodw8QPV8=h8mmkSTHOUH5AdfA@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add unit tests for engine
 keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: James Bottomley <James.Bottomley@...2317...>, Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8hByDO4Wx/HKkX9f
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 23, 2020 at 09:42:51PM +0500, ???????? ?????????????? wrote:
> apparently, it fails for some build on travis
> https://travis-ci.org/github/OpenVPN/openvpn/jobs/701158156

This is the reason why James sent this new patch - what we have in
master works but fails "make distcheck".

[..]
> > > >  - Linux with mbedtls (does not try engine tests, good :-) )
> > > >  - Linux with OpenSSL 1.1.1, works
> > > >  - FreeBSD 11.3 with OpenSSL 1.0.2s -> v6 fails, v6 works \o/

As I've tested the patch with 1.0.2s, I can confirm that it supports
engines, at least "enough for our needs".

(Haven't had time to verify that "distcheck" works now, busy with
other issues to wrangle today)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--8hByDO4Wx/HKkX9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe8jmlAAoJEB2Cnv7KVigSZ+8MAKSvv0Z6SKcK1Q+ZWlzg4NkN
2YGW4v1kZJU1/xFXWYIKFcllAaEjVvKZLG4H2zaNPUjXCawgdPyY3Y1YcqhtU4gr
4x2Rz1ZHg15TfTeVHo+o90BSpXsC7tdaRJ0V43fAF7raoURAKG3AEvbv38H0yjfY
k3O8fa/vJVPFVg7RjsUNdPPH50c825GUP2FvEGBP4T9nDTFyhEo7aw0s1zNzv8pQ
njPcbItYRCe/FeoSRYWL4w8rQ9b2rSA9qH9/ed1JwXn7ztjLR88HLSRS4eJA+e0e
pkltAfBJIRu0zoktiddABSKjbFmY97ZfgQzAffVCBKSnA+SkQyqH1mW956G+fACe
GtL2aiGkn8mHpivBaRTPQTFZpMeqxUVnfDObGn/u5j7eqfqq339DcOIRo3JVtz3H
w8CyMS4+9e7ndAkmgAnfwOKRlOiHeuQNT0WOaJmEzxPvHSxB4t/SEx4obtFW/Z/E
/mo38gtfMzmvQeZLDUl2cEwsUxWgCmELcYfkrlKQtw==
=TlCY
-----END PGP SIGNATURE-----

--8hByDO4Wx/HKkX9f--

