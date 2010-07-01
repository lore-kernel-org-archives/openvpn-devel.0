Mime-Version: 1.0 (Apple Message framework v1081)
From: Eric F Crist <ecrist@...1286...>
In-Reply-To: <20100701145951.GI4340@...1276...>
Date: Thu, 1 Jul 2010 11:29:29 -0500
Message-Id: <EE309900-A83C-466B-9DDF-B2A870EE24BB@...1286...>
References: <4C2B07C1.9050500@...515...>
	<20100701145951.GI4340@...1276...>
Subject: Re: [Openvpn-devel] Packaging OpenVPN for various platforms?
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
To: Till Maas <opensource@...519...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-owner@...1385...

This will not work for freebsd.  This is what the ports tree is for.

Eric


On Jul 1, 2010, at 09:59:51, Till Maas wrote:

> On Wed, Jun 30, 2010 at 12:00:49PM +0300, Samuli Sepp=E4nen wrote:
>=20
>> - write packaging instructions to our Trac wiki
>> (https://community.openvpn.net/openvpn/wiki)
>> - convert the instructions into BuildBot code (BuildSteps)
>>=20
>> After this is done, we can provide the latest version of OpenVPN for
>> various platforms with minimal manual effort. This helps developers as
>> well as users: having the development code in wider circulation helps
>> spot problems faster resulting in faster release cycle.
>=20
> I am a Fedora package maintainer, but not one of OpenVPN. I CC'ed them
> in case they did not notice this.
>=20
> The Fedora package scripts are currently available here:
> http://cvs.fedoraproject.org/viewvc/rpms/openvpn/devel/
>=20
> In the not so far future this URL will not be valid, because Fedora
> switches to git.
>=20
> Packages for Fedora are usually build within a chroot using a helper
> tool called mock[0] and I do not know how well it works on other
> distributions except Fedora or RHEL/CentOS. There are also scripts
> developed to easily build new rpms from SCM and afaik currently only git
> is supported (I do not know what OpenVPN currently uses, but I suspect
> it's SVN):
> https://fedorahosted.org/fedora-packager/ticket/8
>=20
> Adding support for SVN or other SCMs should not be that hard. I will try
> to write something up how to put all this together to easily build new
> OpenVPN Packages for Fedora using a SCM checkout.
>=20
> Regards
> Till
>=20
> [0] http://fedoraproject.org/wiki/Projects/Mock
> -------------------------------------------------------------------------=
-----
> This SF.net email is sponsored by Sprint
> What will you do first with EVO, the first 4G phone?
> Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first___________=
____________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

---
Eric Crist





