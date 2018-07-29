MIME-Version: 1.0
In-Reply-To: <20180729193400.GX55859@...1296...>
References: <1516833453-18991-1-git-send-email-selva.nair@...277...>
 <1532486093-24793-1-git-send-email-selva.nair@...277...>
 <20180729193400.GX55859@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 29 Jul 2018 16:16:00 -0400
Message-ID: <CAKuzo_hSzz=bqMCuYBMoUOTn1uruXN-KcGA9nCbu89Xm9UBe-Q@...278...>
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Sun, Jul 29, 2018 at 3:34 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Tue, Jul 24, 2018 at 10:34:53PM -0400, selva.nair@...277... wrote:
>> From: Selva Nair <selva.nair@...277...>
>>
>> If static challenge is in use, the password passed to the plugin by openvpn
>> is of the form "SCRV1:base64-pass:base64-response". Parse this string to
>> separate it into password and response and use them to respond to queries
>> in the pam conversation function.
>>
>> On the plugin parameters line the substitution keyword for the static
>> challenge response is "OTP". For example, for pam config named "test" that
>> prompts for "user", "password" and "pin", use
>>
>> plugin openvpn-auth-pam.so "test user USERNAME password PASSWORD pin OTP"
>>
>> Signed-off-by: Selva Nair <selva.nair@...277...>
>>
>> ---
>> v2: Depends on the base64 export patch
>> v3: match password string with "SCRV1:" instead of "SCRV1"
>> (pch ointed out by Joe Bell <joeaintexas@...277...>)
>
> I'm a bit confused about the prerequisites for this - if I found the
> right "base64 export patch", this is still pending some reworking
> because you and David disagreed on details, and then David got sucked
> into "Client for OpenVPN 3 on Linux" and had no time working on the
> plugin API for v2.x anymore.

Yes that's the base64 patch. What is stopping it is not the
disagreement on that patch but an "error" [*] in the plugin header
that I had discovered.  David wants to fix that before this one, but
it seems he is too busy with other things.

And there is a pending patch to fix that :
https://patchwork.openvpn.net/patch/87/

Actually we can get base64 export merged without "fixing" the API
(header) as the only place it is referred to in David's patch is in
the accompanying sample that shows how to use the exported function.

If David is okay with it I can volunteer to split his patch into two
and get the base64 export merged sooner as its generally useful.

Selva

[*] A function signature uses a pointer to an opaque handle (a void *)
while it should be just the handle. It generates no warning as it is
void * vs void ** and all existing codes out there must be correctly
passing the pointer (handle) ignoring the signature in the header --
else they wont work. I wanted the header to be fixed and David seems
to agree with that.

