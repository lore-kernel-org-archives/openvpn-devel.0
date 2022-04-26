Date: Tue, 26 Apr 2022 17:02:04 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YmgJbJeBr96zXV0Q@...1296...>
References: <20220422142953.3805364-5-arne@...1227...>
 <202204261459.23QExTfd099794@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2XfPrWUOCpx2YW5k"
Content-Disposition: inline
In-Reply-To: <202204261459.23QExTfd099794@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Move tls_process_state into
 its own function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--2XfPrWUOCpx2YW5k
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Apr 26, 2022 at 04:59:29PM +0200, Gert Doering wrote:
> ACK from Frankf, but I've done another stare-at-code and submitted
> to server + client tests (all good).
>=20
> Uncrustify complained about 2-3 minor things -> adjusted (so possibly
> there might be conflicts later on).
>=20
> Your patch has been applied to the master branch.
>=20
> commit f1b002fb19cc99f1a527cf95b343b5f082b78045

This is the commit ID "without uncrustify".  The correct one is

commit 9a7b95fda56127df6de6fe7c60e08fb5b67a9919 (HEAD -> master)

and the latter one is what will be pushed.

Sorry.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--2XfPrWUOCpx2YW5k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiaAlsAAoJEB2Cnv7KVigSj7cL/2aF/DCrigmdQMIqQWWLkIre
5rlt4QQbi0LuR4DR2WoawKblSepKVE3kauwKcc0ChgRtWVpMbzIDlBr/SY4cieEz
nYGTsEgN/HrjBlGRj+wmMwuwJPDgR6+KT9IGid2FNooiqShL0hs/7utkwnEw3Gmi
nWUB5n8PL1s1RRRGHuUUt/KwWe5eTiV4FsS/NdzypRnOOf5fYdJoxk8dZd+nIJcf
o8LuTYQQJZxYZNr40u6sLhPR+l8mgIQxfIIy7AuRWuKk3Bprohq1WPMPsVY4aYqo
PIohvshWV/qjFCzozkrfUkPApWOL9P7K6y3b52rNCogU+0PxFKuaF3FvhQzPmb1e
FCxY4rd7isaYmIRu4NI691KC8nlEYoGWeEvzyif0ErOJQ8eRyiPrMwwdEPLe0kT1
PTjy3ka6jqULONYYlemKfS68pjLMOh3kHfqZPRcySv4yMrWGP2JLRudX3gua7wNT
mePjmy2VRsvWdUwBxtHR8WGK4OlabTHjbswDXFAKjg==
=z9Xb
-----END PGP SIGNATURE-----

--2XfPrWUOCpx2YW5k--

