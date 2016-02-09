MIME-Version: 1.0
In-Reply-To: <56BA02BF.5090208@...2080...>
References: <1454874438-5081-1-git-send-email-steffan@...1856...>
	<1454874438-5081-10-git-send-email-steffan@...1856...>
	<56B8BC53.40805@...1227...>
	<56BA02BF.5090208@...2080...>
From: Steffan Karger <steffan@...1856...>
Date: Tue, 9 Feb 2016 17:46:21 +0100
Message-ID: <CAA1AbxLu+P5-Vn3kPYFgrVZFHpY1WtD3+0TkFZzDTdOkLJgB-Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH 09/10] Add cipher name translation for
	OpenSSL.
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

On Tue, Feb 9, 2016 at 4:16 PM, David Sommerseth
<openvpn@...2080...> wrote:
> On 08/02/16 17:03, Arne Schwabe wrote:
>> Am 07.02.16 um 20:47 schrieb Steffan Karger:
>>> This keeps naming consistent. For example, instead of id-aes128-GCM use
>>> AES-128-GCM, which is more like AES-128-CBC.
>>>
>>> +
>>> +  if (NULL == pair)
>>> +    return cipher_name;
>>> +
>> I like the pair == NULL style more.
>
> I "kind of" agree, as that's what we've grown up with.  However, from a
> defensive programming style, this is a far better approach.  A mistyping using
> '=' will in 'NULL = pair' case cause a compile failure.  The other way around
> will compile just fine with a nice ugly bug attached with it ... So I'm trying
> to get used to his "flipped around" style.

This indeed the motivation is.

But, modern compilers do detect this (given the correct flags):

gcc 5.2.1:
$ clang -o no-yoda no-yoda.c
no-yoda.c:5:9: warning: using the result of an assignment as a condition without
      parentheses [-Wparentheses]
  if (a = NULL) {
      ~~^~~~~~
no-yoda.c:5:9: note: place parentheses around the assignment to silence this
      warning
  if (a = NULL) {
        ^
      (       )
no-yoda.c:5:9: note: use '==' to turn this assignment into an equality
      comparison
  if (a = NULL) {
        ^
        ==

clang 3.6.2:
$ clang -o no-yoda no-yoda.c
no-yoda.c:5:9: warning: using the result of an assignment as a condition without
      parentheses [-Wparentheses]
  if (a = NULL) {
      ~~^~~~~~

So, I do not have any strong preference.

-Steffan

