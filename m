Date: Tue, 18 Aug 2020 08:32:12 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200818063212.GW75094@...1296...>
References: <CAAWBBYPw=TZg1wftWZL5ABKVWkp7=6hpdaumLN2D24Cgr-E4pQ@...278...>
 <20200818062335.GV75094@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="eu8nj/18vubUeVCi"
Content-Disposition: inline
In-Reply-To: <20200818062335.GV75094@...1296...>
Subject: Re: [Openvpn-devel] 2.5-beta-1 Wintun requires SYSTEM privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Rafael Gava <gava100@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--eu8nj/18vubUeVCi
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 18, 2020 at 08:23:35AM +0200, Gert Doering wrote:
> This can also happen if you run the GUI with admin privs (because then
> it will not use the iservice *but* openvpn needs *more* privs than
> "just administrator", and wintun can not be used at all).

Continueing this thought: I think we might want to abort earlier in
the OpenVPN startup in this case, that is, "wintun and no iservice pipe".

Lev, what do you think?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--eu8nj/18vubUeVCi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfO3XrAAoJEB2Cnv7KVigSUIQL/2MbEuj+aXspwFg6PCaiKNhW
JNzvrJ6k91aaOp3JOFuDpUE++fRVk/xoaAx6wGYa1/ZNK9Tj0YprD2p2VgR3qteg
ZWzfFSgk8wqTygbtv8BHGhnbLO0FRf1VVlDgQJXs6mGHULFViqG8dqSpG9wR2mis
vj6Qb0ppKPU1tMSFxK5tvXU7VsCeZs9nSzG8wV/LL1bVZcr+YQAIcYZWqZyOFL8p
9RjSNmJx1MbswMpsZnxAq8Kg5OTyyIsnahHw/kS1IA5Ie7WwXETcH+ZfKQ7yQ04C
Da7qcJEI/Pq+h5ojt9uCWTDLtZ1xO72n4LCSBRB9didznnQXz9zjt9zZZXTeOPGv
Cbk3IgEVk2gm0THjHlX+NteVH7mDtdKYdso2pNbuTPH6FRqIIb6oxQkCbMOzN6fH
TwBlJ3VUljUyxXfv1axCxycMzH6Q4lq/6fsSU8eivu3GP+6srY/K0ADu/GkWvnhN
MIK+8sguGz/spXAIrgUc7sV8oS60BjvB4lmJkQPaNw==
=V/MR
-----END PGP SIGNATURE-----

--eu8nj/18vubUeVCi--

