References: <82384304.20170718084649@...1934...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <3cc66768-4fb0-108c-433d-85599295ed7f@...1435...>
Date: Wed, 19 Jul 2017 12:46:07 +0200
MIME-Version: 1.0
In-Reply-To: <82384304.20170718084649@...1934...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] iOS key decrypts
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,

On 18-07-17 17:46, Gregory Sloop wrote:
> Does anyone know definitively what key encryptions/decryptions the iOS
> client will properly handle? [And if there's any difference using unfied
> vs non-unified setups.]

The iOS client is not part of the current community development, but
maintained by OpenVPN Technologies.  You could try to get in touch with
them.

That said, I see no reason why it could not support AES-encrypted keys.
The 2.x community code base even uses AES-encrypted test keys (PEM, not
PKCS12), and those work with both OpenSSL and mbed TLS crypto backends
(just tested as for back as PolarSSL 1.2, but earlier versions probably
too).

-Steffan

