Date: Sun, 25 Dec 2022 00:13:56 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y6eHtDvs+r+A8BSs@...1296...>
References: <20221224194253.3202231-1-arne@...1227...>
 <20221224194253.3202231-10-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="H0npTI+9o/JyGgm2"
Content-Disposition: inline
In-Reply-To: <20221224194253.3202231-10-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 9/9] Ignore
 OVPN_DEL_PEER_REASON_USERSPACE to avoid race conditions
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

--H0npTI+9o/JyGgm2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Dec 24, 2022 at 08:42:53PM +0100, Arne Schwabe wrote:
>          buf_printf(&out, "%s", mroute_addr_print(&mi->real, gc));
> +        if (mi->context.c2.tls_multi)
> +        {
> +            buf_printf(&out, " peer-id=3D%d", mi->context.c2.tls_multi->=
peer_id);
> +        }

Do I read this right, this will add the peer-id=3D%d to every single
log line in p2mp mode?  In DCO mode, this might be a relevant information
(... for things related to DCO), but in non-DCO mode, it's mostly=20
"uninteresting", no?

I'm all for complete log information, but making the lines too long
isn't that helpful either...

(The other part of that patch will be looked at, when 4/9 has survived)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--H0npTI+9o/JyGgm2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjp4e0AAoJEB2Cnv7KVigSWBUMAKf5MpKxSAseTzvZKW8ODb4I
YPlKtW+k30K/KeHYinlCJ9RZYUOGW7LjbM7adfsERE/nelgBG6m+n9lsNqh4d8Lt
e5jAsqRHxo2CO9vJpBQAflQ6ixRoyEOdu3ZOPK+cXmwX5sIqJnVPQJRF4Lfv4VwE
77+DqS87ewiM4WzHGXfJ9O04MDIVymWwSrHmSest74DDaF3WmCpy93a1RP9YZ3cc
IAGDhxCxyDXn7HTSicE5OheGp5ndgxiMG/Fnx+3xDORIBGA/Wfg443WIMzNUQ+Dd
iAFrX86/2ipttA8y/Xai6umqODIJjPhdIjrKMuHirIjRKU308/Zjx4Xu77eiPWwq
OLrY9yR+c1F2RyEi4fnZOj3dMMo+rdgMTwAuJCryeLC6Om7QL632FFZs6AGyLovO
JR9CbHAjeWqXqaQC/MDZ1gFimX/CrsCF0+8sCsWlsA85W639g5NWl+M0QIQlLUGg
MumKhm7FG4XFbcL1YJsvRbqpofdWQ8JvqGEvftMbWg==
=EuG5
-----END PGP SIGNATURE-----

--H0npTI+9o/JyGgm2--

