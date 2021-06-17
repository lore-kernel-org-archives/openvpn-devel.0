Date: Thu, 17 Jun 2021 17:45:05 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210617154505.GZ976@...1296...>
References: <20210617061027.140-1-lstipakov@...277...>
 <20210617061226.244-1-lstipakov@...277...>
 <CAKuzo_jCBkQA1FLYAFct1+=f=Vyjw8Mt1HxU+BKtR10Xx-MXQw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vr3kw5i3+MSDHXmq"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jCBkQA1FLYAFct1+=f=Vyjw8Mt1HxU+BKtR10Xx-MXQw@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] crypto_openssl.c: disable explicit
 initialization on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Lev Stipakov <lstipakov@...277...>, Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--vr3kw5i3+MSDHXmq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jun 17, 2021 at 11:25:02AM -0400, Selva Nair wrote:
> This would make it impossible to use openssl.cnf on Windows, wouldn't it?=
 I
> use configuraton file to restrict signature algorithms, for example. There
> are other uses like configuring engines.

Right.

> Instead of disabling, why not make the default path a restricted location
> within, say,  C:\Windows. The user can then override it using env variabl=
es.

This is what we tried to achieve, but Lev could not find a way to make
the MSVC build behave wrt "new ETCDIR".  I have not personally investigated.

So we decided to release 2.5.3 soonish, with "disable openssl.cnf" to=20
cover the problem reported, and then see if we can get to a better fix=20
incrementally (while a "secured" binary is out for users to run).

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--vr3kw5i3+MSDHXmq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgy24AAAoJEB2Cnv7KVigSCpgL/RjmIXGClazU8vDPT1Cf6Cbe
ILr9Axa8EG4aGYzJi45WsDEBrYyqreSKj0z2oj8Np1Pi8Uo5cZueLj6brjdK6iRY
ZLZF09JYD5LmZjokSWwXvXF2/zndC3fQwVCJvUYa3zb2ohbwuUWVUHQE+aDus+E8
2EAE14nnYEQg1B33v4uuL/CPCu8IYMF9z4fgIhZf5RQfz/MGfvdJt0/zINcxazrY
4VTEx7vqkgoJa0q4M28NFY2OSYsqZSYf1fMurPZVVGceKuZ8E4/rBvVRAS5BI61P
I+w+L4zFl96fCErAFufpFfypy1c4o0zvovrfz2C62Z+aBYpvhWZDYSWgWm+Wf2G1
Ujf3SoclWuO+J+uK+M9ZBEOiK9YkVqVhBf10ANr5TX9g0DXPA/vTx5hgR5JAtf3F
pUo0xVSSOjzN7A0ftHdXAAIzkHaqAPX783X7HHG9zlI885r68Zq0uyJiDmcPJZ9O
AicSSd7kZwZRR6GuV7D4I5/a/pAoZNUAlr/L/4+TFw==
=eHKT
-----END PGP SIGNATURE-----

--vr3kw5i3+MSDHXmq--

