References: <20210307161547.25130-1-gert@...1296...>
 <CAKuzo_iG4RfV+u1e5_qtgeet0p8Ne5UvCZNL4afnuPpavdLtGQ@...278...>
 <20210307181002.GQ976@...1296...>
 <CAKuzo_gecRK0fkWToNRuc7oGK==cZQnLFn08_6_C5MERMBKTJQ@...278...>
 <20210307184402.GS976@...1296...>
 <fd76a92c-aad1-53e1-f3fd-fe887be64a24@...1227...>
 <1a5d4ecf-ab54-3f1d-5867-1638a9a5a2f6@...277...>
 <5351a640-22bd-5a9f-b0a0-f80b3109ddb3@...2080...>
 <9ff688b9-9925-962d-1e75-11098907c71d@...277...>
 <3f3d8111-2292-82a6-6499-386834c61613@...2080...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <82098614-a178-4cc1-4e59-a7523bdc1d00@...277...>
Date: Tue, 9 Mar 2021 21:20:32 +0000
MIME-Version: 1.0
In-Reply-To: <3f3d8111-2292-82a6-6499-386834c61613@...2080...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Require at least 20MB of mlock()-able
 memory if --mlock is used.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net



On 09/03/2021 20:53, David Sommerseth wrote:
> On 09/03/2021 21:04, tincanteksup wrote:
>  >
>> I have swapping issues all the time and I can't add more RAM.
>> I don't want system wide disk encryption.
>> And I don't want an SSD either.
>>
>> I do not have the money to keep up with modern hardware.
>>
>> Having openvpn --mlock is exactly the right choice for my home
>> system.
>>
>> Please, do not remove --mlock from openvpn.
>>
> 
> How much memory does your OpenVPN process consume?  And if the process 
> (or task in kernel lingo) is active (not idling), it generally will not 
> be swapped out.  If it does, you are already running way to much on your 
> host.  So you need to prioritize what that host should really run.
> 
> OpenVPN's --mlock does not save you.
> 
> And in fact, the kernel may as well swap out the memory pages containing 
> the program itself and just keep the data pages allocated by the program 
> in memory.  Which will result in a sluggish OpenVPN performance regardless.
> 
> This gives a brief overview which might help you see what happens:
> <https://scoutapm.com/blog/understanding-page-faults-and-memory-swap-in-outs-when-should-you-worry> 
> 
> 
> And even though you don't want SSD.  At least consider if you can get 
> hold of a reasonably performing SSD with not too many GB and activate 
> that device as a swap device on your host.  It will not be optimal, but 
> at least the general swapping can go faster if you have a decent 
> SATA/SAS controller.
> 
>  > Please try to put yourselves in the place of the average user,
>  > for once.
> 
> The average users I know does not push their hardware beyond its limits 
> so much it hurts the overall performance.  Those I know would start 
> planning for an upgrade.  Or get an RPi4 and run OpenVPN on it, as it 
> got a reasonable network performance: 
> <https://notenoughtech.com/raspberry-pi/2019-raspberry-pi-network-speed-test/> 
> 
> 
> But openvpn --mlock is never the solution to performance and swapping. 
> Never ever.
> 
> 

As I Initially clarified, there *may* be a Small performance tweak by 
using --mlock.

The problem here is that by removing --mlock you shift the
burden of securing ephemeral key data to the under lying OS.

You may as well print the full private keys in the log (again)
and expect the user to delete them all and shred their disk.

As for how I must spend my money, that is no business of yours.

my2c

