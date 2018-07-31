MIME-Version: 1.0
In-Reply-To: <c31e5025-4a26-fdca-3227-0141267ff2a2@...2080...>
References: <1516833453-18991-1-git-send-email-selva.nair@...277...>
 <1532486093-24793-1-git-send-email-selva.nair@...277...>
 <20180729193400.GX55859@...1296...>
 <CAKuzo_hSzz=bqMCuYBMoUOTn1uruXN-KcGA9nCbu89Xm9UBe-Q@...278...>
 <53a5faf4-3b97-6b11-f68f-87c64b276334@...2181...>
 <CAKuzo_i1XLeB9AZE=H4kc9x8iOThhz1R8GpDQRv-ktRWHoHeDg@...278...>
 <c31e5025-4a26-fdca-3227-0141267ff2a2@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 31 Jul 2018 10:07:51 -0400
Message-ID: <CAKuzo_hUVE90w9K2EciSKWBjbcQ99fEa9QG2ghjnfd63Nob5oQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] Parse static challenge response in
 auth-pam plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Cc: Antonio Quartulli <a@...2181...>, Gert Doering <gert@...1296...>

HI

On Tue, Jul 31, 2018 at 3:07 AM, David Sommerseth
<openvpn@...2080...> wrote:
> On 30/07/18 16:58, Selva Nair wrote:
>> Hi,
>>
>> On Mon, Jul 30, 2018 at 10:31 AM, Antonio Quartulli <a@...2181...> wrote:
>>> Hi,
>>>
>>> On 30/07/18 04:16, Selva Nair wrote:
>>>> Yes that's the base64 patch. What is stopping it is not the
>>>> disagreement on that patch but an "error" [*] in the plugin header
>>>> that I had discovered.  David wants to fix that before this one, but
>>>> it seems he is too busy with other things.
>>>>

snip

>>> I remember discussing this patch with David as well and the general
>>> feeling was that the patch was correct.
>>>
>>> Maybe David wanted to spend some more time on this patch, but it slipped
>>> off the plate.
>>>
>>> As Selva said, if users of that function were following the header they
>>> would see a lot of explosions, while this is not the case.
>>> Therefore it should be happily applied with no risk.
>>
>> Antonio, thanks for recalling your discussion and for the reassurance.
>>

snip

>
> Hi all, and sorry for letting this one (with many others) fall through the
> cracks.  And quickly responding from a holiday now (planning to be mostly
> disconnected until mid-August; first real holiday in 2 years now).  I remember
> patch was fine but never got around to fix the header file.

Agreed :)

The header patch is short and benign, and it seems more than a couple
of pairs of
eyes have viewed and "approved" it. So can we get an ACK?

Here is a link to the patch.
https://patchwork.openvpn.net/patch/87/

Once this is accepted, the rest should be straightforward.

> Next cool thing to get added would be dynamic challenge, but that will require
> quite some extensions in the plug-in API as well.

What is stopping this is really the same old problem with sending an AUTH_FAILED
reason back to the client -- once that is solved easy to support this
with minimal
changes to the plugin code.

I have some ideas on how to solve the former without too much
refactoring, but let's
get the static challenge support in first.

Thanks,

Selva

