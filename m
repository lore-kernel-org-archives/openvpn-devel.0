References: <20210321144627.1621-1-simon@...2293...>
 <20210321144627.1621-5-simon@...2293...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <cad6f0fd-64a0-bbda-b9fb-a9d9c676df3a@...1227...>
Date: Sun, 21 Mar 2021 16:51:44 +0100
MIME-Version: 1.0
In-Reply-To: <20210321144627.1621-5-simon@...2293...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 5/5] iservice: Resolve MSVC C4996
 warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Simon Rozman <simon@...2293...>, openvpn-devel@lists.sourceforge.net

Am 21.03.21 um 15:46 schrieb Simon Rozman via Openvpn-devel:
> Lots of string functions were declared unsafe in favor of ..._s()
> counterparts. However, the code already is careful about the buffer
> size. Code analysis is just not smart enough (yet) to detect this.
> 
> The code was refactored to use ..._s() variants MSVC is considering as
> "safe".

Acked-By: Arne Schwabe <arne@...1227...>

This change changes Windows specifc functions to other windows specific
functions that do not emit errors. Test compiled with msvc/clang-cl

Arne

