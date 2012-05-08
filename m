Message-ID: <4FA8D931.70107@...515...>
Date: Tue, 08 May 2012 11:28:33 +0300
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <CAOazyz2FzRu8y6FR1xiygh=KCBB=q-N5HrjLLzn5q1_AgL_3ig@...278...>
	<4FA77AB9.7090001@...1114...>
	<CAOazyz3QDHLxY51u0Ya9PscD8Q5+VqqrSn6M6=XpVUiFJY_ENw@...278...>
In-Reply-To: <CAOazyz3QDHLxY51u0Ya9PscD8Q5+VqqrSn6M6=XpVUiFJY_ENw@...278...>
Subject: Re: [Openvpn-devel] [RFC] Split plugins into their own repositories
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
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>


> Hello David,
>
> On Mon, May 7, 2012 at 10:33 AM, David Sommerseth
> <openvpn.list@...1114...> wrote:
>
> <snip>
>
>> The reason I don't see the benefit of splitting out the plug-ins as
>> much is that they all depend on OpenVPN.  You can not make much use of
>> these plug-ins without having OpenVPN.  But with Windows TAP driver
>> and easy-rsa, they can be completely used independently.
>>
>> Another point is that the plug-ins we have in the source tree, is
>> officially supported plug-ins.  And especially auth-pam and down-root
>> are plug-ins which are very useful and we should encourage packagers
>> to always package those.
>>
>> Then the example/ and defer/ plug-ins, which are examples.  Maybe it
>> would rather make sense to merge them somehow?
> There are a lot of plugins out there, think about chrome extension or
> firefox extension, but also network manager plugins or similar, they
> are all depend on the core product, but extend its functionality, and
> have their own repositories.
>
> Plugins should be installed as separate package, aka rpm.
>
> So if administrator wants openvpn he does:
> # yum install openvpn
>
> Now, if administrator wants auth-pam, he should do:
> # yum install openvpn-plugin-auth-pam
>
> As there is no sense in keeping the auth-pam plugin in system if it is
> unused nor to have pam dependency of the openvpn core package.
>
> I would not encourage packages to always have them, it is also not the
> correct approach for plugins. Plugins should be optional in nature.
>
> All the above does not imply separate repository as in both cases we
> can either provide one .spec file that generate both rpms or two
> separate spec files.
>
> The real question is how do we provide proper build for this
> components. Currently it has poor-man-build, which I fixed to meet
> some level of quality, instead of ./configure&&make install, packager
> should go and figure own what else needs to be built in tree.
>
> So either these are officially supported and should be build properly
> using main build system, example:
> ---
> $ ./configure --enable-plugin-auth-pam PAM_CFLAGS=3D... PAM_LIBS=3D...
> ---
>
> Or have plugins as separate components with its own release cycle and
> should have their proper own build system and release cycle.
>
> I think that if we have proper interface (openvpn-plugin.h), there is
> no sense in providing the plugins within the tree, as it has its own
> release cycle.
>
> I also would like to discuss the "official" argument....
> A project can have several repositories all at equal "official" level,
> why on earth people think that having more than one repository around
> damage their "official" state? "officially supported plug-ins", can be
> official in the openvpn repository and can be official in their own
> repository, there is absolutely no difference between the two
> approaches in this regards.
>
> However, splitting the repositories, allow helping distro packaging in
> determine what needed to be packaged and provided to users, it also
> allow separate release cycle (new openvpn release does not force new
> plugin release), and can even help in maintenance as a plugin can have
> its own maintainer (commit access).
>
> If also has more advantage as now in github we can encourage people to
> host and maintain their plugin within the OpenVPN organization,
> attracting more skills.
> So bottom line:
>
> 1. Either we add the plugins to core build system, with its disadvantages.
>
> 2. Split plugins into their own repository, release cycle, packaging.
>
> I am for (2), as I don't afraid of the "official" argument nor do I
> afraid to commit to more than one repository, and the modular nature
> of the plugin interface allows optional components to be installed
> separately along with their own dependencies.
>
> Alon

I think there's some very good argumentation here. In my view,
separating plugins into their own repositories would have some important
advantages; excuse me for repeating some of Alon's arguments here:

1) Delegating maintenance tasks easily to (new) developers: this is now
trivial with GitHub
2) Avoid having to make an OpenVPN release due to an important fix in a
plugin used by few. This also helps distro packagers, provided they
didn't bundle the plugins in their core "openvpn" package

Afaik none of the official plugins are needed to create the official
Windows installers, so that platform is entirely unaffected. On *NIX
side we only release source code. If we don't want to force people to
fetch official plugin code using Git, providing tarballs would be trivial.

I tend to agree that packagers should take care of packaging the plugins
as they see fit and making sure they're compatible with their version of
OpenVPN. For example, on Debian/Ubuntu the OpenVPN package includes
"down-root" and "pam" plugins by default. However, I've never used
those, and I know many others who don't either. Having the plugins in
separate repositories would steer packagers to the (in my opinion) right
direction of packaging optional functionality as optional packages. They
already do this for some of the off-tree plugins:

<https://community.openvpn.net/openvpn/wiki/RelatedProjects>

I believe the primary reason why the "pam" and "down-root" plugins are
in OpenVPN repository is that they seem to come from James, who has a
use-case for them. Personally, I would rather see the plugins in their
own repositories, even if only to see if it fosters collaboration.

I guess that was my 5 cents :).

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


