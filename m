From: Kristof Provost <kprovost@...2661...>
Date: Fri, 03 Mar 2023 12:58:55 +0100
Message-ID: <3ED9B487-93AE-46F7-9695-6C8C7DA600C0@...2661...>
In-Reply-To: <4c2a77ee-b2d6-1675-fdd7-60e501333cc5@...2181...>
References: <20230303110511.9569-1-kprovost@...2661...>
 <aedd91b7-74f7-7916-f5b5-3b2686e4e311@...2181...>
 <4c2a77ee-b2d6-1675-fdd7-60e501333cc5@...2181...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] dco: define
 OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT on FreeBSD
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 3 Mar 2023, at 12:48, Antonio Quartulli wrote:
> On 03/03/2023 12:27, Antonio Quartulli wrote:
>> Hi,
>>
>> On 03/03/2023 12:05, Kristof Provost via Openvpn-devel wrote:
>>> From: Kristof Provost <kp@...1376...>
>>>
>>> FreeBSD's if_ovpn will never emit this as a peer deletion reason
>>> (because it doesn't support TCP), but this allows us to align the
>>> defines between Linux and FreeBSD, and remove a Linux-specific case from
>>> process_incoming_del_peer().
>>
>> SoB missing
>
> Sorry for being very condensed, however the patch looks good and gets my =
ACK:
>
> Acked-by: Antonio Quartulli <a@...2181...>
>
> I normally put my ACK under the SoB, so when I couldn't find it, my brain=
 just threw that exception :-P
>
Ah yes. Do you want me to send an update with the line included, or is this=
 sufficient:

Signed-off-by: Kristof Provost <kprovost@...2661...>

Kristof

