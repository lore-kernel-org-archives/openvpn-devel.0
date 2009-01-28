Date: Wed, 28 Jan 2009 01:55:46 +0100
From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20090128005546.GA54840@...33...>
References: <20090127154806.GA38604@...33...>
	<9e0cf0bf0901270831l72b16993p1037df311fb50c74@...278...>
	<20090127172957.GA90386@...33...>
	<9e0cf0bf0901270934k4ed48d9bl227a807fa0cf0c42@...278...>
MIME-Version: 1.0
In-Reply-To: <9e0cf0bf0901270934k4ed48d9bl227a807fa0cf0c42@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix non-C89 comments
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Tue, 27 Jan 2009, Alon Bar-Lev wrote:

> > Perhaps the choice of version control system used for OpenVPN could
> >  deserve a second thought -- Mercurial or better Git might support such
> >  models or merge queues much better than Subversion does.
> >
> 
> Nope.
> subversion is the simplest one to use.

That's a moot point and depending on requirement no longer true (seems
to me this assertion has always been untrue WRT Mercurial that prints
helpful usage hints all along the way) -- let me state just three points
where I find Mercurial (Hg) or GIT superior to SVN, and that the basic
day-to-day operation is done with the usual set of checkout, diff,
branch, merge, commit, log commands in either of the systems.

(1) selective (partial/interactive) commits of hunks (built-in with Git,
try git commit -i or -p; for Mercurial, there's the record extension
that ships with the tarball proper)

(2) "properties" (svn propedit ... eek) and

(3) cheap & fast & really lightweight tags and branches. No need to
remember URLs and type three lines even for basic operations such as
tagging or branching. SVN is lightweight on the server's repository
database, but heavy on my fingers and local file system...

Further advocacy, comparisons, and tutorials are for other places of the
Internet than this list; let me just point towards Mercurial + MQ, Git
or StGit if you want patch queue handling.

Historical note: If you've last looked at an early Mercurial 0.X
version (current is 1.1.X), or a Git version before 1.5 (current is
beyond 1.6.1), you might want to know that lots of things have improved,
particularly usability and documentation. Git has evolved into a real
version control system that's usable.

-- 
Matthias Andree

