MIME-Version: 1.0
In-Reply-To: <20120326181118.GY1359@...1296...>
References: <20120326161943.GW1359@...1296...>
	<CAOazyz0Tbdn8+W9g1UmtLzGmbHbGNagRsN6KVZnVvqr_c2Hm6g@...278...>
	<20120326181118.GY1359@...1296...>
Date: Mon, 26 Mar 2012 20:20:35 +0200
Message-ID: <CAOazyz2tPpM+qBLyRr+NxCq43=ff8YZ4com22bQ4Uk5kEGktOg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] build failure on OpenBSD
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
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Mar 26, 2012 at 8:11 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Mon, Mar 26, 2012 at 07:58:02PM +0200, Alon Bar-Lev wrote:
>> The problem is the use of the TARGET_XXXX not the use of HAVE.
>> As I wrote before next stage is to get rid of the syshead.h and its comp=
lexity.
>> There is no sense to check for platform, just if header exists.
>
> Check for header is too fragile, obviously - it checks for header, but
> fails, because header needs other headers.

The opposite is true.
From my experience, checking per platform causes problem with
toolchain and versions changes.

> We need the TARGET_XXX stuff anyway, because tun.c and route.c need
> them - stuff like "how is the /bin/route syntax for IPv6 on xxxBSD"
> can not be detected by configure.

The symbols should exists, yes.
They should be used in platform specific implementation.
Headers can be detected in most cases as without references to
platform in much simpler source with less conditionals.

> So I'm much more in favour of actually keeping what we have: knowledge
> about every platform. =C2=A0We *know* which headers are there on FreeBSD,
> NetBSD, OpenBSD - and the way OpenVPN needs to tie into the system
> for ifconfig and route means "porting to a yet-unknown operating system
> by just running 'configure ; make' is a pipe dream, no more".

No it is not.

> This might work for stuff that's sufficiently far away from the system
> innards, and using pkg-config libraries for the nitty gritty details,
> but it won't for OpenVPN.

It will, with a little patient I will show this.

>> In the mean time please try the following[1] patch.
>>
>> Alon
>>
>> [1] https://github.com/alonbl/openvpn/commit/b0f45ae19909b33723faebe7f8f=
b003f82900ff4
>
> That patch makes configure detect <netinet/in.h> (as such: thanks, it
> helps), but it makes configure even more complicated, which means
> "config.log is even longer and harder to read".
>
> <rant>
> All this crap in configure really needs to go away...
>
> checking stdio.h usability... yes
> checking stdio.h presence... yes
> checking for stdio.h... yes
> ...
> checking errno.h usability... yes
> checking errno.h presence... yes
> checking for errno.h... yes
> ...
> checking whether SIGHUP is declared... yes
> checking whether SIGINT is declared... yes
> checking whether SIGUSR1 is declared... yes
> checking whether SIGUSR2 is declared... yes
> checking whether SIGTERM is declared... yes
> ...
> checking for socket... yes
> checking for recv... yes
> checking for recvfrom... yes
> checking for send... yes
> checking for sendto... yes
> checking for listen... yes
> checking for accept... yes
> checking for connect... yes
> checking for bind... yes
> checking for select... yes
> checking for gethostbyname... yes
>
> ... all of these are on any operating that has any chance of running
> OpenVPN. =C2=A0So testing for it is a pure waste of code lines and cpu
> cycles.
> </rant>

Incorrect.
The same is used to detect and configure also in Microsoft platform.

Less platform specific conditional, the cleaner the code is.

But... one note... many will be removed when I clean up the ipv6 usage.

Alon.

