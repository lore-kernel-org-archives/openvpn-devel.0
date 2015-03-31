Message-ID: <551AA3A2.5000300@...1800...>
Date: Tue, 31 Mar 2015 09:39:46 -0400
From: Mike Tancsa <mike@...1800...>
MIME-Version: 1.0
References: <5519B242.2020009@...1856...>
	<20150330210636.GF21893@...1296...>
In-Reply-To: <20150330210636.GF21893@...1296...>
Subject: Re: [Openvpn-devel] [Openvpn-users] FreeBSD+cryptodev testers wanted
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, openvpn-users@lists.sourceforge.net

On 3/30/2015 5:06 PM, Gert Doering wrote:
> Hi,
>
> On Mon, Mar 30, 2015 at 10:29:54PM +0200, Steffan Karger wrote:
>> So, is there anyone with a FreeBSD machine with cryptodev engine
>> available who is willing to test the patch?
>
> Actually, testing on other platforms using any sort of OpenSSL "engine"
> (usually hardware crypto accelerators etc.) is welcome - the patch will not
> affect anyone else, so it's not easy to test.


I am not able to reproduce this. The server

# kldstat | grep aes
  2    1 0xffffffff80fbf000 5a28     aesni.ko
# sysctl -A dev.aesni
dev.aesni.%parent:
dev.aesni.0.%desc: AES-CBC,AES-XTS
dev.aesni.0.%driver: aesni
dev.aesni.0.%location:
dev.aesni.0.%pnpinfo:
dev.aesni.0.%parent: nexus0

tls-server
mode server
daemon openvpn-hq
user root
group wheel
local 1.1.1.2
proto udp
dev tun102
engine cryptodev
cipher AES-128-CBC   # AES

FreeBSD 10.1-STABLE #6 r280386: Mon Mar 23 13:53:00 EDT 2015
# openvpn  --version
OpenVPN 2.3.6 amd64-portbld-freebsd10.1 [SSL (OpenSSL)] [LZO] [MH] 
[IPv6] built on Feb  9 2015
library versions: OpenSSL 1.0.1m-freebsd 19 Mar 2015, LZO 2.09
Originally developed by James Yonan
Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
Compile time defines: enable_crypto=yes enable_crypto_ofb_cfb=yes 
enable_debug=yes enable_def_auth=yes enable_dlopen=unknown 
enable_dlopen_self=unknown enable_dlopen_self_static=unknown 
enable_fast_install=needless enable_fragment=yes enable_http_proxy=yes 
enable_iproute2=no enable_libtool_lock=yes enable_lzo=yes 
enable_lzo_stub=no enable_management=yes enable_multi=yes 
enable_multihome=yes enable_pam_dlopen=no enable_password_save=yes 
enable_pedantic=no enable_pf=yes enable_pkcs11=no 
enable_plugin_auth_pam=yes enable_plugin_down_root=yes 
enable_plugins=yes enable_port_share=yes enable_selinux=no 
enable_server=yes enable_shared=yes 
enable_shared_with_static_runtimes=no enable_small=no enable_socks=yes 
enable_ssl=yes enable_static=yes enable_strict=no 
enable_strict_options=no enable_systemd=no enable_win32_dll=yes 
enable_x509_alt_username=no with_crypto_library=openssl with_gnu_ld=yes 
with_mem_check=no with_plugindir='$(libdir)/openvpn/plugins' with_sysroot=no

I have in the kernel of this server

device  crypto
device  cryptodev
options IPSEC
device pf
device pflog

Are there any special configs that need to be done to openssl ?

# openssl engine
(cryptodev) BSD cryptodev engine
(rsax) RSAX engine support
(rdrand) Intel RDRAND engine
(dynamic) Dynamic engine loading support

I had a client connect and disconnect and was able to pass traffic 
across the tunnel

	---Mike


-- 
-------------------
Mike Tancsa, tel +1 519 651 3400
Sentex Communications, mike@...1800...
Providing Internet services since 1994 www.sentex.net
Cambridge, Ontario Canada   http://www.tancsa.com/

