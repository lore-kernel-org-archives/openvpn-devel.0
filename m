MIME-Version: 1.0
In-Reply-To: <20120326110015.GS1359@...1296...>
References: <CAOazyz1yULF1jkPRGOQriuetsdiUo5PbNVJybSURWPAKgQZMNA@...278...>
	<1332758047-30774-1-git-send-email-alon.barlev@...277...>
	<20120326110015.GS1359@...1296...>
Date: Mon, 26 Mar 2012 13:02:13 +0200
Message-ID: <CAOazyz0S4obu2XWtEFWXJiJGMJS9fk-ULdUNoXWkBriQ45vK7w@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] build: assume dlfcn is available on all
 supported platforms
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
Cc: Openvpn-devel@lists.sourceforge.net

On Mon, Mar 26, 2012 at 1:00 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Mon, Mar 26, 2012 at 12:34:07PM +0200, Alon Bar-Lev wrote:
>> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
>> ---
>> =C2=A0configure.ac | =C2=A0 =C2=A01 -
>> =C2=A01 files changed, 0 insertions(+), 1 deletions(-)
>
> Tested on FreeBSD 7.4 -> configure works fine now, make builds, resulting
> binary exists...
>
> gert@...1703...:/home/gert/alon/test$ ./src/openvpn/openvpn --version
> OpenVPN 2.3_alpha1 amd64-unknown-freebsd7.4 [SSL (OpenSSL)] [eurephia] [M=
H] [PF_INET6] [IPv6 payload 20110522-1 (2.2.0)] built on Mar 26 2012
>
> (no further tests done, but this is good enough improvement to *ACK* this=
).

Hmmm....
This --version is very short.... is it the full output?
I expecting something similar to:

OpenVPN 2.3_alpha1 x86_64-pc-linux-gnu [SSL (OpenSSL)] [LZO] [EPOLL]
[PKCS11] [eurephia] [MH] [PF_INET6] [IPv6 payload 20110522-1 (2.2.0)]
built on Mar 22 2012
Originally developed by James Yonan
Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
Compile time defines: enable_crypto=3Dyes enable_debug=3Dyes
enable_def_auth=3Dyes enable_dependency_tracking=3Dno
enable_dlopen=3Dunknown enable_dlopen_self=3Dunknown
enable_dlopen_self_static=3Dunknown enable_eurephia=3Dyes
enable_fast_install=3Dneedless enable_fragment=3Dyes enable_http_proxy=3Dyes
enable_iproute2=3Dyes enable_libtool_lock=3Dyes enable_lzo=3Dyes
enable_lzo_stub=3Dno enable_malloc0returnsnull=3Dyes enable_management=3Dyes
enable_multi=3Dyes enable_multihome=3Dyes enable_password_save=3Dno
enable_pedantic=3Dno enable_pf=3Dyes enable_pkcs11=3Dyes enable_plugins=3Dy=
es
enable_port_share=3Dyes enable_selinux=3Dno enable_server=3Dyes
enable_shared=3Dyes enable_shared_with_static_runtimes=3Dno
enable_small=3Dno enable_socks=3Dyes enable_ssl=3Dyes enable_static=3Dyes
enable_strict=3Dno enable_strict_options=3Dno enable_systemd=3Dno
enable_win32_dll=3Dyes enable_x509_alt_username=3Dno
with_crypto_library=3Dopenssl with_gnu_ld=3Dyes with_mem_check=3Dno
with_sysroot=3Dno

