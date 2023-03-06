Date: Mon, 6 Mar 2023 10:24:24 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZAWxSEpBIEEM5Uys@...1296...>
References: <20220909195902.2011798-1-arne@...1227...>
 <20230131135248.3574741-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ChL8yRMa9ADJUTy5"
Content-Disposition: inline
In-Reply-To: <20230131135248.3574741-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v7] Dynamic tls-crypt for secure
 soft_reset/session renegotiation
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

--ChL8yRMa9ADJUTy5
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jan 31, 2023 at 02:52:48PM +0100, Arne Schwabe wrote:
> Patch v2: fix spellings of reneg and renegotiations.
> Patch v3: expand comment to original_tlscrypt_keydata and commit message,
>           add Changes.rst
> Patch v4: improve commit message, Changes.rst
> Patch v5: fix spelling/grammar mistakes. Add more comments.
> Patch v6: consistently calld this feature dynamic tls-crypt crypt. Note
>           this changes the export label and makes it incompatible with
>           previous patches.
> Patch v7: also xor tls-auth key data into the dynamic tls-crypt key like
>           tls-crypt key data

I'm a bit late to the party, apologies for this.

I did not look at the code ("Heiko has given it an ACK") but threw it
into the server test framework, where the new code "should" not have made
any difference (automated connections are not lasting long enough to hit
renegotiation at all).

Unfortunately, v7 on top of current master (commit c333a0c05f9d454ef)
fully breaks --tls-crypt-v2 connections, *if* the new code runs both
on client and server end

...
2023-03-06 10:20:03 PUSH: Received control message: 'PUSH_REPLY,route 10.20=
4.0.0 255.255.0.0,route-ipv6 fd00:abcd:204::/48,tun-ipv6,ping 10,ping-resta=
rt 30,route-ipv6 fd00:dead:beef::2001/128,echo,route-ipv6 fd00:dead:beef::2=
002/128,route-ipv6 fd00:dead:beef::1/128,ifconfig-ipv6 fd00:abcd:204:5::2/1=
24 fd00:abcd:204:5::1,peer-id 1,cipher AES-256-GCM,protocol-flags cc-exit t=
ls-ekm dyn-tls-crypt,tun-mtu 1500'

(so the server wants dyn-tls-crypt)

...
2023-03-06 10:20:04 add_route_ipv6(fd00:dead:beef::1/128 -> fd00:abcd:204:5=
::1 metric -1) dev tun0
2023-03-06 10:20:04 /sbin/route add -inet6 fd00:dead:beef::1/128 -iface tun0
add host fd00:dead:beef::1/128: gateway tun0

(ifconfig + route installation is done)

2023-03-06 10:20:04 Assertion failed at tls_crypt.c:83 (key->n =3D=3D 2 && =
other->n =3D=3D 2)
2023-03-06 10:20:04 Exiting due to fatal error

*boom*

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ChL8yRMa9ADJUTy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkBbFIAAoJEB2Cnv7KVigSHmsL/AkzPT2Ierj8n+qbGKOPu+Ls
G4LUvgSwQVTWwIwOBtVHOWZPlpQNQDvX02PDntJAUfTsFAxLFaNf6hoKvPSoO3sf
O8khVEK/brwoVPIp/MjQUg929T9CurWZCJZyFeCBCJlI3WjvJe7oPBKAjbWRv8aS
ySsxnWPjtEKR6cGDqkpDycfr6HVf7GspwEUfAPK7quS5LSdhR5ddH69OuHyGqKAc
26jQBVKL645XTJRj3LGnhK4CMkC3TishYvu7toFAyG3bP2OhQCvwPkla9DnnezSb
Ip7s3XIw79bemyzX4tVzUbqqcMlMZ49OsrDt9bEg6KP2wekNG1a3kVCsbo5vuQ+b
jTelisaQek0A8TIoGiFYTwVQlMljhggNZ5Jfh7kb+d1K2F9tS6Rptx6IKdm33Qkp
bs9sF6QTf3Mh2iTglCenmZ/BsTTYUzRBhnlQ5cp7iVUOAD3cui+9AYk5wDUVvUhI
k9r7BpdX3GrLQMxvQ0OattrnT5r5pZkz8QvkwUMQ8A==
=6nwF
-----END PGP SIGNATURE-----

--ChL8yRMa9ADJUTy5--

