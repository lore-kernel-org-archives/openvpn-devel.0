References: <20200813072923.24385-1-eric@...1918...>
 <1fb10dd1-8ddf-c467-21a5-a93e21e6a8ac@...1227...>
 <0a634481-cf3b-de2f-5e34-8f5c5ef16fdc@...1918...>
 <CAKuzo_h_xWf-Jbkow=H3sL_CQw5CC23pw3DxH0Nsydj2f57usg@...278...>
 <dc800745-efe3-0f10-d08f-046fc041c96a@...1918...>
 <CAKuzo_heHMcpRd31Lc=ZHDjPAb3GsQoBQB4iQvXCd7EPTnGEug@...278...>
 <294d779c-44a1-7f4c-c506-5f21dc76e8ac@...1918...>
 <9e1e0324-45a1-d6ab-068a-eff8bb75aef1@...1227...>
 <6d416208-e6f6-a0d9-e7e8-ef757f8893ba@...1918...>
 <4f554f9d-cc69-6ba1-7f99-b3368d68f7ab@...1227...>
From: Eric Thorpe <eric@...1918...>
Message-ID: <3beb853d-5fe0-4d32-c013-d2af92f151e9@...1918...>
Date: Thu, 27 Aug 2020 09:57:19 +1000
MIME-Version: 1.0
In-Reply-To: <4f554f9d-cc69-6ba1-7f99-b3368d68f7ab@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/2] Send auth-fail messages to clients
 on renegotiation failures via auth-token or user-pass expiry
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi Arne,

> That code/commit message is explicitly talking about renegotiation. So
> if that is also broken, there seems to be something else wrong.
You are quite correct, I've muddled this up with a different issue I've 
been working through with Deferred Auth, management should not be a part 
of this discussion.

> - Do we send the AUTH_FAILED over the new or the old tls session?
The AUTH_FAILED is sent in the old (current) tls session, that is of 
course assuming that it is still active at the time of reneg. Normally 
if reneg is done with only keys or an auth-token, there isn't the risk 
of authentication being too slow. If a user takes too long to enter a 
password, or deferred auth is in use, the server can sigterm the user on 
it's end before authentication is complete and we have the same result. 
With this said though, the configuration can be adjusted to give the 
user a grace period on the server, so that specific scenario isn't 
something that needs to be handled in my opinion as it can be tuned in 
the configuration.

> - Do we establish the data channel (key_method_2_write) before writing
> the key?
This is the question I specifically ignored as I'm not sure why it's 
relevant to plugin/script authentication. key_method_2_write, unless I'm 
mistaken (and I'm happy to be corrected here), is client side. The 
client knows it's time to renegotiate as part of it's regular wake up 
routines or server trigger, of which key_method_2_write is called and 
queries for the user/pass (either by management, file, terminal, etc), 
and then pushes it all to the server. Unlike the initial connection 
process however, a push_request does not follow this information push, 
so if authentication fails at the server end, there is no indication of 
such and we end up with desync.

> understand the implications and whether the patch is really
> fixing the root cause or just band aiding the symptoms.
This I can't answer. I don't think it's a band aid, however there are 
still scenarios this will not cover as mentioned above. Someone with 
more in depth knowledge will need to help review this patch to determine 
if this is a fix, or indeed a band aid to a deeper problem that needs to 
be reviewed.

With this in mind, I'm afraid I have spent enough time on this. We will 
continue to maintain this patch in our fork. In the mean time, we've 
tried to do the right thing by submitting a patch for an issue we've 
discovered and brought to the mailing lists attention a long time ago 
now, and then do the right thing again updating it when requested. I 
will leave the conversation here and leave it to the repo maintainers 
from here whether they wish to use this patch as is, modify it to their 
needs or NAK it for a better future solution. I will keep an eye out for 
a new patch and assist in it's testing if someone wishes to improve upon 
this.

Cheers,
Eric

---
Eric Thorpe
SparkLabs Developer
https://www.sparklabs.com
https://twitter.com/sparklabs
support@...1918...

On 26/08/2020 6:45 pm, Arne Schwabe wrote:
> Am 26.08.20 um 03:12 schrieb Eric Thorpe:
>>> Management goes another code path and management_client_auth directly
>>> calls send_auth_failed.
>> I'm afraid in the case of renegotiation this is not relevant
> That code/commit message is explicitly talking about renegotiation. So
> if that is also broken, there seems to be something else wrong.
>
>>> But I
>>> also haven't digged deep enough to actually understand if your is
>>> actually fixing the problem correctly.
>> May I request that we resolve this first to ensure the content of the
>> patch is correct, and then we can move onto finding a way to avoid this
>> extra state?
> Yeah but I as a said, I currently don't understand it well enough to
> understand if your patch is correct or not and if the code path for
> management sending AUTH_FAILED on renegotiation is also not working,
> there is probably something else broken.
>
> As I said:
>
> - Do we send the AUTH_FAILED over the new or the old tls session?
> - Do we establish the data channel (key_method_2_write) before writing
> the key?
>
> are questions that I don't have an answer to currently and you also
> ignored those questions, so I assume you are not sure either. And I
> don't want to merge a patch where neither I nor the author of the patch
> really understand the implications and whether the patch is really
> fixing the root cause or just band aiding the symptoms.
>
> Arne
>

