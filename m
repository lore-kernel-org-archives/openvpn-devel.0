Message-ID: <4F390984.9080503@...1550...>
Date: Mon, 13 Feb 2012 17:00:52 +0400
From: Igor Novgorodov <igor@...1550...>
MIME-Version: 1.0
References: <7c22eb11c37c167998cc7975576fe585@...1550...>
	<4F3902E7.3050901@...384...>
In-Reply-To: <4F3902E7.3050901@...384...>
Subject: Re: [Openvpn-devel] [PATCH] Check for ENABLE_MANAGEMENT for
	ENABLE_CLIENT_CR
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

I'm building latest GIT with:

./configure \
--disable-debug \
--disable-plugins \
--disable-management \
--disable-socks \
--disable-password-save \
--disable-multi \
--disable-server \
--disable-pkcs11 \
--disable-http \
--disable-port-share \
--disable-def-auth \
--disable-pf \
--disable-lzo \
--disable-selinux \
--disable-iproute2 \
--enable-small

(effectively, the version that supports only static keys and no fancy stuff)

Build fails with:
...
gcc -DHAVE_CONFIG_H -I. -I. -g -O2 -MT init.o -MD -MP -MF .deps/init.Tpo=20
-c -o init.o init.c
init.c: In function =91do_route=92:
init.c:1364:7: error: too few arguments to function =91plugin_call=92
plugin.h:196:1: note: declared here
init.c: In function =91do_init_crypto_tls=92:
init.c:2286:20: error: =91const struct options=92 has no member named =91sc=
_info=92
make[2]: *** [init.o] Error 1
...

Here are even two errors, one of which (plugin_call) function is=20
addressed in OpenWRT patchset:
https://dev.openwrt.org/browser/packages/net/openvpn-polarssl/patches/300-f=
ix-plugin_call-with-ssl.patch

And another is that i'm talking about.

On 13.02.2012 16:32, David Sommerseth wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 12/02/12 19:40, igor@...1550... wrote:
>> When building a very minimal OpenVPN for OpenWRT with
>> --disable-management among others, the compilaton fails due to
>> ENABLE_CLIENT_CR being defined, although the management interface,
>> which makes use of it, has been disabled.
>>
>> The attached simple patch checks for ENABLE_MANAGEMENT before defining
>> ENABLE_CLIENT_CR.
> Which version are you compiling?  I tried a couple of compile with the
> latest version in git (master branch) in combination with
> - --disable-management and --enable-small ... And I could not manage to
> trigger this one.  Our buildbot (even though, not testing all
> combinations) have also not triggered this one.
>
> Could you provide more version information and the configure arguments
> you use?
>
>
> kind regards,
>
> David Sommerseth
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAk85AuIACgkQDC186MBRfroHEACfbJfdxCqMM0rp+wqlWx6yxc6F
> T+UAnAkQ1T7n0vb4F1cOqxaLTmQyQ4Zh
> =3DGwvf
> -----END PGP SIGNATURE-----


