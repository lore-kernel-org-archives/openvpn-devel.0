References: <1484035447-11838-1-git-send-email-chipitsine@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <c95121f3-3f11-1369-a74f-dd09cb49e255@...2080...>
Date: Wed, 25 Jan 2017 20:21:46 +0100
MIME-Version: 1.0
In-Reply-To: <1484035447-11838-1-git-send-email-chipitsine@...277...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="c3v1saIPRtQnABXobph5bO6avPBrqjEdJ"
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
To: Ilya Shipitsin <chipitsine@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c3v1saIPRtQnABXobph5bO6avPBrqjEdJ
Content-Type: multipart/mixed; boundary="a80LoqPdAxWNpUXSms0q8VtHK6PKDivgg";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Ilya Shipitsin <chipitsine@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <c95121f3-3f11-1369-a74f-dd09cb49e255@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Resolving several travis-ci issues:
References: <1484035447-11838-1-git-send-email-chipitsine@...277...>
In-Reply-To: <1484035447-11838-1-git-send-email-chipitsine@...277...>

--a80LoqPdAxWNpUXSms0q8VtHK6PKDivgg
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 10/01/17 09:04, Ilya Shipitsin wrote:
> * moving LD_LIBRARY_PATH as far as possible (otherwise "wget" picks it, w=
hich is not desirable)
> * split LD_LIBRARY_PATH into LD_LIBRARY_PATH/DYLD_LIBRARY_PATH depending =
on operating system
> * removed MBEDTLS_VERSION, OPENSSL_VERSION (the last depended on nonexist=
ent OPENSSL_VERION variable)
> * removed "apt: true" from caching, it never worked actually

Sorry about this lingering ... To the changes itself, I don't have any
real possibility to evaluate these changes.  From the subject and commit
message, I do not understand *why* this is needed.  You just describe
what I can see in the patch itself.

Having an improved commit message actually describing *why* these
changes are needed - that helps motivating us to apply it.  We don't
like to apply things "just because it fixes things".  What is this "it"
and why is /this/ the right way to do it?

Basically a patch with commit message consists of three parts: Problem
description, Why and How.  The patch diff is the How.  These two others
belong to the commit message and often also worthy a comment line or two
in modified files as well - especially if it isn't clear why.

I would strongly recommend you to read this blog post [1] on writing
commit messages.  It is a really good written post on this topic.

[1] <http://chris.beams.io/posts/git-commit/>

> this patch should be applied after https://www.mail-archive.com/openvpn-d=
evel@lists.sourceforge.net/msg13843.html

That approach got rejected and we went for this [2] approach instead,
will that change anything in regards to the changes in this patch?

[2]
<https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13911.=
html>


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--a80LoqPdAxWNpUXSms0q8VtHK6PKDivgg--

--c3v1saIPRtQnABXobph5bO6avPBrqjEdJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYiPrKAAoJEIbPlEyWcf3y094QAK54ONx6E6lxS7Uwy/oasFCF
oD4Fp663vLjq/hWnPHIUTyZFt+30vyLABNWdcO7jzaiwTjy8mg+lrEjNUBwfzK7s
YgQ7HgGlt6tuo8scmNlOkNSjeEN/6Y63ChBbff+4TQZy26dizYnpycy3q78c4hjK
iVQXJpaz17pQoQyexxtufbzudV1q6zCls43WaC9edO28zLlOHlZ6r5KcQ+Mggf+u
yAr9BRo4faXiFXHJYJdx5YB1xkRbp7+Itrh1+lN07CReubusVSrm0K4FdagAY9mj
sm/dSipZKIet/ICBihZd5vYkUe80P9jUG1FojaIU0ZuD3rWnlO6UP+6Rm8VXVmFJ
PFmPDAlbZAbgkviP1oBTc+DowQSKnNDkprYUo43u5FCsZ6IdRMqgNjX9l4wQD2QY
IjsxxLziZJlwLshO2vG+Zaos0nUZ7qVaJcpCLEFgyL90XVGr5IJBeF93wu0G6nY2
wqJWhurw1vIrYcfBlWkSItRTwk1ozqX/EaqgpdxkYre/RZxkFGhCnYhOAGL0HQ/C
HKPvXFItdVjsOD7UY1thqniSay3neGb4NxJGdBcotIhdBJ7AE2f5Sy5Hrezl5j6e
3aAH4HC+cFqiUl3IwmjD5LcvgNt774g2HAhe5/vp2cNgIxuIKsLZeDA8CdZuQ0B6
ymAlRdOvpzmjre0ZsfYt
=sEda
-----END PGP SIGNATURE-----

--c3v1saIPRtQnABXobph5bO6avPBrqjEdJ--

