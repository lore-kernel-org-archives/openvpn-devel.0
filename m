Message-ID: <df512ccf-8bcc-4333-88bd-fe5dcdc2f495@...1227...>
Date: Mon, 16 Mar 2026 13:09:50 +0100
MIME-Version: 1.0
References: <20260315184337.1541272-1-luca.boccassi@...277...>
 <20260315184337.1541272-2-luca.boccassi@...277...>
 <8573cf46-0e95-41ee-bb9f-53138747ff45@...1227...>
 <CAMw=ZnTc41DYb145kQGvJYFuwSgZLK2PaESKkr3BFtG+h+K0sQ@...278...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAMw=ZnTc41DYb145kQGvJYFuwSgZLK2PaESKkr3BFtG+h+K0sQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Increase TLS_CHANNEL_BUF_SIZE from
 2048 to 8192
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
To: Luca Boccassi <luca.boccassi@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Am 16.03.26 um 13:00 schrieb Luca Boccassi:
> On Mon, 16 Mar 2026 at 11:57, Arne Schwabe <arne@...1227...> wrote:
>>
>> Am 15.03.26 um 19:39 schrieb luca.boccassi@...277...:
>>> From: Luca Boccassi <luca.boccassi@...277...>
>>>
>>> When authenticating via a JWT token 2048 bytes are not enough, which
>>> breaks the auth process. In my local case the token is ~2100 bytes.
>>> Bump the maximum harcoded size from 2k to 8k to leave some headroom.
>>
>> This is a change that can break compability. The normal limit is only
>> 128 bw.
>>
>> #define USER_PASS_LEN 128
> 
> The length is actually 4K when PKCS11 is enabled, which is the case in
> most distros:
> 
> /* max length of username/password */
> #ifdef ENABLE_PKCS11
> #define USER_PASS_LEN 4096
> #else
> #define USER_PASS_LEN 128
> #endif
> 
> Could you please clarify how bumping this buffer max size could break
> compatibility? Thanks

The 128 vs 4096 is already problematic at times. Adding a third size 
does not help. Also the real password size that is useable in user/pass 
is not 4k either. Even with the 2048 that you want, you will run into 
problem because of other limitations, e.g. that the packet that 
user+pass and peer info variables a bit of other stuff needs to be is 
limited to 2048 bytes in total.

If we really want to support longer username and password 
authentication, this needs to be implemented in a different way that is 
not so problematic. E.g. client indicating its support for the extended 
password+username stuff (e.g. via IV_SSO) and then switching to that method.


>> Overall things like such big data should really be implemented via
>> auth-pending method or similar.
> 
> Do you have more references available for this, please? Thanks

See management.txt as a start.

Arne

