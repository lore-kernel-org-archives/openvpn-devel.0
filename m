Date: Fri, 2 Oct 2020 17:05:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20201002150533.GC976@...1296...>
References: <63aacbfb-20a0-de78-fccb-bbf8a2ad4189@...2318...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="OlucDFihBVSxvK/7"
Content-Disposition: inline
In-Reply-To: <63aacbfb-20a0-de78-fccb-bbf8a2ad4189@...2318...>
Subject: Re: [Openvpn-devel] with IPv6 VPN connection,
 IPv4 traffic does not get router over VPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?iso-8859-1?Q?Fran=E7ois?= Kooman <fkooman@...2318...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--OlucDFihBVSxvK/7
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Oct 02, 2020 at 03:26:29PM +0200, Fran=E7ois Kooman wrote:
> After testing connecting over native IPv6 to the VPN server, it turns=20
> out the IPv4 traffic is not routed over the VPN. This worked in older=20
> versions of OpenVPN (2.4.x) but no longer in OpenVPN 2.5rc2. I am=20
> testing with Windows 8.1, but the same was reported on Windows 10.

Oops.  That's most certainly a showstopper, and it's very good that
you report this before we release.

We had a report that redirect-gateway was broken for IPv4 "if the
client has no IPv4 at all in the local LAN", but your description=20
speaks differently.

I'll open a "blocker" ticket in trac...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--OlucDFihBVSxvK/7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfdz9MAAoJEB2Cnv7KVigSyUUMAIVg4Qu+BTygCa/k2+nK5aaj
LhgMBd/sCYzML6JKQbQPjujSfKMbpFPcX5+Z7x6YI0IMhp2/s1zPJw6XzEuVLzdp
q2LRx2Hbpk8j8ZyC7AH1/4z8PhndUV6+matgL7O0aWLVZwRHs3vONpSEcVdTQWTB
/IBk2105bkXf20p55pm8wH1iY0dk9KUwvXlDBtmGsTfvn/0jGT9tlqczimVlOCKH
zvmBZ71P37vFjoZ87M7hq2Tmg3rMUoQJJ7Ck/jWvSM0J5znypeneer/4IML/NHLC
XuAISlQHbjMY0Hkb75VIfJozspaYu2e65WZUujbcksQqLMwr7SfK5bwJCmTXIMwh
5z3try1idSzZ9nzXUQKrsPRUTt0lW7NgfMk2TG76apdowd9FImey2fWTxa4jHIAr
jW0jS4iFRUrreBlevxsGV15mA4GJhNcHYIQUO5fMTllMNtCYFyDbIW/xDIUW/lec
wTNwHt9wHtpr62wyupT1Rs6kKMOx2eK0tMTCNnysRA==
=a5R9
-----END PGP SIGNATURE-----

--OlucDFihBVSxvK/7--

