References: <1482524791-5788-1-git-send-email-steffan@...1856...>
	<CAKuzo_jKfWW0TA2TUzFhPFOQa6JjtfDNpiAStTUp4vyT+7yOOw@...278...>
	<f3feae1b-5429-f9aa-dc29-ec0f21124dcd@...1856...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <7b735498-f033-6f7c-0286-08da9eafdb7a@...1856...>
Date: Fri, 23 Dec 2016 22:59:09 +0100
MIME-Version: 1.0
In-Reply-To: <f3feae1b-5429-f9aa-dc29-ec0f21124dcd@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Add nl_for_brace=add to uncrustify.conf
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


On 23-12-16 22:44, Steffan Karger wrote:
> On 23-12-16 22:23, Selva Nair wrote:
>>
>> On Fri, Dec 23, 2016 at 3:26 PM, Steffan Karger <steffan@...1856...
>> <mailto:steffan@...1856...>> wrote:
>>
>>     diff --git a/dev-tools/uncrustify.conf b/dev-tools/uncrustify.conf
>>     index 95e0b2a..3745ed0 100644
>>     --- a/dev-tools/uncrustify.conf
>>     +++ b/dev-tools/uncrustify.conf
>>     @@ -9,6 +9,7 @@ nl_brace_else=add
>>      nl_elseif_brace=add
>>      nl_else_brace=add
>>      nl_else_if=remove
>>     +nl_for_brace=add
>>
>>
>> What about 
>>
>> nl_switch_brace = add
>> nl_while_brace = add
>> nl_fdef_brace = add
>>
>> These are not optional as per the style, are they?
> 
> Indeed.  Let's add them too.  I'll send a v2.

Hrmpf, yet another can of worms.  If I add these and check the changes,
it looks like we need these too:

mod_full_brace_while=add
mod_full_brace_for=add

Otherwise we get a number of

while(i) i--;

type of lines converted to

while(i)
    i--;

instead of

while(i)
{
    i--;
}

I'll send a patch so people can easily see what adding these means for
the code.

-Steffan

