Date: Tue, 29 Mar 2022 12:48:58 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YkLkGj7WrC6ej0yR@...1296...>
References: <CAAUX2SXb8MStU98ZEsswLkLDUM74zL6MapZC+=xc0_eYXwyEbw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Mzax7N/WUUonC2BP"
Content-Disposition: inline
In-Reply-To: <CAAUX2SXb8MStU98ZEsswLkLDUM74zL6MapZC+=xc0_eYXwyEbw@...278...>
Subject: Re: [Openvpn-devel] [ovpn-dco] can not delete tun interface
 automatically if option "user nobody" is used
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tony He <huangya90@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Antonio Quartulli <antonio@...515...>, Arne Schwabe <arne@...1227...>

--Mzax7N/WUUonC2BP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 29, 2022 at 06:21:37PM +0800, Tony He wrote:
> 1. Add option "user nobody" to test ovpn-dco.
> 2. Start openvpn, below is the log. Then we will see tun0 is still
> there after openvpn exit. We must use the command "ip link del tunX"
> to delete. This is not friendly to end user.

Yes.  This is currently unsolved - if you tell openvpn to give up its
privileges, it will give up its privileges, and then it lacks privileges
to tear down the interface again.

This should be doable with linux net capabilities, but right now, we
have not investigated this option further.  So, for now, do not=20
use "user" together with DCO.

(For completeness: this is not a DCO issue, it just happens that normal
tun interfaces go away if the file descriptor is closed, so "magic
auto cleanup" happens - so if you have other stuff to clean up, like
extra routes to non-tun destinates, cleanup will also fail)

@Antonio: can we make DCO interfaces auto-disappear if the OpenVPN
process closes the last FD?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Mzax7N/WUUonC2BP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiQuQaAAoJEB2Cnv7KVigSOC0MAI6eOdTJi7SV41fJBon9mFK+
cp5d+Ilm0sq04SoBaeo7OeqM1Hn8w/nL0UjPLIzMtNLf5ebcks+w6eJA2hcIPfya
wV20G7McdkF8gXOmuY/Q1V0nxigimMZQpFjpdItCZrFMqH7qwGWDPqXLW0h+qwdP
va8LKjv6N89jW42lz6xjUkmehHVxXkJ3nljkFFCjtgHB4SadPCeNoC4mtnIkcgSm
5hf1UsUisWVCuyapCYTxhcmSblxor7+fhUD3QInbIfvnMI4XSEwqJAZvlYN6rZzm
CYsGDsEWQb6854+WjxbuEOc0oPcLlILIEDAvI3qL5e8fR97mh2nfE9Vkh3FOHjcP
VIb7lo9MQMtQg7dyih/3gPID+mEKmLH0J7mQsuE3Cqy+wehS3Lzttm9rdLPMQzgu
wnVLInfvpF6HYQZ8XNJjQTJbDt/FJGI0l/B7Ur4V5E+8dnwYLVCsrzzXHjjGun1n
V3wQXFAA7TMzfbXbP8+pCWCVuUpA/trgThfoi8UO3Q==
=tVeK
-----END PGP SIGNATURE-----

--Mzax7N/WUUonC2BP--

