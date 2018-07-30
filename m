MIME-Version: 1.0
In-Reply-To: <53a5faf4-3b97-6b11-f68f-87c64b276334@...2181...>
References: <1516833453-18991-1-git-send-email-selva.nair@...277...>
 <1532486093-24793-1-git-send-email-selva.nair@...277...>
 <20180729193400.GX55859@...1296...>
 <CAKuzo_hSzz=bqMCuYBMoUOTn1uruXN-KcGA9nCbu89Xm9UBe-Q@...278...>
 <53a5faf4-3b97-6b11-f68f-87c64b276334@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 30 Jul 2018 10:58:31 -0400
Message-ID: <CAKuzo_i1XLeB9AZE=H4kc9x8iOThhz1R8GpDQRv-ktRWHoHeDg@...278...>
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
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Mon, Jul 30, 2018 at 10:31 AM, Antonio Quartulli <a@...2181...> wrote:
> Hi,
>
> On 30/07/18 04:16, Selva Nair wrote:
>> Yes that's the base64 patch. What is stopping it is not the
>> disagreement on that patch but an "error" [*] in the plugin header
>> that I had discovered.  David wants to fix that before this one, but
>> it seems he is too busy with other things.
>>
>> And there is a pending patch to fix that :
>> https://patchwork.openvpn.net/patch/87/
>>
>
> [CUT]
>
>
>>
>> [*] A function signature uses a pointer to an opaque handle (a void *)
>> while it should be just the handle. It generates no warning as it is
>> void * vs void ** and all existing codes out there must be correctly
>> passing the pointer (handle) ignoring the signature in the header --
>> else they wont work. I wanted the header to be fixed and David seems
>> to agree with that.
>>
>
> I remember discussing this patch with David as well and the general
> feeling was that the patch was correct.
>
> Maybe David wanted to spend some more time on this patch, but it slipped
> off the plate.
>
> As Selva said, if users of that function were following the header they
> would see a lot of explosions, while this is not the case.
> Therefore it should be happily applied with no risk.

Antonio, thanks for recalling your discussion and for the reassurance.

My description of this in the previous mail was not entirely correct:
it has been a long time, and I was a bit rusty on the details -- the
pointer in question is a member of "struct openvpn_plugin_args_open_return"
where its wrongly declared.

Selva

