References: <949ac6c4-093f-3c03-c597-2ac6855b3477@...1856...>
	<1482085616-17149-1-git-send-email-steffan@...1856...>
	<075c4a8e-e2b6-c4e6-f55e-86a0236d3a21@...2080...>
	<CAA1AbxJADeM7N67CmXdBuZ7t69LN+MOAjToUg5GaiDt9MA_G-g@...278...>
	<0311294b-9902-c813-6649-9597a867fbea@...2080...>
	<1feee9f2-b989-713e-7c2d-79a54aab285c@...1856...>
	<CAKuzo_gsa32Cjv3FQ6WcZEopdbg0QOw6DX-Kc4rx5nzBVqnELQ@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <f67451b7-dcf4-ec0e-96f4-d6bcd28cfe47@...1856...>
Date: Fri, 23 Dec 2016 22:16:39 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gsa32Cjv3FQ6WcZEopdbg0QOw6DX-Kc4rx5nzBVqnELQ@...278...>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


On 23-12-16 22:10, Selva Nair wrote:
> 
> On Fri, Dec 23, 2016 at 2:39 PM, Steffan Karger <steffan@...1856...
> <mailto:steffan@...1856...>> wrote:
> 
>     > On 21/12/16 23:03, Steffan Karger wrote:
>     >> On 21 December 2016 at 22:09, David Sommerseth
>     >> <openvpn@...2080...
>     <mailto:openvpn@...2080...>> wrote:
>     >>> On 18/12/16 19:26, Steffan Karger wrote:
>     >>>> Now that we have touched each and every file anyway, I decided
>     to go over
>     >>>> the code I regularly work with and reformat it some more by
>     hand.  This is
>     >>>> how for I got today, and is a large enough patch I think.
>     >>>>
>     >>>> This commit is mostly just reordering and changing whitespace,
>     with one
>     >>>> exception: it removes the #if 0 around some debugging code in
>     >>>> read_key_file(), and now always print the debugging if
>     D_SHOW_KEYS is
>     >>>> enabled.
>     >>>>
>     >>>> This patch is best reviewed with something like
>     >>>> 'git diff --ignore-space-change'.
>     >>>>
>     >>>> Signed-off-by: Steffan Karger <steffan@...1856...
>     <mailto:steffan@...1856...>>
>     >>>> ---
>     >>>> v2: fix wrong indent, add more 'for () {' -> 'for ()\n{' fixes.
>     >>>>
>     >>>>  src/openvpn/crypto.c         | 425
>     ++++++++++++++++++++++---------------------
>     >>>>  src/openvpn/crypto.h         |  27 ++-
>     >>>>  src/openvpn/crypto_mbedtls.c |  63 ++++---
>     >>>>  src/openvpn/crypto_openssl.c |  38 ++--
>     >>>>  src/openvpn/cryptoapi.c      | 101 ++++++----
>     >>>>  5 files changed, 356 insertions(+), 298 deletions(-)
>     >>>>
>     >>> [...snip...]
>     >>>
>     >>> Hmmm ... I like that we're trying to clean up the formatting
>     further.
>     >>> But I'm not too happy that uncrustify seems to disagree slightly ...
>     >>> See the attached patch what happened after applying your patch
>     and then
>     >>> running:
>     >>>
>     >>>    $ uncrustify --no-backup -l C $files
>     >>>
>     >>> We should either see if our uncrustify config is correct or need
>     slight
>     >>> adjustments (without needing to re-run it on the complete tree
>     once again)
>     >>
>     >> This seems to be due to 2 things:
>     >>
>     >> 1) I adhered to the CodeStyle page 'When lines exceed this length,
>     >> wrap them using a double indent (ie 8 spaces)', while the crustify
>     >> config uses a single indent.  Since this double indent was somewhat
>     >> arbitrary, I think we should just change the CodeStyle page to single
>     >> indent.
>     >
>     > And this goes against what was agreed upon in the Munich 2014
>     hackathon:
>     >
>     >   o line length?
>     >      - breaking a line in the middle: align to opening (round)
>     brackets
>     >        in line above
>     >
>     >   <http://community.openvpn.net/openvpn/wiki/MunichHackathon2014
>     <http://community.openvpn.net/openvpn/wiki/MunichHackathon2014>>
> 
>     That's about 2), not 1), but I get the point.  As before, I'll just have
>     to accept the "we decided on this before argument", and deal with it.
>     (I'm not sure how to keep the code readable with this requirement, but I
>     guess we'll find out.)
> 
> 
> Do we have to be so strict about the coding style which itself is so
> ill-defined?
> I'll happily adhere to any style if that becomes a requirement for
> patches, but
> overly depending on an external tool to ensure a style that's not even
> precisely
> defined by the CodeStyle page (except by the uncrustify config) sounds lame
> to me.
> 
> Aiming towards a uniform coding style is a good goal. Requiring that
> patches should be invariant under "uncrustify -c some-config" is not, imho.

Oh, I'm definitely not in favour of rejecting patches if they don't pass
"uncrustify -c some-config".  And I don't think we ever agreed to do so.

But in this case, the 'violations' were all either violations of what we
apparently agreed to in Munich ( 'align with (' ), or simply indented
with a different value than uncrustify did.  So actually quite well defined.

-Steffan

