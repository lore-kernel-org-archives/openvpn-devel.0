References: <1465410882-15540-1-git-send-email-steffan@...1856...>
	<1465852568-6972-1-git-send-email-steffan@...1856...>
	<20160623183246.GN79504@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <eed6fe0a-2f80-3cf8-2ad1-30e3c302c413@...1227...>
Date: Fri, 8 Jul 2016 17:20:03 +0200
MIME-Version: 1.0
In-Reply-To: <20160623183246.GN79504@...1296...>
Subject: Re: [Openvpn-devel] [PATCHv3 3/5] Add client-side support for
 cipher negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>, Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net



Am 23.06.16 um 20:32 schrieb Gert Doering:
> Hi,
>
> On Mon, Jun 13, 2016 at 11:16:08PM +0200, Steffan Karger wrote:
>> Based on the 'IV_NCP=3D2' mechanism described in
>> http://permalink.gmane.org/gmane.network.openvpn.devel/9385.
>>
>> This is the first patch of a set that adds support for cipher negotiatio=
n.
>> Follow-up patches will add ways to restrict or disable the mechanism, and
>> add server-side support.
>>
>> v2:
>>  * Account for crypto overhead through struct frame.  This is less
>>    transparant, but the code has been built to work this way.  The
>>    previous approach didn't work with TCP mode (or --port-share).
>>  * Calculate the link-mtu sent in the options string based on the crypto
>>    parameters specified in the config file (prevents link-mtu warnings in
>>    older peers when connecting).
>>
>> v3:
>>  * Use existing max_int() function, instead of new MAX() macro.
>>  * Fix typo in comment.
>>  * Do not regenerate keys if the server sends a second push msg.
>>  * Only advertise IV_NCP=3D2 if we're a pull-client (and thus can do NCP=
).
> There might be surprises lurking here regarding explicitly configured
> --link-mtu, so this will need detailed testing in as many possible option
> variants as possible.
>
> "Logic wise" this looks reasonable to me, so I'm willing to give an ACK
> to v4
>
> "Memory wise", to address James' concerns, I do not see anything obvious
> where this would lead to memory leaks, given that it's mostly just moving
> code around that is run once before and afterwards.  I think we're going
> to waste a handful of bytes on the frame overhead (like, "100"-ish) and
> resulting maximum buffer size, but that seems impossible to avoid without
> much more intrusive changes.
>
>
ACK from me aswell. The few extra kilobyts of memory should really hurt
in my opinion as well.

Arne


