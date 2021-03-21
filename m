References: <20210321144627.1621-1-simon@...2293...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <0345306a-a49f-689b-4d4d-5d5d25432ec0@...1227...>
Date: Sun, 21 Mar 2021 17:25:18 +0100
MIME-Version: 1.0
In-Reply-To: <20210321144627.1621-1-simon@...2293...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 1/5] MSVC: Disable LZ4
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
To: Simon Rozman <simon@...2293...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 21.03.21 um 15:46 schrieb Simon Rozman via Openvpn-devel:
> Commit 24596b25 ("build: Remove compat-lz4") removed lz4 compat layer,
> but openvpn-build\msvc doesn't provide LZ4 library either.

We should either add lz4 to openvpn-build or change the default of lz4
to disabled in all variant. I don't like the idea that windows has a
different default than the other variants.

Arne

