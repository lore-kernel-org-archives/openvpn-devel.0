From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Re: OpenVPN source repository migrated to svn
 (subversion)
In-Reply-To: <dhbevm$sk9$1@...165...>
Message-ID: <Pine.LNX.4.58.0509271224590.25922@...41...>
References: <Pine.LNX.4.58.0509262203120.25922@...41...> <dhbevm$sk9$1@...165...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Sep 27 12:26:10 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Charles Duffy <cduffy@...294...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, 27 Sep 2005, Charles Duffy wrote:

> Feel free to ignore the below rant. Revision control is (or at least was 
> for quite some time) one of my pet topics, and I occasionally feel 
> compelled to bore people at parties (or on mailing lists) with a 
> discussion of the subject. I certainly don't mean to compell anyone to 
> switch RCSs a *second* time within a short period, though if a public 
> request for comments would have been made, I might have argued hard for 
> something different.
> 
> James Yonan wrote:
> > I used the cvs2svn tool to convert the repository, so all the previous cvs 
> > metadata such as branch tags are still there.
> 
> Heh.
> 
> As former maintainer of cscvs (a tool which was most often used to 
> import CVS history into GNU Arch), I'm more than a bit interested in 
> just how effective cvs2svn's changeset-generation turns out to be, 
> particularly in corner-cases (temporally overlapping commits or single 
> commits split by a conflict partway through; commits made from systems 
> with incorrect clocks [CVS uses the client's time, rather than the 
> server's]; commits with comments quoting "cvs log" output (rlog doesn't 
> quote user-provided data, so this can make parsing extremely hairy -- 
> though this isn't such an issue if one works off the ,v files, those 
> aren't always available); files implicitly created by CVS on the trunk 
> due to a new addition to a branch; or the many other corner cases 
> exposed by branching which I no longer have a good recollection of.
> 
> I'm not particularly fond of svn -- I think it's not nearly ambitious 
> enough[1] and have had DB corruption issues in the past -- but it's 
> certainly a big step up from CVS, and history stored in SVN can be far 
> less ambiguously retrieved.
> 
> 
> [1] - Consider that competing next-generation revision control systems 
> offer distributed operation (allowing 3rd parties to start their own 
> branches hosted on their own servers, and allowing easy merging between 
> these various branches[2]); that competing systems offer 
> "cherry-picking", which allows detailed tracking of which specific 
> changesets/patches have been applied on which branches and thus prevents 
> spurious merge attempts; that competing systems, being changeset- rather 
> than snapshot-based, can offer more intelligent merge algorithms... 
> though most of them do have downsides: Arch, for instance, is difficult 
> to learn and has poor win32 support, while Darcs is easy to learn and 
> portable but has serious scalability issues, and several of the others 
> are behind Arch or Darcs in terms of providing the above-mentioned 
> design features and functionality -- though there are some very new 
> systems (such as Git and Mercurial) which have impressive performance 
> characteristics, despite (as before) not having all the functionality 
> (or, in many cases, a design which allows straightforward implementation 
> of all the functionality) of the best-designed distributed SCMs.
> 
> [2] - Distributed operation is IMHO a killer feature doing open source 
> development: It means that 3rd parties working on their own patches have 
> revision control tools assisting them both in building the patch and 
> keeping it up-to-date with the maintainer's tools, and providing the 
> same level of support (ie. history of specific changes that went into 
> their patch/branch) that projects done by the maintainer receive. Having 
> worked on a few OSS projects using distributed revision control systems, 
> I find it quite hard to go back.

Charles,

You make good points, and I completely agree with you that long-term,
distributed SCMs are the way to go.

My main inclination in choosing SVN right now is that it's mature,
well-documented, fast, and is a (mostly) drop-in replacement for CVS which
we were using before.  SVN does a good job of accomplishing what it tries
to do, based on the collective experience of many years using CVS, and the
way that that experience helped us to construct a well-fashioned
understanding of just what an ideal CVS would like like (without jumping
out of the CVS model into the distributed SCM realm).  In many respects, 
SVN is simply the latest release of CVS.

The distributed SCMs on the other hand are trying to tackle a much more
challenging problem.  To a certain extent, even an agreed-upon, canonical
articulation of the distributed SCMs feature space is elusive at this
point. There's certainly a lot of great development occurring right now,
but the tools are going to be a moving target for some time.

So yes -- I'd love to switch to a distributed SCM, and I'd switch in a 
heartbeat if there was an open source alternative, say, of the same 
caliber as BK.  I'm sure that will happen in the next few years, but 
until then I don't feel that the OpenVPN project has scaled up in 
development activity so much that the choice of SCM is holding it back.

James


