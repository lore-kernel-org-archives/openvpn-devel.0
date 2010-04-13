MIME-Version: 1.0
In-Reply-To: <4BC47655.10101@...1114...>
References: <1269951178-30419-1-git-send-email-dazo@...384...>
	<4BBE3205.1040303@...1114...>
	<p2w9e0cf0bf1004100005u819d4b3l97c269272e2604ab@...278...>
	<4BC47655.10101@...1114...>
Date: Tue, 13 Apr 2010 16:59:10 +0300
Message-ID: <t2o9e0cf0bf1004130659l5c4a8dc2o6eab22db336078be@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Add comile time settings from
	./configure information to --version
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, Apr 13, 2010 at 4:49 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 10/04/10 09:05, Alon Bar-Lev wrote:
>> Highly none standard autotools usage.
>> Also requires awk which may not be available.
>> Please REVERT.
>
> First of all, let's bring in the history. =C2=A0This feature was discusse=
d in
> the weekly meeting February 26, 2010. =C2=A0See the chat log at [1], arou=
nd
> the time stamp 20:45:15.

David, IRC is not a development tool, it is sync tool that require all
to be available at the same time, which is never the case. I don't
understand why you took this approach, but its down-side is that
people discover such commits later on.

> This patch-set provides one way of doing this, and it is a requested
> feature. =C2=A0There are probably several ways how to solve this, this is=
 one
> way - and it might not be the best way. =C2=A0However, it is what we got
> right now.

But the knowledge of autotools is not at your disposal.

> Alon, with all respect, it is great getting feedbacks to submitted
> patches, even REVERT suggestions. =C2=A0Could you perhaps share some thou=
ghts
> about how to solve it, instead of just rejecting it?

I did.
I sent you an example of how we solve it in OpenSC and Suspend.

http://www.opensc-project.org/opensc/browser/trunk/configure.ac#L613

autoconf log was NEVER intended to be used as programming interface,
and is far than being stable.

> For now, this patch-set is only in feat_misc branch. =C2=A0I've halted the
> merge into allmerged for now. =C2=A0But unless we can get a better soluti=
on
> (meaning: new patches with enhancements) to this feature within
> reasonable time, this is how it will look like. =C2=A0The initial patch is
> already ready and accepted. =C2=A0I am willing to drop using awk or whate=
ver
> else, as long as we do get this feature. =C2=A0How the feature is impleme=
nted
> is less important.
>
> But this feature will be important for us when we begin to receive
> feedbacks on the openvpn-testing version.

I understand the need, but reject the miss-use of autoconf resources.
In order to be compatible with as many environment as you can, you
cannot use hacks and undocumented approaches.

>
>
> kind regards,
>
> David Sommerseth
>
>
> [1] <http://thread.gmane.org/gmane.network.openvpn.devel/3143>
>
>
>> On Thu, Apr 8, 2010 at 10:44 PM, David Sommerseth
>> <openvpn.list@...1114...> wrote:
>> On 30/03/10 14:12, David Sommerseth wrote:
>>>>> This patch will create ./configure.h which will contain two new #defi=
ne
>>>>> strings. =C2=A0CONFIGURE_DEFINES will contain all USE, ENABLED, DISAB=
LED and
>>>>> DEPRECATED defines from ./config.h. =C2=A0CONFIGURE_CALL will contain=
 the
>>>>> complete ./configure line which was used when configuring the package
>>>>> for building.
>>>>>
>>>>> Signed-off-by: David Sommerseth <dazo@...384...>
>>>>> ---
>>>>> =C2=A0Makefile.am =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A07 +++++++
>>>>> =C2=A0configure_h.awk =C2=A0 | =C2=A0 39 ++++++++++++++++++++++++++++=
+++++++++++
>>>>> =C2=A0configure_log.awk | =C2=A0 36 +++++++++++++++++++++++++++++++++=
+++
>>>>> =C2=A0options.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A03 +++
>>>>> =C2=A04 files changed, 85 insertions(+), 0 deletions(-)
>>>>> =C2=A0create mode 100644 configure_h.awk
>>>>> =C2=A0create mode 100644 configure_log.awk
>>
>> Applied to the openvpn-testing.git feat_misc branch. =C2=A0To be merged =
into
>> allmerged soon.
>> Commit f27bf509315a48b0070294c3993a718df0c2626c
>>
>>
>> kind regards,
>>
>> David Sommerseth
>>>
> -
> -------------------------------------------------------------------------=
-----
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAkvEdlIACgkQDC186MBRfrrimwCfYMO4m2CuY1KPNkLAtHFqL+pr
> dqYAn3T0jEowiV9NQZ+8H3onrH+JFb1B
> =3DqAhn
> -----END PGP SIGNATURE-----
>

