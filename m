Date: Fri, 24 Jun 2022 13:16:40 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YrWdGK8/602Xnk90@...1296...>
References: <20220621161649.2872985-1-arne@...1227...>
 <20220621161649.2872985-5-arne@...1227...>
 <YrWTg6ZnqgtkezEP@...1296...>
 <b00bd799-21b6-ebb3-3a70-5898cc20206a@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="88dcYQJDmNBSqvUV"
Content-Disposition: inline
In-Reply-To: <b00bd799-21b6-ebb3-3a70-5898cc20206a@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 5/6] Change default MTU in server mode
 to 1420 and push it to client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--88dcYQJDmNBSqvUV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 24, 2022 at 12:52:23PM +0200, Arne Schwabe wrote:
> I still think this is a reasonable change. Yes, it might break in some=20
> very obscure setups but for those setups, people can still set the MTU=20
> back to 1500. Tap still uses the 1500 default anyway.

It will break all setups that have openvpn "in the path" and something
else that throws away ICMP fragmentation required messages.

Like

  Host A ---(1500)--> OpenVPN --(1400)--> Host B

if Host A sends a 1500 byte packet with DF bit (or IPv6), the network
stack on the OpenVPN server needs to return an ICMP "packet too big"
message.  If that gets lost - and there are too many folks that do throw
away ICMP packets - we have a black hole.


We see this in commercial VPN setups as well - having a large-enough
MTU for the occasional UDP (or whatever else) packet, and ensuring TCP
packets are of the desirable packet size by means of MSS manipulation
is more robust.

So, still NAK on changing the default.  Turning your argument around:=20
whoever things they need this can enable this on their own.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--88dcYQJDmNBSqvUV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJitZ0YAAoJEB2Cnv7KVigSO7IL/R1QhQoj1Grc0nBfZG3oYLZ4
iQQDmSC6dqP95yBf0VgywcQjHPgnhSnA4DHmirw7CGQnwBwHZB4VjIJxMGzUi8W3
RMe5bKyd8pnH3iscxw6OSZm2xMRbEiilF+m56HCCgDCRR3W0l5oFDHVtrypJW1BX
TALu6dHnoWBKx28innLCdlwoAyA01M4VWokj02CIbkk+ye7BM0+nZ4oMdSEni39x
A7rHYAJeBvyEmvtoUehXkkWHKEEwuoyi/CDvNXzCXBDE4v+JVBjWwnkwyrdYkD3+
GQcdV48NPfwIj1XTU4eOwAMMRk8DnAZZChLP8Aiy87lcfWFv08GzLm+Fn0NM3o7D
Jr8/M672tBQ4e0o4xbOGae1CEFWBArP4XHg/pyDAsqwVOU4Ick/COotYeeIE33p7
JyEzLPfu/VDdmx5Mh/bsQaCPmJCOyRhf4HFE/Sq2mlBWycMDbNLB7J5MiRRfkgtj
/QoE39xSQ/RLyXQRK2aP6xR6ST9kf/qRSnyCj+66pQ==
=Kssz
-----END PGP SIGNATURE-----

--88dcYQJDmNBSqvUV--

