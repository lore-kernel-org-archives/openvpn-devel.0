MIME-Version: 1.0
Date: Tue, 10 Jun 2014 13:35:25 +0000
Message-ID: <CAGyAFMUQ+vF_oh4MYvs_C1Th=2KzoHoDi8Bcrv66X8jfiwARLw@...278...>
From: Lev Stipakov <lstipakov@...277...>
Subject: [Openvpn-devel] Rekey and Defer sample plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hello,

I'm facing a problem with "defer" sample plugin and rekeying.

I use plugin from
https://github.com/OpenVPN/openvpn/tree/master/sample/sample-plugins/defer.

Relevant part of openvpn config:

> auth-user-pass-optional
> setenv test_deferred_auth 2
> plugin /etc/openvpn/simple.so
> reneg-sec 20

Everything works fine, plugin writes into auth control file in 2 secs
and client got authenticated. When rekeying happends, plugin got
called and writes again to auth control file, however after that
connection breaks.

Part of OpenVPN log:

OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY
DEFER u='' p='' acf='/tmp/openvpn_acf_8ec7b1fb155ede01c8bae22c6e4ad4ea.tmp'
( sleep 2 ; echo AUTH
/tmp/openvpn_acf_8ec7b1fb155ede01c8bae22c6e4ad4ea.tmp 2 ; echo 1
>/tmp/openvpn_acf_8ec7b1fb155ede01c8bae22c6e4ad4ea.tmp ) &
Tue Jun 10 13:25:50 2014 us=851659
588b4d7d-f8ec-4397-8156-43ed232c2dd8/10.64.1.101:1194 PLUGIN_CALL:
POST /etc/openvpn/simple.so/PLUGIN_AUTH_USER_PASS_VERIFY status=2
Tue Jun 10 13:25:50 2014 us=851680
588b4d7d-f8ec-4397-8156-43ed232c2dd8/10.64.1.101:1194 TLS:
Username/Password authentication deferred for username ''
OPENVPN_PLUGIN_TLS_FINAL
Tue Jun 10 13:25:50 2014 us=851695
588b4d7d-f8ec-4397-8156-43ed232c2dd8/10.64.1.101:1194 PLUGIN_CALL:
POST /etc/openvpn/simple.so/PLUGIN_TLS_FINAL status=0
Tue Jun 10 13:25:50 2014 us=851842
588b4d7d-f8ec-4397-8156-43ed232c2dd8/10.64.1.101:1194 Data Channel
Encrypt: Cipher 'BF-CBC' initialized with 128 bit key
Tue Jun 10 13:25:50 2014 us=851850
588b4d7d-f8ec-4397-8156-43ed232c2dd8/10.64.1.101:1194 Data Channel
Encrypt: Using 160 bit message hash 'SHA1' for HMAC authentication
Tue Jun 10 13:25:50 2014 us=851894
588b4d7d-f8ec-4397-8156-43ed232c2dd8/10.64.1.101:1194 Data Channel
Decrypt: Cipher 'BF-CBC' initialized with 128 bit key
Tue Jun 10 13:25:50 2014 us=851902
588b4d7d-f8ec-4397-8156-43ed232c2dd8/10.64.1.101:1194 Data Channel
Decrypt: Using 160 bit message hash 'SHA1' for HMAC authentication
Tue Jun 10 13:25:50 2014 us=853273
588b4d7d-f8ec-4397-8156-43ed232c2dd8/10.64.1.101:1194 Control Channel:
TLSv1, cipher TLSv1/SSLv3 DHE-RSA-AES256-SHA, 2048 bit RSA
Tue Jun 10 13:25:51 2014 us=238477
588b4d7d-f8ec-4397-8156-43ed232c2dd8/10.64.1.101:1194 TLS Error:
local/remote TLS keys are out of sync: [AF_INET]10.64.1.101:1194 [1]

and after that lots of "TLS keys are out of sync".

Is it kind of a bug in OpenVPN/sample plugin or am I missing something
in configuration? Anything can be done (maybe in OpenVPN code) to make
it work?

-- 
-Lev

