References: <20180602034206.9459-1-a@...2181...>
 <9f251992-0397-41e3-e1a5-506330c33aba@...2181...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <ceb7f155-cfc4-ac89-4703-fed77e662881@...1147...>
Date: Mon, 4 Jun 2018 09:10:23 +0200
MIME-Version: 1.0
In-Reply-To: <9f251992-0397-41e3-e1a5-506330c33aba@...2181...>
Content-Language: nl-NL
Subject: Re: [Openvpn-devel] [PATCH 1/2] make tls-auth a
 per-connection-block option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Hi Antonio,

On 04/06/18 04:15, Antonio Quartulli wrote:
> Hi all,
>
> On 02/06/18 11:42, Antonio Quartulli wrote:
>> Different VPN servers may use different tls-auth keys. For this
>> reason it is convenient to make tls-auth a per-connection-block
>> option so that the user is allowed to specify one key per remote.
>>
>> If no tls-auth option is specified in a given connection block,
>> the global one, if any, is used.
>>
>> Trac: #720
>> Cc: Steffan Karger <steffan@...1856...>
>> Signed-off-by: Antonio Quartulli <a@...2181...>
> as reported by Steffan on IRC, this feature breaks when using
> "--persist-key".
> It happens because, when moving to the next connection block, OpenVPN
> won't load the new tls-auth key and therefore will trigger an assertion.
>
> After further discussing this issue, it was agreed that we have two main
> options to tackle this issue:
>
> 1) pre-load all the tls-auth keyfiles (like if they were embedded in the
> config file)
> 2) make per-connection-block tls-auth keys mutually exclusive with
> --persist-key
>
>
> while point 2) would be the easiest option and would require the least
> amount of code, we believe that 1) is still the best from the user
> perspective and from the option semantics point of view (as it would not
> lead to any behaviour change).
>
> Therefore a v2 patch will be sent implementing approach 1).
>
>
this is a very interesting patch ! And I agree, approach 1) is the way 
to go, as we've been advising people to use "persist-key" for a looong 
time now.

What's the particular use case for putting tls-auth files in connection 
blocks?  Does it apply only to tls-auth/tls-crypt files or also the 
certificate/private keys?  I could see a use case for that as well...

JM2CW,

JJK


