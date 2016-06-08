References: <1465388443-15484-1-git-send-email-steffan@...1856...>
	<CAA1AbxJ0MQH6UL-b1Y+n_nE74Jw1C7fZeNqpsFkYyjt_UFBVXw@...278...>
	<5758352E.9030407@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <fb02387f-1ca4-5fe6-2bc4-604aa3d45899@...1227...>
Date: Wed, 8 Jun 2016 17:45:35 +0200
MIME-Version: 1.0
In-Reply-To: <5758352E.9030407@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Add support for cipher negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net

On 08.06.2016 17:09, debbie10t wrote:
> Hi
>
> On 08/06/16 13:32, Steffan Karger wrote:
>> On Wed, Jun 8, 2016 at 2:20 PM, Steffan Karger <steffan@...1856...> wrote:
>>> Please test and provide comments.  I ran the 'make check' test suite, including
>>> t_client tests, and performed manual testing.  But, as Gert eloquently puts it,
>>> this is likely to 'break stuff in interesting ways', so more testing (and
>>> review) is very welcome!
>> For those of you that rather check out a github branch instead of
>> applying patches, I pushed my branch - plus some extra debug commits -
>> to https://github.com/syzzer/openvpn/tree/nego-squashed
> I decided to give this a go from git .. but here snappy is still used.
> I am happy to get snappy myself but I thought snappy had been dropped ?
> thanks
>
Since it is on git master there is no snappy in there, can you double
check that you used the right branch and not some other outdated branch
of syzzer repo?

Arne

