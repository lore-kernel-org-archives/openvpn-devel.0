Date: Sat, 1 Oct 2022 19:39:10 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yzh7PoOsv3+fugJb@...1296...>
References: <CAEBHyEV1TvxTF5rPg8NaUkd8D80er-K50TYf_f42smwCgW8-Wg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="u0x26foP+kUk/CeB"
Content-Disposition: inline
In-Reply-To: <CAEBHyEV1TvxTF5rPg8NaUkd8D80er-K50TYf_f42smwCgW8-Wg@...278...>
Subject: Re: [Openvpn-devel] Multiple Openvpn servers using same port + Nginx
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Daniel Lando <daniel.sorridi@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--u0x26foP+kUk/CeB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Sep 30, 2022 at 05:20:52PM +0200, Daniel Lando wrote:
> As described in this
> <https://github.com/OpenVPN/openvpn/pull/166#issuecomment-1263600751>
> comment, what I would like to know is if it's possible (and how) I could
> proxy requests using nginx to multiple openvpn servers. I'm actually using
> docker-compose to start the openvpn servers and also nginx is running in a
> docker container.

If you are willing to live with openvpn over TCP, it might work by
using OpenVPN's --http-proxy feature - it will do a TCP connect to
nginx (or whatever) and then issue a CONNECT <targetip>:<port> command,
and then speak OpenVPN wire protocol inside that TCP connection.

OTOH, using TCP is generally suboptimal performance-wise.  If this is
just for simple remote access, it's good enough, but if you want maximum=20
throughput (especially if there might be packet loss), go for UDP.


A *real* solution would be, of course, to use IPv6, and have distinct
IPv6 addresses for each container - so, do not go through a proxy, but
have directly reachable endpoints.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--u0x26foP+kUk/CeB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjOHs9AAoJEB2Cnv7KVigSpKsMAI1dCZtDkSKU1HqKoCmUucdC
iwFIS7EyoTtRaEnYXyTJTAD3xGB3ueJWuhGIQnhrq+/899G67eEjOYqtkUBdtTF0
PSCqxRmNnYyoWAIp9l03Rhj6GXSN/wZ1W489y9zaMETROT2X05Umud9mo2F3YL6E
zefIqRfVLC9PldFBdqS28uVCLmailkzrnyrMCuKfBVHu8YuLyScj33s1M4gtf1fp
gO0aCnnLA8zIuQTPzL5qz2JnpdMj+2poDleehtBr1i3HNLA545WpmrtbxSksC07v
viexBXuY4SFAAxRErN3fDz+IdsRcto9WmhtILUzMcNKmoi0yaL+R9llD6U7op2fd
gE6UXK//N/q09JGAv3N978BrVz5ojBYiOdVp/i2oVoaNvglBJjPH7/s4JB00xIMy
XniwJCmZ+aePOtdkQdE+B/n7iWeFctojIefvMkd7CC00dcYQnovFfZjL9+kG07+V
DQ3HjEEFDwQCBFm6VIifoYnNMaKJygItdhOAOtHcgg==
=jmTx
-----END PGP SIGNATURE-----

--u0x26foP+kUk/CeB--

