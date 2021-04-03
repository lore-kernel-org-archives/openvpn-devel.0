References: <20210402134529.27866-1-gert@...1296...>
 <b92f02afa4d8156edd55c2126ae6352c.squirrel@...2260...>
 <20210402185720.GS976@...1296...>
 <c76250866ae96447a3ec712f04b4b346.squirrel@...2260...>
 <458e1fb5-a725-781b-c048-4f0e07440c7b@...1227...>
 <1cf9fe7a309a622eb0ddd79a34dd3af4.squirrel@...2556...>
 <a0648ba0-41ed-5eef-4f36-d41bcb636823@...2181...>
 <ec1f603d169af78b5fdf0cbc3b6f4e52.squirrel@...2556...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <9b3b2029-bb7d-ab1d-a69b-0d910565fad2@...2181...>
Date: Sat, 3 Apr 2021 11:40:31 +0200
MIME-Version: 1.0
In-Reply-To: <ec1f603d169af78b5fdf0cbc3b6f4e52.squirrel@...2556...>
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
Content-Transfer-Encoding: 8bit
To: Simon Matter <simon.matter@...2249...>
Cc: Arne Schwabe <arne@...1227...>, Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 03/04/2021 11:18, Simon Matter wrote:
>> If you have a use case that you think can benefit big time by having
>> compression, please feel free to describe it in details. Therefore might
>> be saner ways to address it.
>>

It sounds like there is no answer to this?
Then why are we even discussing further? :-)

>>
>> If somebody feels being expert enough and knows what he is doing more
>> than the others, he can still re-add the feature (i.e. by reverting any
>> patch that might be removing the code) and recompile OpenVPN. The beauty
>> of Open Source :-)
> 
> I knew such answers will come :-)

It wasn't meant to be just "such answer". It is an option that people
willing to have compression can use.

I personally do that for other projects, because I believe I have a
usecase, but I also understand my case does not follow the project
philosophy or it is too specific.

> 
> But, back to security, why do you still allow OpenVPN being built on M$
> Windows then? That's the real place where people are comforted with snake
> oil and may be tempted to feel safe when using an OpenVPN tunnel but in
> reality are vulnerable. Isn't this much worse than leaving compression in
> as a compile time option?

This is totally orthogonal to having compression or not.


Cheers,

-- 
Antonio Quartulli

