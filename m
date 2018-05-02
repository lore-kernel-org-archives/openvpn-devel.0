From: Jon Kunkee <jkunkee@...2393...>
Date: Wed, 2 May 2018 23:55:30 +0000
Message-ID: <DM5PR21MB01856478CE8839E44C23BE7BB0800@...2394...>
References: <DM5PR21MB0185FC110A99E76426A1603FB08D0@...2394...>
 <9fb8c0a0-b1d1-2834-dd42-d0abece8529e@...515...>
In-Reply-To: <9fb8c0a0-b1d1-2834-dd42-d0abece8529e@...515...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN on ARM64 Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: Marc Sweetgall <marcs@...2393...>


First, apologies to all those using PINE and similar. Outlook doesn't know =
what
linebreaks or columns are, so I'm stuck compensating with Notepad++. :/


>From: Samuli Sepp=E4nen <samuli@...515...>=20
>Sent: 04/29/2018 5:27 AM
>
>Hi and welcome!

Thank you!


>> Appveyor will need to be updated to handle the environment and output ch=
anges;
>> I'm happy to explain what's needed, but I have no previous experience wi=
th the
>> service.
>
>Ilya may be able to help you with that: he has written all our AppVeyor
>integrations so far.

I'm tweaking my changes so setting up the build environment is a matter of
mounting the WDK ISO and tweaking paths.py. Hopefully that helps.


>I'm very interested in seeing and testing these changes. I think porting
>the buildsystem to a newer SDK would be a good candidate for a PR.

>> Along with the SDK changes, the build script needed many changes to add a
>> third architecture (ARM64).
>
>These changes would make another PR.

>One final note on PRs/patches: keep them as small and atomic as possible
>and they will be easy to review and marge. Just like you did with your
>first PR :).

I think I see a pattern here, and I like it. :)

This PR contains several simple commits:
https://github.com/OpenVPN/tap-windows6/pull/52

Would that be better as several PRs (except the two commits that overlap)?

With this groundwork laid, here's my PR plan:
 * change the build system version
 * move to a newer NDIS version
 * build for ARM64
 * pack ARM64 in the installer

Each of these would be a sequence of fairly small, concise commits to aid r=
eview.

Thanks,
Jon


