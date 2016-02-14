References: <1454874438-5081-1-git-send-email-steffan@...1856...>
	<1454874438-5081-9-git-send-email-steffan@...1856...>
	<56BB3775.5010801@...1227...>
	<CAA1AbxL_S4umZr5Nd0VTvUvXEHjoWmji18GqM6FgmWqntOKqaA@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <56C0F10F.2080803@...1227...>
Date: Sun, 14 Feb 2016 22:26:39 +0100
MIME-Version: 1.0
In-Reply-To: <CAA1AbxL_S4umZr5Nd0VTvUvXEHjoWmji18GqM6FgmWqntOKqaA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 08/10] Add AEAD cipher support (GCM)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 14.02.16 um 21:59 schrieb Steffan Karger:
> Hi Arne,
> 
> Thanks for reviewing.  Attached a v2, and below inline responses to
> your remarks.
> 

ACK. I looked through the changes and it is now good to go.

> On Wed, Feb 10, 2016 at 2:13 PM, Arne Schwabe <arne@...1227...> wrote:
>>> AC_ARG_ENABLE(
>>>     [aead-modes],
>>>     [AS_HELP_STRING([--disable-aead-modes], [disable AEAD crypto modes
>>> @<:@default=yes@:>@])],
>>>     ,
>>>     [enable_aead_modes="yes"]
>>> )
>>
>> I would not make this user configurable. If it wasn't for RHEL5 I even
>> would throw out 0.9.8 support and always compile it in.
> 
> I agree.  I removed the configurability.
> 
> Now that OpenSSL has officially stopped supporting 0.9.8 and 1.0.0 (as
> of 31st Dec 2015), we might want to revisit our decision to support
> those in 2.4/master, but let's not do that as a part of this patch set
> :)

>>      {
>> +      /* Get the key we will use to encrypt the packet. */
>>        tls_pre_encrypt (c->c2.tls_multi, &c->c2.buf, &co);
>> +      /* If using P_DATA_V2, prepend the 1-byte opcode and 3-byte peer-id to the
>> +       * packet before openvpn_encrypt(), so we can authenticate the opcode too.
>> +       */
>> +      if (c->c2.buf.len > 0 && !c->c2.tls_multi->opt.server && c->c2.tls_multi->use_peer_id)
>>
>> The latter part of that if might be turned into a small inline fuction
>> to make it clearer. Or alternatively a local boolean variable to be used
>> in both if places.
> 
> Hm, I tried that but don't really like it.  I'd rather simplify this
> by making server->client traffic use P_DATA_V2 too (but didn't want to
> do that in this patch set).

Yes. Also better alignment for those packets.

> Good point.  I took the opportunity to also explain a bit more about
> the relation between --auth and --tls-auth.

Good idea.


And we may need another patch for the Changes.rst

Arne

