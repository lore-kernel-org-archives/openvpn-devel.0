MIME-Version: 1.0
In-Reply-To: <20120512081025.GC1359@...1296...>
References: <CAOazyz12Rw0kOSS+siU7tLP4eXO5XkhexjVLn+uC97s4K1Z8EQ@...278...>
	<4FAAFCB4.8040606@...1227...>
	<CAOazyz2wP2ms7HC31LPp3VzFRBu+S3zURZm1ozz0MzjmhQv07g@...278...>
	<4FAB0556.50903@...1227...>
	<CAOazyz2pdJysuaEhoDL8O=S=CdEfW8XCuB6n8YrnKjOBqstTPA@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8A98@...1436...>
	<CAOazyz0Qb8xa-FUqQcMDX=w+=Vb3J8sQ2R8GAxNtfWxT-4DNkw@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8AB9@...1436...>
	<20120511185641.GZ1359@...1296...>
	<4FAD8A16.6020303@...1400...>
	<20120512081025.GC1359@...1296...>
Date: Sat, 12 May 2012 11:18:45 +0300
Message-ID: <CAOazyz3JEjxmBEobs6x_zdb+3CQo-Ectgux7LAb-LgzNkBC=Xg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Openvpn for Android 4.0 Changeset
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
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Arne Schwabe <schwabe@...1400...>

On Sat, May 12, 2012 at 11:10 AM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Fri, May 11, 2012 at 11:52:22PM +0200, Arne Schwabe wrote:
>> Am 11.05.12 20:56, schrieb Gert Doering:
>> > Changing the build environment to build a shared library out of openvpn
>> > is something I do not fully understand yet, though - and don't view
>> > a particular useful goal right now.
>> The shared library is not used as real shared library. I build
>> libopenvpn as complete library and then build a miniature executable
>> that calls the main method of the shared library and therefore exactly
>> behaves like openvpn as executable.
>>
>> The reason for this is that libraries are managed by the android package
>> system. For executables I have to carry them as data files and write
>> them to a cache partition. By putting the main =C2=A0code into the libra=
ry I
>> can minimise the amount of data that is written twice to the /data
>> parition on Android.
>
> I'm still not sure I fully understand what Android is doing there - but
> I don't need to :-) - so that explanation is good enough for me.
>
> gert

Gert, even if we don't understand the android details, it is obvious
that either:

a. upstream should merge and maintain yet another parallel build system.

b. downstream should maintain another parallel build.

This should be absolutely avoided if there are alternatives before
accepting any explanation.

Alon.

