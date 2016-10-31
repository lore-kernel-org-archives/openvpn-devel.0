References: <25534afb-4dfc-fe21-6498-dc4aac20246f@...277...>
	<CAKuzo_gkTEh+-=z=dHm+sfHGqcHYwhCsOUvT=knNgj+X-B3HnA@...278...>
	<82c751dd-095d-cd1c-1422-24a443f1f1d0@...277...>
	<5c4e3f93-c584-4a19-4081-9bf4adaf417a@...277...>
	<502e093a-cb39-c76d-27b5-ab86fd4bcfd6@...515...>
	<73352d7f-521e-b968-2990-8783955da5c9@...2080...>
	<04516948-204e-57c2-fb57-f355157ed5af@...515...>
	<CAKuzo_gRDm566EwD_qtrYNM5AOYHF8xgCzsi1FQ3emjYGDeGmw@...278...>
	<43094758-efda-c613-c51d-e7980dfa6b24@...2080...>
	<CAKuzo_iaEhhrVhRr_zPATsFHinFi=ECtDFofEB2_8zP7Z2+zSg@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <90baad6a-25c5-2ecc-1ea8-b5a1febf1521@...2080...>
Date: Mon, 31 Oct 2016 22:30:06 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iaEhhrVhRr_zPATsFHinFi=ECtDFofEB2_8zP7Z2+zSg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="9M5GMkWqJSDmURPwdA6BhhAiXuIbjWPlD"
Subject: Re: [Openvpn-devel] trac 757 --auth-user-pass up + GUI 2.3 vs 2.4
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9M5GMkWqJSDmURPwdA6BhhAiXuIbjWPlD
Content-Type: multipart/mixed; boundary="cjdrqcmKUVebkENhHKgk7C0B0ivaCpAaJ";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>
Message-ID: <90baad6a-25c5-2ecc-1ea8-b5a1febf1521@...2080...>
Subject: Re: [Openvpn-devel] trac 757 --auth-user-pass up + GUI 2.3 vs 2.4
References: <25534afb-4dfc-fe21-6498-dc4aac20246f@...277...>
	<CAKuzo_gkTEh+-=z=dHm+sfHGqcHYwhCsOUvT=knNgj+X-B3HnA@...278...>
	<82c751dd-095d-cd1c-1422-24a443f1f1d0@...277...>
	<5c4e3f93-c584-4a19-4081-9bf4adaf417a@...277...>
	<502e093a-cb39-c76d-27b5-ab86fd4bcfd6@...515...>
	<73352d7f-521e-b968-2990-8783955da5c9@...2080...>
	<04516948-204e-57c2-fb57-f355157ed5af@...515...>
	<CAKuzo_gRDm566EwD_qtrYNM5AOYHF8xgCzsi1FQ3emjYGDeGmw@...278...>
	<43094758-efda-c613-c51d-e7980dfa6b24@...2080...>
	<CAKuzo_iaEhhrVhRr_zPATsFHinFi=ECtDFofEB2_8zP7Z2+zSg@...278...>
In-Reply-To: <CAKuzo_iaEhhrVhRr_zPATsFHinFi=ECtDFofEB2_8zP7Z2+zSg@...278...>

--cjdrqcmKUVebkENhHKgk7C0B0ivaCpAaJ
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 31/10/16 15:58, Selva Nair wrote:
>=20
> On Mon, Oct 31, 2016 at 10:51 AM, David Sommerseth
> <openvpn@...2080...
> <mailto:openvpn@...2080...>> wrote:
>=20
>     I was not aware it was fixed in the 2.4 branch until today.=20
>=20
>=20
>     But this is still an issue with 2.3.  That's what I believe should be
>     fixed, as that is considered at least a missing feature there.
>=20
>=20
> The feature request is for username from file, password from GUI. That
> is not supported in any versions and the limitation comes from openvpn
> itself, not the GUI.

Okay, we all know that each platform will have slight variations of
behaviour.  But we should try to have as little variation on the
*feature* side.  Fair enough, we don't support bash-scripts through the
script hooks on Windows out-of-the-box, on the other hand we don't
support Windows batch or PowerShell scripts on Linux.  I rather try to
encourage you to think outside the box.  Which has already been done in
the 2.4 branch, there exists an alternative solutions for this feature.

If people request this feature, it is far better to say: "You can't do
it like that on Windows, but you can do it in *this* way instead" ....
Now all we can say is "No, you can't store usernames in Windows."

So let's try to aim at pleasing the end user than being picky about the
wording of a track ticket.  Because most users will be thankful for a
related feature than no feature at all.

Which is also why this core feature was added to the core OpenVPN 2.3
branch.  It wasn't important *how* this was solved.  It was important
that it was solved in *some* way; for non-Windows having a single line
auth-pass file was the solution.   For Windows the solution might need
to be different, just for the similar reasons we don't support bash
scripts on Windows - but we provide support for alternatives.

Of course the contra argument is that 2.4 have this support.  But should
we start recommending users to upgrade to 2.4_alpha in production?  I
don't think so - as then we could have jumped straight to the final
release instead.  It will be a while until the final 2.4 version is
released.


--=20
kind regards,

David Sommerseth



--cjdrqcmKUVebkENhHKgk7C0B0ivaCpAaJ--

--9M5GMkWqJSDmURPwdA6BhhAiXuIbjWPlD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYF7feAAoJEIbPlEyWcf3yGewQAMVH2Ff4k71qhdGAfliAHUsg
ww0iiBztY9ExiBBxadSBEherKmE8wfdKH2fuskp5NQ0vFg00maUOhX0ssSFAvmxr
ReV5FCd5oneDwp7L90QMwUUM4XLnh3j4Wwx5gqmgXHh0hdK0HidKnnYVKZs49vIV
eUTgdxTjuJSZy1tC2/dNemLWkP0W6y/ls3SG1F/HL2re5H/Ph/QJMLJMqv7bPfyB
cWcDOF/EOXZMvwojx61etoFYw3Ka4JHqm8vUaRwX8yVEEq+R5hCssnGVxYhSnoZp
qhpP6ETP1zal/yABB5Jv5sSyxeKQ9qz/dduqJnvqexYg9ew1UTCOf1oY8hY5V5Xq
ulJl2fp2Yqe3AK3jV3DIVhCxKWF0kbIJyw3JMtehXJ72KHZV3AmUKeMbHQsHHgZR
cnBHSDlI2jMczRJn1T8hPRIygcOAkJG7Jy2f2QFsKsIZit4meiAdHqGNkpCI/Gn/
bOuHUDExTAsdfq0D7nFYvIBf11oaaDDl2+Djh21g80W5XNY/pYiFcHsnlh2qPX2i
28YT543mezirdD9xdFm7Yl0th5pXYRKIhbb2udWQHzMWL5AljysbOLKB/hBE47Sx
3P0QjPRgYsm6Rym8U3IncWZkVdO3x3stAetKD7d7CuTtk24fq+cYpGNOcYggSkQj
lsmO+dHJgW94wdXUEDR0
=8SLO
-----END PGP SIGNATURE-----

--9M5GMkWqJSDmURPwdA6BhhAiXuIbjWPlD--

