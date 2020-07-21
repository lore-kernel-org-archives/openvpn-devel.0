Date: Tue, 21 Jul 2020 17:07:35 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200721150735.GD1431@...1296...>
References: <20180308194748.4627-1-steffan@...1856...>
 <20180812085104.30193-1-steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="SvRBn7F+DHpbufVC"
Content-Disposition: inline
In-Reply-To: <20180812085104.30193-1-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH v4] Allow changing cipher from a ccd file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--SvRBn7F+DHpbufVC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Aug 12, 2018 at 10:51:04AM +0200, Steffan Karger wrote:
> As described in msg  <374a7eb7-f539-5231-623b-41f208ed856e@...1823...> on
> openvpn-devel@lists.sourceforge.net, clients that are compiled with
> --disable-occ (included in --enable-small) won't send an options string.
> Without the options string, the 2.4 server doesn't know which cipher to
> use for poor man's NCP.

Just for the record: we do not need this patch anymore, as Arne's
magic refactoring work has made adding this functionality very trivial
("just permit cipher in ccd/ files") - and that one has been merged
already.

I just found this one in patchwork and thought a bit of commenting
would help transparency :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--SvRBn7F+DHpbufVC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfFwS3AAoJEB2Cnv7KVigSAOUL/3qE2DHGmlzoC3vWJHugKpyE
NV/ihqfuxe7FMQq+nUKsLAEWKyjxbj8RXeZFRjnL1Ad0QTvAj+D6eA9OcrnZj7N8
ep8d22Gw06LBzlkUS992o3fMmRCmq8OCNZ3InWxFymoY8hhOiOsbJ0SWgNZB2WWW
EXPUnwEL2/lSAGF3R+x2ENZtHtrDZefaUS8eWvI4aA+n8FvQFYLQJahnIxDTq2WC
+N93SeaHuAhRnc9DOVIkoJ/mk68Idyv1yI59DYlpl3M424NItHKfoOXLuBCpNZFw
fxLew/XzDyHb/G2zkAbJIdtZz6nB2n5kLHH4hZXWvUaA8uJ9fi7Qp0YzD9KFZbXY
UKsHK5+OzdGMLgRt5XN5nSDWn0V5SjBi4+2CQxGiwf4fnV2yg6xqorESosB2MD5y
p8Vviup8qV9L6kQZDlKSJgd7eJuLyYc3mfvwSrzpivFHR5jjjpouDmpBbb1wZS3P
u89O0rg9GI0qy5Qam7dmDP/1FAHKpdpEpnZ3vaGO5A==
=9NLh
-----END PGP SIGNATURE-----

--SvRBn7F+DHpbufVC--

