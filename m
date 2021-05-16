References: <20210409162846.GT976@...1296...>
 <c9aa3222-63c1-ae68-c1b1-67b427010df2@...1227...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <602aaf60-b7fd-5d3d-5e12-fd852ec53a72@...1856...>
Date: Sun, 16 May 2021 11:35:33 +0200
MIME-Version: 1.0
In-Reply-To: <c9aa3222-63c1-ae68-c1b1-67b427010df2@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] make --persist-key always-on and remove "off"
 code path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 10-04-2021 01:42, Arne Schwabe wrote:
> 
> Am 09.04.2021 um 18:28 schrieb Gert Doering:
>> Hi,
>>
>> there was a big discussion on the IRC channel today about interactions
>> between "--chroot" and "--persist-key" and how and when stuff is reloaded
>> or not.
>>
>> Now, we all seem to agree that OpenVPN has way too many obscure options,
>> so I propose to get rid of another one, namely --persist-key - and I
>> suggest to make it permanently-active ("load the keys at startup, and
>> then do not touch these files again").
>>
>> Unless someone explains to me in simple words what the benefit is of
>> reloading the keys on every new outbound connection...  yes, you *could*
>> put in a new key/cert/CA set while OpenVPN is active, and then trigger
>> a SIGUSR1 restart, having it "seamlessly" move to new credentials...
>>
>> But...
>>
>> How many of you do that?  Instead of just calling "service openvpn
>> restart"?
>>
>> I do not use --persist-key, but I still restart my services after
>> fiddling
>> with configs...
> 
> I am also for removing persist-key option (and ignore it if still
> present) and just always have the same behaviour. I can also not come up
> with a valid scenario where setting/not setting this option is making a
> real desirable difference.

For what it's still worth: I too agree that persist-key should be
always-on and removed as on option.

-Steffan

