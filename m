MIME-Version: 1.0
In-Reply-To: <56706E28.8030900@...2080...>
References: <1448852638-2644-1-git-send-email-fukawi2@...277...>
	<56706E28.8030900@...2080...>
From: Steffan Karger <steffan@...1856...>
Date: Tue, 15 Dec 2015 20:54:23 +0100
Message-ID: <CAA1AbxKm2cjH3EahH4pdjdRsN9W06aRXAybgWZb1MQc7+X6qYA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Use example.com to improve clarity of
	documentation
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

On Tue, Dec 15, 2015 at 8:46 PM, David Sommerseth
<openvpn@...2080...> wrote:
> On 30/11/15 04:03, Phillip Smith wrote:
>> This patch uses the generic "host1.example.com" and "host2.example.com" to
>> replace the current "may" and "june" hostname examples. Generic names chosen
>> rather than other names like "server"/"client" or "head-office"/"remote-office"
>> etc which may create other unintended or implicit meanings to the reader.
>> The example.com domain is set aside defined by IANA for use as documentation
>> examples. Refer to: http://www.iana.org/domains/reserved
>> Using this well-known domain makes comprehension of documentation easier.
>>
>> Signed-off-by: Phillip Smith <fukawi2@...277...>
>> ---
>>  doc/openvpn.8 | 84 +++++++++++++++++++++++++++++------------------------------
>>  1 file changed, 42 insertions(+), 42 deletions(-)
>
> [...snip...]
>
>> -.B may.kg
>> +.B host1.example.com
>>  and
>> -.B june.kg.
>> +.B host2.example.com.
>
> Any reason changing from {may, june} to {host1, host2}?  I find
> documentation to be easier to read when there are more than just one or
> two letters changing.  Especially when it is related to two different
> systems you want to configure to talk to each other.  For people
> struggling with dyslexia, more diversity also helps a lot too.
>
> It doesn't need to be may or june.  Could even be
> "alice-laptop.example.org", "bob-workstaion.example.org" or something
> more even more unique.  Just have a broader variety.

Ooh, I like using alice and bob!  Typical crypto example names, and
easy to differentiate.  But I would prefer to ditch the -laptop and
-workstation, to prevent unintended or implicit meanings as Philip
suggested.

-Steffan

