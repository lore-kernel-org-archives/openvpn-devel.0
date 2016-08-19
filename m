References: <57A3C76A.1020809@...277...>
	<CAKuzo_h0vMR4jv=iAgT2Vr2kq-nJRDs0Pq=3JC7eydQ-m1Ucpw@...278...>
From: debbie10t <debbie10t@...277...>
Message-ID: <f9d8f147-e3d1-b80b-5646-faba6b853bc2@...277...>
Date: Fri, 19 Aug 2016 17:13:21 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_h0vMR4jv=iAgT2Vr2kq-nJRDs0Pq=3JC7eydQ-m1Ucpw@...278...>
Subject: Re: [Openvpn-devel] Win10 Tun Server +Standard W10 User +OVPN
 Interactive Service +OVPN GUI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 05/08/16 03:04, Selva Nair wrote:
> On Thu, Aug 4, 2016 at 6:53 PM, debbie10t <debbie10t@...277...> wrote:
>
>> Hi
>>
>> So windows 10 as a Server.
>>
>> ===
>>
>> General details:
>>     Non admin Win10 unmodified user
>>     Using OVPN GUI
>>     OVPN Interactive service started and used
>>     Win10 Tun Server (auto + manual)
>>     IPv4 + IPv6 In average constant use
>>     ~20 Clients virtual, local and remote
>>         win xp/7/10 +linux
>>
>>
>> Selva,
>>
>> If you have any specific tests please send me details.

You are probably aware but for completeness:

--up/--down scripts are *not* run with elevated privs
and so they fail .. even when logged in as administrator
and when using GUI + Interactive service.

The /good old/ openvpnservice works fine.

-- 


