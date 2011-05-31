Message-ID: <4DE55CDE.10300@...1030...>
Date: Tue, 31 May 2011 22:25:50 +0100
From: Mr Dash Four <mr.dash.four@...1030...>
MIME-Version: 1.0
References: <4DB864E0.4060207@...515...> <4DE4F116.2000904@...1030...>
	<4DE502D5.3070403@...1114...>
	<4DE504BA.6060209@...1030...>
	<4DE50E52.2000509@...1114...>
In-Reply-To: <4DE50E52.2000509@...1114...>
Subject: Re: [Openvpn-devel] OpenVPN 2.2.0 build failure
	with	"--disable-management"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> If this works for you, I'll take this as an ACK from you, then this patch
> will get into the queue for a 2.2.1 release.
>   
Yep, the patch works without a hitch, but when I now have this:

configure \
--build=x86_64-redhat-linux-gnu \
--host=i686-redhat-linux-gnu \
--enable-password-save \
--enable-iproute2 \
--with-ifconfig-path=/sbin/ifconfig  \
--with-iproute-path=/sbin/ip \
--with-route-path=/sbin/route \
--disable-port-share \
--disable-multi \
--disable-server \
--disable-eurephia \
--disable-socks \
--disable-http \
--disable-management

I get the following error during make:

gcc -DHAVE_CONFIG_H -I.   -I.    -O2 -g -pipe -Wall 
-Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector 
--param=ssp-buffer-size=4 -m32 -march=i686 -mtune=pentium2 
-fasynchronous-unwind-tables -c options.c
options.c: In function 'init_options':
options.c:781: error: 'struct options' has no member named 'tmp_dir'
options.c:782: error: 'struct options' has no member named 'tmp_dir'
options.c:783: error: 'struct options' has no member named 'tmp_dir'
make[2]: *** [options.o] Error 1
make[2]: Leaving directory `/home/me/rpmbuild/BUILD/openvpn-2.2.0'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/me/rpmbuild/BUILD/openvpn-2.2.0'
make: *** [all] Error 2

I hope there is equally effective patch ready to squash this bug as 
well! :-)

