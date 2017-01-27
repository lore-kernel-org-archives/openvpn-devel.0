References: <1484035447-11838-1-git-send-email-chipitsine@...277...>
	<c95121f3-3f11-1369-a74f-dd09cb49e255@...2080...>
	<CAFHpkQE6w_EwAY8_osyubZs3eE4v80adVhFVP1ePy5O5NXr7sg@...278...>
	<46da70ef-ce50-01cc-023d-76a866069c4d@...2080...>
	<CAKuzo_hw2MbZoYZEZBthwq818XZWz59Z4rn7rDydkerLKjALBQ@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <e944cfae-a619-f48d-e3c9-073129acff8a@...2080...>
Date: Sat, 28 Jan 2017 00:55:31 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hw2MbZoYZEZBthwq818XZWz59Z4rn7rDydkerLKjALBQ@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="7GlAMkCf8F8rGatMXRXtRP9mCovB6PjRC"
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
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7GlAMkCf8F8rGatMXRXtRP9mCovB6PjRC
Content-Type: multipart/mixed; boundary="8GWgvGl2wvwiAQsQeMPoakjrff5xuDJa1";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>
Message-ID: <e944cfae-a619-f48d-e3c9-073129acff8a@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Resolving several travis-ci issues:
References: <1484035447-11838-1-git-send-email-chipitsine@...277...>
	<c95121f3-3f11-1369-a74f-dd09cb49e255@...2080...>
	<CAFHpkQE6w_EwAY8_osyubZs3eE4v80adVhFVP1ePy5O5NXr7sg@...278...>
	<46da70ef-ce50-01cc-023d-76a866069c4d@...2080...>
	<CAKuzo_hw2MbZoYZEZBthwq818XZWz59Z4rn7rDydkerLKjALBQ@...278...>
In-Reply-To: <CAKuzo_hw2MbZoYZEZBthwq818XZWz59Z4rn7rDydkerLKjALBQ@...278...>

--8GWgvGl2wvwiAQsQeMPoakjrff5xuDJa1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 27/01/17 17:58, Selva Nair wrote:
>=20
> On Fri, Jan 27, 2017 at 10:08 AM, David Sommerseth
> <openvpn@...2080...
> <mailto:openvpn@...2080...>> wrote:
>=20
>     On 27/01/17 14:56, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=
=D1=86=D0=B8=D0=BD wrote:
>     >
>=20
>     >
>     > may I ask you something in turn ?
>     > I cannot read other people thoughts, if there's something wrong wit=
h my
>     > patch, there's no other known way, but your reply.
>     >
>     > since, you are keeping silence, I've no idea whether is it wrong or=
 not.
>     > It would be really nice if you will tell "that and that is wrong". =
I'm
>     > sure, there are sites about git, where it is written.
>=20
>     Fair point, and this is a very common issue in most open source
>     projects.  We are not necessarily ignoring you just for the fun of it.
>     But we do look through a lot of patches, and need to prioritise them.
>     For example: Patches which fixes real issues in released OpenVPN
>     versions naturally gets a higher priority than a patch fixing a man
>     page.
>=20
>=20
> That is hardly true. I am not complaining, but just pointing out some
> reality that can't be helped.
>=20
> We have a dozen man page or similar level improvements since 2.4.0
> though at least one critical bug fix I submitted is still awaiting
> review. This has to be expected as it takes the right person and quality
> time to get certain things reviewed.  Sometimes trivialities like the
> non-exiting inefficiency (save a microsecond once an hour?)  of carrying
> around [[INLINE]] tag may get multiple reviews, but a bug fix may wait
> for ever and even lost under the pile.
>=20
> It all depends what catches our fancy, personal interest, expertise and
> mood. No point in trying to rationalize it beyond that.

Also a fair point, Selva.  I did generalize way too much.  But I do not
completely agree with you.

I can't speak for the others, but I do actually scan the list for
patches where I have knowledge and look for critical/important issues
first.  If there are patches outside my knowledge, I can definitely
process the "lower hanging fruits" first if their in my field of
expertise, to get them done.  If I have some spare time, I often do look
at stuff outside my "comfort zone" as well, but that usually can take
quite a bit longer time as I need to completely understand the issue and
implementation.  And it's not too uncommon that some others actually
manage to send the ACK/NAK before I complete my look at it.

*And* towards the end of the 2.4.0 release cycle, it was a deliberate
choice to not bring in any code changes unless absolutely needed.  But
we did pull in several documentation patches which would not jeopardize
the release.  Yes, we let known bugs pass - we evaluated these known
issues and patches, considered the risks and decided that several of
them should go into 2.4.1, to be sure 2.4.0 would be as stable as
possible.  Basically better to have a few known issues than adding more
code which could make things even worse.  That is a hard and tough
decision to take, and it often doesn't look pretty to those not involved
in those discussions.  This may very well also have skewed the
impression of the normal working approach we try to have.

But I do understand and accept that from an outsiders point of view,
seeing all reviewers as a single instance, it may very well be
experienced very differently.  But we're not a single unit.  We're a
handful persons with very different set of skills, working somewhat
unsynchronized in parallel - mostly trying to prioritize the important
things first, within our own scope of skills.  The unified end result of
that can indeed look much more like a bag filled of random patches.

The fact is that there are quite few on this list who dare to ACK/NAK
patches.  If more had just done that, things could flow quicker into the
git trees.  Luckily the list of those giving ACK/NACK is growing
slightly, but there is still too much on our list of open issues to
manage everything in a timely and appropriate manner.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--8GWgvGl2wvwiAQsQeMPoakjrff5xuDJa1--

--7GlAMkCf8F8rGatMXRXtRP9mCovB6PjRC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYi93zAAoJEIbPlEyWcf3yLRMP/ixUWrbG812jBsBJgmm3EXph
H6neFLLLzGt4V/x7tXWbNhQOcbtAde23OWOnS4rsi0/2xwUa/xyUrU9Tvd6vSvtD
CxJYo+/3bULEB5YN+9D3rSVPIP0m6kLw5a5kkppqWduQfI6gNZ7WOfhXZ6gMvht0
YSXjwTNrAniID5N3dQOLJnBukZJ5wFLuOcc/hkmy6DpdVZvaaY99sfkyIvAsXxPz
9SBkEg3CtPQIwGwrVxbFAEqYLawTdlr22xqHP/ENhUVuZHGVMMDkWF0w8Eh/BRWx
7JFof7UuU5bzNY+Ui3JyowV7xkCvFju0Z4tz70sFJQ8XY5dGF+E89Meab1oZSKsz
9w29GTvGpo+uexG5yAI1iBHTb9Jbx/CHn+8MbPOKUhnlzkftkVEURDMQm25JjBAu
uJdq2POXjwrGAxG5a8UbgQts1pCQimNO4hu18HLtuiaB/fPmTqe78GmWKKYPCyTc
Q0rVnNnDAYU9o+CBoWGWWapJbeTnA6m2CpFZU1uCLFuaje7Ns/bxIK7mM4btdL1u
1McYWmBBp4ekDk58drB1LocrgFSSGFyGBcCCn1lIoji/6CQ7jzN61l0aILs2XQS9
fIAhZ5k2ecFMzIoluD8BGDfr5o84gimfYjMy7MLVHxcpsuiunHVhUigcKJe8amfQ
DcY8xIJraHUDP93P/Jv3
=avv2
-----END PGP SIGNATURE-----

--7GlAMkCf8F8rGatMXRXtRP9mCovB6PjRC--

