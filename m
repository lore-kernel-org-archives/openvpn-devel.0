References: <1478636302-9678-1-git-send-email-steffan.karger@...1435...>
	<1478636302-9678-3-git-send-email-steffan.karger@...1435...>
	<e5e524cb-1b41-2dab-8204-a4e0f49334c7@...1227...>
	<61283c80-0326-8584-5097-c3f31e84d120@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <36376702-ce12-a462-0b34-1b547683de67@...1227...>
Date: Mon, 14 Nov 2016 21:13:09 -0500
MIME-Version: 1.0
In-Reply-To: <61283c80-0326-8584-5097-c3f31e84d120@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 2/5] Add control channel encryption
 (--tls-crypt)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

Am 13.11.16 um 14:14 schrieb Steffan Karger:
> Hi,
> 
> Thanks for reviewing!  Replies inline.
> 
> On 13-11-16 17:41, Arne Schwabe wrote:
>>
>>> This boils down to the following on-the-wire packet format:
>>>
>>>    -opcode- || -session_id- || -packet_id- || auth_tag || * payload *
>>
>> I am pretty that opcode is *not* authenticated looking the code. Which
>> is probably not a problem but should not be documented as authenticated.
>> (There is a buf_advance(buf ,1) before calling the unwrap function.
> 
> No, the opcode *is* authenticated.  See e.g. tls_crypt_wrap(), which
> receives a dst buffer which is prepared with the opcode and session_id,
> and computes the HMAC over the contents.


Yeah, I looked harder and see now the buffer pointer magic more clearly.
My fault.

I think that

    cipher_ctx_reset (ctx->cipher, tag);

belongs into the encrypt block instead of the auth block.

Arne

