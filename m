Message-ID: <1b9e0fbc-d2e3-f09f-c7b5-29122e9c2f1f@...1227...>
Date: Thu, 12 Jan 2023 12:57:56 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20230111235052.24855-1-a@...2181...>
 <CAGyAFMUqycz=8qZF3VwWJ8YYVaoJkc0Uru_0+Wgo_uo3-pKPfw@...278...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAGyAFMUqycz=8qZF3VwWJ8YYVaoJkc0Uru_0+Wgo_uo3-pKPfw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] dco: print proper message in case of
 transport disconnection
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
To: Lev Stipakov <lstipakov@...277...>, Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Am 12.01.23 um 09:43 schrieb Lev Stipakov:
> Hi,
> 
>> -/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> 
> This specific hunk is beyond my pay grade.

And we should change it. Currently that header file is incompatible with 
the rest of OpenVPN as it does not allow linking against OpenSSL.

Arne


