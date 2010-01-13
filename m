Message-ID: <20100113174945.12137.qmail@...1287...>
Date: Wed, 13 Jan 2010 18:49:45 +0100
From: Peter Stuge <peter@...1287...>
References: <4B4DBCE6.2010500@...515...>
MIME-Version: 1.0
In-Reply-To: <4B4DBCE6.2010500@...515...>
Subject: Re: [Openvpn-devel] Summary of the "OpenVPN development
	model"	meeting
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
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Samuli Seppänen wrote:
> Most other tasks are dependent on the setup of the community site.
> A somewhat realistic estimate for finishing them is 1-2 months.

Let me know (maybe off-list) if you want some hints on setting up
Trac with git support.

Trac is nice because it offers both tickets and a wiki. Some projects
do a really nice job using Trac for everything by changing the
styling; e.g. http://madwifi-project.org/ have it looking so nice
that no second site (MediaWiki) is neccessary.

Trac currently does not yet have stellar coverage for multiple
related projects. Components can be used, but it may not be enough.
A single 0.12 Trac can supposedly run with several repostiories, but
I don't have experience from this (yet). Some links:

http://trac.edgewall.org/ticket/130
http://trac.edgewall.org/wiki/TracMultipleProjects
http://trac.edgewall.org/wiki/TracMultipleProjects/SingleEnvironment
http://trac.edgewall.org/wiki/VcRefactoring#SupportforMultipleRepositories


//Peter

