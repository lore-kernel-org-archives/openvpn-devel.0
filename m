Message-ID: <4D875453.2000508@...515...>
Date: Mon, 21 Mar 2011 15:36:19 +0200
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <4D836B41.2040600@...515...>	<AANLkTi=VPAkEkUjPWgEqZg_p+Fspuc=v5kEPe3z5LN=+@mail.gmail.com>	<4D8376F0.3080202@...515...>
	<AANLkTimARrUoZR5-B92_c2mXgEF4QUW475ZqYuhTERU-@...278...>
In-Reply-To: <AANLkTimARrUoZR5-B92_c2mXgEF4QUW475ZqYuhTERU-@...278...>
Subject: Re: [Openvpn-devel] First OpenVPN 2.2-RC2 preview available
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Alon,
> Hello,
>
> GIT/SVN repository is expected to be published clearly in opened
> source projects, just like you have Download option in menu, there
> should be Source or similar.
>=20=20=20
Agreed, Git repo is too hard to find currently. I'll get this fixed.
> If your git is the one that is candidate for next release, publish it,
> better something than nothing.
>
> Also, please install gitweb, so the repository can be tracked online.
>=20=20=20
The "beta2.2" branch in Git is the basis for the next release. It's
hosted on SF.net, and instructions for using it are here:

<https://community.openvpn.net/openvpn/wiki>

Trac has it's own Git browser, but it's pretty slow and does not scale
up well. Fortunately SF.net provides a GitWeb interface already: click
on the "Source" link in Trac panel. Or use this direct link:

<http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=3Dopenvpn/openvpn-test=
ing.git;a=3Dsummary>
> You should have a branch for the "james" openvpn so people know what he a=
cked.
>=20=20=20
James' SVN tree is just another "external" tree, like cron2's or jjo's.
All ACKs James gives will be announced on openvpn-devel and will also
show up in Git commit logs.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


