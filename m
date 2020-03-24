References: <ce155eed-2936-8d5c-33a8-36f355fa243a@...2545...>
 <20200324133539.GH1431@...1296...>
 <7c6025e1-03bb-d8b9-9b13-36e8aaf8c5b5@...2181...>
 <6c0abd28-0767-825c-5e08-3b054a6f8cc7@...2545...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <660664bc-d745-0786-6857-a08b722af6ba@...2181...>
Date: Tue, 24 Mar 2020 16:45:22 +0100
MIME-Version: 1.0
In-Reply-To: <6c0abd28-0767-825c-5e08-3b054a6f8cc7@...2545...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] mbedTLS: Make sure TLS session survives
 move
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Tom van Leeuwen <tom.van.leeuwen@...2545...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi Tom,

you forgot to CC the mailing list :-)
I am adding it back.


On 24/03/2020 16:44, Tom van Leeuwen wrote:
> On 24-03-2020 14:54, Antonio Quartulli wrote:
>> Hi,
>>
>> On 24/03/2020 14:35, Gert Doering wrote:
>>> Hi,
>>>
>>> On Tue, Mar 24, 2020 at 11:42:02AM +0100, Tom van Leeuwen wrote:
>>>> When an mbedTLS session is moved in move_session(), the contents of the
>>>> the tls_session is copied to the new session and the old session is
>>>> reinitialized. This tls_session contains, amongst other things, an
>>>> mbedtls_ssl_config and bio_ctx structure. However, the mbedtls context has
>>>> internal pointers to the mbedtls_ssl_config and bio_ctx. When the session
>>>> is moved, these internal pointers point to the reinitialized session.
>> Can you explain, from an higher level perspective, what real/visible
>> issue is this creating? i.e. do we have a crash under specific
>> circumstances? do we have a key exchange failure at some point?
>>
>> How did you find the issue?
>>
> Hi,
> 
> Sorry for the inconvenience, I am not used to the git-email workflow.
> 
> The issue is described in issue 880:
> https://community.openvpn.net/openvpn/ticket/880
> 
> Summarizing, if you configure a bind-port on a client and you kill the
> client, you cannot reconnect again.
> My patch would fix issue 880.

I think that the information you reported is good material for the
commit message.

That would help the casual reader understanding what this patch wants to
achieve, before describing the how.

Cheers,

-- 
Antonio Quartulli

