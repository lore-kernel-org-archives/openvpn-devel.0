References: <20180102222002.21454-1-steffan@...1856...>
 <20180102222854.29198-1-steffan@...1856...>
 <CAKuzo_gLMrhLj9CiHBkvG18_AOm1Ex=ktPNA-Ye9eDW9iF=P8w@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <3b2cb21d-5748-2b8c-67ab-8cb23d13a371@...1856...>
Date: Sun, 4 Mar 2018 10:58:06 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gLMrhLj9CiHBkvG18_AOm1Ex=ktPNA-Ye9eDW9iF=P8w@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v2] Check for time_t overflow in
 event_timeout_trigger()
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 01-03-18 05:15, Selva Nair wrote:
> We can avoid all overflow and eliminate the check and the ASSERT
> by writing it as
> 
> time_t wakeup = (et->last - local_now) + et->n; // parens added for clarity
> 
> For the first subtraction to overflow, last and now have to differ by
>> INT_MAX (for 32 bit time_t), not something we should worry about
> (can't happen in normal operation).
> Further, the term in brackets is always negative (as now >= last),
> while et->n is positive and < INT_MAX by construction. So the final
> addition also cannot overflow. All assuming that 32 bit "now" and
> "last" are not used beyond 2037.
> 
> That would take care of this particular overflow concern.

Looking more closely at the "now" handling, I see that it indeed can not
go back (our notion of time can, but that is managed through now_adj,
not by setting now back).

So your approach is much simpler and better.  Since that is your
solution, do mind sending a patch?  I'll then do the review-and-ack.

-Steffan

