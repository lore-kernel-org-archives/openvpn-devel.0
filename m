Message-ID: <0ad27bd2-6ae8-d142-bc21-0429446032ba@...1227...>
Date: Wed, 11 Jan 2023 11:40:07 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20220909195902.2011798-1-arne@...1227...>
 <20221212112746.1719605-1-arne@...1227...>
 <Y7wsTTgS7oYV0acO@...2685...>
 <8c76e266-6622-0e65-6b7b-f1697c3b2b13@...1227...>
 <Y71dMcb+kLwK237+@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <Y71dMcb+kLwK237+@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
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
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

>>      /*
>>       * key_id increments to KEY_ID_MASK then recycles back to 1.
>>       * This way you know that if key_id is 0, it is the first key.
>>       */
>>      ++session->key_id;
>>      session->key_id &= P_KEY_ID_MASK;
>>      if (!session->key_id)
>>      {
>>          session->key_id = 1;
>>      }
> 
> Okay, so it does roughly what I assumed it does. But strictly speaking this
> is not a renegotiation key then. Once the first renegotiation happens the key
> will be used for ALL control channel packets, is that correct?
> 
> So how does that avoid the replay attack? I mean it obviously avoids it for the
> first renegotiation, but could you replay the first renegotiation afterwards?
> Or does that not work due to increasing key_id/packet_id?

We do initialise the replay protection on the tls-crypt keys. So an 
attacker can only replay packets that are already known to both peer and 
they will drop them. While you can get the same level of protection with 
tls-crypt (without dynamic key) using --replay-persist option, I don't 
think I have seen this option ever being used.

Arne

