Date: Thu, 18 Mar 2021 12:39:27 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210318113927.GY976@...1296...>
References: <20210201174310.22153-1-arne@...1227...>
 <20210201174310.22153-4-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="k6tYLeJ9xhxAZKR0"
Content-Disposition: inline
In-Reply-To: <20210201174310.22153-4-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3 3/3] Handle the unlikely case that
 PRF generation fails
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

--k6tYLeJ9xhxAZKR0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Feb 01, 2021 at 06:43:10PM +0100, Arne Schwabe wrote:
> We never had handling of this failure condition. But should it happen
> we can now handle it.

For the sake of the list archives: this patch was folded into the
larger "Prefer TLS libraries TLS PRF function, fix OpenVPN in FIPS mode"
patch.  So it is already in master via "commit 06f6cf3ff850f2".

Tagging in patchwork as "Superseded".

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--k6tYLeJ9xhxAZKR0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgUzvuAAoJEB2Cnv7KVigSGPIL/0DVQLP8zfkirnykNMQHiDxs
uCZFQfjFzfpc3poBGYRA/TDUzA1njJAtTigHLdhZqjAQ6V8rNZSEPPE+Bg/gsZTu
mWhL1J/6srGcwwfHJVW0xNjDln1rxFOFd4sEmHewUKJaJhLVObLqwqStbvsEwZKw
CirW12d3fIn9kNhURU7m+84Ytm1vwNhsqrvLElgrmWWezoZrLry1CUFJs8Tu9tiV
0r//1mmCSM1PI7VqaIFOB248NjQauPZxl63jjI4b7Ff1nXvHxviilcyZtiGHC24G
grx7EID+ig0VkV7X0g7oEUPT5z0+C+G+T1sARWfDOqjhpF5JCPHVODyxOuI1snXj
HWWYalJklu8CxamyL7JxhtMfdSGA+v386B69LvlfUOVPtRDVF9oei1yadR7SJcml
nVG+MQpnb9VXPOFdFPUZpoPr+rJQ4mCf/oCX+CBNBvfkJvbw+mNV5E9rDyG8wL2P
1iC7hiZJYUPIni+1hBVaAUjyaftEH6duOpeW+iNpTA==
=RkwZ
-----END PGP SIGNATURE-----

--k6tYLeJ9xhxAZKR0--

