Message-ID: <12570dae-cf48-9969-dea9-16e25c6cad71@...2181...>
Date: Tue, 2 May 2023 23:06:19 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <CAKasoNDCgjXHkj2SCn0Pe-MsO0+E5JUN08yJj3K8Ld+cWvfO=g@...278...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <CAKasoNDCgjXHkj2SCn0Pe-MsO0+E5JUN08yJj3K8Ld+cWvfO=g@...278...>
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
To: Shawn Asmussen <shawn.asmussen@...277...>, openvpn-devel@lists.sourceforge.net

Hi,

On 02/05/2023 20:38, Shawn Asmussen wrote:
> Today I began to setup a test platform in our organization for openvpn 
> DCO. We are running Oracle's OEL 8. The make of the dco module fails, 
> and I suspect that it is because the Makefile detects EL8, and tries to 
> compile using a configuration that is specific to RHEL's custom kernel 
> source code. However, Oracle Linux, by default uses
> their own custom kernel called the UEK (Unbreakable Enterprise Kernel). 
> Commenting out the EL8 check in the Makefile results in the module 
> compiling, but I still have to configure the rest of the pieces of the 
> test before I can verify that the compiled module is functional.

Unfortunately this is a bit of a mess with distros claiming to have a 
certain kernel, but then supporting features that do not belong to it.

The RHEL workaround is just a way to deal with it in the Red Hat world.

Somebody else on GitHub already reported about this logic not working 
for CentOS.

Can you please paste the content of your /etc/redhat-release ?

Regards,

> 
> 
> -[~/dco-test/ovpn-dco:$]- make
> /buildhome/oracle8/build/dco-test/ovpn-dco/gen-compat-autoconf.sh 
> /buildhome/oracle8/build/dco-test/ovpn-dco/compat-autoconf.h
> make -C /lib/modules/5.4.17-2136.318.7.1.el8uek.x86_64/build 
> M=/buildhome/oracle8/build/dco-test/ovpn-dco 
> PWD=/buildhome/oracle8/build/dco-test/ovpn-dco REVISION=0.2.20230426 
> CONFIG_OVPN_DCO_V2=m INSTALL_MOD_DIR=updates/    modules
> make[1]: Entering directory 
> '/usr/src/kernels/5.4.17-2136.318.7.1.el8uek.x86_64'
>    CC [M] 
>   /buildhome/oracle8/build/dco-test/ovpn-dco/drivers/net/ovpn-dco/main.o
> /buildhome/oracle8/build/dco-test/ovpn-dco/drivers/net/ovpn-dco/main.c:113:28: error: ‘dev_get_tstats64’ undeclared here (not in a function); did you mean ‘dev_get_stats’?
>    .ndo_get_stats64        = dev_get_tstats64,
>                              ^~~~~~~~~~~~~~~~
>                              dev_get_stats
> make[3]: *** [scripts/Makefile.build:268: 
> /buildhome/oracle8/build/dco-test/ovpn-dco/drivers/net/ovpn-dco/main.o] 
> Error 1
> make[2]: *** [scripts/Makefile.build:503: 
> /buildhome/oracle8/build/dco-test/ovpn-dco/drivers/net/ovpn-dco] Error 2
> make[1]: *** [Makefile:1798: /buildhome/oracle8/build/dco-test/ovpn-dco] 
> Error 2
> make[1]: Leaving directory 
> '/usr/src/kernels/5.4.17-2136.318.7.1.el8uek.x86_64'
> make: *** [Makefile:59: all] Error 2
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-- 
Antonio Quartulli

