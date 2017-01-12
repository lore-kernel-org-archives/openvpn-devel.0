References: <20161227112436.5045-1-a@...2181...>
	<97c51277-d8b7-b768-5205-706492e92f84@...1856...>
	<20170111063237.GQ18524@...2182...>
	<20170112155453.GT18524@...2182...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <3828ebe8-32df-c89a-8888-5962d4663cdc@...1856...>
Date: Thu, 12 Jan 2017 18:28:58 +0100
MIME-Version: 1.0
In-Reply-To: <20170112155453.GT18524@...2182...>
Subject: Re: [Openvpn-devel] [PATCH v2] convert *_inline attributes to bool
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net


On 12-01-17 16:54, Antonio Quartulli wrote:
> On Wed, Jan 11, 2017 at 02:32:37PM +0800, Antonio Quartulli wrote:
>> On Tue, Jan 10, 2017 at 10:35:10PM +0100, Steffan Karger wrote:
>>>> @@ -6496,7 +6531,7 @@ add_option(struct options *options,
>>>>      else if (streq(p[0], "push") && p[1] && !p[2])
>>>>      {
>>>>          VERIFY_PERMISSION(OPT_P_PUSH);
>>>> -        push_options(options, &p[1], msglevel, &options->gc);
>>>> +        push_options(options, &p[1], is_inline, msglevel, &options->gc);
>>>
>>> Same as with 'plugin', I don't think we can inline a 'push' option?
>>
>>
>> My understanding is that the code allows for push-options to be inline'd, but
>> right now there is no push-option that can be used that way. Am I wrong?
> 
> This said, I agree that we should just not support pushing inline options.
> As of now, none of the 'inlineable' options can be pushed.
> 
> I'll send v3 soon!

Great!  I don't think inline push options would work in general, because
the push string is formatted like "option value, option2 value, ...".
Inline options can contain thinks like line breaks, which would be
unclear how to transform that to the push string.

Maybe even error out if(inline==true) ?

-Steffan

