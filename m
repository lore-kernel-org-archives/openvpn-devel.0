Message-ID: <704cc498609f9451a1af5010669452b4.squirrel@...2556...>
In-Reply-To: <768c58ba-e87b-4e96-0403-61fece8297d0@...2181...>
References: <20210402134529.27866-1-gert@...1296...>
 <b92f02afa4d8156edd55c2126ae6352c.squirrel@...2260...>
 <20210402185720.GS976@...1296...>
 <c76250866ae96447a3ec712f04b4b346.squirrel@...2260...>
 <458e1fb5-a725-781b-c048-4f0e07440c7b@...1227...>
 <1cf9fe7a309a622eb0ddd79a34dd3af4.squirrel@...2556...>
 <a0648ba0-41ed-5eef-4f36-d41bcb636823@...2181...>
 <ec1f603d169af78b5fdf0cbc3b6f4e52.squirrel@...2556...>
 <9b3b2029-bb7d-ab1d-a69b-0d910565fad2@...2181...>
 <e477a1210a2efee09ee2eaccb604e164.squirrel@...2556...>
 <20210403095640.GW976@...1296...>
 <5f61a142d6c8fc91223af9b89cf2772b.squirrel@...2556...>
 <768c58ba-e87b-4e96-0403-61fece8297d0@...2181...>
Date: Sat, 3 Apr 2021 15:07:11 +0200
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

> Hi,
>
> On 03/04/2021 12:06, Simon Matter wrote:
>> Our use case is simple, we don't want ANY application in our company to
>> consume more WAN bandwidth than is absolutely needed. Of course we're
>> using compression like in rsync where it's possible, but that's not
>> possible everywhere and with every application. So we also try to catch
>> those cases by using compression over the VPN links. In case there is no
>> compressible data, it doesn't hurt much, but it can help a lot with
>> compressible data.
>
> Out of curiosity, would you be able to provide statistics of how much
> you are saving and with which application protocol?

No, I can not show applications but I can tell you it's from a huge number
of different devices. There are thin clients but also a zoo of document
printers, different label printer types, barcode scanning devices, payment
terminals, DECT VoIP phones, alarm systems, lots of embedded systems,
document scanners, video cameras and the list goes on. It's quite
difficult to analyze every protocol and see how or if it can be compressed
which is why it's nice to know things get at least compressed when running
over the WAN links.

Example status shows this:

Apr  3 15:00:30 gw-X1 openvpn[1477]: pre-compress bytes,833300152
Apr  3 15:00:30 gw-X1 openvpn[1477]: post-compress bytes,796650159
Apr  3 15:00:30 gw-X1 openvpn[1477]: pre-decompress bytes,343572096
Apr  3 15:00:30 gw-X1 openvpn[1477]: post-decompress bytes,510118472

Apr  3 15:00:09 gw-X2 openvpn[1502]: pre-compress bytes,3152837867
Apr  3 15:00:09 gw-X2 openvpn[1502]: post-compress bytes,3142711232
Apr  3 15:00:09 gw-X2 openvpn[1502]: pre-decompress bytes,3045691308
Apr  3 15:00:09 gw-X2 openvpn[1502]: post-decompress bytes,4980566715

It shows at least that it does something. It's clear that the gain is not
so big but, this status doesn't show the negative effect that one stupid
protocol can have on the connection. If there is one device doing lots of
compressible traffic during half an hour per day, this can greatly disturb
connectivity during the half an hour. That's half an hour too much.

Simon


