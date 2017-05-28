From: debbie10t <debbie10t@...277...>
Message-ID: <b40a8930-a6aa-cd9d-8cfb-0ed57d1cdc93@...277...>
Date: Sun, 28 May 2017 21:47:30 +0100
MIME-Version: 1.0
Content-Language: en-GB
Subject: [Openvpn-devel] Ubuntu 16.04.2 LTS --enable-systemd ./configure
 error
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi

This is just a heads up !

I cannot build openvpn on ubuntu 16.04.2 LTS (fresh install) because
./configure --enable-systemd fails to build with the following error:

autoconf -ifv [done]

./configure --enable-system log

<q>

checking for RSA_meth_set0_app_data... no
checking for lzo1x_1_15_compress in -llzo2... yes
checking lzo/lzoutil.h usability... yes
checking lzo/lzoutil.h presence... yes
checking for lzo/lzoutil.h... yes
checking lzo/lzo1x.h usability... yes
checking lzo/lzo1x.h presence... yes
checking for lzo/lzo1x.h... yes
configure: checking for LZ4 Library and Header files...
checking for LZ4_compress in -llz4... yes
checking lz4.h usability... yes
checking lz4.h presence... yes
checking for lz4.h... yes
checking for libsystemd... no
checking for libsystemd... no
configure: error: in `/home/dik/openvpn/master':
configure: error: The pkg-config script could not be found or is too 
old.  Make sure it
is in your PATH or set the PKG_CONFIG environment variable to the full
path to pkg-config.

Alternatively, you may set the environment variables libsystemd_CFLAGS
and libsystemd_LIBS to avoid the need to call pkg-config.
See the pkg-config man page for more details.

To get pkg-config, see <http://pkg-config.freedesktop.org/>.
See `config.log' for more details

</q>

Not only but also ..

$ systemctl version
Unknown operation version.

$ uname -a
Linux ub64-tst 4.4.0-62-generic #83-Ubuntu SMP Wed Jan 18 14:10:15 UTC


./configure without --enable-systemd is fine

apt-get install libsystemd-dev is done


-- 

