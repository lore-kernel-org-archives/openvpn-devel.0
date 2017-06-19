Date: Mon, 19 Jun 2017 14:45:55 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170619124555.GG97029@...1296...>
References: <f7ac719e-0b28-4c4d-5e8a-2932827789b6@...2080...>
	<20170619111141.17692-1-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BdDRKbxUqzNp7SCP"
Content-Disposition: inline
In-Reply-To: <20170619111141.17692-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH applied] backport: Ignore auth-nocache
 for auth-user-pass if auth-token is pushed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--BdDRKbxUqzNp7SCP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 19, 2017 at 01:11:41PM +0200, David Sommerseth wrote:
> Your patch has been applied to the release/2.3 branch

Uh?  We were talking master and release/2.4, not release/2.3...

But anyway: whatever that patch does, buildbot does not like the result
- all builds have exploded, and as far as I can see, with the same
error:

init.o(.text+0x2625): In function `initialization_sequence_completed':
/home/buildbot/build-openvpn/build-cron2-freebsd-74-amd64-stable-master--di=
sable-crypto/build/src/openvpn/init.c:1394: undefined reference to `delayed=
_auth_pass_purge'

What did happen here?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--BdDRKbxUqzNp7SCP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZR8eBAAoJEB2Cnv7KVigSa5EMAKp5flrlVFnXopWEftdZxLI4
8In7qNb0QAXJNYHFiSiv37gNYShEmpEsY+gCPOT2cbYK9a1xFGVFOdj17nVtgcX2
XWjabAAQUYZNs+Ka0xrjqTqqJG9dhQRMG0ZJPzEsLvXQiE8BnmBnv1I1dQ3sOc4k
S0PlQUM6lMGoxorbDlgzNewNkzCJNBgzsBQkk3Ze4qHUuAjz+sJ2hPq+hhjQQ3J5
tQnZbeu3rcmFk3JDZa54PK+UuZbuXqhOumjt85zFbEf/A8UKTixaQRyDH01ytGPm
rf4JunB8RYMLRP9+tk/D4kY74ZTUmYhvrw5dwvs4tGm7x5ySbJFQ3XOowvf6Wr6N
HERPL0qIGKQlN9hC1WXkuvhRKuLkJvJ15g5QUFcpGrS4P4uyxjVIbUnQ9Y1p9PfZ
RwR94RmDqEpdtajdNyVkrdw1T4NF4+g3j4gqHyf+n7x2j5PUX0uyKigh2VPacI0p
++qcKL41WWA9uFvi5fI66AvwCYH6fRvaFJOwf+UXSg==
=2jLW
-----END PGP SIGNATURE-----

--BdDRKbxUqzNp7SCP--

