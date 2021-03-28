References: <20201215164221.5995-1-arne@...1227...>
 <20201215164221.5995-2-arne@...1227...>
 <d9fa3e30-32a3-5b81-baeb-716e60fda38c@...2181...>
 <0bfb39c7-8d28-24b9-c830-32424787d489@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <20bfb379-1265-21dc-e027-7836004cfcb0@...2181...>
Date: Sun, 28 Mar 2021 03:03:53 +0200
MIME-Version: 1.0
In-Reply-To: <0bfb39c7-8d28-24b9-c830-32424787d489@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 2/2] Fix condition to generate session
 keys
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 26/03/2021 14:10, Arne Schwabe wrote:
> Am 25.03.21 um 23:37 schrieb Antonio Quartulli:
>> Hi,
>>
>> On 15/12/2020 17:42, Arne Schwabe wrote:
>>> For --nobind clients OpenVPN reuses the context and tls_multi structs
>>> of the previous clients and does not rerun the connect scripts on
>>> connect. But since it is a new client connection, the key_id is 0 and
>>> we postpone the key generation but it will never happen.
>>
>> Can you explain how the --nobind on the client is related to the server
>> behaviour?
>>
>> Are you saying that a client connecting from the same IP of another
>> client will share its session and tls_multi object?
> (I will also copy that explanation to a v2 of the patch )
> 
> When OpenVPN sees a new (SSL) connection via HARD or SOFT_RESET with the
> same port/ip as an existing session, it will give it the slot of the
> renegotiation session (TM_UNTRUSTED). And when the authentication
> succeeds it will replace the current session. Since we already have gone
> through connect stages and set context_auth to CAS_SUCCEEDED, we don't
> call all the connect stages again, and therefore also never call
> multi_client_generate_tls_keys for this session.

Thanks for explaining this further.
I agree that adding some more text to the commit message would be
beneficial.

Other than that the patch looks logically correct to me.

Basically context_auth is set CAS_SUCCEEDED upon first connection cycle,
therefore a new connection that re-uses the existing instance will
already have context_auth set to CAS_SUCCEEDED and a new session key
will be generated.

I wonder if the connection can really be fully working if the server
believes that the client was already setup and does not performs the
usual connection steps. But this is another story, unrelated to this
patch...

This said, the new if condition does not look being properly aligned.

Cheers,


-- 
Antonio Quartulli

