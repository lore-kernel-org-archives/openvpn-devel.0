From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] Re: OpenVPN source repository migrated to svn (subversion)
Message-ID: <20050927230203.GA30828@...33...>
References: <Pine.LNX.4.58.0509262203120.25922@...41...> <dhbevm$sk9$1@...165...>
MIME-Version: 1.0
In-Reply-To: <dhbevm$sk9$1@...165...>
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
Date: Tue Sep 27 16:03:33 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Tue, 27 Sep 2005, Charles Duffy wrote:

> I'm not particularly fond of svn -- I think it's not nearly ambitious 
> enough[1] and have had DB corruption issues in the past -- but it's 
> certainly a big step up from CVS, and history stored in SVN can be far 
> less ambiguously retrieved.

I have worked quite a bit with Berkeley DB (which SVN set off with as
its database backend) in bogofilter, and while lots of things are to be
said about BDB robustness and corruptions, the most important point of
criticism is that one needs to take BDB by the hand and guide it, and it
doesn't tolerate application bugs that cause BDB to be used improperly.
If used properly, it's fast and solid - but then you've entered the
realm of transactions, and they're as awful to hack as GTK+ or assembly
language - it's all raw and low-level.

SVN has its shortcomings, and it's a huge beast, code-wise, but
switching programmers from CVS to SVN is easy.

> [1] [about competitors]
> though most of them do have downsides: Arch, for instance, is difficult 
> to learn and has poor win32 support, while Darcs is easy to learn and 
> portable but has serious scalability issues, and several of the others 
> are behind Arch or Darcs in terms of providing the above-mentioned 
> design features and functionality -- though there are some very new 
> systems (such as Git and Mercurial) which have impressive performance 
> characteristics, despite (as before) not having all the functionality 
> (or, in many cases, a design which allows straightforward implementation 
> of all the functionality) of the best-designed distributed SCMs.

I think that SCM systems are interesting to watch and to see what comes
out of it. After long years with everyone being happy between RCS and
CVS, some still on SCCS, some trying BitKeeper for a change, a lot of
projects have started, some have forked, and it's interesting to watch
some of them taking a second attempt before the first one had even
completely finished - SCMs are certainly a field where a lot of
development will take place in the near future.

For a maintainer however, he needs to get a job done. Trying the SCM of
the week will distract him from the real work, pull him into the depths
of meta data export, and in the end the situation might be worse than it
used to be even with CVS's serious shortcomings.

> [2] - Distributed operation is IMHO a killer feature doing open source 
> development: It means that 3rd parties working on their own patches have 
> revision control tools assisting them both in building the patch and 
> keeping it up-to-date with the maintainer's tools, and providing the 
> same level of support (ie. history of specific changes that went into 
> their patch/branch) that projects done by the maintainer receive. Having 
> worked on a few OSS projects using distributed revision control systems, 
> I find it quite hard to go back.

While they all have their advantages, they, too, need proper handling,
and you can also just import the upstream branch in your local SCM of
the day, clone the code and hack away, and then merge back. It gets, of
course, harder if you do a lot of work, but it's certainly OK for the
"occasional" patch - and lots of work in the OSS communities is that
someone sends a short patch, it's merged, and at that point, the local
separate branch becomes obsolete -- it was a single merge point, perhaps
two or three, and that's it.

I think if the SCM zoo has stabilized in two years, we hackers (I'm not
speaking for the OpenVPN project now) will have some more tools that a
maintainer can rely on, that are widespread and work well.

Those that caught my eye, and are open source, are listed in
<http://home.pages.de/~mandree/version-control-links.html> - chances are
there's a new promising contestant out that I've missed in the past
quarter or someone that used to be centralized has now gone distributed.

-- 
Matthias Andree

