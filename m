References: <20160916161354.GM78279@...1296...>
	<1474104227-13974-1-git-send-email-arne@...1227...>
	<CAFHpkQGHJxm8kb=3JDwaUk7HK4v-s2qyUCi=TQBU9xPWGpTeBg@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <ce4d054b-29ee-944d-6e82-1cd02677aacb@...1227...>
Date: Sat, 17 Sep 2016 13:10:32 +0300
MIME-Version: 1.0
In-Reply-To: <CAFHpkQGHJxm8kb=3JDwaUk7HK4v-s2qyUCi=TQBU9xPWGpTeBg@...278...>
Subject: Re: [Openvpn-devel] [[PATCH v2]] Remove tun-ipv6 Option. Instead
 assume that IPv6 is always supported.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 17.09.16 um 12:40 schrieb Илья Шипицин:
> funny enough, neither Azure, nor GCP are running ipv6.
> well, GCP images are compiled with ipv6 support actually.

Yeah. But the patch is not about ipv6 actually working. Just about
telling that the OS support of IPv6 tun.

Arne


