References: <1484297432-14435-1-git-send-email-chipitsine@...277...>
	<7dc75a19-451e-effa-503a-ac5b75a23bab@...515...>
	<ac93d2de-d56a-0ff9-b97a-a590923f5cf8@...2080...>
	<CAFHpkQEHRCveRiiBWscwLQ7U3UoJ+yY5_0Lx82UMc=f4ucwMbQ@...278...>
	<CAFHpkQFs5x_7MEH5gjieUsp=1f2SPdG9Fr6PeakgBGrSEPQC_Q@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <6256c846-ca60-be4f-7122-60465374a322@...515...>
Date: Mon, 30 Jan 2017 14:34:32 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQFs5x_7MEH5gjieUsp=1f2SPdG9Fr6PeakgBGrSEPQC_Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH] add PR template in order to simplify
 new developers cooperate properly if they open PR. discussed here:
 https://sourceforge.net/p/openvpn/mailman/message/35601310/
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

I agree with you on keeping the pull request template minimal and having=20
the more fine-grained information in Trac.

ACK.

On 30/01/2017 08:48, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> can we merge it ?
> @mattock ?
>
> 2017-01-21 13:47 GMT+05:00 =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...
> <mailto:chipitsine@...277...>>:
>
>
>
>     2017-01-21 0:24 GMT+05:00 David Sommerseth
>     <openvpn@...2080...
>     <mailto:openvpn@...2080...>>:
>
>         On 13/01/17 10:05, Samuli Sepp=C3=A4nen wrote:
>         > Il 13/01/2017 10:50, Ilya Shipitsin ha scritto:
>         >> ---
>         >>  .github/PULL_REQUEST_TEMPLATE.md | 8 ++++++++
>         >>  1 file changed, 8 insertions(+)
>         >>  create mode 100644 .github/PULL_REQUEST_TEMPLATE.md
>         >>
>         >> diff --git a/.github/PULL_REQUEST_TEMPLATE.md b/.github/PULL_R=
EQUEST_TEMPLATE.md
>         >> new file mode 100644
>         >> index 0000000..d0cfd7f
>         >> --- /dev/null
>         >> +++ b/.github/PULL_REQUEST_TEMPLATE.md
>         >> @@ -0,0 +1,8 @@
>         >> +# Thank you for your contribution
>         >> +
>         >> +You are welcome to open PR, but they are used for discussion =
only. All
>         >> +patches must eventually go to the openvpn-devel mailing list =
for review.
>         >> +For details, see these Wiki articles:
>         >> +
>         >> +* https://community.openvpn.net/openvpn/wiki/Contributing
>         <https://community.openvpn.net/openvpn/wiki/Contributing>
>         >> +* https://community.openvpn.net/openvpn/wiki/DeveloperDocumen=
tation <https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation>
>         >>
>         >
>         > Based on testing in the travis-openssl-test repository the temp=
late
>         > works as intended, so ACK on that part.
>         >
>         > Any comments on the text itself?
>
>         How does this work with branches?  Do we need to say that new
>         patches
>         should go into the master branch primarily, unless it is fixing
>         a bug or
>         another issue which is only relevant for specific release branche=
s?
>
>
>
>     we can put such information to
>
>     https://community.openvpn.net/openvpn/wiki/Contributing
>     <https://community.openvpn.net/openvpn/wiki/Contributing>
>     https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation
>     <https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation>
>
>
>     I would leave PR template skinny
>
>
>
>
>         --
>         kind regards,
>
>         David Sommerseth
>         OpenVPN Technologies, Inc
>
>
>
>


--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

