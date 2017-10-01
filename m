References: <1b275182-8551-6100-e3e9-80c966c2b200@...277...>
 <c2fbb372-cbfe-5231-66fa-33403a1566df@...277...>
 <20170930172859.GY70062@...1296...>
 <CAKuzo_h_HMpRVVoSXft3DPDoDrjhnkWepLiThLbDC43HJtt-Sg@...278...>
From: fragmentux <fragmentux@...277...>
Message-ID: <865e2247-b802-5bc8-73ae-229e478cda80@...277...>
Date: Sun, 1 Oct 2017 22:21:54 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_h_HMpRVVoSXft3DPDoDrjhnkWepLiThLbDC43HJtt-Sg@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] Too much output at --verb 0 (bug?)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Howdy

On 01/10/17 04:25, Selva wrote:
> Hi,
> 
> On Sat, Sep 30, 2017 at 1:28 PM, Gert Doering <gert@...1296...> wrote:
> 
>> Hi,
>>
>> On Thu, Sep 28, 2017 at 01:18:20PM +0100, fragmentux wrote:
>>>
>>
>> Could you please fix your mail client settings so that it writes a proper
>> name here?

maybe

>>
>>> On 27/09/17 15:57, fragmentux wrote:
>>>> not sure if this really counts as a bug but ..
>>>>
>>>> according to the manual --verb 0 = "No output except fatal errors"
>>>>
>>>> This, however, is the output at --verb 0 (2.4.4)
>>>>
>>>> == Start client:
>>>> Option 'explicit-exit-notify' in [PUSH-OPTIONS]:3 is ignored by
>> previous
>>>> <connection> blocks
>>>> Option 'explicit-exit-notify' in [PUSH-OPTIONS]:9 is ignored by
>> previous
>>>> <connection> blocks
>>
>> These two have been taken care of just now ("why is your server pushing
>> it twice?"), but anyway.

yes twice ..


>>
> 
> Yes, muted when pushed. But such messages will still print at verb 0 if
> present outside connection blocks in the config file.
> 

Why is this message printed at --verb 0 at all ?
(possibly you explain below)


> 
>>
>>>> do_ifconfig, tt->did_ifconfig_ipv6_setup=0
>>
>> This one comes as a bit of surprise - it's logged with M_DEBUG, and I
>> assumed that this would be something like "verb 3 or 4, or even higher".
>>
>> Selva, Steffan, or someone else who understands our message levels -
>> what's M_DEBUG for, and what *should* I have used here?
>>
> 
> Hmm.. The log levels code is out of this world and I've only a vague idea..
> I for sure don't know the "officially sanctioned" way of using it and have
> more questions than answers.
> 
> M_DEBUG, M_WARN, M_FATAL etc by themselves do not define any printing level
> -- in other words these will print at all verb levels unless combined with
> something that sets the print level. M_INFO is the only M_x flag that is
> different -- it  has a "verb level" of 1 or more encoded in it.
> 
> I suppose the original design idea was that we are only supposed to use
> M_INFO or one of the LOGLEV's defined in errlevel.h -- the ones starting
> with D_xxx. If so I  don't see one appropriate for printing ifconfig
> errors/info/debug. You ma have to create one?
> 
> One could generate a log level on the fly using, say,  LOGLEV(4,0,M_DEBUG)
> meaning print at verb 4+, don't mute, tag as debug. But there is not a
> single instance of such use anywhere in the code, so I suppose that would
> be considered a hack?
> 
> 
>>
>>>> WARNING: this configuration may cache passwords in memory -- use the
>>>> auth-nocache option to prevent this
>>>>
>>>> == Reconnect client:
>>>> WARNING: 'link-mtu' is used inconsistently, local='link-mtu 1550',
>>>> remote='link-mtu 1602'
>>>> WARNING: 'cipher' is used inconsistently, local='cipher AES-256-GCM',
>>>> remote='cipher AES-256-CBC'
>>>> WARNING: 'auth' is used inconsistently, local='auth [null-digest]',
>>>> remote='auth SHA512'
>> [..]
>>>> None of these are Fatal errors ..
>>
>> Indeed, WARNINGs could also be re-evaluated.  Either we document that
>> "verb 0" will print errors *and* warnings, or we change the printout
>> to not print warnings.

I think --verb 0 should be nought but Fatal ..
If you are trying to figure out what went wrong
then better to have the one ERROR message
than pages of unrelated slush to wade through.


>>
> 
> Aha. so we're not supposed to print warnings or non-fatal errors at verb 0
> -- had no idea.
> 
> I would wager that documentation is wrong as we have loads of messages
> printed with just M_WARN or M_NONFATAL. All of those will print at verb 0.
> Unless are we not supposed print anything with pure M_x flags alone --
> M_INFO being the only exception? Is every M_WARN to be used as
> M_WARN|M_INFO so that it will print only at verb 1+? That would be a kludge.
> 
> Then there is a M_VERB0 = 0 which is commented as "messages displayed even
> at verb0 -- (fatal errors only)" but its used just once in the code -- that
> too used by itself which does nothing but just print the message at all
> verb levels.  And make log consumers (like the GUI) wrongly assume that its
> a benign info message.
> 
> As all M_INFO messages will print at verb 1, we do not have much room to
> define verb levels for WARN, ERROR, FATAL, do we.. This is unlike any
> logging system I've seen and could be totally misreading the designer's
> intent.
> 

No doubt this is the heart of the problem and also beyond my scope of
understanding .. this probably should be trac'd though ?

> 
>>
>> Personally, I wouldn't ever run any software with "--verb 0".  I want
>> to be able to check the log and see "oh, it reconnected tonight at
>> 4:30, so something must have been funny with the network or the server".
>>
> 
> ++1.
> 

I hope we are not expected to obey here ..
verb 0 is a totally valid mode for a "managed" client to use.
If it does not connect then don't send them to openvpn.net because of
some unrelated message in a log.  Make them ask the admin of their
VPN to resolve the issue.

With that in mind, why not have a configurable error message ?
eg: --fatal-contact "Please call xyz on 123 or email admin@...2308..."



