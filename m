Message-ID: <46610f00-8a5b-4439-9f88-846e96d05d54@...1227...>
Date: Mon, 28 Apr 2025 12:43:30 +0200
MIME-Version: 1.0
References: <20250423175843.104553-1-walter.openvpn@...2889...>
 <55dfca69-67f1-4afa-8b05-a0bfddb94929@...1227...>
 <c58984b2-e637-42d7-917c-130d282da34c@...2889...>
 <7bacd83dadac3cc3af2e6339428d13d6.squirrel@...2890...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <7bacd83dadac3cc3af2e6339428d13d6.squirrel@...2890...>
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Walter Doekes <walter.openvpn@...2889...>, openvpn-devel@lists.sourceforge.net

Am 28.04.25 um 09:53 schrieb Walter Doekes:
>> On 24-04-2025 10:26, Arne Schwabe wrote:
>>> You are also saying that there is a difference in OpenVPN 2.5 vs OPneVPN
>>> 2.6. If that is indeed the case, a git bisect would be helpful to point
>>> to the commit that is breaking this.
> 
> Well. This was my least worst bisect experience so far. So, thank you for
> that! :)
> 
>    autoreconf -ivf && ./configure && echo '#define HAVE_EVP_PKEY_ID 1' >>
> config.h && make -j12
> 
> was sufficient on Ubuntu/Noble and running didn't require extra
> installation/path shuffling.
> 
> The offending commit is:
> 
>    commit b364711486dc6371ad2659a5aa190941136f4f04
>    Author: Arne Schwabe <arne@...1227...>
>    Date:   Mon May 2 17:43:10 2022 +0200
> 
>      Implement stateless HMAC-based sesssion-id three-way-handshake
> 
> 
> Double checked and confirmed. Apparently this alters things so the
> source-IP-switched connection shows up as a second connection.
> 
> I haven't checked if it's something I can fix yet. But At least we have a
> culprit now.

Well that changes the behaviour of how new sessions are established, 
that this change is the one that is triggering the issue is even more 
perplexing.

Arne

