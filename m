Date: Sun, 12 Nov 2023 19:22:45 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZVEX9TEflRrLHUmb@...1296...>
References: <13E5C41C-8358-4252-A751-8FDA9EE95B7D@...2722...>
 <0acc8d93-6175-4d7e-a39a-269a9652ac3e@...1823...>
 <f2f54207-f37c-4c0d-96a3-a600cd2bb811@...1823...>
 <ZU3aVt0EgPyOQWEe@...1296...>
 <ae5ddbf4-44fd-4d4b-a045-53274aa9cc5d@...1823...>
 <fe0a4e43-4015-4834-a9bd-8764baf0134a@...1823...>
 <ZU39JoRBq8R_NgD6@...1296...> <ZU6I1MMD980Ervm-@...1296...>
 <CACDCbPq3O71Pjvaj0aBE8Dd-JQA3idZOxP+eyb=9if_MiLREQw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6awsBQ1nLmJ+j3kw"
Content-Disposition: inline
In-Reply-To: <CACDCbPq3O71Pjvaj0aBE8Dd-JQA3idZOxP+eyb=9if_MiLREQw@...278...>
Subject: Re: [Openvpn-devel] OpenVPN 2.6.7 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Greg Cox <gcox@...1057...>
Cc: Gert Doering <gert@...1296...>, Dmitry Melekhov <dm@...1823...>, openvpn-devel@lists.sourceforge.net

--6awsBQ1nLmJ+j3kw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Nov 12, 2023 at 06:08:48PM +0000, Greg Cox wrote:
> Spun this config up, then ran:
>=20
> iptables -t nat -A PREROUTING -i eth0 -p tcp -m multiport --dports 443,80
> -j REDIRECT --to-ports 1194
>=20
> Within 5 minutes the random web scanners found and segfaulted me.

This sounds promising.  Hopefully we can make it crash too with that :-)

(Focus so far was on UDP because that was the first report we got, but if
TCP gets the job done, even better).

Not totally trivial, though... "basic" openssl s_client or just plain
"GET / HTTP/1.0" will just make OpenVPN close the link, not crash...

*keeps trying*


(If you feel like debugging a bit more - could you compile an instance
without optimization, run from gdb, and when it segfaults print all=20
local variables of interest?  i, j, ks, *ks, ks->send_reliable?  We
got one variable print from Dmitry - thanks! - but the optimizer broke
printing "ks" things)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--6awsBQ1nLmJ+j3kw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJlURf1AAoJEB2Cnv7KVigSBOIL/jI5qdzpyLknDvChnu7FmaMw
kAcBEAPIu/j05JTdf26jcceegM167ce5lsqecHMMilEb5wZVRfVit04KxSaspr9s
WDsBD9GncIsSFVvDFLH93WWuOulc4rguuNDszlTVbkgRPw5fSwqc2x/54aqA2bJ9
doGGAnHwqqk73CTDwJMQmUb8pF7yKd6DTXX8cDBVQ3w165kIXgoHTO0RnEzIRCCm
liDHHxuolZUMzp6FzSjsgg1Rzr4infJ6RUxK+5gQq8/qHkFUtefE56ddJUB/9aGH
GXPqKXKNmYiGcdxvmk2ggg50COLmkrMsi4CyvlPWOzlvQPJ1M0/vqkljTWoclpys
tj0Gp4pCZRayvxkJ9phH80O3Q1pLp4fH7nI2Za+2Vs/P81idK6AZO/NARQLQMFdQ
S2Mok+e53q+CVV5WUnEkdgT1WHrCvwfCCRqUAbAHCpWQTHGc42zinpQ1sRmJpcx1
2EtI+2fx1e4gz+ez7hbSsQux104h17M4waTmK+I6nA==
=wzgE
-----END PGP SIGNATURE-----

--6awsBQ1nLmJ+j3kw--

