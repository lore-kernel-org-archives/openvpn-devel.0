References: <20200930131317.1299-1-arne@...1227...>
 <20200930131317.1299-4-arne@...1227...>
 <CAGyAFMVCy=09wVifPBY0hXKQ9oMKbc8wzcEVG__acYbG6qH9Bg@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <5a90382c-5b8a-4829-0160-a0664f0b899d@...1227...>
Date: Mon, 25 Jan 2021 11:51:59 +0100
MIME-Version: 1.0
In-Reply-To: <CAGyAFMVCy=09wVifPBY0hXKQ9oMKbc8wzcEVG__acYbG6qH9Bg@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 02/11] Implement client side handling of
 AUTH_PENDING message
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 15.01.21 um 14:13 schrieb Lev Stipakov:
> Hi,
> 
> Please not that I got errors applying this patch, so I reviewed
> corresponding commit
> from github (https://github.com/schwabe/openvpn/commit/3901e46127a2db3e6dfb20c44e8d8e30adea58c7).
> 
>> +Receiving a AUTH_PENDING message will make the client change its timeout the
>> +timeout proposed by the server, even if the timeout is shorter.
> 
> Typo.
> 
> 
>>  /*
>>   * min/max functions
>>   */
>> +static inline unsigned int
>> +max_uint(unsigned int x, unsigned int y)
> 
> It is 2021 and we have to write our own min/max :(

Yes. We had a discussion on #openvpn-devel and there seem to be no
(non-float) min/max version in the standard library. The linux kernel
also has a macro for this. This would be min_t(unsigned int, x, y) iirc
in the kernel, so similar to what we do here

Arne

