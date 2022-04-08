Message-ID: <69699e39-4257-2598-4b56-55ff6526fd18@...2669...>
Date: Fri, 8 Apr 2022 13:18:44 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220330205536.139-1-timo@...2669...>
 <20220407184023.249-1-timo@...2669...>
 <YlAB9NJWMd9H/EUg@...1296...>
From: Timo Rothenpieler <timo@...2669...>
In-Reply-To: <YlAB9NJWMd9H/EUg@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v3] platform: Retain CAP_NET_ADMIN when
 dropping privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net, David Sommerseth <davids@...515...>

On 08/04/2022 11:35, Gert Doering wrote:
> Hi,
> 
> On Thu, Apr 07, 2022 at 08:40:24PM +0200, Timo Rothenpieler wrote:
>> +    else if (res < 0)
>> +    {
>> +        if (res == -3)
>> +        {
>> +            msg(M_NONFATAL, "Following error likely due to missing capability CAP_SETPCAP.");
>> +        }
>> +        msg(err_flags | M_ERRNO, "capng_change_id('%s','%s') failed retaining capabilities: %d",
>> +            user_state->username, group_state->groupname, res);
>> +        goto fallback;
>> +    }
> 
> Wouldn't that overwrite errno for the "res == -3" case, given that
> msg() will do stdio stuff?  Maybe reorder and print the "error likely due..."
> message with a preceding "NOTE:" after the capng_change_id() message?
> 
> (That would be more typical for our logs - the "NOTE: this could be
> because..." tends to come after the error message)

Good point.
I like that idea better as well, will implement.

>> +    if (new_uid >= 0)
>> +    {
>> +         msg(M_INFO, "UID set to %s", user_state->username);
>> +    }
>> +    if (new_gid >= 0)
>> +    {
>> +         msg(M_INFO, "GID set to %s", group_state->groupname);
>> +    }
>> +
>> +    msg(M_INFO, "Capabilities retained: CAP_NET_ADMIN");
>> +
>> +    return;
>> +fallback:
> 
> My inner whitespace dragon does would prefer to have the blank line
> between "return" and "fallback:" (and no blank linke after the M_INFO).

No strong preference there on my side, so sure.

>> +    /* capng_change_id() can leave this flag clobbered on failure
>> +     * This is working around a bug in libcap-ng, which can leave the flag set
>> +     * on failure: https://github.com/stevegrubb/libcap-ng/issues/33 */
>> +    if (prctl(PR_GET_KEEPCAPS) && prctl(PR_SET_KEEPCAPS, 0) < 0)
>> +    {
>> +        msg(M_ERR, "Clearing KEEPCAPS flag failed");
>> +    }
>> +#endif  /* HAVE_LIBCAPNG */
> 
> This one does not really look like it should be in "fallback:" - because
> that way it always gets called, even if we jump there right at function
> entry, if keep_caps == 0.

No, it's intentional. It ensures that it's printed even if we don't 
HAVE_LIBCAPNG but someone called the function requesting to keep 
capabilities, which is not possible then.

>> +
>> +    if (keep_caps)
>> +    {
>> +        msg(err_flags, "Unable to retain capabilities");
>> +    }
>> +
>> +    platform_group_set(group_state);
>> +    platform_user_set(user_state);
>> +}
>> +
> 
> Maybe "fallback:" should be right before platform_group_set()?
> 
> 
> (Sorry for being late to the "complain about your code" party...)
> 
> gert

