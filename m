Message-ID: <59605434-9c79-bd5d-8359-110c069bf941@...1227...>
Date: Tue, 4 Jul 2023 13:03:55 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20230703153925.48990-1-frank@...2641...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20230703153925.48990-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH] CMake: Throw a clear error when
 config.h in top-level source directory
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Frank Lichtenheld <frank@...2641...>, openvpn-devel@lists.sourceforge.net

Am 03.07.23 um 18:39 schrieb Frank Lichtenheld:
> This causes weird, difficult to debug compilation errors. Usually
> caused by trying to run CMake against a source that had an
> in-tree autoconfig build.
> 
> Note that you're able to do out-of-tree autoconfig builds and
> they can obviously mix with out-of-tree cmake builds.
> 

Acked-By: Arne Schwabe <arne@...1227...>


