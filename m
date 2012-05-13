MIME-Version: 1.0
In-Reply-To: <20120513111240.GK1359@...1296...>
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
Date: Sun, 13 May 2012 14:26:05 +0300
Message-ID: <CAOazyz1keZzQjqeUoUSQ88UzVn3=BMz1FWRp0KiB+gS6-43HhQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
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
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

On Sun, May 13, 2012 at 2:12 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Sun, May 13, 2012 at 02:00:32PM +0300, Alon Bar-Lev wrote:
>> >> Can't we progress?
>> >
>> > Why is that progress?
>> >
>> > Change always has drawbacks. =C2=A0If the plus sides outweighs the dra=
wbacks,
>> > change is good. =C2=A0Change for change's sake, "just because you can =
change
>> > it", is not.
>>
>> Yes, but still from your responses I don't see any drawback... maybe I
>> am slow learner...
>
> Drawback to maintainers and sysadmins has already been mentioned by
> ecrist and me. =C2=A0Try being a sysadmin for a few weeks and figure out
> which bits of xorg you need to download to install xinit, assuming
> you have a system without any X libraries and headers yet (in the xorg
> example: splitting off "xinit" might actually make sense, but splitting
> the basic infrastructure to build anything into about 50 different
> "xyz-library" and "xyz-headers" packages is crazyness).

First, I was gentoo developer for some time, and maintained, among
other, openvpn packages.
The case of xorg is not similar, you keep using this example while in
the openvpn case we have a core and a set of optional plugins, that's
all.
So please give appropriate example.

One example of your approach is the bluez project, which insist of
using in-tree plugins not because it is the simpler approach, but this
way it can enforce GPL license on all plugins and make sure they are
stay opened.

> But the onus is not particularily on me: you have not put forward
> convincing arguments why splitting off a very small number of files
> that only make use in the context of OpenVPN into their own repository
> has any *advantage*.

I think I already stated some advantages, you can ether accept or
reject but at least they are focus on the subject at hand:

1. we remove dependencies from the core openvpn package.

2. we can release a fix in plugin without releasing the complete openvpn.

3. plugins are optional, user may install the plugin as separate
pacakge if needed.

4. we can delegate maintenance of plugin.

5. we can attract more people to the community.

6. simpler to track the history of atomic components in the mean of
source control.

>
> The handwavy argument "it will attract more users!" can be countered by
> similarily handwaving "I, as a user, hate to download multiple packages
> to figure out how to start contributing, and so it will scare *away*
> users".

Hmmmm... I think that you are at the xorg example again...

> As a counterexample, look at Apache. =C2=A0They have heaps of modules in
> the main tarball, and have no issues with frequent release and with
> attracting developers. =C2=A0And still, modules maintained by non-apache
> developers can be developed externally, without having to splitt off
> all existing modules beforehand.

OK... now you are talking... so you say that like apache we need to
integrate the plugins to main build system, this was the other
alternative.

>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //www.muc.de/~gert/
> Gert Doering - Munich, Germany =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gert@...1296...
> fax: +49-89-35655025 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gert@...1297...

