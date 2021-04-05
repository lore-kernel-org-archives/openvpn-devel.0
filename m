Message-ID: <a05d96546358214e20165fb51cab11d3.squirrel@...2556...>
In-Reply-To: <20210405083413.GN976@...1296...>
References: <9b3b2029-bb7d-ab1d-a69b-0d910565fad2@...2181...>
 <e477a1210a2efee09ee2eaccb604e164.squirrel@...2556...>
 <20210403095640.GW976@...1296...>
 <5f61a142d6c8fc91223af9b89cf2772b.squirrel@...2556...>
 <768c58ba-e87b-4e96-0403-61fece8297d0@...2181...>
 <704cc498609f9451a1af5010669452b4.squirrel@...2556...>
 <20210403165313.GY976@...1296...>
 <d4daa5b7f65017700e60369dc5ff1778.squirrel@...2556...>
 <f63feda0-a22b-4e01-ea3b-a2c6bcb0eaaf@...2181...>
 <63c5054ebcf20fceb7dba025f065b180.squirrel@...2556...>
 <20210405083413.GN976@...1296...>
Date: Mon, 5 Apr 2021 10:48:17 +0200
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
To: Gert Doering <gert@...1296...>
Cc: Antonio Quartulli <a@...2181...>, Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

> Hi,
>
> On Mon, Apr 05, 2021 at 10:16:07AM +0200, Simon Matter wrote:
>> Then I misunderstood what is written here?
>>
>> https://community.openvpn.net/openvpn/wiki/DeprecatedOptions#Option:--co=
mpress
>>
>> "Compression is not recommended and is a feature users should avoid
>> using.
>> To signal this clearly, --comp-lzo and --compress are discouraged and
>> considered deprecated features. Beginning with 2.5, these options will
>> no
>> longer enable compression, just enable the compression framing to be
>> able
>> to receive compressed packets."
>>
>> That made me feel compression support in 2.5 is only on a compatibility
>> level.
>
> This is half-correct, and half-incomplete.  Look at
>
>   --allow-compression yes
>
> (new in 2.5).
>
> Yes, 2.5 will no longer send compressed packets unless explicitly
> permitted
> by "allow-compression yes" - but the infrastructure is still there, and
> still tested, but moved from "this is something everybody will want" to
> "if you know what you are doing and why, you can still have it".
>
> Regarding your other mail where you doubted that "there will be a
> discussion"
> - well, I can assure you that there are discussions about every feature we
> take out of OpenVPN (and usually, mails to openvpn-devel and openvpn-users
> to figure out who might still be using it).  Many of these discussions do
> not happen on the list but on the #openvpn-devel and #openvpn-meeting
> IRC channels - but Samuli is sending the meeting minutes to the -devel
> list (and they are on the trac web page), so we try to make transparent
> what we discuss and why.
>
>
> As always, code is a balance between features, maintenance effort, bugs,
> and security...
>
> gert

Ok, thanks for explaining.

Regards,
Simon


