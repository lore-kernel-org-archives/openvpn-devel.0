MIME-Version: 1.0
Date: Mon, 13 Feb 2012 21:36:10 +0400
From: igor@...1550...
In-Reply-To: <4F392718.1040603@...1114...>
References: <7c22eb11c37c167998cc7975576fe585@...1550...>
	<4F3902E7.3050901@...384...> <4F390984.9080503@...1550...>
	<4F392718.1040603@...1114...>
Message-ID: <62531c0f691bcbe70d6e942805e271b0@...1550...>
Subject: Re: [Openvpn-devel]
 =?utf-8?q?=5BPATCH=5D_Check_for_ENABLE=5FMANAGEME?=
 =?utf-8?q?NT_for_ENABLE=5FCLIENT=5FCR?=
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

 Thanks!

 Well, i'm no OpenWRT developer, just customizing some packages for my=20
 needs,
 but i thought that they are sending patches upstream :)

 Anyway, if i happen to find anything, i'll post here.

 What's for the second patch (gateway/debug stuff), it has been patched=20
 in OpenWRT too,
 i just forgot to mention it:
 https://dev.openwrt.org/browser/packages/net/openvpn-polarssl/patches/400-=
fix-undefined-print_default.gateway.patch

 On Mon, 13 Feb 2012 16:07:04 +0100, David Sommerseth wrote:
> On 13/02/12 14:00, Igor Novgorodov wrote:
>> I'm building latest GIT with:
>>
>> ./configure \
>> --disable-debug \
>> --disable-plugins \
>> --disable-management \
>> --disable-socks \
>> --disable-password-save \
>> --disable-multi \
>> --disable-server \
>> --disable-pkcs11 \
>> --disable-http \
>> --disable-port-share \
>> --disable-def-auth \
>> --disable-pf \
>> --disable-lzo \
>> --disable-selinux \
>> --disable-iproute2 \
>> --enable-small
>>
>> (effectively, the version that supports only static keys and no=20
>> fancy stuff)
>>
>> Build fails with:
>> ...
>> gcc -DHAVE_CONFIG_H -I. -I. -g -O2 -MT init.o -MD -MP -MF=20
>> .deps/init.Tpo
>> -c -o init.o init.c
>> init.c: In function =E2=80=98do_route=E2=80=99:
>> init.c:1364:7: error: too few arguments to function =E2=80=98plugin_call=
=E2=80=99
>> plugin.h:196:1: note: declared here
>> init.c: In function =E2=80=98do_init_crypto_tls=E2=80=99:
>> init.c:2286:20: error: =E2=80=98const struct options=E2=80=99 has no mem=
ber named=20
>> =E2=80=98sc_info=E2=80=99
>> make[2]: *** [init.o] Error 1
>> ...
>>
>> Here are even two errors, one of which (plugin_call) function is
>> addressed in OpenWRT patchset:
>>=20
>> https://dev.openwrt.org/browser/packages/net/openvpn-polarssl/patches/30=
0-fix-plugin_call-with-ssl.patch
>
> I would love the OpenWRT guys o give us a heads up directly when=20
> something
> like this is noticed.  Such things we really want to fix ASAP.



>
> However, I didn't particular like the approach in that patch, so I've
> attached another patch for review.  If this is acked, please consider=20
> using
> this one instead (patch 0001).
>
>> And another is that i'm talking about.
>
> I'm giving your patch an ACK, so that will go into the tree.  But=20
> even one
> more fix is needed, which is in the second patch I attached.
>
>
> kind regards,
>
> David Sommerseth
>
>
>> On 13.02.2012 16:32, David Sommerseth wrote:
>> On 12/02/12 19:40, igor@...1550... wrote:
>>>>> When building a very minimal OpenVPN for OpenWRT with
>>>>> --disable-management among others, the compilaton fails due to
>>>>> ENABLE_CLIENT_CR being defined, although the management=20
>>>>> interface,
>>>>> which makes use of it, has been disabled.
>>>>>
>>>>> The attached simple patch checks for ENABLE_MANAGEMENT before=20
>>>>> defining
>>>>> ENABLE_CLIENT_CR.
>> Which version are you compiling?  I tried a couple of compile with=20
>> the
>> latest version in git (master branch) in combination with
>> --disable-management and --enable-small ... And I could not manage=20
>> to
>> trigger this one.  Our buildbot (even though, not testing all
>> combinations) have also not triggered this one.
>>
>> Could you provide more version information and the configure=20
>> arguments
>> you use?
>>
>>
>> kind regards,
>>
>> David Sommerseth
>>
>>
>>
>>=20
>> ------------------------------------------------------------------------=
------
>> Try before you buy =3D See our experts in action!
>> The most comprehensive online learning library for Microsoft=20
>> developers
>> is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3,=20
>> MVC3,
>> Metro Style Apps, more. Free future releases when you subscribe now!
>> http://p.sf.net/sfu/learndevnow-dev2
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>

