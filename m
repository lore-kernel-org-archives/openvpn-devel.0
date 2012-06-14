MIME-Version: 1.0
In-Reply-To: <20120614144454.GX1059@...1296...>
References: <20120614144454.GX1059@...1296...>
Date: Thu, 14 Jun 2012 19:56:11 +0300
Message-ID: <CAOazyz3ZtBL+Zi=dGMvhbNqP_UxgViTt-8AWfNeRJTb4kOnsOg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] ENABLE_PF and config.h breakage
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

Right.
config.h should be included in all C sources never in .h file, it is
also not protected for multiple includes.
Don't know why the polarssl had this, as syshead used to perform this
in the past so it should not have existed also in the past.

Thanks,
Alon.

On Thu, Jun 14, 2012 at 5:44 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> openvpn-devel in the current openwrt tree is broken, due to upstream-
> breakage.
>
> For the record, it's built like this:
>
> =C2=A0$ ./configure --target=3Dmips-openwrt-linux --host=3Dmips-openwrt-l=
inux --build=3Di686-pc-linux-gnu --program-prefix=3D --program-suffix=3D --=
prefix=3D/usr --exec-prefix=3D/usr --bindir=3D/usr/bin --sbindir=3D/usr/sbi=
n --libexecdir=3D/usr/lib --sysconfdir=3D/etc --datadir=3D/usr/share --loca=
lstatedir=3D/var --mandir=3D/usr/man --infodir=3D/usr/info --disable-nls --=
enable-small --disable-selinux --disable-systemd --disable-plugins --disabl=
e-debug --disable-eurephia --disable-pkcs11 --enable-lzo --disable-crypto d=
isable-x509-alt-username-ssl --enable-server --disable-management --enable-=
socks --enable-http --enable-fragment --enable-multihome --disable-iproute2=
 --enable-def-auth --enable-pf --enable-ssl --enable-crypto --with-crypto-l=
ibrary=3Dpolarssl
>
> ... and the real breakage is the combination of --enable-pf,
> --disable-plugins, --disable-management and --with-crypto-library=3Dpolar=
ssl.
>
> What this will do is:
>
> =C2=A0- config.h defines ENABLE_PF
>
> /* Enable internal packet filter */
> #define ENABLE_PF 1
>
> =C2=A0- syshead.h turns it off again
>
> #if defined(ENABLE_DEF_AUTH) && P2MP_SERVER && defined(ENABLE_MANAGEMENT)
> #define MANAGEMENT_DEF_AUTH
> #endif
> ...
> /*
> =C2=A0* Enable packet filter?
> =C2=A0*/
> #if defined(ENABLE_PF) && P2MP_SERVER && defined(ENABLE_PLUGIN) && define=
d(HAVE_STAT)
> #define PLUGIN_PF
> #endif
> #if defined(ENABLE_PF) && P2MP_SERVER && defined(MANAGEMENT_DEF_AUTH)
> #define MANAGEMENT_PF
> #endif
> #if !defined(PLUGIN_PF) && !defined(MANAGEMENT_PF)
> #undef ENABLE_PF
> #endif
>
> =C2=A0- so pf.c gets compiled into an empty pf.o module (all ok)
>
> =C2=A0- now, init.c does more interesting things
>
> =C2=A0 =C2=A0- include "config.h" -> #define ENABLE_PF 1
> =C2=A0 =C2=A0- include "syshead.h" -> #undef ENABLE_PF
> =C2=A0 =C2=A0- include "init.h"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0include "openvpn.h"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 include "ssl.h"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0include "ssl_backend.h"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 include "ssl_pola=
rssl.h"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0incl=
ude "config.h" =C2=A0--> #define ENABLE_PF 1
>
> =C2=A0- so init.c and multi.c get compiled with the function calls towards
> =C2=A0 pf.c, but pf.o is empty -> linker fails
>
> This cannot be triggered with --disable-pf, or OpenSSL (because ssl_opens=
sl.h
> does not include config.h), or if either plugins or management are enable=
d.
>
>
> The quick fix is "remove config.h from ssl_polarssl.h" - because all .c
> modules right now include this anyway, as the first thing, including all
> SSL modules. =C2=A0I would propose to do that right away (patch attached)=
, but
> would like confirmation from Adriaan that I'm not overlooking anything.
>
> The "right" fix is manyfold (and I think I'll agree with Alon here)
>
> =C2=A0- stop calling our own include files many layers deep
>
> =C2=A0- stop modifying config.h variables from sysdep.h - if we want to
> =C2=A0 override ENABLE_PF depending on other options, let's do it in
> =C2=A0 configure
>
> =C2=A0- cleanup the amazing heap of #ifdefs in sysdep.h
>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //www.muc.de/~gert/
> Gert Doering - Munich, Germany =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gert@...1296...
> fax: +49-89-35655025 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gert@...1297...
>
> -------------------------------------------------------------------------=
-----
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond. Discussions
> will include endpoint security, mobile security and the latest in malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

