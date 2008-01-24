Date: Thu, 24 Jan 2008 02:18:20 +0100
From: =?iso-8859-15?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Message-ID: <977951940.20080124021820@...449...>
In-Reply-To: <1235941264.20080124002142@...449...>
References: <4797B53E.4020007@...41...> <1323691392.20080123234058@...449...>
	<9e0cf0bf0801231453i796138cctb3ddb28d1c803c68@...278...>
	<359159876.20080124000039@...449...>
	<9e0cf0bf0801231507hf027b09jbc7a9cdae292f475@...278...>
	<1235941264.20080124002142@...449...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.1-rc5 released
Reply-To: =?iso-8859-15?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

> I try to setup a toolchain for windows.

I build lzo-2.0.2 and openssl-0.9.7m (patched)

OPENSSL_DIR=~/openssl-0.9.7m
export OPENSSL_DIR

building openvpn didn't work (maybe it's only to late and I didn't see
an obvious thing)

Carsten@...1075... ~/openvpn-2.1_rc5
$ make -f makefile.w32
gcc -g -O2 -Wall -Wno-unused-function -Wno-unused-variable -mno-cygwin -I./openssl/include -I/include -I/include -c crypto.c -o crypto.o
In file included from crypto.c:35:
crypto.h:40:29: openssl/objects.h: No such file or directory
crypto.h:41:26: openssl/rand.h: No such file or directory
crypto.h:42:25: openssl/evp.h: No such file or directory
crypto.h:43:26: openssl/hmac.h: No such file or directory


greetings
Carsten


