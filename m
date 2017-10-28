Message-ID: <1509192147.3021.6.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Sat, 28 Oct 2017 13:02:27 +0100
Mime-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/1] add engine keys keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Engine keys are an openssl concept for a key file which can only be
understood by an engine (usually because it's been wrapped by the
engine itself). =C2=A0We use this for TPM engine keys, so you can either
generate them within your TPM or wrap them from existing private keys.
=C2=A0Once wrapped, the keys will only function in the TPM that generated
them, so it means the VPN keys are tied to the physical platform, which
is very useful. =C2=A0Engine keys have to be loaded via a specific callback,
so use this as a fallback in openvpn if an engine is specified and if
the PEM read of the private key fails.

James

---

James Bottomley (1):
=C2=A0 openssl: add engine method for loading the key

=C2=A0src/openvpn/crypto_backend.h | 13 ++++++++++++
=C2=A0src/openvpn/crypto_openssl.c | 49 +++++++++++++++++++++++++++++++++++=
+++++++++
=C2=A0src/openvpn/ssl_openssl.c=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A06 +++++-
=C2=A03 files changed, 67 insertions(+), 1 deletion(-)

--=C2=A0
2.12.3

