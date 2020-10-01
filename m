Message-ID: <c319712b9f596989d66570d9624d8357.squirrel@...2260...>
In-Reply-To: <f27fb070-c84e-2319-2db5-b0cda50fe3c9@...1227...>
References: <84a29b8afab02733064c2cf715ae0b8c.squirrel@...2257...>
 <f27fb070-c84e-2319-2db5-b0cda50fe3c9@...1227...>
Date: Thu, 1 Oct 2020 17:03:39 +0200
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Add --up-pre with the same functionality as
 --down-pre
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Arne,

> Am 22.11.17 um 17:58 schrieb Simon Matter:
>> Hi,
>>
>> In our situation we have the requirement to run scripts before tun/tap
>> is
>> opened, not after. While this could be hacked into the init script, the
>> proper way seems to add it to openvpn as --up-pre option. That's
>> independent from any init scripts / systemd service file and works the
>> same way as --down-pre, only for the up status.
>>
>> My initial feature wish, posted 5 years ago, was turned down as won't
>> fix:
>> https://community.openvpn.net/openvpn/ticket/284
>>
>> But there are people who wish it and they have good reasons to wish it.
>> Just yesterday someone asked again:
>> https://community.openvpn.net/openvpn/ticket/284#comment:10
>>
>> Without going into much details
>
> This patch currently misses a commit message anyway but a good commit
> should explain why this change is a good one.
>
>> just one thing why --up + --up-pre is
>> better than hacking around outside of openvpn: the command called with
>> --up also gets additional run time information from openvpn by
>> parameters
>> and environmental variables. You don't get all those information when
>> calling anything from outside of openvpn before openvpn actually starts.
>>
>> If you feel there are good reasons to still refuse this patch, please
>> let
>> me know.
>
> I am just looking at this patch since it is still in the review queue.
>
> - Missing documentation.
> - pre-up flag is wrong in terms of scripts. If we add this, it needs to
> be a different script because otherwise you will break use cases that
> also need the --up script.
>
> Also having down and down-pre but then only not also up/up-pre but a up
> with flag breaks the symmetry and is confusing.

One of us is confused here.

What you say is missing in my patch is not missing at all. It simply
brings both, the "up" and the "down" functionality to the same level!

I modeled the --up-pre option EXACTLY the same way as the EXISTING
--down-pre option. It works the same way now for "up" as it is working
since many years for "down".

The existing man entry for --down-pre says:

--down-pre
  Call ``--down`` cmd/script before, rather than after, TUN/TAP close.

The patched man entry for --up-pre says:

--down-pre
  Call --down cmd/script before, rather than after, TUN/TAP close.

Why should --down-pre use another script while the existing code for
--up-pre doesn't do?


I really can't understand why this small patch was refused for years and I
still feel nobody ever really looked at it.

I know we could fiddle something with systemd now on Linux to get a
similar functionality but it's still not the same. And if you have mixed
environments with other Unices then it's really a mess.

So, it's a non intrusive, small patch which fixes the symmetry between
"up" and "down" path in openvpn.

Regards,
Simon


