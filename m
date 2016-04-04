Date: Mon, 4 Apr 2016 08:54:18 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160404065418.GA53051@...1296...>
References: <5701661B.80904@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jIdBwf7/i7YThJrI"
Content-Disposition: inline
In-Reply-To: <5701661B.80904@...277...>
Subject: Re: [Openvpn-devel] [PATCH 0/7] Vlan support for openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Mike Auty <mike.auty@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--jIdBwf7/i7YThJrI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Apr 03, 2016 at 07:51:07PM +0100, Mike Auty wrote:
> This is the start of a 7-patch set to add vlan support to openvpn, as
> authored by Fabian Knittel.
>=20
> This a squashed patchset (originally numbering 21 patches, but now
> reduced to 7).
[..]
> Please let me know what further I'll need to do in order to help get
> these patches included upstream?

Well.  Thanks for maintaining, and squashing this.

Overall, I think it's still too many patches - like the doc patch and the
configure patch, these do not make sense on their own, so maybe squashing
the patch set even further (after some feedback) might be the way to go.

Usually we try to have patches in logical units - like, "one bug fix", or
"one manageable chunk of refactoring", or "one new feature, with header,
code, configure, and documentation".  Very complex new features do get
spread across multiple patches, of course, but splitting off configure and
documentatation does not really make sense - without documentation, the
patch is incomplete, and the configure change without the code change is
not useful.  Of course this is not a hard rule, but you might look at
the commit log to get an idea how "this is usually done".

I have not done a full review, but I noticed that at least for the=20
"is_ipv4()" patch, the documentation isn't correct anymore - it talks
about is_ipv4(), but the function has been merged with IPv6 and is called
is_ipv_X() - which the code change acknowledges, but the commit message
doesn't.  Further, that particular change creates quite a bit of messy
code - we do have a style guide, and the code should follow it (I'm aware
that the original code is more "compact" than according to style guide,
but when extending by extra branch levels, this gets non-pretty quickly).


But these are all minor things - "the big thing" missing here is "the succe=
ss
story".=20=20

So - what is it that you can do with it that you can not do with tun mode?=
=20=20
How would the configuration look like on the host side?  etc.  - please=20
describe this to an audience that has no idea whatsoever about vlan=20
stuff(*), and has mostly moved from tap mode to tun mode in the previous=20
years (since tun has less overhead, *and* both Android and iOS do not=20
support tap mode unless rooted).

So we have somewhat of a niche feature for a niche corner of OpenVPN=20
(tap mode) - which will land on our plates for maintenance if we take it,
and the balance between "useful new code" and "maintenance chore" needs
to be on the side of "useful"...

Right now, we have about 47123 strange options and compile-time features
that hardly anyone is using, but every time we change one of the more
mainstream features in a bigger way, one of the exotic things breaks
(and we feel stupid about it).  Which makes us a bit reluctant about adding
new "special feature" code.

gert

(*) I do understand VLANs - being a network guy - but I'm missing the=20
big picture "how would the configuration on the host and client (and ccd/)
side look like?  what can you do with it?  why is this cool?"

PS: I promise a more detailed review per-chunk, so don't send new patches
yet.  I'm not making promises which month this is going to happen - sorry.
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--jIdBwf7/i7YThJrI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVwIPmakuBuNlUUl1AQLs7QQAtvZ6vCVf88lS/nHQ0KlBLQ35cDQlS6yP
VPK1XRDT1Y/QvI1xCQ1z3Yp2rXrKJKqrWxBzzT1Koh3zJPB/ZVm9zGEysieCX8MS
qcHzNpoxaWPtNlMUl/UfjirBe71fM3KVHNmcD0wkVcJUJD6PCEmTxhyImqAf54C0
QZvUgYUm2S4=
=NvXh
-----END PGP SIGNATURE-----

--jIdBwf7/i7YThJrI--

