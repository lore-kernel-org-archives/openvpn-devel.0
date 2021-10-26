References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-19-arne@...1227...>
From: Max Fillinger <maximilian.fillinger@...2507...>
Message-ID: <06b09ac6-8494-5fcb-810b-00fd2c2c827c@...2507...>
Date: Tue, 26 Oct 2021 19:48:26 +0200
MIME-Version: 1.0
In-Reply-To: <20211019183127.614175-19-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 18/21] Fix error when BF-CBC is not
 available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 19/10/2021 20:31, Arne Schwabe wrote:
> Through the multiple iteration of allowing OpenVPN to run without
> BF-CBC we accidentially made a regression and still required BF-CBC.
> 
> This patch fixes the code path and restores its intended function.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Acked-by: Max Fillinger <maximilian.fillinger@...2507...>

This fixes running with --mode server when BF-CBC is unavailable.

