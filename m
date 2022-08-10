From: Kristof Provost <kprovost@...2661...>
Date: Wed, 10 Aug 2022 20:00:33 +0200
Message-ID: <EB06CA31-9F28-43C9-B63E-A579A977D3AE@...2661...>
In-Reply-To: <YvPdlCSxQ6wvfIna@...1296...>
References: <20220808143424.65924-1-kprovost@...2661...>
 <20220808143424.65924-3-kprovost@...2661...>
 <YvPdlCSxQ6wvfIna@...1296...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 1/2] ovpn-dco: introduce FreeBSD
 data-channel offload support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Thanks!

On 10 Aug 2022, at 18:32, Gert Doering wrote:
> Test results:
>
>  - running openvpn over TCP gives me a kernel panic - this is not so
>    nice... (see attached .png from the vmware console) - userland seems
>    to assume "kernel can do TCP", kernel panics on "if !udp, panic()"
>    (so intentional panic, not corruption panic).
>
>    This is on freebsd git FreeBSD 14.0-CURRENT #1 main-n257130-c0665d5c824
>
I think I see what the problem is. I=E2=80=99m writing up a test case to re=
produce it and will commit a fix soon. Hopefully tomorrow.

>  - running openvpn over UDP has issues with fragmentation - almost all
>    t_client tests that *do* use DCO fail the "big ping" test
>
I=E2=80=99m going to have to do some digging here.

> - tcpdump'ing on the DCO interface gave me complains from the kernel
>   about locking on ctrl-c'ing
>
>     Aug 10 17:28:41 fbsd14 kernel: lock order bpf global lock -> iflib ct=
x lock attempted at:
>     Aug 10 17:28:41 fbsd14 kernel: #0 0xffffffff80c5c3dd at witness_check=
order+0xbfd
>     Aug 10 17:28:41 fbsd14 kernel: #1 0xffffffff80bf5303 at _sx_xlock+0x63
>     Aug 10 17:28:41 fbsd14 kernel: #2 0xffffffff80d3874f at iflib_if_ioct=
l+0x2df
>     Aug 10 17:28:41 fbsd14 kernel: #3 0xffffffff80d19b5e at if_setflag+0x=
de
>     Aug 10 17:28:41 fbsd14 kernel: #4 0xffffffff80d19a2a at ifpromisc+0x2a
>     Aug 10 17:28:41 fbsd14 kernel: #5 0xffffffff80d0e72b at bpf_detachd_l=
ocked+0x27b
>     Aug 10 17:28:41 fbsd14 kernel: #6 0xffffffff80d111f7 at bpf_dtor+0x87
>     Aug 10 17:28:41 fbsd14 kernel: #7 0xffffffff80a7818b at devfs_destroy=
_cdevpriv+0xab
>     Aug 10 17:28:41 fbsd14 kernel: #8 0xffffffff80a7bda4 at devfs_close_f=
+0x64
>     Aug 10 17:28:41 fbsd14 kernel: #9 0xffffffff80b876eb at _fdrop+0x1b
>     Aug 10 17:28:41 fbsd14 kernel: #10 0xffffffff80b8af3b at closef+0x1db
>     Aug 10 17:28:41 fbsd14 kernel: #11 0xffffffff80b8ec97 at closefp_impl=
+0x77
>     Aug 10 17:28:41 fbsd14 kernel: #12 0xffffffff810c733e at amd64_syscal=
l+0x12e
>     Aug 10 17:28:41 fbsd14 kernel: #13 0xffffffff8109ae0b at fast_syscall=
_common+0xf8
>
>    ... so while this is outside "openvpn source code patches", it's
>    still something that smells like it needs to be addressed.
>
That appears to be unrelated to DCO. It=E2=80=99s a problem with iflib, and=
 I think I=E2=80=99ve seen it before.
Out of scope for DCO, at least.

> Now, coding style ;-) - as promised, I went through the code for things
> that need to be done in a certain way in OpenVPN land, due to agreed
> convention... inline (things I do not comment could go in "as is").
>
I=E2=80=99ll fix those once I=E2=80=99ve dealt with the panic and fragmenta=
tion issues.

Thanks for the review.

Kristof

