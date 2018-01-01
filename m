References: <CAFHpkQHuJmbYk2G58-VdexeUbrrYT1Qz+HdrZ9HZps3QuZD6ZA@...278...>
 <2764e29d-928d-a643-6fa7-0554ff7b7dfa@...2080...>
 <CAFHpkQEcyz9q=kYx6CM_kT9Jm3YFG9EZRe08NZnLm-G+knDktA@...278...>
 <e6c5f73e-2920-3e30-2539-702632d30e43@...2080...>
 <CAFHpkQHPpkb2GfsV4y7B3GntpoQ0JzZz2X+rWffYqexbiJzgYg@...278...>
 <9561c64d-3c54-b65b-9fce-f99b4ef9c3b3@...2080...>
 <CAFHpkQHZXbMDBPXV=dGWYs0M2B4C9AU-FY4KE2pCZqsxe5iJbw@...278...>
 <7bc9701e-b5dd-f9cb-7edf-76e38e36f6a2@...2080...>
 <b09d8b3c-b8ff-1d33-06eb-fa152c168a88@...1856...>
 <3e1d6a01-2ceb-b01a-d903-a8d66e3a62bd@...2181...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <3705fc29-89a8-d41b-0eeb-2402a3937419@...1856...>
Date: Mon, 1 Jan 2018 14:34:26 +0100
MIME-Version: 1.0
In-Reply-To: <3e1d6a01-2ceb-b01a-d903-a8d66e3a62bd@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] better handling of revoked certs
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 01-01-18 13:56, Antonio Quartulli wrote:
> On 01/01/18 20:30, Steffan Karger wrote:
> 
> [CUT]
> 
>>
>> Note the '5 seconds' reconnect loop, which is the same as what current
>> released openvpn would do in response to an alert.  So if we change our
>> servers to send alerts, they will experience quite a bit more load from
>> clients attempting to reconnect.  We can make newer clients use some
>> exponential back-off, but older clients will be around for quite a while.
>>
> 
> If we really go this way, we could even have the client "understand" the
> alert and stop retrying if the error is permanent (i.e. certificate
> revoked).

Yeah, it might make sense to treat specific alerts differently.

> However, are we sure we're not going to introduce surface for a DoS
> attacks by opening this hole for unauthorized clients?
> Basically anybody with a revoked certificate is now able to trigger some
> kind of logic on the server side (this is how I understand it).
> 
> Consider that obtaining a revoked certificate is not that difficult
> (i.e. VPN providers granting free periods normally do that by issuing
> and revoking a new cert).

Yes, this increases DoS attack surface too.  Not sure if there is a
viable way that's more efficient than simply opening many new
connections and trying to exhaust our connection limits though.  In any
case, it will be "no worse than plain TLS", for whatever that's worth ;-)

To be perfectly clear: I'm not advocating this change.  But user
experience / error reporting is a regularly recurring topic, so I found
it useful to take some time to spell out what allowing TLS alerts would
look like.

-Steffan

