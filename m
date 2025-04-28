Message-ID: <1e8ccfd451cbf9e6d090bd6a6886e366.squirrel@...2890...>
In-Reply-To: <46610f00-8a5b-4439-9f88-846e96d05d54@...1227...>
References: <20250423175843.104553-1-walter.openvpn@...2889...>
 <55dfca69-67f1-4afa-8b05-a0bfddb94929@...1227...>
 <c58984b2-e637-42d7-917c-130d282da34c@...2889...>
 <7bacd83dadac3cc3af2e6339428d13d6.squirrel@...2890...>
 <46610f00-8a5b-4439-9f88-846e96d05d54@...1227...>
Date: Mon, 28 Apr 2025 11:38:49 -0000
From: "Walter Doekes" <walter.openvpn@...2889...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] multi.c: Allow floating to a new IP
 right after connection setup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

> On 24-04-2025 10:26, Arne Schwabe wrote:
> The code doesn't really do what the comment does. If you were trying to
> actually figure out if it is the same client you should rather compare
> the session ID of the tls state.

As for the session_id, I checked the following:

- m->session[TM_ACTIVE].session_id (matches)
- m->session[TM_ACTIVE].key[KS_PRIMARY].session_id_remote (matches)
- m->session[TM_ACTIVE].key[KS_LAME_DUCK].session_id_remote (is zero)

- m->session[TM_UNTRUSTED].session_id (does not match)
- m->session[TM_UNTRUSTED].key[KS_PRIMARY].session_id_remote (is zero)
- m->session[TM_UNTRUSTED].key[KS_LAME_DUCK].session_id_remote (is zero)

So, two session IDs match. I'll assume you meant the
m->session[TM_ACTIVE].session_id one then.

I can change the if-expression in my original patch to this:

  if (m1->multi_state == CAS_CONNECT_DONE
      && m2->multi_state == CAS_NOT_CONNECTED
      && m1->locked_cert_hash_set
      && !m2->locked_cert_hash_set
      && session_id_equal(&m1->session[TM_ACTIVE].session_id,
                          &m2->session[TM_ACTIVE].session_id))

Or do you suggest something else?


>> The offending commit is:
>>
>>    commit b364711486dc6371ad2659a5aa190941136f4f04
>>    Author: Arne Schwabe <arne@...1227...>
>>    Date:   Mon May 2 17:43:10 2022 +0200
>>
>>      Implement stateless HMAC-based sesssion-id three-way-handshake
>>
>> Double checked and confirmed. Apparently this alters things so the
>> source-IP-switched connection shows up as a second connection.
[...]

> Well that changes the behaviour of how new sessions are established,
> that this change is the one that is triggering the issue is even more
> perplexing.

Well. If it was expected, we wouldn't be here investigating ;)

Can I assist you with some test or extra log line?

Cheers,
Walter



