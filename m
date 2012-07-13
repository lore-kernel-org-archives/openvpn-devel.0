MIME-Version: 1.0
In-Reply-To: <500012F6.9030108@...515...>
References: <500012F6.9030108@...515...>
Date: Fri, 13 Jul 2012 20:30:01 +0300
Message-ID: <CAOazyz3iwPa=-m5XdgpS6nUnNsugKxCwW0NPGikR7QzGvpuLwA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Openvpn-2.3_alpha2 and easy-rsa-2.2.0_master
 packages and packaging files published
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
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello Samuli,

Why didn't you use rpmbuild -tb <tarball>.tar.gz?
And if you have changes in spec file you should probably add this with
proper conditionals to the spec file within the appropriate package.

There should be no external resource maintained.

The debian packaging should also be integrated within project.

Alon

On Fri, Jul 13, 2012 at 3:22 PM, Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:
> Hi all,
>
> I've just finished packaging openvpn-2.3_alpha2 for Debian/Ubuntu and
> Fedora/EL. As the packaging files required significant changes on both
> Debian and RPM front, I've put them here for others to use/improve:
>
> <http://build.openvpn.net/downloads/packaging>
>
> The packaging highlights for the 2.3_alpha2 are:
>
> - easy-rsa split into it's own architecture-independent package
> - packages for Ubuntu 12.04
> - debian packaging files made as generic as possible, only Ubuntu 12.04
> files having required minor changes
>
> CentOS/EL6 is still missing the new packages as I don't have direct
> access to the CentOS build computers until next Monday. All other
> packages are already in their respective ("-snapshot") repositories.
>
> For details on how to use our software repositories, please look here:
>
> <https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos>
>
> If you encounter any issues with the packages, please let me know! Also,
> any suggestions on where to host these files in the long run are most
> appreciated! Perhaps "openvpn-build" repository would be the least bad
> place?
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
> -------------------------------------------------------------------------=
-----
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond. Discussions
> will include endpoint security, mobile security and the latest in malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

