Mime-Version: 1.0 (Apple Message framework v1084)
From: Seth Mos <seth.mos@...1458...>
In-Reply-To: <20120513111240.GK1359@...1296...>
Date: Sun, 13 May 2012 13:40:07 +0200
Message-Id: <65AA0B7D-D286-4DF3-94BA-F2EC1ED7413B@...1458...>
References: <CAOazyz3QDHLxY51u0Ya9PscD8Q5+VqqrSn6M6=XpVUiFJY_ENw@...278...>
	<4FA8D931.70107@...515...>
	<CAOazyz2N744s+VJekGJNK4sqHCONLCzMtsiJyRTkgrpO4RWHzw@...278...>
	<363B57F6-F3E8-4C7D-A19D-0E08541233BD@...1286...>
	<20120513090153.GG1359@...1296...>
	<CAOazyz1FB+JU7QRmeMuxMX7-6fAN28VH1-6ApJnOu7eHDq9jUA@...278...>
	<20120513092355.GH1359@...1296...>
	<CAOazyz0=+ZE6+n-KqyzZSJhbweHb236LjwefvV6BtMvfbh37mQ@...278...>
	<20120513093551.GI1359@...1296...>
	<CAOazyz0bEZMBYcKGvKTux=+7XE43=-4Aw02HGVCNHPoO35wAWg@...278...>
	<20120513111240.GK1359@...1296...>
Subject: Re: [Openvpn-devel] [RFC] Split plugins into their own repositories
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Chiming in here,

Although pfSense is basically a giant tarbal, it has the benefit of being s=
ure that all parts of it fit together. We also have installable packages an=
d we frequently see issues with that. We are trying to solve some of them u=
sing PBI packages just so that each "package" always has it's dependencies =
in check.

Although we are just a "consumer", we'd rather have a single FreeBSD port t=
hat we build then 5 ports we need to update, with all the required dependen=
cies.

Our github repo is split into one for packages, tools and pfSense. But each=
 is really a standalone thing, because there is no overlap. Which probably =
my point, the plugin is useless without the main.

The one git repo for pfSense is pretty manageable, even more so through git=
 with Pull requests. The single biggest jump in commits and patches from th=
e community is moving to GitHub. It makes contributions so much easier. Tha=
t said, even for us the amount of simultaneous active coders is about 5, al=
though we do see small patches and pull requests from about 30 or so people=
 a year.

I see nagios using nagios-plugins, that has seperate releases from the main=
 nagios. So there's that too.

Just a few thoughts from the other end.

Really, really, _really_ looking forward to Viscosity and Tunnelblick shipp=
ing Ipv6 enabled clients. Pretty please.

Cheers,

Seth
pfSense developer

Op 13 mei 2012, om 13:12 heeft Gert Doering het volgende geschreven:

> Hi,
>=20
> On Sun, May 13, 2012 at 02:00:32PM +0300, Alon Bar-Lev wrote:
>>>> Can't we progress?
>>>=20
>>> Why is that progress?
>>>=20
>>> Change always has drawbacks.  If the plus sides outweighs the drawbacks,
>>> change is good.  Change for change's sake, "just because you can change
>>> it", is not.
>>=20
>> Yes, but still from your responses I don't see any drawback... maybe I
>> am slow learner...
>=20
> Drawback to maintainers and sysadmins has already been mentioned by
> ecrist and me.  Try being a sysadmin for a few weeks and figure out
> which bits of xorg you need to download to install xinit, assuming
> you have a system without any X libraries and headers yet (in the xorg
> example: splitting off "xinit" might actually make sense, but splitting
> the basic infrastructure to build anything into about 50 different
> "xyz-library" and "xyz-headers" packages is crazyness).
>=20
> But the onus is not particularily on me: you have not put forward=20
> convincing arguments why splitting off a very small number of files=20
> that only make use in the context of OpenVPN into their own repository=20
> has any *advantage*.
>=20
> The handwavy argument "it will attract more users!" can be countered by
> similarily handwaving "I, as a user, hate to download multiple packages
> to figure out how to start contributing, and so it will scare *away*
> users".
>=20
>=20
> As a counterexample, look at Apache.  They have heaps of modules in
> the main tarball, and have no issues with frequent release and with
> attracting developers.  And still, modules maintained by non-apache
> developers can be developed externally, without having to splitt off
> all existing modules beforehand.
>=20
> gert
> --=20
> USENET is *not* the non-clickable part of WWW!
>                                                           //www.muc.de/~g=
ert/
> Gert Doering - Munich, Germany                             gert@...1296...
> fax: +49-89-35655025                        gert@...1297...
> -------------------------------------------------------------------------=
-----
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and=20
> threat landscape has changed and how IT managers can respond. Discussions=
=20
> will include endpoint security, mobile security and the latest in malware=
=20
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/_______=
________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


