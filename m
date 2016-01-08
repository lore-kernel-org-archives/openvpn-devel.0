Date: Fri, 8 Jan 2016 19:53:12 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160108185312.GO24952@...1296...>
References: <567EA6B5.9040108@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s599DUe1LoD7GyL8"
Content-Disposition: inline
In-Reply-To: <567EA6B5.9040108@...277...>
Subject: Re: [Openvpn-devel] Fabian Knittel's 802.1q/VLAN tagging support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Mike Auty <mike.auty@...277...>
Cc: openvpn-devel@lists.sourceforge.net, David Sommerseth <dazo@...2108...>

--s599DUe1LoD7GyL8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Dec 26, 2015 at 02:39:49PM +0000, Mike Auty wrote:
[..]
> Given I didn't author most of these patches (I fixed up a tiny bit of
> documentation at the end), I was wondering how best to supply these so
> that they could be considered for inclusion in the main tree?  Should
> I submit a pull request from my repo with all the patches applied [4],
> or post the git format-patches to this mailing list, or is there
> another method I should be using?

I'm aware of these patches (as is David), but so far the interest has not
been high enough to prioritize them and get them properly reviewed and
tested.  As you have noticed, the patch set is fairly big, and touches
quite a bit of code - and since we'll have to maintain that code from
that point on, it needs to fulfill "enough interest" and "the currently
active maintainers understand it well enough" (for the packet code, that
would be mostly Arne and I...)

Process-wise, we do not deal in pull requests but patches need to be sent
(with git send-email) to the openvpn-devel list for public review, and
merging with a reference to the public list archive.

I'm not saying that these patches won't go in - but it will not happen
in the close future.  Main focus right now is to get lots of small things
fixed, get AEAD, pushable ciphers and iservice in, and release 2.4.0
(so people can enjoy proper dual-stack support, proper IPv6-over-IPv6
support, full peer-id floating, etc.) - and since interest for vlan=20
tagging has not been that high, it's likely not going in.

Sorry if that wasn't the reply you wanted to hear.  We're doing our best,
but days are short...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--s599DUe1LoD7GyL8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVpAFl6kuBuNlUUl1AQLAqQP8CprHq+lF5SouUctXZLsELbEJo/5xIQVt
6R5vR9tAumYqagQBtfP+nHlfS0Uxq1lL5pfH6AKy+5rCUwd9eY7lIdySNbK8ii/b
hVMJix/L0LRb/WTER2jq+ZKqXrIurSKWZ4wm9d0YNPbJNZJ/udr7lK1R/gXy6/2K
XAa9MhVV2Rg=
=G1hP
-----END PGP SIGNATURE-----

--s599DUe1LoD7GyL8--

