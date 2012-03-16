MIME-Version: 1.0
In-Reply-To: <CABT9mj9fB-B1_=cK-jVzm6m3+Om7B0qMMFQWf1atqX_ry2QQnQ@...278...>
References: <CAOBzU4PN6qDxf39+s4noXEiW8hNbDy-hkQWGSauBd3hX0pu2hw@...278...>
	<CAOazyz1DE7Y-P9HFK3LN8-HeoGbHzYeqofX3RiEuK0C-zcxnug@...278...>
	<CAOazyz0nV8P8Age_wyFCvu1J4g1MECA7YdTAAL4of7TTVctXow@...278...>
	<1CED409804E2164C8104F9E623B08B90129350BEDF@...1436...>
	<CAOazyz0daYPAH=ooKDenavTyG1qK1=wJv8ZJ0VF+u-vXWBE2xQ@...278...>
	<4F4B456A.8010208@...515...> <4F4B542D.9090309@...1114...>
	<CAOazyz1E809DFQ7-GBvopezmELL+SuW+A5A+EKgbXTsZTNVd8w@...278...>
	<4F4E6104.2000900@...1114...>
	<CAOazyz3fg_qSWb92ftSeq3Z7qN1fhfEBnuURfxenOsBbxGWQ4g@...278...>
	<CAOazyz1=87RqYEo=ovMtGkc1n=yh5VOQcc_YdM4nMHbQ8oNTNA@...278...>
	<CAOazyz2Svm8sG3kZMiMzH2hppNpRkQn2a_8NK9sGM0o9qCJKzg@...278...>
	<4F5720D3.7060309@...515...>
	<CAOazyz0Qopk1b8VRSobuui8QBZ3GNr5zbu4moa4abJZWyzaQWQ@...278...>
	<4F606088.8030607@...1114...>
	<CAOazyz2ZrDL-kaFa+Nc-aDcyWgOVJd82scypg9vZsZghvsY7Wg@...278...>
	<4F60903E.9090506@...515...>
	<CAOazyz3hA9LPCq0sEOWbY30PwjwxPUyCkDFWWq9x4S3dxfYVXw@...278...>
	<CABT9mj-YbHc_5w_hPBo2DNQ_TA_0dP3Py9ue9JZ32UXg0A4YEg@...278...>
	<CABT9mj9U0ewSBH=WqJ=nWgkBFGycL4R1Pw27bkhRG6WFgnpf8w@...278...>
	<CABT9mj8mywqhyiwh_y6zTtxPN8EHeT-M=1er73OD9kdHm87kBQ@...278...>
	<CAOazyz15m6go2PxXgE3RR=mO5pnJCTS-ZACYTVh9vawevCxX-A@...278...>
	<CAOazyz1NCOQOQQt0_JkppC-1ZDewzBKLKOOemXG1f4OGjFp3ww@...278...>
	<CABT9mj_XRKAt7uyMv31TmW89izDmGWmCDoBpRpHODmAL7aMenQ@...278...>
	<CAOazyz3K8sGCWQO4iRCBZSmhqY-Y84BTHAzmpWbTxNWqRnD-Ew@...278...>
	<CABT9mj8P8H86THWzNTGtZZ=gNS4dvmWQYzJJ4EVKWShoNsND7g@...278...>
	<CAOazyz0=vkjyx93yyauJC=2Njss0wVmK2FTS6teLERHM80MYAg@...278...>
	<CABT9mj_8NZUYJ55WqNkSU1YqsJXH23LBMsUxuNjH6j_yj18cHg@...278...>
	<CAOazyz1sc341TXojsESp7yGpWsPsu7bme2=GZjBSfqfVFWqTNw@...278...>
	<CABT9mj_LL133jp1_EHnm77GJt8xx0TgoM6yPQhwHFX8KR0cMjg@...278...>
	<CAOazyz3XJSqFPwUpqnbqZY1xNsjs_tkV8ncPENuGmnifHvMqLA@...278...>
	<CABT9mj9fB-B1_=cK-jVzm6m3+Om7B0qMMFQWf1atqX_ry2QQnQ@...278...>
Date: Fri, 16 Mar 2012 19:43:51 +0200
Message-ID: <CAOazyz2h2qZ7x19AD-P=J+Vp3TXfh6isEUpLvKQZ92+CFUtWJg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 00/35] build revolution
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
To: Athanasios Douitsis <aduitsis@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

