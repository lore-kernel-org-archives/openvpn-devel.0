Date: Mon, 2 Nov 2020 19:22:43 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20201102182243.GT976@...1296...>
References: <ed56b8ea-00b7-eac2-7ab7-9bf9f21c838a@...2080...>
 <56ed6984-aba1-ffeb-8cd7-7591b75dbae4@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7cR/5cY1igHxmpEa"
Content-Disposition: inline
In-Reply-To: <56ed6984-aba1-ffeb-8cd7-7591b75dbae4@...2080...>
Subject: Re: [Openvpn-devel] OpenVPN 3 Linux client - v11 beta released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--7cR/5cY1igHxmpEa
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 02, 2020 at 03:00:58PM +0100, David Sommerseth wrote:
> >   Then the imported configuration profile must get the DCO feature
> >   enabled:
> >=20
> >       $ openvpn3 config-manage --show --name CFGNAME --dco true
>=20
> So I managed to introduce a typo here, this config-manage operation
> should use --config instead of --name:
>=20
>         $ openvpn3 config-manage --show --name CFGNAME --dco true

Yeah, right.  The difference is quite obvious :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--7cR/5cY1igHxmpEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfoE5yAAoJEB2Cnv7KVigSKJ0L/0ie7IloA6eotjARzamEouFb
XngGF0wfHRPobvR8oz2DjGWlLI7VcM6p0Y1tatAinnaS9c8PZRP/YBlzXLst3tPb
xTjcgpLC/Hcy6DauED6dvnAECQfGXcLTS/MI4AgWWAxNFCtvp1dIafJGVLE24Smj
qXJtJcImjkPFNVhm7jFpYRTTn2MkO/ODxO33q5FPYBlyC6d5sUYBTOvvVPM5+5MC
0JVGRZclYsjFYEbgOfZc+sXnK+ls9iGO+IaZ2qZWxlZRuBkmztCxMDEsO+Z0pxsa
/SYnlkPvl5vPv0fJwvFXsvbZbbLkioMkdfvmc+370gwAg8YGYXdMavvBWLt6I/+F
lG9bJGN5ffJWau2lgIWSXQtTcp9/zVW7kJa51U9eTcMFJP0IgtC7MSRC5ie/gyem
79MQokHlgU+fnoz/ZdOw6IdLt+Si+pgpiSdguu3nMNMi728n++9t7LFmVUzkHOPF
RQ7erlSMZ5YwQYzGMLjBPGqageT9byQYgKfMrqADQw==
=otBX
-----END PGP SIGNATURE-----

--7cR/5cY1igHxmpEa--

