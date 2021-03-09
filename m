References: <20210307161547.25130-1-gert@...1296...>
 <CAKuzo_iG4RfV+u1e5_qtgeet0p8Ne5UvCZNL4afnuPpavdLtGQ@...278...>
 <20210307181002.GQ976@...1296...>
 <CAKuzo_gecRK0fkWToNRuc7oGK==cZQnLFn08_6_C5MERMBKTJQ@...278...>
 <20210307184402.GS976@...1296...>
 <fd76a92c-aad1-53e1-f3fd-fe887be64a24@...1227...>
 <1a5d4ecf-ab54-3f1d-5867-1638a9a5a2f6@...277...>
 <5351a640-22bd-5a9f-b0a0-f80b3109ddb3@...2080...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <9ff688b9-9925-962d-1e75-11098907c71d@...277...>
Date: Tue, 9 Mar 2021 20:04:20 +0000
MIME-Version: 1.0
In-Reply-To: <5351a640-22bd-5a9f-b0a0-f80b3109ddb3@...2080...>
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



On 09/03/2021 18:52, David Sommerseth wrote:
> On 08/03/2021 14:45, tincanteksup wrote:
>>
>>
>> On 08/03/2021 08:06, Arne Schwabe wrote:
>>
>>> Looking at this feature  from today's perspective, it feels like one of
>>> OpenVPN's boutique features. Was probably useful at some point but
>>> doesn't really make much sense today anymore. Esepcially with what is
>>> written in the manpage. Today you rather would use full disk encryption
>>> or disable swapping rather than to rely on OpenVPN's --mlock.
>>>
>>> That being said I am against your patch, I am just wondering if that is
>>> a feature we need to keep at all.
>>>
>>
>> Having all openvpn data remain permanently in memory also offers
>> a (small) performance boost.
>>
>> Your alternative offers would impact performance and be system wide.
>>
>> Therefore, I for one disagree.
> 
> mlock() itself does not really have any impact your these arguments.
> 
> Yes, mlock() is about ensuring that OpenVPN can allocate a certain 
> amount of memory which will stay entirely in RSS the memory pool as long 
> as the memory pages has been locked.  But it is not a system wide knob; 
> it's a per process knob and applications can even turn this on and off 
> at will (given they have the needed privileges for it) during the 
> lifetime of the process.
> 
> Due to this flexibility to when you can enable and disable memory 
> locking, it is also clear it is not intended to be used as a performance 
> knob.  It is designed to be more a security related feature, which in 
> OpenVPN's context is there to avoid getting memory containing keying 
> material being swapped out to disk.
> 
> On today's hardware even telling the kernel to not swap out a few 
> hundred megabytes will also not result in much noticeable performance 
> improvements.  To feel the difference, you would need to have some 
> really ancient hardware.
> 
> If you care or have issues with performance related to swapping, you 
> need to revisit your swap setup - or add more RAM.  A few hundred 
> megabyte related to OpenVPN will not make things better or worse system 
> wide on your system.  Fixing the real reason you have swapping issues will.
> 
> 

I have swapping issues all the time and I can't add more RAM.
I don't want system wide disk encryption.
And I don't want an SSD either.

I do not have the money to keep up with modern hardware.

Having openvpn --mlock is exactly the right choice for my home
system.

Please, do not remove --mlock from openvpn.

Please try to put yourselves in the place of the average user,
for once.

R

