MIME-Version: 1.0
In-Reply-To: <CAKuzo_jRJcTGWRqv51O3TPc7rU=8aomQqFeib0FF_G-dtUmeQg@...278...>
References: <CAKuzo_jO0FLo=xMakh1yB6_h=huE4Pqp6Xtk2QEgXikeui-F6w@...278...>
	<073f348b-77a8-3967-2874-77f2c973dbf4@...2070...>
	<CAKuzo_goKiVr4k7+eQbLK93fzQ99ZH+pkk1uVw0k2_OGb0mH4A@...278...>
	<CAKuzo_jRJcTGWRqv51O3TPc7rU=8aomQqFeib0FF_G-dtUmeQg@...278...>
From: Steffan Karger <steffan@...1856...>
Date: Tue, 23 Aug 2016 17:56:55 +0200
Message-ID: <CAA1AbxJWFS-Xm+FCL3kqKFfXZ364eGYKrpzPCncimF-hmz5W1Q@...278...>
Subject: Re: [Openvpn-devel] block-outside-dns and multiple tunnels
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 23 August 2016 at 17:23, Selva Nair <selva.nair@...277...> wrote:
> On Tue, Aug 16, 2016 at 1:42 PM, Selva Nair <selva.nair@...277...> wrote:
>> On Tue, Aug 16, 2016 at 12:41 PM, ValdikSS <iam@...2070...> wrote:
>>>
>>> This is known issue (for me), and it was superficially discussed on IRC
>>> at some point. It wasn't considered significant to implement
>>> block-outside-dns for multiple connections.
>>>
>>> Is there ahy reason to use block-outside-dns on multiple connections?
>>> Just asked supergregg (bug reporter), he probably has a reason if he created
>>> the bug.
>>
>> I have no strong reason except that if an end user gets two configs with
>> block-outside-dns enabled it should just work without having to edit the
>> configs. Support for dns traffic through each tunnel may not be required,
>> but at least one of them working even if block-outside-dns is specified in
>> multiple configs looks like a nice thing to do.  Not all users can be
>> expected to edit configs.
>
> The IRC summary of Aug 22  says
>
> Discussed "block-outside-dns and multiple tunnels":
>
> <https://sourceforge.net/p/openvpn/mailman/message/35263770/>
> <https://community.openvpn.net/openvpn/ticket/718>
>
> It was agreed to move this forward by looking into the approaches
> suggested by Selva, and by giving him feedback.
>
>
> So what is the consensus? Should we support DNS through all tunnels for
> which block-outside-dns is specified or just make sure DNS works through at
> least one of the tunnels if the option is used on multiple ones?

"At least one" is a huge improvement, so that alone is worth a feature-ack.

From a user perspective, I can imagine a use case where someone wants
to connect to company network A and company network B, both with
internal DNS, and expects to resolve both server.local.companya.com
and server.local.companyb.com.  (Whether connecting two networks like
this is wise is another question, but I'm pretty sure it happens.)
That will only work if DNS through both tunnels is supported.  But
this does feel like a corner case, so it totally depends on the extra
complexity required to make this work... (and I have no clue about
that).

-Steffan

