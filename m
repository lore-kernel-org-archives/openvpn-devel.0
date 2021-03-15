References: <20210312150629.57302-1-juliusz@...2525...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <c290dac4-66b6-60d5-20d8-dfc441415bbe@...1227...>
Date: Mon, 15 Mar 2021 18:11:02 +0100
MIME-Version: 1.0
In-Reply-To: <20210312150629.57302-1-juliusz@...2525...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] EVP_DigestSignFinal siglen parameter
 correction
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Juliusz Sosinowicz <juliusz@...2525...>, openvpn-devel@lists.sourceforge.net

Am 12.03.21 um 16:06 schrieb Juliusz Sosinowicz:
> In the EVP_DigestSignFinal API, "before the call the siglen parameter should contain the length of the sig buffer".

This is probably correct but I need to take a closer look as this
function is directly taken from OpenSSL's internal function and only has
minimal adaptations. Note also that we plan to remove this compatibility
path as soon as we drop OpenSSL 1.0.2 support.

Arne

