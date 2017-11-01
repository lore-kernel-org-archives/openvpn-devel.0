References: <cda9d511-43b5-cc6f-ead0-017f0f869e61@...2181...>
 <20170929162458.16514-1-steffan@...1856...>
 <23b4e635-04ac-42c9-d47d-42a80171ec76@...2181...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <65d0a2fb-346c-7cfe-b267-1dd6637470c1@...1856...>
Date: Thu, 2 Nov 2017 00:26:55 +0100
MIME-Version: 1.0
In-Reply-To: <23b4e635-04ac-42c9-d47d-42a80171ec76@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 0/2] Reject client if PF plugin is
 configured, but init fails
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 30-09-17 03:00, Antonio Quartulli wrote:
> On 30/09/17 00:24, Steffan Karger wrote:
>> This changes the behavior for pf plugins: instead of just not initializing
>> the firewall rules and happily continuing, this now rejects the client in
>> the case of an (unlikely) failure to initialize the pf.
>>
>> Signed-off-by: Steffan Karger <steffan@...1856...>
>> ---
>>  src/openvpn/pf.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
>> index 5cb002bf..29231b67 100644
>> --- a/src/openvpn/pf.c
>> +++ b/src/openvpn/pf.c
>> @@ -639,10 +639,11 @@ pf_init_context(struct context *c)
>>                  }
>>  #endif
>>              }
>> -            else
>> -            {
>> -                msg(M_WARN, "WARNING: OPENVPN_PLUGIN_ENABLE_PF disabled");
>> -            }
>> +        }
>> +        if (!c->c2.pf.enabled)
>> +        {
>> +            msg(M_WARN, "WARNING: failed to init PF plugin, rejecting client.");
>> +            register_signal(c, SIGUSR1, "plugin-pf-init-failed");
>>          }
> 
> after this part there is some code dealing with the management
> interface: wouldn't it be better to have a return after registering the
> signal so that we don't attempt any interaction with the management
> interface? If the plugin initialization failed, we should exit right
> away no?
> 
> (although this PF thing with the plugin being optional makes everything
> more complicated every time :/)

Good point, I'll fix that and send a whole new patch set with all your
comments processed.  With the expansion from 2 to 4 patches, the thread
has become quite a mess.

> Another thought: if we abort every time we can't initialize the pf
> context, do you think we need the c->c2.pf.enabled member at all?
> 
> It looks to me that after this patch if PF is enabled, either a client
> is connected and has a PF context, or its connection was rejected
> entirely. Thus a overall state should be enough rather than a per-client
> one. (Can probably be adjusted with another patch if you don't feel like
> doing all this in here?)

The pf.enabled member is used in a number of quick inline checks to
determine whether to go into the whole pf code path or not.  I think
it's best to keep it.

-Steffan

