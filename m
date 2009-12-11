Date: Fri, 11 Dec 2009 11:32:23 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <4B20CFFD.5090900@...515...> (from samuli@...515... on Thu
	Dec 10 04:39:57 2009)
Message-Id: <1260552743.31755.0@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN project organization [WAS: Introducing
 OpenVPN Community Manager]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Samuli =?iso-8859-1?q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 12/10/2009 04:39:57 AM, Samuli Sepp=E4nen wrote:
> David Sommerseth ha scritto:

> > I believe James have received several patches in the past from
> people on
> > the mailing list - or directly.=20

> > They will either include patches into their own source
> trees, or
> > kick them back to be reworked or cancelled completely.
> >
> > Patches which are accepted will then be sent to James for a final
> review
> > and inclusion.  If James don't like it, it must be discussed on the
> > mailing list so that everyone can see and understand why it was
> rejected
> > and how to make it more acceptable for inclusion.  If James can=20
> take
> the
> > time to bring this discussion on the mailing list directly himself
> in
> > these cases, that would bring the needed transparency.  Further, it
> > should hopefully not happen too often, as James' "inner circle"
> should
> > already have made sure it is suitable for inclusion.

Via public discussion.  Who wants to submit a patch when it
just disappears without comment.  Public discussion has been
sorely lacking in the past.

> >  Even
> patches
> > these people write themselves should be posted to the openvpn-devel
> list
> > (or other another more suitable one).  That way, more eyes can pay
> > attention and raise awareness if something seems to be wrong or
> needs to
> > be discussed.

Absolutely.  Public discussion of all submitted patches is essential.

When you can commit to public discussion of submitted patches
then I'll re-send at least one.  (Something very minor.)

> > Another topic which is needed to be included is documentation.=20=20
> This
> > would be to organise the documentation and make sure all features
> are
> > documented, review documentation to make sure it works as expected
> etc,
> > etc.  This part do not necessarily require any coding skills at=20
> all.

However, it _could_ be a requirement that all patches be submitted
with documentation.  If not, I can't see how you'd want to
include any functional changes without also having documentation
so somebody else would have to be gotten to document the patch.
This is obviously up to whomever reviews the patches.


> > What I do see as much more urgent is actually a better distributed
> > VCS/RCS.  I believe SVN is used now - but I don't recall where I
> found
> > the URL for it (and I have lost now, I believe).  There's also a
> rather
> > outdated CVS tree on sourceforge.net.  This needs to be cleaned up,
> and
> > a publicly available source tree must be made available.

> > David Sommerseth

> The SVN repository URL's are here:
>=20
> http://www.openvpn.net/index.php/open-source/documentation/
> miscellaneous/subversion-repository.html
>=20
> I checked the logs and last update in 2.1 branch was from 2009-11-20,
> so
> it's probably 100% up-to-date. I agree with you for the most part.
> Beaker sounds interesting, as I guess OpenVPN probably lends itself
> well
> to automated testing.=20

Are you saying that there has been no development on OpenVPN since
2009-11-20, approximately 20 days ago?  That seems a long time
for James to have done no work on the code or documentation.

A public revision control repository means that the public gets
to see all the changes as they are committed.  It does not mean
that we get to see the code only at arbitrary release points.

There are 2 reasons for this.  The first is trust and transparency.
We want to see where the code is going as it gets there so
we can make our plans.  The second is to assist the people who
review submitted patches.  Submitted patches should, by
strong preference, be against the very latest version
of the code.  This keeps merge conflicts, and related bugs,
to a minimum and makes the job of reviewing patches much
easier.

If you don't have a public version of the latest development
code you can't be said to be running an open project.

FWIW using a good (rather than merely adequate) revision control
system makes it much easier to keep the very latest code
on-line and still perform regression tests, keep separate
code branches for feature development, and so forth.

What's the real policy regards the SVN repository and
what are the concerns that have driven this policy?

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


