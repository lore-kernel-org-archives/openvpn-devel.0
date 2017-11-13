References: <20171110163946.7656-1-fkooman@...2318...>
 <63ccd0e3-491f-3fb3-e611-9b6674d3d501@...2298...>
 <aef485c7-f619-eaac-6534-0828ab9d41f5@...2318...>
 <CAKuzo_jfJQOBhYMEyT4oiNN1xAZkvkxZm8eeDT=xcUfToaC9kQ@...278...>
 <20171112214244.GI958@...1296...>
 <34a7cc97-16e2-becc-4f97-ff8dbf8ecb0a@...2318...>
 <4ea94797-c52a-da17-b5ba-c7f8d9411326@...2181...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <4717a1f2-b8c6-26ae-2cf4-42ae5f34c3eb@...1435...>
Date: Mon, 13 Nov 2017 11:15:45 +0100
MIME-Version: 1.0
In-Reply-To: <4ea94797-c52a-da17-b5ba-c7f8d9411326@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Implement "status 4" (JSON) for
 management interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,

Since I don't use the mgmt interface / status file a lot, I didn't chip
in earlier.  But since this quite closely matches my initial thoughts
I'll do so anyway.

On 13-11-17 10:54, Antonio Quartulli wrote:
> On 13/11/17 17:44, Fran=E7ois Kooman wrote:
>> On 11/12/2017 10:42 PM, Gert Doering wrote:
>>> On Sun, Nov 12, 2017 at 12:21:06PM -0500, Selva wrote:
>>>> One of the niceties of JSON is its readability which is greatly reduced
>>>> if formatted without line breaks.=20
>>>
>>> +1
>>>
>>> the difference in efficienty is not large, but "human readability for
>>> manual proofreading" is good.
>>
>> Selva, Gert,
>>
>> You know, the funny thing is that my main reason for implementing JSON
>> support for status was to have it easily _machine_ readable, for higher
>> level programming languages where JSON is "first class citizen", and not
>> primarily human readability. Besides you could easily do this to make
>> JSON human readable:
>>
>> $ cat /path/to/status.json | python -mjson.tool
>>
>> Thinking some more about it now, it doesn't really make sense to
>> implement JSON at all, because CSV _is_ actually meant to be machine
>> readable and a lot more efficient in the amount of data it uses (much
>> less duplication). So it seems my reasons for implementing JSON support
>> seems to completely miss the point. For machine readable output it would
>> make more sense to use a binary format instead of JSON.
>>
>> What do you guys think? Are there any other reasons to implement JSON
>> support?

This was my original question: why should we *add* JSON?  I agree that
if we would have to pick something now, I'd prefer JSON over CSV.  But
we already have CSV, and as far as I understand it suffices just fine.

> Although JSON is a bloated language (meaning that there is lots of
> overhead next to the data itself), I think that it allows you to easily
> extend the objects being sent back and forth with a fairly high chance
> to keep backwards compatibility.
>=20
> This is barely true for csv.

The biggest difference is that CSV is 'flat' while JSON is
"hierarchical".  But since we already support CSV (and want to keep
supporting it, I guess?), I think we're kind of bound to a flat
structure anyway.

> A binary presentation per se is not bad, but then you need to make sure
> that the format is properly encoded/decoded (especially if the data is
> transferred across the network from/to different platforms) and this can
> be error prone.

Slightly offtopic: I recently came across CBOR, which seems a good
attempt to merge the benefits of JSON with a binary representation:
https://tools.ietf.org/html/rfc7049

Haven't really used it yet though, so no practical experiences
unfortunately.

> Honestly I did not read the rest of the thread, but if this data is
> supposed to be exposed through an API (i.e. REST API or any other
> interface) and it is meant to travel across the network, I wouldn't mind
> seeing the JSON format being used.
>=20
> JSON consumers nowadays are extremely easy to implement compared to other=
s.

Even compared to CSV?  I can't really come up with a situation where I
can consume JSON easily, but can't consume CSV.

> Regarding the JSON "prettiness", I think that printing it in a nice
> readable format makes it just extremely easy to debug and possibly spot
> errors on the fly (even when not searching for them). For this reason
> I'd rather add a couple of tabs and \n to make it easier to read.

+1, one of the strong sides of JSON is that is easy to make it both user
and machine readable.

-Steffan

