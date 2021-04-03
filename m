References: <20210402134529.27866-1-gert@...1296...>
 <b92f02afa4d8156edd55c2126ae6352c.squirrel@...2260...>
 <20210402185720.GS976@...1296...>
 <c76250866ae96447a3ec712f04b4b346.squirrel@...2260...>
 <458e1fb5-a725-781b-c048-4f0e07440c7b@...1227...>
 <1cf9fe7a309a622eb0ddd79a34dd3af4.squirrel@...2556...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <a0648ba0-41ed-5eef-4f36-d41bcb636823@...2181...>
Date: Sat, 3 Apr 2021 10:43:37 +0200
MIME-Version: 1.0
In-Reply-To: <1cf9fe7a309a622eb0ddd79a34dd3af4.squirrel@...2556...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Fix 'compress migrate' for 2.2 clients.
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
To: Simon Matter <simon.matter@...2249...>, Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 03/04/2021 10:32, Simon Matter wrote:
> I'm not asking to enable it by default or even compile it by default. I'm
> only asking to keep the code in so those who know what they are doing can
> enable it as a compile time option or expert mode option or something like
> that.

If you ask everybody, they always knew what they were doing, even when
something went wrong.

If there is no real usecase for a feature, and this feature is known to
be a potential risk, it is our duty to make sure people will not shoot
themselves in the foot.

If you have a use case that you think can benefit big time by having
compression, please feel free to describe it in details. Therefore might
be saner ways to address it.


If somebody feels being expert enough and knows what he is doing more
than the others, he can still re-add the feature (i.e. by reverting any
patch that might be removing the code) and recompile OpenVPN. The beauty
of Open Source :-)

Cheers,


-- 
Antonio Quartulli

