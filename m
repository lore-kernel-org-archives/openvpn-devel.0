Message-ID: <5166C1ED.9040209@...1114...>
Date: Thu, 11 Apr 2013 16:00:13 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1346422753-19520-1-git-send-email-arne@...1227...>
	<201304110933.r3B9XwPT011987@...1729...>
	<20130411105202.GA26778@...1296...>
	<5166B459.9020801@...515...>
	<20130411131748.GR569@...1296...> <5166B9BE.80201@...515...>
	<20130411132757.GV569@...1296...>
In-Reply-To: <20130411132757.GV569@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2JXPVFMVUAUHFABLJNIMG"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add the client id (CID) to
 the output of the status command
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2JXPVFMVUAUHFABLJNIMG
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 11/04/13 15:27, Gert Doering wrote:
> Hi,
>=20
> On Thu, Apr 11, 2013 at 04:25:18PM +0300, Samuli Sepp=E4nen wrote:
>> As long as nobody is actually using the staging repo rewriting history
>> should not be an issue. Perhaps one could just do
>>
>> $ git reset --hard HEAD^1
>> $ git push origin master
>>
>> and be done with it?

Do not ever do that without fully understanding what it does.  Basically
it rewrites the git history, and others who have cloned this repo will
get ugly warnings from git on the next git-fetch.  Whenever such
warnings appears, it can indicate that the git tree has been
compromised.  And if you have some merges involved and do this on a
merge commit ... well, things gets even more complicated.

This operation should only be done when no other alternatives will work.
 It is the last resort of a git fix.

By all means, use git-reset, but avoid it once you've pushed out a
commit you want to remove.  If you use git-reset on a local un-pushed
tree, that's all fine.  That's called cleaning up before you push.  But
once pushed, rather clean it up differently.

> Will that un-push already-pushed commits?  Or just have "one commit less
> than $remote" in your local repo?

Yes, and it will make users of such a git tree become suspicious.

I rather recommend using 'git revert' instead.  Which simply reverts the
commit, you add a reason why it was reverted ... and it's all logged as
a new separate commit.  Much cleaner, and it documents what we've tried
and why we didn't use the patch after all.  We don't need to be ashamed
of pushing out things which breaks, as long as we fix it.


--=20
kind regards,

David Sommerseth


------enig2JXPVFMVUAUHFABLJNIMG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFmwe8ACgkQDC186MBRfromJACfYBTsAU0cIqbzUm5x0YtqrdcS
UsQAoIN5LV15kQqXBgHcxGhYyv4nc4hu
=38zu
-----END PGP SIGNATURE-----

------enig2JXPVFMVUAUHFABLJNIMG--

