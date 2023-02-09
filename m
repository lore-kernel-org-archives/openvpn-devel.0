Date: Thu, 9 Feb 2023 17:33:45 +0100
From: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@...2710...>
Message-ID: <20230209163344.GC89400@...2711...>
Reply-To: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@...2710...>
References: <20230209153658.24001-1-ynezz@...2710...>
 <828cce6b-72dc-50db-a0d3-7948db0d941e@...1227...>
 <37d7433b-8534-51d5-da07-a94fce1f06bf@...1227...>
MIME-Version: 1.0
In-Reply-To: <37d7433b-8534-51d5-da07-a94fce1f06bf@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] get_addr_generic: fix server crash in
 freeaddrinfo on musl libc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Arne Schwabe <arne@...1227...> [2023-02-09 17:03:31]:

> Am 09.02.23 um 16:53 schrieb Arne Schwabe:
> > Am 09.02.23 um 16:36 schrieb Petr Štetiar:
> > > Server can crash on systems using musl libc when client with comma in
> > > commonName tries to connect:
> > > 
> > >   ifconfig_pool_read(), in='VPN Client, abc,192.168.1.2,'
> > >   RESOLVE: Cannot parse IP address:  abc: (Name does not resolve)
> > > 
> > > as this leads to NULL pointer dereference in freeaddrinfo():
> > > 
> > >   Program received signal SIGSEGV, Segmentation fault.
> > >   0x00007ffff7fbf81a in freeaddrinfo (p=0x0) at
> > > src/network/freeaddrinfo.c:10
> > >   (gdb) bt
> > >   #0  0x00007ffff7fbf81a in freeaddrinfo (p=0x0) at
> > > src/network/freeaddrinfo.c:10
> > >   #1  0x00000000004389ec in get_addr_generic (af=af@...1851...=2,
> > > flags=flags@...1851...=4, hostname=hostname@...1851...=0x7ffff7ee2988 " abc",
> > > network=network@...1851...=0x7fffffffcb7c, netbits=netbits@...1851...=0x0,
> > >       resolve_retry_seconds=resolve_retry_seconds@...1851...=0,
> > > signal_received=0x0, msglevel=64) at
> > > openvpn-2.5.7/src/openvpn/socket.c:186
> > >   #2  0x0000000000438a2d in getaddr (flags=flags@...1851...=4,
> > > hostname=hostname@...1851...=0x7ffff7ee2988 " abc",
> > > resolve_retry_seconds=resolve_retry_seconds@...1851...=0,
> > > succeeded=succeeded@...1851...=0x7fffffffcba7,
> > >       signal_received=signal_received@...1851...=0x0) at
> > > openvpn-2.5.7/src/openvpn/socket.c:202
> > >   #3  0x0000000000430ae5 in ifconfig_pool_read
> > > (persist=0x7ffff7ee4510, pool=0x7ffff7edd450) at
> > > openvpn-2.5.7/src/openvpn/pool.c:661
> > > 
> > > So fix it by checking if `struct addrinfo*` pointer is valid before
> > > passing it down to freeaddrinfo().
> > 
> > I am bit surprised that freeadrinfo does not follow the usual semantics
> > of calling freesomething on a nullptr is a noop.
> > 
> > If this is really the case would should add similar code (with comments
> > that freeaddrinfo is special here) also in gc_freeaddrinfo_callback and
> > the other places that call it without checking for ai to be valid.
> > 
> 
> So FreeBSD has:
> 
>  * - freeaddrinfo(NULL).  RFC2553 is silent about it.  XNET 5.2 says it is
>  *   invalid.  Current code accepts NULL to be compatible with other OSes.
> 
> and android bionic has a similar comment (bionic is also BSD libc based):
> 
>  * - freeaddrinfo(NULL).  RFC2553 is silent about it.  XNET 5.2 says it is
>  *   invalid.
>  *   current code - SEGV on freeaddrinfo(NULL)
> 
> but then actually does nothing on ai == NULL:
> 
> #if defined(__BIONIC__)
> 	if (ai == NULL) return;
> #else
> 	_DIAGASSERT(ai != NULL);
> #endif
> 
> so it seems that apart from some implementations like musl this assumption
> that freeaddrinfo is a noop is kind of true. I would still open a report
> against musl to fix this as this seem to be better to be aligned with the
> rest of the world.

https://www.openwall.com/lists/musl/2019/03/26/18

