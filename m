From: Antonio Quartulli <a@...2181...>
References: <20201118145413.26134-1-huangya90@...277...>
Message-ID: <7687c14d-bfd7-5a41-6ede-d94ccfd91f3e@...2181...>
Date: Wed, 18 Nov 2020 16:39:11 +0100
MIME-Version: 1.0
In-Reply-To: <20201118145413.26134-1-huangya90@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] ovpn-dco: nestns-test.sh - fix the issue that
 veth is not created successfully
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
To: Tony He <huangya90@...277...>, a@...2181..., openvpn-devel@lists.sourceforge.net

Hi Tony,

On 18/11/2020 15:54, Tony He wrote:
> 
> Hi Antonio,
> 
> Have you encountered this issue? Please help to review.
> 

No, we have never encountered this issue.

My feeling is that you are using userspace tools that are older than
what we normally use.

I see you are using Ubuntu 18.04 and that might be the reason.

In any case, your patch is small and does not hurt :-)

Thanks


-- 
Antonio Quartulli

