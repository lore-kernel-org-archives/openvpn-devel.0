Message-ID: <4B6A9823.8010800@...1114...>
Date: Thu, 04 Feb 2010 10:49:23 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4B6564E1.1000506@...515...>
In-Reply-To: <4B6564E1.1000506@...515...>
Subject: Re: [Openvpn-devel] New development process ready
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 31/01/10 12:09, Samuli Seppänen wrote:
> Hi all,
> 
> I discussed the main development process of OpenVPN with James and a few
> community developers in the IRC. This is what I ended up with:
> 
> http://users.utu.fi/sjsepp/openvpn/getting_code_to_openvpn.png
[snip]
> - James maintains the "stable" OpenVPN tree and take care of stable releases
> - All code goes to "stable" through a "testing" tree
> - Merges from testing to stable are discussed on Thursday's meetings
> (19:00 UTC, #openvpn-discussion at irc.freenode.net)
> - James merges stable patches from "testing" to "stable" on Thu-Fri
> - If necessary, invasive new features are tested in separate
> feature-testing trees which are kept in sync with testing
[snip]
> Now all we need are people willing and capable of maintaining the
> "testing" tree. Any volunteers or suggestions :)?
> 

(Just for info - I have discussed this a little bit with Samuli, and we
agreed that I would send this mail for a public discussion.)

I am willing to maintain a testing tree, but to make it maintainable and
flexible for my ideas around this I'd prefer to keep this in a git tree.
 I'll base my git tree on the upstream (James' tree) SVN tree, and will
rebase against this tree.

What I am imagining is that I provide several branches in this tree,
which tracks the different patches/contributions separately.  And I will
then be able to keep one branch where all contributed patches are
gathered, which will be useful for testing all patches at once.  So the
branches will be:

     master	  -- Should be identical to SVN development branch
     bugfix2.1    -- Containing only bugfixes for OpenVPN 2.1
     {featureX}   -- Containing only patches for feature X
     {featureY}   -- Containing only patches for feature Y
     {featureZ}   -- Containing only patches for feature Z
     allmerged    -- All branches above merged

This gives James a possibility to only include/merge in the features and
bugfixes which he wants to include into his development branch.  And if
he wants it easy, and see that all branches have been tested enough he
can just merge in the 'allmerged' branch.

But I must warn those who wants to contribute patches as well.  I will
be critical and easily rejective if certain "rules" are not followed.

  - All patches should be useful and beneficial for several OpenVPN
    users, not just for "special case" situations.
  - All patches must contain an argumentation for *why* this patch
    should be included and *how* it solves the issue in plain English.
  - Everyone who has contributed to this patch should be mentioned,
    with at least a valid e-mail address, preferably with full name in
    addition.  (I want to give credit to contributors!)
  - All patches must be against the SVN development branch or git
    master branch, at least until a feature branch is created.
  - All initial patches must be sent as unified diff (diff -u)
  - Patches must be sent to the openvpn-devel mailing list, at least
    until a better patch tracker have been implemented.
  - Patches on the mailing list should preferably be start with [PATCH]
    in the subject field.  (This will not cause a direct rejection, but
    I might miss a contributed patch when parsing the mailing list)
  - Patches sent to me directly *will* be rejected.  All patches must be
    public and will be discussed in public.
  - If a lot of merge conflicts turns up when applying the patch, I will
    most likely reject the patch and ask for a new patch which applies
    cleanly.

If someone maintains their code in a git tree already, I am willing to
pull those git trees - as long as it will not cause any conflicts
against the master/SVN development branch I am maintaining.  But!  Pull
requests with an update of the changes must be sent to the mailing list.

Further, I would prefer if we could arrange with a ACK/NACK system of
patches.  That means that patches goes through minimum a "code review"
by at least one other person on the openvpn-devel mailing list.  And if
it looks good, it gives it either an ACK for acceptance or NACK for
disapproving it.  Ideally, I would only implement those patches which
gets at least one ACK.  The person ACKing would also be mentioned in the
commit log.  This way, it's not only me who reviews patches and only
contributions which makes sense to implement are included - and we avoid
spoiling the code base with features which is only requested for very
special conditions.

I will not commit to keeping it up-to-date continuously, but I expect to
work on this tree minimum once a week.  I will then rebase the master
branch against the upstream SVN tree (James' tree) and then merge the
master, bugfix21 and the allmerged branches are handled.

It is expected that each contributor which have received a feature
branch makes sure it merges cleanly against the development branch at
any time.  I will not maintain contributed features after the initial
patches have been sent.  I will only collect patches and make sure all
features and bugfixes play nicely together, to catch conflicts as early
as possible.  And of course do sanity review of all patches :)

So, for those wanting to test the "bleeding edge" openvpn tree, they
should then focus on the 'allmerged' branch in this openvpn-testing
tree.  As this tree might not be easily rebased or merged, I preserve
the right to scrap this branch and build it up again freshly by merging
all branches, whenever I feel the need for it.  Feature branches will
preferably use rebasing, but will merge whenever that is needed.

But a few things needs to be arranged for this to be work.  I need a
place where to put this openvpn-testing tree.  I have one openvpn
related project on sourceforge.net, where I can place it.  Another
solution is to put it under the OpenVPN project on sourceforge.net, if
that is acceptable for the OpenVPN company.  This will of course require
them to enable git there and to give me write access to it.

In addition I would need an overview somehow of all contributed patches
which has not made it into the OpenVPN SVN tree yet.  And if it has not
been sent to the openvpn-devel mailing list, it needs to be sent there.

I would also appreciate to have a wiki page somewhere where I would put
up an overview over all accepted contributions which gets a separate
branch.  This page should contain information about contributor, what
and how this feature solves and which git branch it can be found in.

It would be great if all patch contributors who have contributed patches
could contact me on IRC (freenode: ##openvpn-devel, nick: dazo),
especially if they are not sure or they know that their patch has not
been included yet in the SVN tree James keeps.

Of course, I am only going to do this if the community *and* OpenVPN
company accept my offer.  So unless somebody feel I'm not trustworthy or
not capable of doing this job, I will step aside and let others do this
job.  No hard feelings :)  But as I've not seen or heard about anyone
stepping up yet, so I take the chance of doing that now.


Any comments?  They are most welcome!


kind regards,

David Sommerseth



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAktqmB8ACgkQDC186MBRfroqEQCgjiEaOpskpZw9Jp1IgXVAuSHs
0FsAoJUL2O4ou03z1jy5b/wH+Do/DwNl
=BY+/
-----END PGP SIGNATURE-----

