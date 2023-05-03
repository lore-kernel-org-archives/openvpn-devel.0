Message-ID: <99b6e464-497f-ae7b-0ab8-f69edb407138@...2181...>
Date: Wed, 3 May 2023 11:05:02 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <CAKasoNDCgjXHkj2SCn0Pe-MsO0+E5JUN08yJj3K8Ld+cWvfO=g@...278...>
 <12570dae-cf48-9969-dea9-16e25c6cad71@...2181...>
 <CAKasoNDVEsNBSceOgyTYGxE43tca2=yijV2mudC0WX4QnBL2=A@...278...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <CAKasoNDVEsNBSceOgyTYGxE43tca2=yijV2mudC0WX4QnBL2=A@...278...>
Subject: Re: [Openvpn-devel] Compiling DCO module on Oracle Linux 8,
 against UEK kernel
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Shawn Asmussen <shawn.asmussen@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 02/05/2023 23:18, Shawn Asmussen wrote:
> Certainly. Here is the contents of the redhat-release, oracle-release, 
> and os-release files. It's also worth noting that the UEK kernel is 
> optional on OEL, so theoretically an OEL system can be running either 
> the RHEL kernel (A recompile of the RHEL source code, just like CentOS 8 
> used to be before the change), or Oracle's own UEK kernel. In my 
> experience, most people using Oracle tend to stick with the Oracle UEK 
> kernel, though. Therefore, an OEL user could either need the RHEL 
> configuration when compiling the DCO module, or not, depending on which 
> kernel they were compiling against.

I see that the build system of the backports project looks into the 
kernel config for some RHEL specific macros.
This might be more sensible as we abstract away from the distro 
name/version and we rather focus on what kernel is available on the system.

I'll add it to my todo list, but patches are welcome :-)

Cheers,

> 
> -[~:#]- cat /etc/os-release
> NAME="Oracle Linux Server"
> VERSION="8.7"
> ID="ol"
> ID_LIKE="fedora"
> VARIANT="Server"
> VARIANT_ID="server"
> VERSION_ID="8.7"
> PLATFORM_ID="platform:el8"
> PRETTY_NAME="Oracle Linux Server 8.7"
> ANSI_COLOR="0;31"
> CPE_NAME="cpe:/o:oracle:linux:8:7:server"
> HOME_URL="https://linux.oracle.com/ <https://linux.oracle.com/>"
> BUG_REPORT_URL="https://bugzilla.oracle.com/ <https://bugzilla.oracle.com/>"
> 
> ORACLE_BUGZILLA_PRODUCT="Oracle Linux 8"
> ORACLE_BUGZILLA_PRODUCT_VERSION=8.7
> ORACLE_SUPPORT_PRODUCT="Oracle Linux"
> ORACLE_SUPPORT_PRODUCT_VERSION=8.7
> 
> 
> 
> 
> -[~:#]- cat /etc/oracle-release
> Oracle Linux Server release 8.7
> 
> 
> 
> -[~:#]- cat /etc/redhat-release
> Red Hat Enterprise Linux release 8.7 (Ootpa)
> 
> On Tue, May 2, 2023 at 2:06 PM Antonio Quartulli <a@...2181... 
> <mailto:a@...2181...>> wrote:
> 
>     Hi,
> 
>     On 02/05/2023 20:38, Shawn Asmussen wrote:
>      > Today I began to setup a test platform in our organization for
>     openvpn
>      > DCO. We are running Oracle's OEL 8. The make of the dco module
>     fails,
>      > and I suspect that it is because the Makefile detects EL8, and
>     tries to
>      > compile using a configuration that is specific to RHEL's custom
>     kernel
>      > source code. However, Oracle Linux, by default uses
>      > their own custom kernel called the UEK (Unbreakable Enterprise
>     Kernel).
>      > Commenting out the EL8 check in the Makefile results in the module
>      > compiling, but I still have to configure the rest of the pieces
>     of the
>      > test before I can verify that the compiled module is functional.
> 
>     Unfortunately this is a bit of a mess with distros claiming to have a
>     certain kernel, but then supporting features that do not belong to it.
> 
>     The RHEL workaround is just a way to deal with it in the Red Hat world.
> 
>     Somebody else on GitHub already reported about this logic not working
>     for CentOS.
> 
>     Can you please paste the content of your /etc/redhat-release ?
> 
>     Regards,
> 
>      >
>      >
>      > -[~/dco-test/ovpn-dco:$]- make
>      > /buildhome/oracle8/build/dco-test/ovpn-dco/gen-compat-autoconf.sh
>      > /buildhome/oracle8/build/dco-test/ovpn-dco/compat-autoconf.h
>      > make -C /lib/modules/5.4.17-2136.318.7.1.el8uek.x86_64/build
>      > M=/buildhome/oracle8/build/dco-test/ovpn-dco
>      > PWD=/buildhome/oracle8/build/dco-test/ovpn-dco REVISION=0.2.20230426
>      > CONFIG_OVPN_DCO_V2=m INSTALL_MOD_DIR=updates/    modules
>      > make[1]: Entering directory
>      > '/usr/src/kernels/5.4.17-2136.318.7.1.el8uek.x86_64'
>      >    CC [M]
>      > 
>       /buildhome/oracle8/build/dco-test/ovpn-dco/drivers/net/ovpn-dco/main.o
>      >
>     /buildhome/oracle8/build/dco-test/ovpn-dco/drivers/net/ovpn-dco/main.c:113:28: error: ‘dev_get_tstats64’ undeclared here (not in a function); did you mean ‘dev_get_stats’?
>      >    .ndo_get_stats64        = dev_get_tstats64,
>      >                              ^~~~~~~~~~~~~~~~
>      >                              dev_get_stats
>      > make[3]: *** [scripts/Makefile.build:268:
>      >
>     /buildhome/oracle8/build/dco-test/ovpn-dco/drivers/net/ovpn-dco/main.o]
>      > Error 1
>      > make[2]: *** [scripts/Makefile.build:503:
>      > /buildhome/oracle8/build/dco-test/ovpn-dco/drivers/net/ovpn-dco]
>     Error 2
>      > make[1]: *** [Makefile:1798:
>     /buildhome/oracle8/build/dco-test/ovpn-dco]
>      > Error 2
>      > make[1]: Leaving directory
>      > '/usr/src/kernels/5.4.17-2136.318.7.1.el8uek.x86_64'
>      > make: *** [Makefile:59: all] Error 2
>      >
>      >
>      > _______________________________________________
>      > Openvpn-devel mailing list
>      > Openvpn-devel@lists.sourceforge.net
>     <mailto:Openvpn-devel@lists.sourceforge.net>
>      > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>     <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>
> 
>     -- 
>     Antonio Quartulli
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-- 
Antonio Quartulli

