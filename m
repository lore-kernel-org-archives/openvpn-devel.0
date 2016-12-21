MIME-Version: 1.0
In-Reply-To: <075c4a8e-e2b6-c4e6-f55e-86a0236d3a21@...2080...>
References: <949ac6c4-093f-3c03-c597-2ac6855b3477@...1856...>
	<1482085616-17149-1-git-send-email-steffan@...1856...>
	<075c4a8e-e2b6-c4e6-f55e-86a0236d3a21@...2080...>
From: Steffan Karger <steffan@...1856...>
Date: Wed, 21 Dec 2016 23:03:06 +0100
Message-ID: <CAA1AbxJADeM7N67CmXdBuZ7t69LN+MOAjToUg5GaiDt9MA_G-g@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] reformatting: fix style in
	crypto*.{c, h}
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 21 December 2016 at 22:09, David Sommerseth
<openvpn@...2080...> wrote:
> On 18/12/16 19:26, Steffan Karger wrote:
>> Now that we have touched each and every file anyway, I decided to go over
>> the code I regularly work with and reformat it some more by hand.  This is
>> how for I got today, and is a large enough patch I think.
>>
>> This commit is mostly just reordering and changing whitespace, with one
>> exception: it removes the #if 0 around some debugging code in
>> read_key_file(), and now always print the debugging if D_SHOW_KEYS is
>> enabled.
>>
>> This patch is best reviewed with something like
>> 'git diff --ignore-space-change'.
>>
>> Signed-off-by: Steffan Karger <steffan@...1856...>
>> ---
>> v2: fix wrong indent, add more 'for () {' -> 'for ()\n{' fixes.
>>
>>  src/openvpn/crypto.c         | 425 ++++++++++++++++++++++---------------------
>>  src/openvpn/crypto.h         |  27 ++-
>>  src/openvpn/crypto_mbedtls.c |  63 ++++---
>>  src/openvpn/crypto_openssl.c |  38 ++--
>>  src/openvpn/cryptoapi.c      | 101 ++++++----
>>  5 files changed, 356 insertions(+), 298 deletions(-)
>>
> [...snip...]
>
> Hmmm ... I like that we're trying to clean up the formatting further.
> But I'm not too happy that uncrustify seems to disagree slightly ...
> See the attached patch what happened after applying your patch and then
> running:
>
>    $ uncrustify --no-backup -l C $files
>
> We should either see if our uncrustify config is correct or need slight
> adjustments (without needing to re-run it on the complete tree once again)

This seems to be due to 2 things:

1) I adhered to the CodeStyle page 'When lines exceed this length,
wrap them using a double indent (ie 8 spaces)', while the crustify
config uses a single indent.  Since this double indent was somewhat
arbitrary, I think we should just change the CodeStyle page to single
indent.

2) Uncrustify insists on either 'align function parameters' or 'indent
function parameters'.  There is no 'ignore' for this option.  The
current config uses 'align', which is fine in a lot of places, but in
some cases (such as the ones I've changed) it impairs readability.

Point 2 makes me believe that we should not enforce the code style
with a tool, but rather just with eyes during patch review.  There's
just too many places where some freedom can improve readability.

Alternatively, if everyone thinks that 'indent' is better than
'align', we can change the config and postpone this discussion until
the next time where we run into something ;)

-Steffan

