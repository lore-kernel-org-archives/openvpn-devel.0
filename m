Message-ID: <119569a0-0fc9-44dd-aba9-28b5efa46a88@...2108...>
Date: Thu, 7 May 2026 20:41:24 +0200
MIME-Version: 1.0
References: <mzoefoeqRopySw9np2VgZ1sGVs9t8K_MOTi9xy0z8evXtTPgWY75aoy-XNxqWC14hcuup_X-pBCpZgmV2EoHb8D4xWrlVgEQhlSZLcSKmzI=@azban.net>
 <ca21397d-7f5f-48b7-8cb8-1ed4e2f470d8@...2108...>
 <3Q9tY6l2SmzxQ3cupgD4SA1UZAB3QufxmaDNsOT6_V78VeT8vESuIPKhp-Wzheb5Bk742gGPowisW0qGP5cypA==@protonmail.internalid>
 <x46zXQGfuTbX-37bUoQQgU9EVf1uYwGYHu8I7-bfKot66v3F3P8m4dUFBEywiGPIYXvrCa3ogtKspp-ksTmmpeS-Cy_oMHHsvEgMFNmBWNA=@azban.net>
From: David Sommerseth <dazo+openvpn@...2108...>
Content-Language: en-US
In-Reply-To: <x46zXQGfuTbX-37bUoQQgU9EVf1uYwGYHu8I7-bfKot66v3F3P8m4dUFBEywiGPIYXvrCa3ogtKspp-ksTmmpeS-Cy_oMHHsvEgMFNmBWNA=@azban.net>
Subject: Re: [Openvpn-devel] [PATCH] handle result from
 DcoKeyConfig_ParseFromString
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: azban <me@...3015...>
Cc: openvpn-devel <Openvpn-devel@lists.sourceforge.net>

On 07/05/2026 17:48, azban wrote:
> Awesome, thanks. Can you let me know how things were mangled so I can improve next time?

Lines seemed to be wrapped, leading white-spaces was most likely
ignored; all the lines was pulled all the way to the left; including the
line which was being removed.  All the kind of stuff GUI mail clients
are pretty good at mangling.

Also, please run clang-format on the changed files before committing
them.  That way you're also sure the formatting is according to the
project standards.  The clang-format configuration is already in the git
repository.

> Also, is there a better way to interact with the list to get something like this reviewed?

In the OpenVPN projects, we prefer to have final patches ending up on
the mailing lists.  These mailing lists are distributed across the
Internet and is not bound to the availability of a single service.

If possible, I would recommend you to set up git send-email; that will
enable git to send the mail directly to an SMTP server and the mangling
is far less likely to happen.

For the OpenVPN 3 Linux project, I could be open to test out Radicle [1]
and the 'patch' feature there [2]; as that is also a decentralised and
distributed approach.  But it's too early now to say if that can or will
replace the mailing list.  It needs to be tested out properly over time.
 And so far, there has been fairly few regular contributors to the
OpenVPN 3 Linux project (even though, it is slowly improving).  But if
you have time an interest to contribute more, that would of course be
lovely!

So to wrap it up: We want to ensure that the development progress
history is not lost for the future.  And that means we don't trust a
single centralised service to be available for eternity - hence
distributed and decentralised storage is preferred.


[1] <https://radicle.dev/>
[2] <https://radicle.dev/guides/user#working-with-patches>


-- 
kind regards,

David Sommerseth
OpenVPN Inc

> -------- Original Message --------
> On Thursday, 05/07/26 at 09:08 David Sommerseth <dazo+openvpn@...2108...> wrote:
> On 22/03/2026 08:19, azban wrote:
>> This previously warned with unused-result, which fails compilation
>> if you are building with warnings as errors. This checks the result
>> and throws an exception if the parsing fails.
>>
>> Signed-off-by: azban <me@...3015...>
>>
>> ---
>> src/netcfg/netcfg-dco.cpp | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Hi,
> 
> Thanks a lot for your patch.  Sorry it took time to resolve this.  I've
> just pushed out an git master branch to all the repositories which
> includes this fix and a lot of other issues related to building
> OpenVPN 3 Linux.
> 
> <https://codeberg.org/OpenVPN/openvpn3-linux/commit/18f19569ce2da673b786c848fe6222ffae1809b6>
> 
> I had to redo the patch, as the patch had been sufficiently mangled on
> the way to the mailing list.  But you're credited in the commit,
> together with other reporters of the same issue.
> 
> Current git master commit b8ac395171e6354aa2d27875b76ed9cbc44b99cd
> Codeberg: <https://codeberg.org/OpenVPN/openvpn3-linux/src/branch/master>
> Radicle: rad:zN58oopqzrAkTregNZaRQpgg7x3c
> Radicle: <https://radicle.network/nodes/iris.radicle.xyz/rad:zN58oopqzrAkTregNZaRQpgg7x3c>
> GitLab: <https://gitlab.com/openvpn/openvpn3-linux/>
> GitHub: <https://github.com/OpenVPN/openvpn3-linux/>



