Date: Wed, 24 Aug 2022 13:42:28 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <YwYOpETWRZV/nYh8@...2685...>
References: <20220818201505.656149-1-frank@...2641...>
 <20220818201505.656149-2-frank@...2641...>
 <6e140f92-f71f-35e8-cd3b-914949ef24b5@...2181...>
 <52da546c-3890-c073-aea7-a620db92520d@...1227...>
 <Yv9jXk9r5Zc9ut5c@...1296...>
MIME-Version: 1.0
In-Reply-To: <Yv9jXk9r5Zc9ut5c@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] uncrustify: remove newlines after
 return type of function prototype
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Gert Doering <gert@...1296...>
Cc: Arne Schwabe <arne@...1227...>, Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

On Fri, Aug 19, 2022 at 12:18:06PM +0200, Gert Doering wrote:
> Hi,
[...] 
> It would be cool if uncrustify had a magic flag for that, like "if 
> return type + function name is < 40 characters, put on a single line,
> and if over, split" :-)

Pretty sure there is nothing like that. So should we mark this patch
just as rejected in patchwork and move on?

> Am I making sense?

I understand your reasoning. I wouldn't agree that it is worth clinging
to a style that can't be enforced just because it is slightly prettier.
But definitely not going to waste further time arguing about this
specific bikeshed ;)

Regards,
-- 
  Frank Lichtenheld

