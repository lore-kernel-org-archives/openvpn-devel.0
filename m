Message-ID: <4F43EE92.50802@...515...>
Date: Tue, 21 Feb 2012 21:20:50 +0200
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <CAOazyz34oFXrQ8vh5qXcEFPC3wA8Qhn7ivzLKasB=B9mOCKyZQ@...278...>
	<4F43BEB5.6050404@...1114...>
	<CAOazyz2rRpsKzitWS5bWe8Ug7ut=ODQy9PDkq7v4Aa7E1ygHHA@...278...>
	<4F43D9B0.6010900@...1114...>
	<CAOazyz0Z4Lv=qDN1r_W504vBOgaF1YWiNs+9j_MCorACOzfyzQ@...278...>
In-Reply-To: <CAOazyz0Z4Lv=qDN1r_W504vBOgaF1YWiNs+9j_MCorACOzfyzQ@...278...>
Subject: Re: [Openvpn-devel] [RFC] openssl minimum supported version
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
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>, James Yonan <jim@...41...>


> On Tue, Feb 21, 2012 at 7:51 PM, David Sommerseth
> <openvpn.list@...1114...> wrote:
>>> No there is none. Unlike other dependencies autotools dependencies are
>>> of development machine. You should create tarball on newer machine
>>> then compile it on the target platform. Target platform may not have
>>> autotools installed at all.
>>>
>>> The new build system will support >=3Dautoconf-2.60, automake>=3D1.10,
>>> libtool>=3D2.2
>> That is not how James does his builds, from what I've understood.  He
>> does builds in his own compile farm straight from source repositories.
>> James might just as well pop up NACKing things if these changes breaks
>> his tool chain.  To put is simple: We are not allowed to break his
>> environments.
>>> Again, from experience generating tarball using these versions tends
>>> to work well on very old platforms.
>> That's good, which can solve RHEL4 issues in a nice way.  But I expect
>> James to do plenty of RHEL5 builds in the future, so there is noway we
>> are allowed to break this.
> I guess we should ask James.
> Adding him (at least his old address).
>
> Hello James,
>
> Can you please share your build environment so I know the impact?
> In all my build environments I check out the source at central build stat=
ion,
> autoreconf, configure, make dist and then ssh the tarballs to targets
> for building.
> What exactly is your process?
>
> Supporting old autotools results in ugly hard to maintain implementations.
> More productive is to help fixing the build environment.
>
I don't think build farmers like Alon, James or me will suffer much from
having to split the build into two parts like this. The real impact will
be felt by casual builders using old operating systems. I think the
questions are:

- How often do people build OpenVPN themselves? [1]
- How old is new enough?
- Do other projects also require fairly recent autotools, i.e. how
likely is it to see new
  autotools installed on old operating systems?
- How much simpler will the buildsystem be by not having to support old
autotools versions?

I would be inclined to focus on cutting down complexity as much as
possible. I think the best way to gauge real need for old autotools is
to scrap support for it. We can always fix things afterwards, if
necessary. I can ask James' opinion if he does not step in soonish.

Also, ecrist publishes source tarballs every couple of weeks already...
couldn't these old autotools users use those and still get failrly
recent OpenVPN versions on their boxes?

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


[1] Last time I checked the ratio of source downloads to Windows
installer downloads was aroung 1:10.

