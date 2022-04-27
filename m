From: Kristof Provost <kprovost@...2661...>
Date: Wed, 27 Apr 2022 11:52:40 +0200
Message-ID: <DA49D57D-FF28-4B6D-B9EB-5C5BE8332F48@...2661...>
In-Reply-To: <761e5640-6d43-d25b-4845-25698d2e0688@...2181...>
References: <20220427074828.6283-1-kprovost@...2661...>
 <20220427074828.6283-2-kprovost@...2661...>
 <761e5640-6d43-d25b-4845-25698d2e0688@...2181...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Handle (DCO) timeouts in client mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

On 27 Apr 2022, at 9:55, Antonio Quartulli wrote:
> Hi Kristof,
>
> On 27/04/2022 09:48, Kristof Provost via Openvpn-devel wrote:
>> From: Kristof Provost <kp@...1376...>
>>
>> Handle the DCO driver telling us that the peer went away, even if we're
>> not running in multi-instance mode.
>
> thanks for catching and fixing this. It was indeed on the todo list, but =
well hidden under the rest :-D
>
I know how todo piles work all too well.

>>
>> Signed-off-by:	Kristof Provost <kprovost@...2661...>
>> ---
>>   src/openvpn/forward.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
>> index 9ddea439..f60c56a8 100644
>> --- a/src/openvpn/forward.c
>> +++ b/src/openvpn/forward.c
>> @@ -1111,6 +1111,12 @@ process_incoming_dco(struct context *c)
>>        dco_do_read(dco);
>>  +    if (dco->dco_message_type =3D=3D OVPN_NOTIF_DEL_PEER)
>
> Not sure where this constant is coming from, but on ovpn_dco_linux.h we h=
ave OVPN_CMD_DEL_PEER (similar format as the following OVPN_CMD_PACKET).
>
> Is that a format we can adhere to on BSD as well?
>
Good catch. OVPN_NOTIF_DEL_PEER  is specific to the FreeBSD DCO interface a=
nd shouldn=E2=80=99t be used in the generic openvpn code. It worked acciden=
tally because it has the same value as OVPN_CMD_DEL_PEER. We should indeed =
be using OVPN_CMD_DEL_PEER here.

I=E2=80=99ll update the patch and probably submit both the freebsd dco patc=
h and this together in a few hours.

Kristof

