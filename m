Message-ID: <542E87BD.2090409@...515...>
Date: Fri, 03 Oct 2014 14:25:49 +0300
From: =?windows-1252?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <20140426210044.GF16637@...1296...>
	<535CD403.6040603@...1227...>
In-Reply-To: <535CD403.6040603@...1227...>
Subject: Re: [Openvpn-devel] socket.c issues when building snapshots on
	windows...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Arne Schwabe <arne@...1227...>, Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> On 26.04.2014 23:00, Gert Doering wrote:
>> Hiya,
>>
>> with some arm-twisting, I managed to convince build-snapshot to actually
>> do that (it would prefer to do a git clone, autoconf, tarball, copy
tarball,
>> ignore the tarball, fetch 2.3.3 source, extract 2.3.3 and build that,
thus
>> never showing compilation errors...), and here we go...
>>
>> socket.c: In function 'socket_bind':
>> socket.c:1124:40: error: 'IPV6_V6ONLY' undeclared (first use in this
function)
>> socket.c:1124:40: note: each undeclared identifier is reported only
once for each function it appears in
>> socket.c:1124:7: warning: passing argument 4 of 'setsockopt' from
incompatible pointer type [enabled by default]
>>
/usr/lib/gcc/i686-w64-mingw32/4.6/../../../../i686-w64-mingw32/include/wins=
ock2.h:1016:34:
note: expected 'const char *' but argument is of type 'int *'
>> socket.c: In function 'openvpn_connect':
>> socket.c:1218:32: error: 'const struct sockaddr' has no member named
'addr'
>> socket.c:1218:62: error: 'const struct sockaddr' has no member named
'addr'
>> socket.c: In function 'socket_recv_queue':
>> socket.c:3135:45: error: 'struct link_socket_addr' has no member
named 'local'
>>
>> ... I'm posting this here so whoever has time can take a stab at it
>> (I won't be able to work on this for the next couple of days, will focus
>> on 2.3.4 release items).
>>
>>
> The option seems to be supported since Windows Vista. I think we should
> add something like this to the windows ifdefs (copied from
> http://marc.info/?l=3Dapr-dev&m=3D121392734329754&w=3D2):
>
> +/* Ugly solution - only the Windows 2008 SDK or later have this symbol
> defined.
> + * The symbol doesn't guarantee that the socket option is supported on
> + * the runtime version of Windows, so we define it here (for build
> systems)
> + * and always check at runtime if it is supported.
> + */
> +#ifndef IPV6_V6ONLY
> +#define IPV6_V6ONLY 27
> +#endif
>
>
I'll revive this old thread because the problem seems to persist. It
seems we have two issues here. First there's this:

"socket.c:1124:40: error: 'IPV6_V6ONLY' undeclared (first use in this
function)"

The above error can be fixed by using mingw-w64 that is recent enough -
version 2.23 seems to work fine.

However, that will not fix this error:

socket.c: In function =91socket_bind=92:
socket.c:1120:7: warning: passing argument 4 of =91setsockopt=92 from
incompatible pointer type [enabled by default]
       if (setsockopt(sd, IPPROTO_IPV6, IPV6_V6ONLY, &v6only,
sizeof(v6only)))
       ^
In file included from ../../src/compat/compat.h:29:0,
                 from syshead.h:28,
                 from socket.c:31:
/usr/share/mingw-w64/include/winsock2.h:999:34: note: expected =91const
char *=92 but argument is of type =91int *=92
   WINSOCK_API_LINKAGE int WSAAPI setsockopt(SOCKET s,int level,int
optname,const char *optval,int optlen);
                                  ^
socket.c: In function =91socket_recv_queue=92:
socket.c:3098:45: error: =91struct link_socket_addr=92 has no member named
=91local=92
    int addrlen =3D af_addr_size(sock->info.lsa->local.addr.sa.sa_family);
                                             ^
make[4]: *** [socket.o] Error 1

- ---

The above can be reproduced using latest Git sources and Ubuntu 14.04.
Any ideas how to fix this?

Samuli

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQuh70ACgkQwp2X7RmNIqPqOgCfS9dM5gG2ONr8qZEngqTMOjGf
V2UAoKq/E0K46tNFjXkuFt6uxCZWw5EO
=3D4XgJ
-----END PGP SIGNATURE-----



