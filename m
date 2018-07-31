Reply-To: openvpn-devel@lists.sourceforge.net
References: <1516833453-18991-1-git-send-email-selva.nair@...277...>
 <1532486093-24793-1-git-send-email-selva.nair@...277...>
 <20180729193400.GX55859@...1296...>
 <CAKuzo_hSzz=bqMCuYBMoUOTn1uruXN-KcGA9nCbu89Xm9UBe-Q@...278...>
 <53a5faf4-3b97-6b11-f68f-87c64b276334@...2181...>
 <CAKuzo_i1XLeB9AZE=H4kc9x8iOThhz1R8GpDQRv-ktRWHoHeDg@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <c31e5025-4a26-fdca-3227-0141267ff2a2@...2080...>
Date: Tue, 31 Jul 2018 09:07:27 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_i1XLeB9AZE=H4kc9x8iOThhz1R8GpDQRv-ktRWHoHeDg@...278...>
Content-Language: en-GB
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>, Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 30/07/18 16:58, Selva Nair wrote:
> Hi,
> 
> On Mon, Jul 30, 2018 at 10:31 AM, Antonio Quartulli <a@...2181...> wrote:
>> Hi,
>>
>> On 30/07/18 04:16, Selva Nair wrote:
>>> Yes that's the base64 patch. What is stopping it is not the
>>> disagreement on that patch but an "error" [*] in the plugin header
>>> that I had discovered.  David wants to fix that before this one, but
>>> it seems he is too busy with other things.
>>>
>>> And there is a pending patch to fix that :
>>> https://patchwork.openvpn.net/patch/87/
>>>
>>
>> [CUT]
>>
>>
>>>
>>> [*] A function signature uses a pointer to an opaque handle (a void *)
>>> while it should be just the handle. It generates no warning as it is
>>> void * vs void ** and all existing codes out there must be correctly
>>> passing the pointer (handle) ignoring the signature in the header --
>>> else they wont work. I wanted the header to be fixed and David seems
>>> to agree with that.
>>>
>>
>> I remember discussing this patch with David as well and the general
>> feeling was that the patch was correct.
>>
>> Maybe David wanted to spend some more time on this patch, but it slipped
>> off the plate.
>>
>> As Selva said, if users of that function were following the header they
>> would see a lot of explosions, while this is not the case.
>> Therefore it should be happily applied with no risk.
> 
> Antonio, thanks for recalling your discussion and for the reassurance.
> 
> My description of this in the previous mail was not entirely correct:
> it has been a long time, and I was a bit rusty on the details -- the
> pointer in question is a member of "struct openvpn_plugin_args_open_return"
> where its wrongly declared.
> 


Hi all, and sorry for letting this one (with many others) fall through the
cracks.  And quickly responding from a holiday now (planning to be mostly
disconnected until mid-August; first real holiday in 2 years now).  I remember
patch was fine but never got around to fix the header file.

So if we get the header file fixed,  all should be good for getting the base64
stuff added; including this patch.  I have only glared at the code quickly of
this last v3 patch, so it just needs to be well tested before we add it to git
master.

Next cool thing to get added would be dynamic challenge, but that will require
quite some extensions in the plug-in API as well.  Use case: systems which
uses sssd to do the authentication via PAM, where OTP may or may not be
activated for some user accounts - or temporarily disabled if the backend sssd
depends on is unavailable (where sssd can do a local off-line password auth only).


-- 
kind regards,

David Sommerseth
OpenVPN Inc


