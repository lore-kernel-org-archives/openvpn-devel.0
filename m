References: <1484035447-11838-1-git-send-email-chipitsine@...277...>
	<c95121f3-3f11-1369-a74f-dd09cb49e255@...2080...>
	<CAFHpkQE6w_EwAY8_osyubZs3eE4v80adVhFVP1ePy5O5NXr7sg@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <46da70ef-ce50-01cc-023d-76a866069c4d@...2080...>
Date: Fri, 27 Jan 2017 16:08:19 +0100
MIME-Version: 1.0
In-Reply-To: <CAFHpkQE6w_EwAY8_osyubZs3eE4v80adVhFVP1ePy5O5NXr7sg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="1IObOaKHHfcVvj11e1KHfgU0043SQLElH"
Subject: Re: [Openvpn-devel] [PATCH] Resolving several travis-ci issues:
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1IObOaKHHfcVvj11e1KHfgU0043SQLElH
Content-Type: multipart/mixed; boundary="qBp4PbJQWSbVugB4RgOm3rM41dt0R1kcH";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
	"openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <46da70ef-ce50-01cc-023d-76a866069c4d@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Resolving several travis-ci issues:
References: <1484035447-11838-1-git-send-email-chipitsine@...277...>
	<c95121f3-3f11-1369-a74f-dd09cb49e255@...2080...>
	<CAFHpkQE6w_EwAY8_osyubZs3eE4v80adVhFVP1ePy5O5NXr7sg@...278...>
In-Reply-To: <CAFHpkQE6w_EwAY8_osyubZs3eE4v80adVhFVP1ePy5O5NXr7sg@...278...>

--qBp4PbJQWSbVugB4RgOm3rM41dt0R1kcH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 27/01/17 14:56, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
>=20
>=20
>     Basically a patch with commit message consists of three parts: Problem
>     description, Why and How.  The patch diff is the How.  These two othe=
rs
>     belong to the commit message and often also worthy a comment line or =
two
>     in modified files as well - especially if it isn't clear why.
>=20
>     I would strongly recommend you to read this blog post [1] on writing
>     commit messages.  It is a really good written post on this topic.
>=20
>     [1] <http://chris.beams.io/posts/git-commit/
>     <http://chris.beams.io/posts/git-commit/>>
>=20
>=20
>=20
> thank you for the link.
> I added more detailed commit description based on that article.
>=20
> may I ask you something in turn ?
> I cannot read other people thoughts, if there's something wrong with my
> patch, there's no other known way, but your reply.
>=20
> since, you are keeping silence, I've no idea whether is it wrong or not.
> It would be really nice if you will tell "that and that is wrong". I'm
> sure, there are sites about git, where it is written.

Fair point, and this is a very common issue in most open source
projects.  We are not necessarily ignoring you just for the fun of it.
But we do look through a lot of patches, and need to prioritise them.
For example: Patches which fixes real issues in released OpenVPN
versions naturally gets a higher priority than a patch fixing a man page.

We who review patches might also misunderstand the importance of them,
which is why the commit message is so important.  There you give the
"selling point" to why we should spend time soonish on doing a proper
review and ACK/NAK it.

Also, if you have outstanding patches ... it will also help getting some
attention if you join the #openvpn-devel channel and ask a bit around.
Further, joining the developers meeting can help too; anyone can even
add items to the discussion list for those meetings.  And lastly, which
you did, you asked if your patch could get some attention.

So ... don't feel bad that your patches have not been processed yet.
This week I managed to get some time to look at a pile of patches from
Christian Hesse - he sent most of them before end of December.  The
reason they got my attention is that it covered my area of interest and
expertise, covered issues I have identified myself and we have discussed
them on the IRC channel before Christmas last year.  So there was a good
understanding why we needed those patches.  Also, you'll even find
patches from me which is lingering on the ML which have also not gained
much review yet.  So this happens to anyone.

In regard to "what is wrong" ... that is truly hard to give some good
pointers here.  But I try as much as I can to point people into the
right direction.  On the other side, we do expect people to also do some
research and gain more knowledge when we provide some pointers.  We
don't like to do spoon feeding ;-)

And a git trick, which you can instantly benefit from ... when doing git
commit ... add the -s argument ;-)


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--qBp4PbJQWSbVugB4RgOm3rM41dt0R1kcH--

--1IObOaKHHfcVvj11e1KHfgU0043SQLElH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYi2JkAAoJEIbPlEyWcf3yk4UP/3JYmeCeV/l1vEKn6QCJb+mP
F1aCay77Ku/Es96svK053m8xa3KAzKeziJAWDgfidtNgpRJkd2nPGhc6P7Rnn3A1
HiOP7lmdVIxshwZKPqZZ9dztqj3unl0MdeVzqXYcd6oWqh+xcf9+bKfZcgAt+C/N
7YaDU6Sp0TPT1He7dnnd1BQBcA0ipF1Q7liE2f5x8vW/JEn4e9rpcE7dFnfaupJH
lpU8L9O9d48NOt+ATA1J/9nwCWiA6/4pal7ZjykDyIz+fulxCF01hDcqdp+noGes
46UkGahpZoojfdSS2/3TCxzw6XZejsidbpaK7kVjX/VwNn3WSfET8S1/QWVm5BFZ
2Jyiv1ucNa1uQCVrsaw/80IvxwYBAIpgfmn1r8OaAcDDCCl84OclPgBdS9k9wwcy
gUMwVbmBPYzyrgh2mzln6akGPzGxN4LNjmoraRPsEdQz0h2Q2UABtgJiRZnYWv1k
kg4XKv1zZH2d7L+gHpZUlDyVyc/saktx5u7uC10A422CJaflJtkUyJCz2pN7d62h
nq5BjWofOF8QHKhb4vFCcwE6xspuvFr2vASu2VkEW7FJMBPVqIDSeFs0hhRtR0iX
Z4/nkz5e0fCxqcj0oBDszdH+qGaH+6HZCakz/PUy/8ZfkRHAzlPNR/Voh3KvUCqs
NpYVBehvBE/s2lbPkeLy
=AWnY
-----END PGP SIGNATURE-----

--1IObOaKHHfcVvj11e1KHfgU0043SQLElH--