It should be:

CHOST=i686-w64-mingw32 CBUILD=i686-pc-cygwin

On Fri, Mar 16, 2012 at 7:25 PM, Athanasios Douitsis <aduitsis@...277...> wrote:
> I have installed cygwin just two days ago. And I issue:
>
> CHOST=i686-pc-mingw32 CBUILD=i686-pc-linux-gnu ./build
>
>
>
>
> On Fri, Mar 16, 2012 at 7:05 PM, Alon Bar-Lev <alon.barlev@...277...> wrote:
>>
>> Which toolchain do you use?
>> It looks like you are trying to use an old toolchain...
>>
>> On Fri, Mar 16, 2012 at 6:51 PM, Athanasios Douitsis <aduitsis@...277...>
>> wrote:
>> > Hi everyone,
>> >
>> > Just to give an update, compilation on Alon's generic/ fails when it
>> > tries
>> > to compile openvpn with messages like:
>> >
>> > In file included from base64.c:40:0:
>> > syshead.h:345:22: fatal error: ntddndis.h: No such file or directory
>> > etc.
>> >
>> > ntddndis.h can be found in several places i.e. /usr/include/w32api/ddk,
>> > but
>> > including that path manually results in duplicate definitions and the
>> > build
>> > brakes again. Besides, I'm not sure including the path manually is the
>> > right
>> > thing to do.
>> >
>> > Ref: also my message from the 9th of March, where I had a similar
>> > problem in
>> > a completely different build environment in different builder system.
>> > And
>> > this has occurred with 2.3alpha1, not before.
>> >
>> > Cheers,
>> > Athanasios
>> >
>> >
>> >
>> >
>> > On Thu, Mar 15, 2012 at 1:39 AM, Alon Bar-Lev <alon.barlev@...277...>
>> > wrote:
>> >>
>> >> Next step is for you to create an installer :)
>> >> Use the windows-nsis scripts.
>> >>
>> >> On Thu, Mar 15, 2012 at 1:37 AM, Athanasios Douitsis
>> >> <aduitsis@...277...>
>> >> wrote:
>> >> >
>> >> >
>> >> > On Thu, Mar 15, 2012 at 1:19 AM, Alon Bar-Lev <alon.barlev@...277...>
>> >> > wrote:
>> >> >>
>> >> >> On Thu, Mar 15, 2012 at 1:05 AM, Athanasios Douitsis
>> >> >> <aduitsis@...277...>
>> >> >> wrote:
>> >> >> > I was just thinking loudly, definitely not asking for someone to
>> >> >> > write
>> >> >> > it
>> >> >> > and replace the existing build process(es). Having said that, I'd
>> >> >> > like
>> >> >> > to
>> >> >> > clarify that what I meant is this would not be an additional
>> >> >> > dependency
>> >> >> > on
>> >> >> > top of others, since neither cygwin nor msvc would be needed
>> >> >> > anymore.
>> >> >> > Anyway, not important, just a thought.
>> >> >>
>> >> >> Visual studio build is for compatibility for people who insist of
>> >> >> using
>> >> >> it.
>> >> >>
>> >> >> The "generic" build system is pure cross compile / native build
>> >> >> system
>> >> >> for dependencies and openvpn. It compiles openvpn using a given
>> >> >> toolchain to any environment.
>> >> >>
>> >> >> For example, you can use it to compile at Linux for Linux on power
>> >> >> pc
>> >> >> or to Linux on arm.
>> >> >> As a side effect you can also compile openvpn on Linux to windows
>> >> >> using
>> >> >> mingw.
>> >> >> This exact same script without any modification can be used on
>> >> >> Windows
>> >> >> in cygwin environment to cross compile to windows native.
>> >> >>
>> >> >> So at the larger picture the target is to maintain a single build
>> >> >> system for all environment... same dependencies, same utilities.
>> >> >>
>> >> >> Alon
>> >> >
>> >> >
>> >> > Thanks for taking the time to explain! I'll be happy to provide as
>> >> > much
>> >> > feedback as possible on the windows native case with cygwin.
>> >> >
>> >> > Best regards,
>> >> > --
>> >> > Athanasios Douitsis
>> >> >
>> >> >
>> >> >
>> >
>> >
>> >
>> >
>> > --
>> > Athanasios Douitsis
>> >
>> >
>> >
>
>
>
>
> --
> Athanasios Douitsis
>
>
>

