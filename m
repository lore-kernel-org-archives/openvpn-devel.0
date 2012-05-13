MIME-Version: 1.0
Sender: fabian@...1547...
In-Reply-To: <CAOazyz2NzD76kqdM4v+fPK4uuvCd6E-oh79EpGv5p1K=ZZTucw@...278...>
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
	<CAOazyz2NzD76kqdM4v+fPK4uuvCd6E-oh79EpGv5p1K=ZZTucw@...278...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Sun, 13 May 2012 21:52:39 +0200
Message-ID: <CAP+U6tJ51hoEZOAQ_7R58HHtJcVB48JkzOH1_7jYGRnXEWptgQ@...278...>
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

Hi Alon,

2012/5/13 Alon Bar-Lev <alon.barlev@...277...>:
> On Sun, May 13, 2012 at 9:10 PM, Gert Doering <gert@...1296...> wrote:
>> Huh? =C2=A0You're the master of Autoconf, and I'm sure you will be able =
to
>> produce a working PAM detection for those platforms that have it.
>
> Yes, and as such I tell you that automatic detection is something that
> leads to package breakage.

How does PAM detection relate to the question whether to split out the
plugin? Wouldn't the plugin's configure also need to detect PAM? As
already discussed previously, I much prefer configure to notice a
missing development package than to run into a failing "make" run.

And why would automatic pam detection lead to package breakage? Have
an option for enabling / disabling plugins. If a plugin is enabled and
needs PAM, check for the existence of PAM. If PAM isn't found, exit
configure and tell the user to pass the proper paths for pam headers
and libraries.

>>> >> These plugins should be optional I don't see any value in enforcing
>>> >> them and their dependencies.
>>> >
>>> > If these plugins are useful for a large number of users, there is no
>>> > point in not installing them by default.
>>>
>>> They are not.
>>
>> Unfounded claim.
>
> I know one or two installations, and I am tracking this project more
> than 6 years.
> Come on! most of installations are plain public key without any of
> these plugins.
> There is no need for these if you configure your server.
> I simply don't understand your attitude... sorry, I simply don't.

As already mentioned elsewhere in this thread, the currently included
plugins aren't a huge burden to maintain. So even if we were to agree
that most people don't need them by default, I would suggest to change
the build default, not throw them out of the repository.

I can see where the purity of the split-out would appeal to you, but
the increased number of separate repositories, releases, packages,
etc. to maintain forms a strong counter-point in my opinion. So I'm
against splitting out the plugins for now. (Just saw Eric's
openvpn-contrib proposal. Might serve as a compromise, but then we'd
still lose the purity advantage ...)

Cheers
Fabian

