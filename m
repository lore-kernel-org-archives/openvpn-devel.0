Resent-To: "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>
Resent-Message-ID: <5690465A.3070705@...2080...>
References: <567EA6B5.9040108@...277...>
	<20160108185312.GO24952@...1296...>
	<CAHxAb_VkaGTxf=Cue=B3MWGhQhRukHPs4DcnEyOZrT9Jxz52-w@...278...>
From: David Sommerseth <dazo@...2108...>
Message-ID: <56902019.2070405@...2108...>
Date: Fri, 8 Jan 2016 21:46:17 +0100
MIME-Version: 1.0
In-Reply-To: <CAHxAb_VkaGTxf=Cue=B3MWGhQhRukHPs4DcnEyOZrT9Jxz52-w@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="S7lsFU7etnaafL2ESRRxcL1DPeSEIMEgG"
Subject: Re: [Openvpn-devel] Fabian Knittel's 802.1q/VLAN tagging support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Mike Auty <mike.auty@...277...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--S7lsFU7etnaafL2ESRRxcL1DPeSEIMEgG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 08/01/16 21:32, Mike Auty wrote:
> Hiya Gert,
>=20
> Thanks for the reply.  Obviously I'd prefer to see this merged into the
> main codebase than have to maintain the changes externally as the tree
> changes, but I understand the nature of volunteer projects.  I'm happy
> to submit the patches individually, but I'm slightly concerned that the
> original author made corrections as he went along, meaning there are
> many more patches than actual changes to the code.=20=20
>=20
> I'm not sure how to squash the patches down and maintain the authorship
> and appropriate comments?  Is there a simple way to do this or will I
> have to have ask the author to recraft and minimize the commits?

The best would be if those of you interested in getting these patches
into OpenVPN unite forces.  Establish a git tree you all can at least
clone.  And apply needed patches as you fix things.  How you do this is
entirely up to all of you being involved.  This way, more can be
involved in this process and you expose this side-project of OpenVPN.

I would even go so far to suggest that you can use the openvpn-devel
list for discussing issues and patches too.  Then those involved in
pulling these things into the mainline will also better be able to see
both the interest for these patches and understand better how this is
resolved.  You might even get some input from the core developers.

> If this feature doesn't make it into 2.4, is it significant enough to
> have to wait for 2.5 before it becomes mainlined or could it see the
> light of day in a 2.4.x release?  I'd primarily like to ensure that all
> requirements for getting it integrated are met and that it does then get
> integrated (since the patchset had existed against various trees since
> 2011 and trying to follow the history it isn't clear why it hasn't been
> merged earlier other than interest).

We generally do not want new features into patch-level releases (2.3.x,
2.4.x).  With that said, none of us would have thought 2.3.x we would do
10 patch-level releases for 2.3.  We generally want to do major releases
more often.  But many of us have been more time restrained after 2.3 was
released, so 2.4 have not had the pace we intended.

> I'm not sure how to generate more interest (and I'm slightly surprised
> more people aren't asking for this feature, given it can reduce multiple
> instances of openvpn down to a single multi-vlan endpoint).  Do you have
> any suggestions for how to deal with this requirement (given the others
> are largely technical)?

As I said, get a published git tree out to the public with some activity
... maybe even do some point-releases with source packages.  And use our
mailing lists, I think this is important enough that getting a broader
public discussion will be beneficial for all.  Getting exposure is often
the needed detail :)


--
kind regards,

David Sommerseth


--S7lsFU7etnaafL2ESRRxcL1DPeSEIMEgG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlaQIBkACgkQDC186MBRfrpVXQCgjNuKdylvap511/NJAZgS4nC2
oEcAnREMC0wEI999dl8fYqS1KxjEQlLA
=ZyDl
-----END PGP SIGNATURE-----

--S7lsFU7etnaafL2ESRRxcL1DPeSEIMEgG--

