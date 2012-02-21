MIME-Version: 1.0
In-Reply-To: <4F43D9B0.6010900@...1114...>
References: <CAOazyz34oFXrQ8vh5qXcEFPC3wA8Qhn7ivzLKasB=B9mOCKyZQ@...278...>
	<4F43BEB5.6050404@...1114...>
	<CAOazyz2rRpsKzitWS5bWe8Ug7ut=ODQy9PDkq7v4Aa7E1ygHHA@...278...>
	<4F43D9B0.6010900@...1114...>
Date: Tue, 21 Feb 2012 19:59:39 +0200
Message-ID: <CAOazyz0Z4Lv=qDN1r_W504vBOgaF1YWiNs+9j_MCorACOzfyzQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
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
To: David Sommerseth <openvpn.list@...1114...>, James Yonan <jim@...41...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

On Tue, Feb 21, 2012 at 7:51 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
>> No there is none. Unlike other dependencies autotools dependencies are
>> of development machine. You should create tarball on newer machine
>> then compile it on the target platform. Target platform may not have
>> autotools installed at all.
>>
>> The new build system will support >=3Dautoconf-2.60, automake>=3D1.10,
>> libtool>=3D2.2
>
> That is not how James does his builds, from what I've understood. =C2=A0He
> does builds in his own compile farm straight from source repositories.
> James might just as well pop up NACKing things if these changes breaks
> his tool chain. =C2=A0To put is simple: We are not allowed to break his
> environments.

>
>> Again, from experience generating tarball using these versions tends
>> to work well on very old platforms.
>
> That's good, which can solve RHEL4 issues in a nice way.  But I expect
> James to do plenty of RHEL5 builds in the future, so there is noway we
> are allowed to break this.

I guess we should ask James.
Adding him (at least his old address).

Hello James,

Can you please share your build environment so I know the impact?
In all my build environments I check out the source at central build statio=
n,
autoreconf, configure, make dist and then ssh the tarballs to targets
for building.
What exactly is your process?

Supporting old autotools results in ugly hard to maintain implementations.
More productive is to help fixing the build environment.

>
> On the RHEL5.7 base, libtool-1.5.22 is the base version.

This is supported but none for Windows... I think it is sufficient.

Alon.

