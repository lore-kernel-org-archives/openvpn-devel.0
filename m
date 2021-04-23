Date: Fri, 23 Apr 2021 08:13:39 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210423061339.GR976@...1296...>
References: <ZIKZwAKGvWmbJ-kO_eJLJtMC987pVCbt6uMCrILdSuhQ6AcV0SVrQMn1r2xab_2K8ncLE47H_VO9gZqAcCSP6HkcFWXOKTuXXqhRXETdFwU=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Ba5PDGIzcHC57qat"
Content-Disposition: inline
In-Reply-To: <ZIKZwAKGvWmbJ-kO_eJLJtMC987pVCbt6uMCrILdSuhQ6AcV0SVrQMn1r2xab_2K8ncLE47H_VO9gZqAcCSP6HkcFWXOKTuXXqhRXETdFwU=@protonmail.com>
Subject: Re: [Openvpn-devel] --tls-crypt-v2-verify env $daemon_pid
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: tincantech <tincantech@...2282...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--Ba5PDGIzcHC57qat
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 22, 2021 at 09:02:30PM +0000, tincantech via Openvpn-devel wrot=
e:
> I am requesting that $daemon_pid be added to the --tls-crypt-v2-verify en=
vironment.

What for?

> FTR: $daemon_pid is currently undocumented in all three manuals.

It seems to be an obscure and not very useful feature.

"Programs that are called from OpenVPN" can find the OpenVPN pid trivially
by calling getppid() (or $PPID in shell).

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Ba5PDGIzcHC57qat
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJggmWSAAoJEB2Cnv7KVigS+BsL/jidqAcAVKtv6JeNihuBRMc5
B0FAVSVCd/VxevbPFhwGsomJqUB9JXtOKtHQ4NvlpsGAcTEBotAk7HUii3br1cTz
UC+qpttDLMwMg9YY5AwK9/p95mZAPdxTDc047O0gQ+TbDsAupAy4mhXjeZOxdN7e
Efd/UA1AXoDA66rdL1ofEAsjZRp1JvjFPe7hrKjzkzn1ksWe+kuIP2HbhtAuTttX
B7kk3Vodl0QLPsBedPXCVB+lWy+kaw3PXT02ONx7orV30ivvCMTfbsNFy8ezZl60
g8HSa53pzLqUaKIvp4WzQrd+Bm1t9Tf1ZcBcGgLGAV2K41MW10JToZUg4GQbbOkn
V+29/xlAtbaZ/RtHYrIBRZHo2tQz63cd20NuHYcBc6yVMAaNJMBExJFdoEr6Ju0K
j3fSzVVjbnwreI4DFjAjxZUKoskt+YPERSGgneAYTLEdepzyCOxWOp36XVTukcz6
pjoi22ubEaF570mY3npgOoNau9uKNp8WcwIp6wjxrg==
=kV1Q
-----END PGP SIGNATURE-----

--Ba5PDGIzcHC57qat--

