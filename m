Date: Wed, 14 Jul 2021 10:36:37 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210714083637.GO976@...1296...>
References: <20210525173838.3969-1-selva.nair@...277...>
 <202105270711.14R7BOiW072533@...2054...>
 <CAKuzo_j8+Kp_89t=wxQMtNbav+FuDnzooh=Vt3FtTBUOH8WMng@...278...>
 <20210529094423.GC976@...1296...>
 <CAKuzo_j6pwqyv=mx2v+-_cFP94Rqzf1i6wjHiBY24R_-WPRQLQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2Pms4ABgCg3ihcql"
Content-Disposition: inline
In-Reply-To: <CAKuzo_j6pwqyv=mx2v+-_cFP94Rqzf1i6wjHiBY24R_-WPRQLQ@...278...>
Subject: Re: [Openvpn-devel] RfD: Windows code, UNICODE and ansi
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--2Pms4ABgCg3ihcql
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, May 30, 2021 at 04:12:37PM -0400, Selva Nair wrote:
> > So my "vote" would be towards what you propose - always build unicode,
> > and for older code, assume (or force-#define) UNICODE.
> >
> > Plus, document this somewhere.  On our styleguide page, maybe?
>=20
> I have added a section named "Windows specific" to the codestyle in
> the wiki. Not very polished -- please take a look and feel free to
> pull it apart.
>=20
> https://community.openvpn.net/openvpn/wiki/CodeStyle#Windowsspecific

This looks good to me.  Short and concise.  (One typo - WHCAR - fixed).

Lev, anything else we might want to add there?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--2Pms4ABgCg3ihcql
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJg7qIVAAoJEB2Cnv7KVigSHvML/0H0rOjKCrzjg4E+re1ehQKR
vzERNfIATZiGfIAoNzZmT/WdkVYFi+xYxKcGodSh4SjTOwTyYPrDIIvujfQvhGdt
QwXSu/S33oyg7HQUdDOwwXTBGwY/b0OEtK1yRLqGd+Xsr8tyIRGtQBKPGCHRCOHf
RtafLf8E8ImLXfT/BcgjwzQf96yqBd/VbxjxFbgnK86T/eXSMkMJq/gkMLlnXn79
4ukVVdimy4BsXxGT6Ws63fQ2YPAAAS0hL3loSMVCmN5NhoH4kr+kYayFP/6Ncf06
wm4mnvEh4jGVnh1anif92B6YHf5yr07Yl+aAOUPtri9WhjoCMjeR1WudYrk3YKdG
Jpd0qygw1CBgH81H4IwLvyVxIbQHiSWtHpUXacNezK1ioaCkCYSfao89ENCUDu9j
7dMksHjyHX9igi/wl/YKKxfH0ezBrjShbaDjopJAz3z0Ov1Kluzy0ZbCuBPOVbOt
hi39rWz559cpN4rj/F98VojXergifLAbtWdcuWWnzQ==
=v+ft
-----END PGP SIGNATURE-----

--2Pms4ABgCg3ihcql--

