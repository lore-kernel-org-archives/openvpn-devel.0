MIME-Version: 1.0
In-Reply-To: <20120513181038.GP1359@...1296...>
References: <20120513092355.GH1359@...1296...>
	<CAOazyz0=+ZE6+n-KqyzZSJhbweHb236LjwefvV6BtMvfbh37mQ@...278...>
	<20120513093551.GI1359@...1296...>
	<CAOazyz0bEZMBYcKGvKTux=+7XE43=-4Aw02HGVCNHPoO35wAWg@...278...>
	<20120513111240.GK1359@...1296...>
	<CAOazyz1keZzQjqeUoUSQ88UzVn3=BMz1FWRp0KiB+gS6-43HhQ@...278...>
	<20120513121906.GL1359@...1296...>
	<CAOazyz3WetA0vHpm965krjKm=OiFovT1JRi39T9kOY2sf7-khA@...278...>
	<20120513130750.GN1359@...1296...>
	<CAOazyz1hA7EGOhoOtOgNgAcH91Y4crs1TrTzgDbC6_MbgA8reQ@...278...>
	<20120513181038.GP1359@...1296...>
Date: Sun, 13 May 2012 21:23:04 +0300
Message-ID: <CAOazyz2NzD76kqdM4v+fPK4uuvCd6E-oh79EpGv5p1K=ZZTucw@...278...>
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

On Sun, May 13, 2012 at 9:10 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Sun, May 13, 2012 at 04:10:54PM +0300, Alon Bar-Lev wrote:
>> >> And always have pam dependency for this example?
>> >
>> > FreeBSD, NetBSD, all Linuxes and Solaris have PAM anyway.
>> >
>> > So make this "if pam libraries + headers are detected, install auth-pa=
m,
>> > otherwise, not".
>>
>> We already discussed the automatic detection and integrity failure as re=
sult.
>
> Huh? =C2=A0You're the master of Autoconf, and I'm sure you will be able to
> produce a working PAM detection for those platforms that have it.

Yes, and as such I tell you that automatic detection is something that
leads to package breakage.
We already discussed that in the lzo subject.
I know you are fundamentally against any change, but I think I proved
very well that I actually know what I am doing.

>
>> >> These plugins should be optional I don't see any value in enforcing
>> >> them and their dependencies.
>> >
>> > If these plugins are useful for a large number of users, there is no
>> > point in not installing them by default.
>>
>> They are not.
>
> Unfounded claim.

I know one or two installations, and I am tracking this project more
than 6 years.
Come on! most of installations are plain public key without any of
these plugins.
There is no need for these if you configure your server.
I simply don't understand your attitude... sorry, I simply don't.

>> Exactly because the are not useful, I am for the split.
>> Anyway, if you follow the apache example there is explicit
>> enable/disable to each.
>
> And there are some that are enabled by default. =C2=A0Your point?

These which enabled by default requires for proper apache functionality.
There are absolutely no openvpn plugin that is actually required for anythi=
ng.
Please stop trying to just try to oppose... but think of the relevant
of what you are referring.
First you compare xorg to openvpn, which is totally invalid.
Then you compare openvpn to apache, which is also invalid.
What next?

>> BTW: Packager of what platform are you?
>
> openwrt. =C2=A0Not that this is of any relevance.

Exactly, so I think I am more experienced distro maintainer, please
understand that I am taking from first hand experience, and I would
like to help, plain positive help... I really don't understand why you
are trying to force your opinion if you have theoretical knowledge.

BTW: openwrt is a good example of a platform that does not need these
plugins right?

Alon.

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

