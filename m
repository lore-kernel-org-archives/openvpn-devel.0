References: <4B4DBCE6.2010500@...515...>
	<20100113174945.12137.qmail@...1287...>
	<4B56DD56.6000804@...515...>
In-Reply-To: <4B56DD56.6000804@...515...>
Mime-Version: 1.0 (Apple Message framework v1077)
Message-Id: <C9D1AE76-F7C2-4913-8F8D-0C0718922538@...1286...>
From: Eric F Crist <ecrist@...1286...>
Date: Wed, 20 Jan 2010 07:04:59 -0600
Subject: Re: [Openvpn-devel] Summary of the "OpenVPN development model"
	meeting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

On Jan 20, 2010, at 04:39:18, Samuli Sepp=E4nen wrote:

> Hi all,
>=20
> I dug a little deeper into Trac and to Redmine, which was another
> candidate for the (developer) site. I took a look at Git support which
> we need (if we need to start using Git later on). Trac has had some
> _serious_ performance problems when using the GitPlugin to browse Git
> repositories. These problems are apparently due to the architecture of
> the GitPlugin. It seems they have not yet been fixed. However, one "fix"
> may be to integrate GitWeb with Trac using the GitWebPlugin. Redmine, on
> the other hand, seems to support Git better, but has it's share of minor
> Git problems, too. Also, Redmine does not yet seem to support multiple
> Git branches without dirty hacks. Trac has a very wide array of actively
> developed plugins available. Redmine has quite a few, but not as many as
> Trac. Trac was also the clear favorite among everyone in the community
> site meeting. We also have in-house expertise with Trac and Python,
> which makes it easier for us to deploy and maintain.
>=20
> I've used both Trac and Redmine, and I think the main advantage of
> Redmine is better support for multiple projects. As the links Peter
> provided show there are several ways to host multiple projects using
> Trac. None of these are 100% solutions, but I'd put them in the "good
> enough" category. Also, better support for multiple projects should be
> coming in next release (0.12). It's not clear, however, when that
> release will be made (see http://trac.edgewall.org/roadmap).
>=20
> I suggest we choose Trac for our developer site. I think we should still
> have a simpler, less development-oriented site for casual users and for
> general, non-developer content (wiki, forums, etc.). I think both Trac
> and Redmine sites feel too developer-oriented, no matter how much the
> themes are customized. What do you think?

As I suggested during the IRC meetings, there is not yet a need for git and=
 the features of git, or another VCS, as SVN is meeting the current needs. =
 I think the developer community would not be 'upset' by a change later if =
it was deemed appropriate, and so a lot of time is unnecessarily being wast=
ed on researching this.

Until SVN is failing the organization, just keep using it.=20=20
---
Eric Crist





