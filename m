Date: Wed, 8 Jul 2020 13:15:10 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200708111510.GV1431@...1296...>
References: <20200707121615.15736-1-arne@...1227...>
 <20200707121615.15736-4-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="d/OlUz6aKGytC/ix"
Content-Disposition: inline
In-Reply-To: <20200707121615.15736-4-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] Cleanup: Remove unused code of old
 poor man's NCP.
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

--d/OlUz6aKGytC/ix
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 07, 2020 at 02:16:14PM +0200, Arne Schwabe wrote:
> Ever since the NCPv2 the ncp_get_best_cipher uses the global
> options->ncp_enabled option and ignore the tls_session->ncp_enabled
> option.

For the record, this breaks "poor man's NCP" for big packets - tested
with 2.3 client and 2.4 with "--ncp-disable".    Session is negotiated
fine, key material is generated perfectly fine, both sides agree on
ciphers, but if I do the "ping 3000 byte test" I get this on the
server:

13:00 <@cron2> Jul  8 12:59:19 gentoo tun-udp-p2mp[30281]: cron2-freebsd-tc=
-amd64-23/2001:608:0:814::f000:21 TCP/UDP packet too large on write to [AF_=
INET6]2001:608:0:814::f000:21:35389 (tried=3D1544,max=3D1542)

so it seems to get confused about frame size values.

No --mtu-disc involved, no --anything-mtu configured on the server (=3D all
on defaults).

I do remember that this is scary stuff all intertwined...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--d/OlUz6aKGytC/ix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfBaq9AAoJEB2Cnv7KVigSToMMAKb25sVbpLy4+KJf30Thvmu8
bxGsjAmL1uXDdh6S0O+6AC/7k3/7gCXbfGdlEroBZ4HXpllhoZUB0oYxZD5TCsEa
zGWh/Gv8mVG5QwI4NMJYzYiR/dXeZLvheqPTtleYlGtw8KHLcvqZzkROA1VmO8R2
EG9yjY02UuWjQSBmkBrXKQu2P39i9F5f3zr0doXjdmu6W8ErBLmhmZjgD38NNIn1
WwZ/B1fZJcqhlxC2ZOmarxrOkQsML+u8xhrBu3Kkl1C+gZ3mc8wLzN0Sinq7wqPZ
yQv2BMBL0XaXxLhxQJ1ykuh5YBePwtA56r3JGuZv/KZXudFPlLMHshjQdJxMu7Yx
94hV+SEBEhzmDAfQ6u1SUd35dsMnfmydBOM9yrS4LZh78Yzr4oeE3DfC2WdaUmsr
tlfNmNV7oPBIkvuK9XszB0izXNZ4t6AaQuCiSVeKBOPOVieSUA0ojl1a1owjz4D8
6rQZXvv8+B2/VYL5Ap1xii6yVZWLotAmiw4OhtRrLw==
=qdYF
-----END PGP SIGNATURE-----

--d/OlUz6aKGytC/ix--

