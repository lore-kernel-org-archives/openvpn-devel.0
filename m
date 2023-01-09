Message-ID: <8c76e266-6622-0e65-6b7b-f1697c3b2b13@...1227...>
Date: Mon, 9 Jan 2023 17:36:06 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20220909195902.2011798-1-arne@...1227...>
 <20221212112746.1719605-1-arne@...1227...>
 <Y7wsTTgS7oYV0acO@...2685...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <Y7wsTTgS7oYV0acO@...2685...>
Subject: Re: [Openvpn-devel] [PATCH v4] Introduce dynamic tls-crypt for
 secure soft_reset/session renegotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Am 09.01.23 um 16:01 schrieb Frank Lichtenheld:
> On Mon, Dec 12, 2022 at 12:27:45PM +0100, Arne Schwabe wrote:
>> Currently we have only one slot for renegotiation of the session/keys.
>> If a replayed/faked packet is inserted by a malicous attacker, the
>> legimate peer cannot renegotiate anymore.
>>
>> This commit introduces dynamic tls-crypt. When both peer support this
>> feature, both peer create a dynamic tls-crypt key using TLS EKM (export key
> 
> "peers"
> 
>> material) and will enforce using that key and tls-crypt for all
>> renegotiations. This also add an additional protection layer for
> 
> General question about this feature:
> We trigger using this key on key_id > 0, so if I understand the code
> correctly, it will be used first when we want to renegotiate.
> But will it then continued to be used? What exactly is the state after
> the successful renegotiation?

That is one of this hidden logic things of OpenVPN again. We ensure that 
the keyid will go to 1 instead 0 on key rollover, so only initial keyids 
are 0. So key-ids for renegotiations will be 1 to 7 and then rollover to 
1 instead of 0.


     /*
      * key_id increments to KEY_ID_MASK then recycles back to 1.
      * This way you know that if key_id is 0, it is the first key.
      */
     ++session->key_id;
     session->key_id &= P_KEY_ID_MASK;
     if (!session->key_id)
     {
         session->key_id = 1;
     }

>> +/**
>> + * Determines if the current session should use the renegotiation tls wrap
>> + * struct instead the normal one and returns it
> 
> Since this seems to be where the actual magic happens, maybe we could
> have a slightly more verbose comment here for people not as familiar
> with the OpenVPN state machine?
> 
> Will the renegotiation key be refreshed as part of the renegotiation or
> do all future renegotiations the same key?

Same key. The idea is to have a tls-crypt key that is only known between 
the two peers and not by anyone else. Rotating it here gives no benfit, 
so we keep the same keep to simplify the code.

I added the fact that we only one key in the description of 
thetls_session_generate_secure_renegotiation_key .

Arne

