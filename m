References: <20200622113022.23047-1-davids@...515...>
 <0c62f389-39dc-b896-ec89-c864a1076089@...1227...>
 <f79b3d70-13bc-4dab-4a7c-826eb10318c9@...2080...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <b5dec3fb-a1fd-3705-a69b-e5e19e7356c9@...1856...>
Date: Mon, 22 Jun 2020 14:43:42 +0200
MIME-Version: 1.0
In-Reply-To: <f79b3d70-13bc-4dab-4a7c-826eb10318c9@...2080...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] systemd: Change the default cipher to
 AES-256-GCM for server configs
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
To: openvpn-devel@lists.sourceforge.net

Hi,

On 22-06-2020 14:29, David Sommerseth wrote:
> On 22/06/2020 14:21, Arne Schwabe wrote:
>>
>>>  PrivateTmp=true
>>>  WorkingDirectory=/etc/openvpn/server
>>> -ExecStart=@sbindir@/openvpn --status %t/openvpn-server/status-%i.log --status-version 2 --suppress-timestamps --config %i.conf
>>> +ExecStart=@sbindir@/openvpn --status %t/openvpn-server/status-%i.log --status-version 2 --suppress-timestamps --cipher AES-256-GCM --ncp-ciphers AES-256-GCM:AES-128-GCM:AES-256-CBC:AES-128-CBC:BF-CBC --config %i.conf
>>>  CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE CAP_AUDIT_WRITE
>>>  LimitNPROC=10
>>>  DeviceAllow=/dev/null rw
>>>
>>
>> NACK.
>>
>> Setting ncp-cipher to include BF-CBC by default allows BF-CBC in configs
>> that did not allow it before. Basically any config that had something
>> other than cipher BF-CBC and no ncp-ciphers in it will now allow clients
>> with BF-CBC to connect. I don't want force users to set ncp-cipher to a
>> sane value since the systemd unit file doesn't.
> 
> That will break existing configs on the next upgrade.  Do we want do do that?
> 
> I'm fine with removing BF-CBC, but it is scheduled for removal in OpenVPN 2.6.

I think Arne has a very good point that it's kinda weird to "degrade"
the NCP defaults.

Making AES-256-GCM the default cipher for TLS-based connections (GCM
won't work with static key configs) does not imply *removing* BF-CBC
support. Maybe these should be the steps:

2.4: Use to AES-256-GCM when available (basically what NCP did)
2.5: Switch to AES-256-GCM as the default cipher (but allow overriding)
2.6: Remove support for small block ciphers all together

Yes, this will probably break some (less secure) setups and make some
people angry. But at some point people need to move on. We've been
throwing warnings at them for a while now.

-Steffan

