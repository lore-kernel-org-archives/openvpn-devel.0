Message-ID: <4B263634.3050000@...515...>
Date: Mon, 14 Dec 2009 14:57:24 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1260552743.31755.0@...1207...> <4B237608.6030109@...515...>
	<4B23DCE2.20607@...1114...>
In-Reply-To: <4B23DCE2.20607@...1114...>
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
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

David Sommerseth ha scritto:
> On 12/12/09 11:52, Samuli Sepp=E4nen wrote:
> >> FWIW using a good (rather than merely adequate) revision control
> >> system makes it much easier to keep the very latest code
> >> on-line and still perform regression tests, keep separate
> >> code branches for feature development, and so forth.
> >>=20=20=20
> > Any suggestion which VCS would do the best job?
>
>
> Then I'll throw in my burning piece of wood to fire ;-) ... Well,
> discussing VCS'es is a really tricky thing, and sometimes can become
> more a religious war than a technical war.  Especially VCS discussions
> seems often to hit the nerve of emotions.  Just to make that clear, I do
> not want to contribute to a "religious" war, but purely look at the
> technical point of view.  But it is based on my experiences, and I
> admit, I have not tried all solutions.  I have strong opinions, but I
> don't mean to attack anyone with them.
>
> My experiences is mostly based on CVS, SVN and git.  Even though, I have
> barely touched Mercurial/hg.  And I'm not going to discuss CVS, as
> that's not a good solution at all, IMHO.  In addition, it's centralised,
> not distributed.
>
> I've been following the Apache Qpid project somewhat for sometime
> earlier.  At that time it was based on SVN, and to be honest, it was a
> nightmare to work with.  To get the commit log, it took over 10-15
> seconds or so.  To pull down the complete tree took over 30 minutes,
> with a very decent connection (8Mbit++).  I believe the reason is that
> it was over 65.000 commits in the tree.  Branching is also somewhat
> cumbersome, even though it do work.
>
> Then I've been working with the Linux kernel.  A git repository which is
> getting close to 7-800MB (haven't checked in a while), it contains
> several years of commit history (it goes back to the 2.6.13 kernel or
> so, iirc).  And it takes milliseconds to look into the commit log.
> Cloning the kernel is done in 10-15 minutes tops, on the same connection
> as Qpid via SVN.  Everyone can create their own branches (in
> milliseconds), and can easily provide patches suitable for mailing.  In
> fact, you can send the patches via mail directly if you configure things
> correctly.  You can use multiple remote repositories which you can
> track, and you merge in the remote branches how you like yourself.
>
> What that means:  Everyone will pull at least one public git tree, which
> James "ownes".  Then James will have his "inner circle" with, f.ex.
> three persons.  Each of these three persons have their own public git
> trees, at least public to James.  These persons retrieve patches for
> review either via mail, patch files or other remote trees.  They will
> merge in changes into their own trees and publish their tree.  James
> will then only need to pull these three trees and merge them, whichever
> way James likes.  And when James is happy, he pushes his tree out.  Now,
> the good thing - if this is done right, people who committed changes to
> their own local trees, and git their trees pulled somehow by someone
> else closer to James, they can pull James' tree and merge it, without
> have no conflicts.  In fact, they might even find their commit ID's
> staying the same (depending on how patch was merged in on the way to
> James' tree).
>
>
> And git *is* pretty *easy* to get started with /nowadays/ (it's many
> years since it was difficult to use and more "kernel oriented").  Coming
> from the world of CVS and SVN, it took me 2-3 hours to de-learn CVS/SVN
> and 30 minutes to learn the basic git stuff.  And now, I can hardly
> imagine anything else.  I even use it for non-source code stuff too now,
> whenever I need to track some changes, and it takes me less than 10
> seconds to get it ready for it (really!).
>
> A very good resource for learning git, is a book called "Pro Git" ...
> <http://progit.org/book/>.  A video of Linus explaining his thoughts
> behind git, can be viewed here:
> <http://www.youtube.com/watch?v=3D4XpnKHJAok8>
>
>
> But if SVN is preferred by OpenVPN, I'll most probably make use of
> git-svn, which is a SVN client for git.  It at least speeds up things
> for me, even though there are some awkward things with this, trying to
> make git stuff out of SVN, as that's not always easy due to the very
> different way of VCS designs ... but it do work somehow, and when the
> cloning is done - it is very fast again.
>
> So for me, git is among the greatest VCS' and, IMO, superior to SVN ...
> and I would therefore recommend git.  But it's not the only solution.
>
>
> kind regards,
>
> David Sommerseth
Any objections to GIT? If not, we should consider using that as our
primary future VCS. That is, when we can agree upon a new development
model that benefits from using it. I definitely need to delearn my SVN
skills, too, and start digging into GIT.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc




