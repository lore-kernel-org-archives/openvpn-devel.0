Date: Fri, 26 Mar 2021 08:19:05 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210326071905.GS976@...1296...>
References: <20210325000121.10331-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="75URpteHaMYyx69+"
Content-Disposition: inline
In-Reply-To: <20210325000121.10331-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Deprecate non TLS mode in OpenVPN
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

--75URpteHaMYyx69+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 25, 2021 at 01:01:20AM +0100, Arne Schwabe wrote:
> The non-TLS mode is a relict from OpenVPN 1.x or 2.0. When tls mode was
> introduce the advantages of TLS over non-tls were small but tls mode
> evolved to include a lot more features. (NCP, multipeer, AEAD ciphers to =
name
> a few).

I think the most prominent benefit is "use of a session key which is
independent of the shared secret", so perfect forward secrecy even if
the secret is lost.  The "features" are a nice benefit, but PFS is=20
the truly important part, no?

> Today VPN that use --secret are mainly used because of its relative easy =
to
> setup and requiring to setup a PKI. This shortcoming of TLS mode should be
> addressed now with the peer-fingerprint option.

This is fine, I'd say.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--75URpteHaMYyx69+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgXYrpAAoJEB2Cnv7KVigSBJEL/jr3CWEhN4u9wYIU6Uo8OgQK
Ff2D0BSRUX5Fyh7/ZNYR25lOC7ajqzcImdvB6joNi1xp8AljmrmnLsEYy1ShGMKq
nTbFHL7W4ipWyDq/jZUki+ESa0AHpkqfslYBZxDdviRuFyV2wIQDsEMwGDe5oTka
awgueyPtV3RLGJIMnrwlpqNMabBNwCUlnfKRQBBovjJZZI+nGaHWHFqeD3HFwrLL
HrTmAb/eSJD0it3bmvLiPLaq8oF+mxX9CE6lPHcCjIlkO0cx8kiE/0LSPSvBUvjC
sUFHVeZ99He9iSJ4pDWHP7Q9s99jSgDbf0hFjpNhwQCaVnJm9QK/WafWtF/LiucK
Bfr5cCO3bN9nvcqxXvdE+YKZSMth9heoLpNW7mRIkJ7F/zL6pFOYiMMxCk8vFU0t
H9oQ7jxh5x2EOh6+PQVBF1UyQdz4zuvw8nOEKe/RPZ0Sujt8qOH4atUHiShTtNrj
rSgDKHEl2ucowGxlQPSM814rc1ZFaLASd5eyLsyKwQ==
=Rpa5
-----END PGP SIGNATURE-----

--75URpteHaMYyx69+--

