References: <20200920090929.8321-1-gert@...1296...>
 <d682d99e-1c9a-6832-cb04-6f3d5d45f13f@...2181...>
 <20200921075040.GO976@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <4332859d-93f8-1352-8d05-ead5f62c6ad0@...2181...>
Date: Mon, 21 Sep 2020 15:45:59 +0200
MIME-Version: 1.0
In-Reply-To: <20200921075040.GO976@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Fix line number reporting on config
 file errors after <inline> segments
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 21/09/2020 09:50, Gert Doering wrote:
> Hi,
> 
> On Mon, Sep 21, 2020 at 09:22:38AM +0200, Antonio Quartulli wrote:
>> Sorry for not chiming in earlier, but honestly I believe your other
>> option would be "cleaner". The other option being "return int instead of
>> bool, where the returned value is the number of lines of the inline'd
>> material.
>>
>> If 0, we know there was no inline'd material, thus we can treat that
>> result as "not inline'd".
> 
> We could do that, indeed.  I was torn between both variants - this one
> is a bit more intrusive (because it adds a new argument to so many
> functions), but on the other hand, the bool stays a bool and is not
> magically overloaded - which would make the call to add_option() 
> either "even longer", or if you rely on magic "we just pass the integer
> to a bool-expecting function" much harder to understand.
> 
>> Anyway, this is just my opinion. If you believe this is a better
>> approach, I am fine with it too.
> 
> I wasn't sure.  In the end, this one didn't feel so bad, so this is
> what we have.
> 
> Maybe I'll do the other one as well, for fun, and to compare :-)
> 
>>> @@ -4692,7 +4696,7 @@ check_inline_file(struct in_src *is, char *p[], struct gc_arena *gc)
>>>              p[0] = string_alloc(arg + 1, gc);
>>>              close_tag = alloc_buf(strlen(p[0]) + 4);
>>>              buf_printf(&close_tag, "</%s>", p[0]);
>>> -            p[1] = read_inline_file(is, BSTR(&close_tag), gc);
>>> +            p[1] = read_inline_file(is, BSTR(&close_tag), num_lines, gc);
>>
>> am I wrong or here we should add 1 to num_lines to include the opening
>> tag that was parsed *before* entering read_inline_file()?
> 
> The opening tag is parsed as "regular" line in read_config_file(), and as 
> such, the "++line_num" in there applies.
> 
> (I have tested this :-) - nothing more embarrassing than a patch to fix
> line numbers actually still printing wrong line numbers)
> 

Ok, then for me this patch is good to go.

FTR on IRC we discussed the possibility of using the "other approach".
Gert may give it a try and decide if he wants to send that version to
the ml as well.

In any case, this patch gets my blessing:

Acked-by: Antonio Quartulli <a@...2181...>


-- 
Antonio Quartulli

