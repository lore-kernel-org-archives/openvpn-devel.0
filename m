From: Jens Neuhalfen <openvpn-devel@...2127...>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_504CE506-1A07-4D6E-8D40-4E16BE43A16C"
Message-Id: <D7D7D1CE-BFD0-4C0E-B5C3-6E9EDE4E2C3B@...2127...>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Date: Fri, 29 Apr 2016 10:46:44 +0200
References: <AAA08590-8376-431C-AE96-44060D64C6D9@...2127...>
In-Reply-To: <AAA08590-8376-431C-AE96-44060D64C6D9@...2127...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] add test servers to use with
	t_client.sh
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <Openvpn-devel@lists.sourceforge.net>

--Apple-Mail=_504CE506-1A07-4D6E-8D40-4E16BE43A16C
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi  everyone,

I reworked the scripts, and put them in a PR for comments: https://github.c=
om/OpenVPN/openvpn/pull/45 <https://github.com/OpenVPN/openvpn/pull/45>

cheers
Jens

> On 23 Apr 2016, at 17:48, Jens Neuhalfen <openvpn-devel@...2127...> wrote:
>=20
> Hi,
>=20
> this patch will add test servers to use with t_client.sh. This will make =
testing on different systems much easier. Bonus: testing on a laptop is a b=
reeze.
>=20
>=20
> Virtual machines are defined by [Vagrant](https://www.vagrantup.com) scri=
pts. Virtualbox is used for virtualisation.
>=20
> Each of the virtual machines is configured to compile openvpn and run a s=
erver.
>=20
> Inside the vm a openvpn server can be launched to run `t_client.sh` tests=
 against it. Sample launcher scripts are provided.
>=20
>=20
> Patch as attachment because of its size.
>=20
> Jens
> <0001-add-test-servers-to-use-with-t_client.sh.patch>


--Apple-Mail=_504CE506-1A07-4D6E-8D40-4E16BE43A16C
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html charset=
=3Dus-ascii"></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode=
: space; -webkit-line-break: after-white-space;" class=3D"">Hi &nbsp;everyo=
ne,<div class=3D""><br class=3D""></div><div class=3D"">I reworked the scri=
pts, and put them in a PR for comments:&nbsp;<a href=3D"https://github.com/=
OpenVPN/openvpn/pull/45" class=3D"">https://github.com/OpenVPN/openvpn/pull=
/45</a></div><div class=3D""><br class=3D""></div><div class=3D"">cheers</d=
iv><div class=3D"">Jens<br class=3D""><div class=3D""><br class=3D""><div><=
blockquote type=3D"cite" class=3D""><div class=3D"">On 23 Apr 2016, at 17:4=
8, Jens Neuhalfen &lt;<a href=3D"mailto:openvpn-devel@...2127..." class=3D"=
">openvpn-devel@...2127...</a>&gt; wrote:</div><br class=3D"Apple-interchan=
ge-newline"><div class=3D""><div class=3D"">Hi,<br class=3D""><br class=3D"=
">this patch will add test servers to use with t_client.sh. This will make =
testing on different systems much easier. Bonus: testing on a laptop is a b=
reeze.<br class=3D""><br class=3D""><br class=3D"">Virtual machines are def=
ined by [Vagrant](<a href=3D"https://www.vagrantup.com" class=3D"">https://=
www.vagrantup.com</a>) scripts. Virtualbox is used for virtualisation.<br c=
lass=3D""><br class=3D"">Each of the virtual machines is configured to comp=
ile openvpn and run a server.<br class=3D""><br class=3D"">Inside the vm a =
openvpn server can be launched to run `t_client.sh` tests against it. Sampl=
e launcher scripts are provided.<br class=3D""><br class=3D""><br class=3D"=
">Patch as attachment because of its size.<br class=3D""><br class=3D"">Jen=
s<br class=3D""><span id=3D"cid:5F0FC940-FAC9-4638-B1B0-BFD71C928B64@...2130...=
9...">&lt;0001-add-test-servers-to-use-with-t_client.sh.patch&gt;</span></d=
iv></div></blockquote></div><br class=3D""></div></div></body></html>=

--Apple-Mail=_504CE506-1A07-4D6E-8D40-4E16BE43A16C--

