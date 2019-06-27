Date: Thu, 27 Jun 2019 09:53:21 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190627075321.GD1097@...1296...>
References: <da61f7b0-f9e1-e4e7-3aa0-a0dd603a3f32@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="sQTf9N6XI0Qk9QIT"
Content-Disposition: inline
In-Reply-To: <da61f7b0-f9e1-e4e7-3aa0-a0dd603a3f32@...277...>
Subject: Re: [Openvpn-devel] Patch for pam recent module
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Paolo <wardragon78@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--sQTf9N6XI0Qk9QIT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jun 26, 2019 at 03:37:56PM +0200, Paolo wrote:
> i make a pull reuqest ofr this patch some times ago over github, this
> patch implements the right peace of software for passing ip and hostname
> to pam modules, to use for example in firewall or modules like
> pam_recent, this patch is succefull running by more tha 7 years into our
> systems.

Please send patches with "git send-email".  Your mail program totally
massacred the patch (most spaces were replaced by alt-space, 0xa0, which
looks like a space but isn't)

Please do also use a meaningful commit message that describes what
the patch does, and use "git commit -s" to add a signed-off-by line.

> \xa0\xa0\xa0\xa0 char response[128];
> +\xa0\xa0\xa0 char remote[128];

This is how the patch arrived here...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--sQTf9N6XI0Qk9QIT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdFHXxAAoJEB2Cnv7KVigSREkL/1bD88u9KtOVvwDtWjz1hHuG
j4+axauBKfneUXkZ7CB1XcXyLlX2sZillE9gqSEwD27UzaVUzOVHCgOPijIQlEyC
xie12CRqOauWdw/CZqeVdF6LnKILWY35eYGoCP8DrKz+HZ5bRDgHxHSF3BGH+rwA
TF4ambcAzqM5CIvKtXpuPmSiIhDphQlVTN4e+KKtSE91r8IMIB5zqhF5WAw/9JQJ
p70Y71s3VugPxcNeBDFHp8pKe0WcqfwZExS2Qq/Mzhv7zmhqkvHNJ/X3ScOuaO5w
3WEaL/Ose1Ta/9KKIvGp2Jn5kSkxHXXciC+ypvHJk2CBPgvbBsL3QRx6O1qGqwnz
sK+cEC+aUr87dzpVwajvhFIwUlCrQVtdkz/DYKLQuH0+YWgGDmtata3lkRNIBNL8
iXccSGsQ3CH1OqyEOW3ZAVXx8k8a9zGTfmcHjwcJ+mJCmhfs9pKb3VOeNZCjN+k0
EpLUwDyJMb91SbqLb8wbC33vUFCAom576xQdDcDvWA==
=tGev
-----END PGP SIGNATURE-----

--sQTf9N6XI0Qk9QIT--

