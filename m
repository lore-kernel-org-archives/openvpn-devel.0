Message-ID: <63c5054ebcf20fceb7dba025f065b180.squirrel@...2556...>
In-Reply-To: <f63feda0-a22b-4e01-ea3b-a2c6bcb0eaaf@...2181...>
References: <458e1fb5-a725-781b-c048-4f0e07440c7b@...1227...>
 <1cf9fe7a309a622eb0ddd79a34dd3af4.squirrel@...2556...>
 <a0648ba0-41ed-5eef-4f36-d41bcb636823@...2181...>
 <ec1f603d169af78b5fdf0cbc3b6f4e52.squirrel@...2556...>
 <9b3b2029-bb7d-ab1d-a69b-0d910565fad2@...2181...>
 <e477a1210a2efee09ee2eaccb604e164.squirrel@...2556...>
 <20210403095640.GW976@...1296...>
 <5f61a142d6c8fc91223af9b89cf2772b.squirrel@...2556...>
 <768c58ba-e87b-4e96-0403-61fece8297d0@...2181...>
 <704cc498609f9451a1af5010669452b4.squirrel@...2556...>
 <20210403165313.GY976@...1296...>
 <d4daa5b7f65017700e60369dc5ff1778.squirrel@...2556...>
 <f63feda0-a22b-4e01-ea3b-a2c6bcb0eaaf@...2181...>
Date: Mon, 5 Apr 2021 10:16:07 +0200
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Fix 'compress migrate' for 2.2 clients.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

> Hi Simon
>
> On 05/04/2021 09:38, Simon Matter wrote:
>>> Hi,
>>>
>>> On Sat, Apr 03, 2021 at 03:07:11PM +0200, Simon Matter wrote:
>>>> Apr  3 15:00:30 gw-X1 openvpn[1477]: pre-compress bytes,833300152
>>>> Apr  3 15:00:30 gw-X1 openvpn[1477]: post-compress bytes,796650159
>>>> Apr  3 15:00:30 gw-X1 openvpn[1477]: pre-decompress bytes,343572096
>>>> Apr  3 15:00:30 gw-X1 openvpn[1477]: post-decompress bytes,510118472
>>>
>>> This is indeed fairly significant - and if WAN circuits are full and/or
>>> cost money per Gbyte, compression is still a win.
>>>
>>> I'm more of a compression fan than not :-) - so this will be
>>> interesting
>>> discussions indeed.
>>
>> Hi Gert,
>>
>> Based on the answers I got on this list I'm afraid there won't be any
>> discussion and compression is gone. That's really sad as it is a useful
>> feature for many use cases as I was easily able to show.
>>
>
>
> at the moment there is neither a patch nor a point on any meeting agenda
> about removing compression from the OpenVPN codebase.
>
> Please don't hastily draw such conclusions.
>
> So far it was *you* opening this discussion about compression removal as
> OT of the patch in the subject. We only expressed our personal opinions
> about your statements.

Then I misunderstood what is written here?

https://community.openvpn.net/openvpn/wiki/DeprecatedOptions#Option:--compr=
ess

"Compression is not recommended and is a feature users should avoid using.
To signal this clearly, --comp-lzo and --compress are discouraged and
considered deprecated features. Beginning with 2.5, these options will no
longer enable compression, just enable the compression framing to be able
to receive compressed packets."

That made me feel compression support in 2.5 is only on a compatibility
level.

Regards,
Simon


