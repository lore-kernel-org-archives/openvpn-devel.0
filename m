MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE1085B4CA4D@...2294...>
References: <20171010231130.6832-1-simon@...2293...>
 <20171010231130.6832-9-simon@...2293...>
 <20171105192019.GM958@...1296...>
 <99D61A626FDA8A4B90A270669121BE108587DA0D@...2294...>
 <CAKuzo_hTnJVcEuCqCQ-ZR3swbkio7CWZgy3z5C0fWVJ-E0PCvQ@...278...>
 <99D61A626FDA8A4B90A270669121BE108587DF29@...2294...>
 <CAKuzo_jFp86anFk6mgavBoYhmCCHUeJ_EQpb6Z05PTNJxBYWWw@...278...>
 <99D61A626FDA8A4B90A270669121BE10858830C4@...2294...>
 <20171204192515.GA69387@...1296...>
 <99D61A626FDA8A4B90A270669121BE1085B4AC9A@...2294...>
 <CAKuzo_hJdNEMMmUqa4d=n4k9vZXoYtkC9CFcvAkW9cDgzT2wCA@...278...>
 <99D61A626FDA8A4B90A270669121BE1085B4CA4D@...2294...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 6 Dec 2017 20:02:37 -0500
Message-ID: <CAKuzo_iAJxP9AmGvApNXno7yw5q_rn5jQko+bUePmdXqUXgmgQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH 09/13] Signed/unsigned warnings of MSVC
 resolved
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Simon Rozman <simon@...2293...>
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On Wed, Dec 6, 2017 at 12:10 PM, Simon Rozman <simon@...2293...> wrote:
> Hi,
>
>> > The get_interface_metric() function should get a more thorough rewrite
>> than just a compiler warning shut-up. So the patch will probably get divided
>> in two - the simple signed/unsigned fixes and get_interface_metric()
>> redesign.
>>
>> For the latter, I had "re-invented" the get_interface_metric function for the
>> pending "use lowest metric interface when multiple interfaces match a
>> route" patch.
>>
>> Obviously, its better to refactor this one and use it there, so I just copied the
>> implementation and submitted a patch to do so. Unlike I had thought earlier,
>> this has to stay in block_dns.h for ease of sharing with the service.
>>
>> Could you please take a look and see whether it addresses MSVC's concerns
>> among other things?
>
> I have tested and am confirming MSVC is happy with the block_dns.c now.
>
> Should your patch be merged, I shall rebase the "[PATCH 09/13] Signed/unsigned warnings of MSVC resolved" to the new master and deliver the next version.

Yes, if you can review and ack/nak it :)

Selva

