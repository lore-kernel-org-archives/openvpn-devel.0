Date: Mon, 30 Mar 2020 07:55:01 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200330055501.GT1431@...1296...>
References: <20191116102835.22883-1-arne@...1227...>
 <2ce5e07d-ac3d-4034-c2e1-56a00cb332bc@...2080...>
 <20200328113327.GO1431@...1296...>
 <172c2cf6-c27e-4b53-7867-83a01fb16b60@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Kqu4dxz3gYjPH61T"
Content-Disposition: inline
In-Reply-To: <172c2cf6-c27e-4b53-7867-83a01fb16b60@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Reformat all source files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--Kqu4dxz3gYjPH61T
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 29, 2020 at 11:54:36PM +0200, David Sommerseth wrote:
> > Applying: Reformat all source files
> > error: patch failed: src/openvpn/tun.c:3418
> > error: src/openvpn/tun.c: patch does not apply
> > Patch failed at 0001 Reformat all source files
>=20
> Ahh, sorry ... I did the reviews based on Arne's github tree [1], so I co=
uld
> compile test them.  And I trust him enough to not do any stupid stunts in=
 his
> tree.  His icsopenvpn branch has all of the stuff I've reviewed; that bra=
nch
> rebased against our latest master without any hickups.
>=20
> Unfortunately git apply is (rightfully) super picky about conflicts.
>=20
> Not sure now what would be the best approach forward. Picking the commit
> contents from a rebased icsopenvpn branch would be one way (I can provide
> commitish references I reviewed, if needed).  Another approach is for Arn=
e to
> resend rebased patches to ML.

Well, our current defined process is "we review, test and merge *exactly*
what is on the list".

So, ACKing list patches based on "some other tree" is doubtful at best
(for initial review and discussion, fine, but for the final ACK?), and
"have something on the list and then merge something else" is also
clearly violating the "everything must be transparent, and no code changes
compared to what is archived in a public archive".


We can change this, of course, but even then it needs to be fairly=20
transparent what was exactly was ACKed and merged (and what, if anything,
was changed between ACK and merge).

It would make my life easier to be able to do minor code changes on
the fly, or do larger adjustments like for the argv<->tun.c adjustments,
but we need to be very clear that we change the process.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Kqu4dxz3gYjPH61T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJegYm0AAoJEB2Cnv7KVigSW9UL/iO5UJDIsngC8yP7pcNB+IYt
8NEg/Q7X32zYzwGTrkjjjqAsamJbZ9fxF5ZIM1sq+ouYGW3hiaQbOzIYBB0w0dXt
rK1Lpz9umTF2JH6IoYXouHdhbgmmFU1sbjQlCY+Vu+kskvN7Zvwle8+gl/U6unsV
JmVeuv8L2NQadvXz03Pm7/RK/IcqbFM3wvYMlcdRlv5uanucsgMH1qFpxJxT34N+
QHi5nZgVmC/YVNxAcpS+o9EtWscqnZZTdEQNKsW7GBYBC7JSkP3Uqwu+vrwbEr4l
FsPHpDKQYrXvxP+Hdx4k2w1Q0GaomPlrtzIS1YaSK/1satq/GuzfANnLuxDPgjgY
jx8tZTq2kYa7ybky9RAgfoRR+LHFLQ8J5hIJd1Z36ZgP1mp1ZMkVD0X5h130V1wI
5yNfW7FoXf4+/kXAcnNepOGP0DmCTcg8fAxbooubZ+1NZI14UGr2E2DKQU72TMNm
CP9ITk8lUcEiA8ZACg8KiKSHBy83XWH9pEQJwSb9nA==
=j3Yx
-----END PGP SIGNATURE-----

--Kqu4dxz3gYjPH61T--

