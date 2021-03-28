Date: Sun, 28 Mar 2021 12:41:39 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210328104139.GC976@...1296...>
References: <20210319153129.8734-2-arne@...1227...>
 <20210324220853.31246-1-arne@...1227...>
 <2222d9d1-864f-ba18-06d6-00dc0ee157b4@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="HDo6kgESCCTTSOZ2"
Content-Disposition: inline
In-Reply-To: <2222d9d1-864f-ba18-06d6-00dc0ee157b4@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] Implement '--compress migrate' to
 migrate to non-compression setup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--HDo6kgESCCTTSOZ2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 25, 2021 at 09:13:13PM +0100, Antonio Quartulli wrote:
[..]
> Acked-by: Antonio Quartulli <antonio@...515...>

I see your ACK, and find myself wanting to be convinced that this is
really the best possible approach.

The code change in multi.c is nice, but the effects on ssl.c are ugly,
and will be with us "forever".

So I wonder if un-rushing the part about "make compression go away"=20
slightly (since even with "comp-lzo set", both ends do not actually=20
compress anymore, already today), and rushing "remove all/most OCC=20
warnings" instead (including 2.5.x) - so, when 2.5.x and 2.6.x just=20
do not warn on OCC mismatches anymore, we could have the nice part of=20
this patch, and skip the ugly one.

For everything that can be pushed, OCC warnings seem to just get in the
way these days.


I'm not adamant on this, just want a bit more discussion on "best strategy"
and timeline.  I've put it on wednesday's meeting agenda - more brains
around, then :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--HDo6kgESCCTTSOZ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgYF1iAAoJEB2Cnv7KVigSO9gL/24rm2PFaZXktnk9nC5hXnhi
5hDutK8goIsLdiDvZN2kmWzzi3EvvnDvM0UtzF+jFvx6KCPxPLcwyC9REfKUgWrl
KGEoYBs3t7TaWesb+knI6t9KOiW6c2P0ChAG1dhL8qrX5lapFqtM7V0sA8pp7AT1
Ksw1CdHAyuZa6jzJ7hf2rEPffrrQK6KyKvse8wHqwe52lpA24szah35dNyQLh1F/
PenGz8t7uJThBMVF5aKVpjcFkHR3Qs1gF6UXh1vfmIwZNoA2EeH1AegyAJPXKbjj
+5AV5RFSVIoVeHnq0extR0ef5OjF+Q42KyzTogGI98OAvq3wBnwyoGX3L5GsolP1
mwyDpdpzhOZgzjy8WzTsZ+0nFRCl9FTx/j+8KwcmeEd2TDTnkpx8lkwWgbvmItAW
41CVhsvWINoFhZ4oN2oiS4T1kLvhWIZjzAPdpkLdxkOBuW6UzZeH4azI4fct/Kp0
ro5g4pbDVLTSG61cUcVhdwZt3niVWSayduJDBPUetg==
=kBSS
-----END PGP SIGNATURE-----

--HDo6kgESCCTTSOZ2--

