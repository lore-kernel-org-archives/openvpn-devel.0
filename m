References: <57A3C76A.1020809@...277...>
	<CAKuzo_h0vMR4jv=iAgT2Vr2kq-nJRDs0Pq=3JC7eydQ-m1Ucpw@...278...>
	<f9d8f147-e3d1-b80b-5646-faba6b853bc2@...277...>
	<76eb908d-b7b3-7425-5340-e4cd5726fbd1@...2080...>
From: debbie10t <debbie10t@...277...>
Message-ID: <3642cff2-6233-0a28-2a39-36513f008ab4@...277...>
Date: Tue, 23 Aug 2016 01:55:23 +0100
MIME-Version: 1.0
In-Reply-To: <76eb908d-b7b3-7425-5340-e4cd5726fbd1@...2080...>
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
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net



On 20/08/16 19:41, David Sommerseth wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 19/08/16 18:13, debbie10t wrote:
>> Hi,
>>
>> On 05/08/16 03:04, Selva Nair wrote:
>>> On Thu, Aug 4, 2016 at 6:53 PM, debbie10t <debbie10t@...277...>
>>> wrote:
>>>
>>>> Hi
>>>>
>>>> So windows 10 as a Server.
>>>>
>>>> ===
>>>>
>>>> General details: Non admin Win10 unmodified user Using OVPN
>>>> GUI OVPN Interactive service started and used Win10 Tun Server
>>>> (auto + manual) IPv4 + IPv6 In average constant use ~20 Clients
>>>> virtual, local and remote win xp/7/10 +linux
>>>>
>>>>
>>>> Selva,
>>>>
>>>> If you have any specific tests please send me details.
>> You are probably aware but for completeness:
>>
>> --up/--down scripts are *not* run with elevated privs and so they
>> fail .. even when logged in as administrator and when using GUI +
>> Interactive service.
> This was an explicit design detail which was strived for with the new
> interactive service - as a security enhancements.  Otherwise it would
> be trivial for non-admins to get elevated privileges when they should
> not have that (think larger companies/enterprises with centrally
> managed policies).
>
>> The /good old/ openvpnservice works fine.
> Which is considered not secure for many reasons.
>
As is "par for the course" ..


On 22/08/16 21:49, David Sommerseth wrote:

It is fully accepted to ask again if something is unclear and the
questions are reasonably well asked.


I need to use --up/--down/--client-connect/disconnect et al ..

How does one run openvpn on *windows* without these "considered"
security flaws ? or are we all just "lambs to the slaughter"
from here on in ?


Digging my own ****ing grave ...

-- 


