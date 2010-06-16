Message-ID: <4C18C0D3.2010805@...515...>
Date: Wed, 16 Jun 2010 15:17:23 +0300
From: =?ISO-8859-2?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <499929A843E2C541A8AD31A881A2B6A206236F74@...1006...>
In-Reply-To: <499929A843E2C541A8AD31A881A2B6A206236F74@...1006...>
Subject: Re: [Openvpn-devel] [Openvpn-users] FW: Patch submission - git
	crash course ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-2"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

You could start from here:

https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation#Testingre=
positorygit

Take a look at the links in that chapter. You'd probably have to do
something like this:

apt-get install git-core
git clone <repository_url>
# do your changes
# then git <something> to create and mail a patch to -devel

Hope this helps, I'm not a Git wizard myself, either.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


> Hi!
>
> Is there some crash course for using git with openvpn sources?
>
> I know svn and other tools, but not git.
>
> So i need steps list like:
>
> apt-get install git
> svn co http://repo.openvpn.net/patchme # translated into git syntax
> #do your changes
> svn diff > my_patch  # again , git syntax
>
>
> Thanks!
>
> David Bala=BEic
>
> -------------------------------------------------------------------------=
-----
> ThinkGeek and WIRED's GeekDad team up for the Ultimate=20
> GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the=20
> lucky parental unit.  See the prize list and enter to win:=20
> http://p.sf.net/sfu/thinkgeek-promo
> _______________________________________________
> Openvpn-users mailing list
> Openvpn-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-users
>=20=20=20



