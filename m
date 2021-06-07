Date: Mon, 7 Jun 2021 10:21:58 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210607082158.GX976@...1296...>
References: <20210507145644.195-1-lstipakov@...277...>
 <202105101557.14AFvbud098718@...2054...>
 <CAGyAFMUH0e-Uoxik+PfS03RUAyTSseCQUmjOKbTsu=SeD4Bhdg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="XxL9RZ//6cExjA+q"
Content-Disposition: inline
In-Reply-To: <CAGyAFMUH0e-Uoxik+PfS03RUAyTSseCQUmjOKbTsu=SeD4Bhdg@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: msvc: add ARM64
 configuration
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Gert Doering <gert@...1296...>, Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--XxL9RZ//6cExjA+q
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 04, 2021 at 05:33:25PM +0300, Lev Stipakov wrote:
> This can be applied to release/2.5 as well.

And so it has been done

commit 90770576baf4bd81545f19b531bae5fe37f69802 (HEAD -> release/2.5)
Author: Lev Stipakov <lev@...515...>
Date:   Fri May 7 17:56:44 2021 +0300

    msvc: add ARM64 configuration
    (cherry picked from commit 8de7e643baefcb6a3000a3a89ae42ce1328a9a7d)

no conflicts, applied smoothly.

(Not tested either, but does not touch "openvpn code", just MSVC build
environment)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--XxL9RZ//6cExjA+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgvdclAAoJEB2Cnv7KVigSX5AMAKzA59cRYlQ0sCtWycJE1OAq
yxn7xqGzOZKkVcyyp/9Q63daz4dgxfK0mG0eVivG4zh268vfoNH9lxMQGl7bUAoO
Ivhrsw8HsJhXzMWLzxSYDGgtIJeQJzQw7Dcie0hR7WE8hWvpS9DyB4kbA5Y5kUhO
qyU1WPc86IrvS1k8r2/u0NThUZkfF86o/oOf3xtuA5D6PVFnsgXC2TZm8xkCx1c/
SCMYbJ+7JxRblazIX6+ITUWIY0P7kCdqXxhFyyntFeR8+s19blcCfCA22bLi8so6
e7chza/0PUNMcP2bXE4SOdMd+5GQh5RJYMnauV4wGIisyeoAKTNBKWYKUHsFROzm
2Y/BddZWfGNM9/RPg6zSXwnK/XdwWoHOcJlIUnzrxaEAPpqU4csGyxxKud6nWjXB
oGJr/W6aXna1HX66KtRZxTRfV5UVDLqbQcNp1BcRqj7RL2Wtb8RD4Z+ZXE91XqdU
Fb/Re2x6T4Kv5C+UgoPOQIZSjgkwsvzQ9DBQIAS9cg==
=bt+2
-----END PGP SIGNATURE-----

--XxL9RZ//6cExjA+q--

