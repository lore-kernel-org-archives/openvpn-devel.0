MIME-Version: 1.0
In-Reply-To: <20120513130750.GN1359@...1296...>
References: <20120513090153.GG1359@...1296...>
	<CAOazyz1FB+JU7QRmeMuxMX7-6fAN28VH1-6ApJnOu7eHDq9jUA@...278...>
	<20120513092355.GH1359@...1296...>
	<CAOazyz0=+ZE6+n-KqyzZSJhbweHb236LjwefvV6BtMvfbh37mQ@...278...>
	<20120513093551.GI1359@...1296...>
	<CAOazyz0bEZMBYcKGvKTux=+7XE43=-4Aw02HGVCNHPoO35wAWg@...278...>
	<20120513111240.GK1359@...1296...>
	<CAOazyz1keZzQjqeUoUSQ88UzVn3=BMz1FWRp0KiB+gS6-43HhQ@...278...>
	<20120513121906.GL1359@...1296...>
	<CAOazyz3WetA0vHpm965krjKm=OiFovT1JRi39T9kOY2sf7-khA@...278...>
	<20120513130750.GN1359@...1296...>
Date: Sun, 13 May 2012 16:10:54 +0300
Message-ID: <CAOazyz1hA7EGOhoOtOgNgAcH91Y4crs1TrTzgDbC6_MbgA8reQ@...278...>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

On Sun, May 13, 2012 at 4:07 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Sun, May 13, 2012 at 03:24:59PM +0300, Alon Bar-Lev wrote:
>> > If we ignore the examples, we really only have "auth-pam" and "down-root"
>> > in the main distribution today, and those are useful in many cases - so
>> > I'd go for "always build and install them".
>>
>> And always have pam dependency for this example?
>
> FreeBSD, NetBSD, all Linuxes and Solaris have PAM anyway.
>
> So make this "if pam libraries + headers are detected, install auth-pam,
> otherwise, not".

We already discussed the automatic detection and integrity failure as result.

>
>> These plugins should be optional I don't see any value in enforcing
>> them and their dependencies.
>
> If these plugins are useful for a large number of users, there is no
> point in not installing them by default.

They are not.
Exactly because the are not useful, I am for the split.
Anyway, if you follow the apache example there is explicit
enable/disable to each.

BTW: Packager of what platform are you?

Alon.

