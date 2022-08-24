Message-ID: <e2e49e37-6cf9-0267-4092-1dda10d6c91b@...1227...>
Date: Wed, 24 Aug 2022 15:01:10 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220824105311.71288-1-arne@...1227...>
 <CAFHpkQFi+--ZwcGpr=O+tiy3j1=xU6h0tu=5DYNbqoHj_7i+mA@...278...>
 <d948db75-b3ae-e922-7247-25556d04ba73@...1227...>
 <CAFHpkQE-yhweLEjB4F1rAJOBjW6cNUCrOHrEQKr7GPbSNS5VqQ@...278...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAFHpkQE-yhweLEjB4F1rAJOBjW6cNUCrOHrEQKr7GPbSNS5VqQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add OpenSSL 3.0 to mingw build
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
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 24.08.22 um 14:36 schrieb Илья Шипицин:
> It reverts 3.0 behaviour to 1.1.1
> However --libdir is available for 1.1.1 as well

I understand. What I am missing is *why* reverting to 1.1.1 is a good 
idea. I think we should rather use the new default. I can see arguments 
that we add --libdir=lib64 to openSSL 1.1.1 to adjust it to OpenSSL 3.0 
but not the other way round.

Arne


