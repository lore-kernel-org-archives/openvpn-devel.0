Message-ID: <4B56DD56.6000804@...515...>
Date: Wed, 20 Jan 2010 12:39:18 +0200
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <4B4DBCE6.2010500@...515...>
	<20100113174945.12137.qmail@...1287...>
In-Reply-To: <20100113174945.12137.qmail@...1287...>
Subject: Re: [Openvpn-devel] Summary of the "OpenVPN
	development	model"	meeting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Peter Stuge ha scritto:
> Samuli Sepp=C3=A4nen wrote:
>=20=20=20
>> Most other tasks are dependent on the setup of the community site.
>> A somewhat realistic estimate for finishing them is 1-2 months.
>>=20=20=20=20=20
>
> Let me know (maybe off-list) if you want some hints on setting up
> Trac with git support.
>
> Trac is nice because it offers both tickets and a wiki. Some projects
> do a really nice job using Trac for everything by changing the
> styling; e.g. http://madwifi-project.org/ have it looking so nice
> that no second site (MediaWiki) is neccessary.
>
> Trac currently does not yet have stellar coverage for multiple
> related projects. Components can be used, but it may not be enough.
> A single 0.12 Trac can supposedly run with several repostiories, but
> I don't have experience from this (yet). Some links:
>
> http://trac.edgewall.org/ticket/130
> http://trac.edgewall.org/wiki/TracMultipleProjects
> http://trac.edgewall.org/wiki/TracMultipleProjects/SingleEnvironment
> http://trac.edgewall.org/wiki/VcRefactoring#SupportforMultipleRepositories
>
>
> //Peter
>=20=20=20
Hi all,

I dug a little deeper into Trac and to Redmine, which was another
candidate for the (developer) site. I took a look at Git support which
we need (if we need to start using Git later on). Trac has had some
_serious_ performance problems when using the GitPlugin to browse Git
repositories. These problems are apparently due to the architecture of
the GitPlugin. It seems they have not yet been fixed. However, one "fix"
may be to integrate GitWeb with Trac using the GitWebPlugin. Redmine, on
the other hand, seems to support Git better, but has it's share of minor
Git problems, too. Also, Redmine does not yet seem to support multiple
Git branches without dirty hacks. Trac has a very wide array of actively
developed plugins available. Redmine has quite a few, but not as many as
Trac. Trac was also the clear favorite among everyone in the community
site meeting. We also have in-house expertise with Trac and Python,
which makes it easier for us to deploy and maintain.

I've used both Trac and Redmine, and I think the main advantage of
Redmine is better support for multiple projects. As the links Peter
provided show there are several ways to host multiple projects using
Trac. None of these are 100% solutions, but I'd put them in the "good
enough" category. Also, better support for multiple projects should be
coming in next release (0.12). It's not clear, however, when that
release will be made (see http://trac.edgewall.org/roadmap).

I suggest we choose Trac for our developer site. I think we should still
have a simpler, less development-oriented site for casual users and for
general, non-developer content (wiki, forums, etc.). I think both Trac
and Redmine sites feel too developer-oriented, no matter how much the
themes are customized. What do you think?


Btw. here are a few links I gathered during the research process...

IRC meeting summaries:

http://sourceforge.net/mailarchive/message.php?msg_name=3D4B4DBCE6.2010500%=
40openvpn.net
http://sourceforge.net/mailarchive/forum.php?thread_name=3D4B4DBD75.20406%4=
0openvpn.net&forum_name=3Dopenvpn-devel

Sites using Redmine:

http://www.redmine.org/
http://redmine.lighttpd.net/
http://redmine.ruby-lang.org/

Sites using Trac:

http://madwifi-project.org/
https://trac.macports.org/wiki
http://trac.edgewall.org/
http://trac-hacks.org/wiki

GitWeb:

http://git.or.cz/gitwiki/Gitweb
http://git.kernel.org/
http://trac-hacks.org/wiki/GitwebPlugin

Git support for Trac:

http://trac-hacks.org/wiki/GitPlugin

Git support for Redmine:

http://www.redmine.org/wiki/1/RedmineRepositories

Trac plugins:

http://trac-hacks.org/wiki/plugin

Redmine plugins:

http://www.redmine.org/wiki/redmine/Plugin_List

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


