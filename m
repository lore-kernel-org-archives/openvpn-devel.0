References: <CAFHpkQEqEqu4Pcy4-KfhGqLYW26HR-ydCZO0xeU9YP5ZZUiL-Q@...278...>
	<dec62c2a-7c92-bfcb-1949-48ae1eeadc44@...2080...>
	<CAFHpkQFd2iuv56YkdyMHsVya86MpDemm45uVO+8eEt+uLie33A@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <c7c905e0-8295-1a6d-400c-5e8ce73fc2ad@...515...>
Date: Fri, 13 Jan 2017 09:55:16 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQFd2iuv56YkdyMHsVya86MpDemm45uVO+8eEt+uLie33A@...278...>
Subject: Re: [Openvpn-devel] helping developers to collaborate properly
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Il 06/01/2017 18:06, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD ha scritto:
>
>
> 2017-01-06 15:52 GMT+03:00 David Sommerseth
> <openvpn@...2080...
> <mailto:openvpn@...2080...>>:
>
>     On 06/01/17 09:18, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=
=D1=86=D0=B8=D0=BD wrote:
>     > Hello,
>     >
>     > https://github.com/OpenVPN/openvpn/pull/77
>     <https://github.com/OpenVPN/openvpn/pull/77>
>     >
>     > I'm not sure about exact text (I need help from you),
>     > the idea behind those changes is to point developers who use regular
>     > github workflow to a proper procedures (maybe there're pages on wik=
i ?
>     > @mattock  ?)
>     >
>     > it will help to not lose PRs and will probably save time of current
>     > developers
>
>     Two questions:
>
>     1) Can you explain what those .github/ files does?
>
>
> those files are mark down templates for new PRs and new issues.
> when someone open new PR, he sees such a template
>
> https://github.com/blog/2111-issue-and-pull-request-templates
>

Having a ".github/PULL_REQUEST_TEMPLATE.md" makes sense. Have you tested=20
if ".github/PULL_REQUEST_TEMPLATE.rst" works as well? Rst is what we use=20
elsewhere.

As for the contents - what about this (in .rst syntax):

Thank you for your contribution
###############################

You are welcome to open PR, but they are used for discussion only. All=20
patches must eventually go to the openvpn-devel mailing list for review.=20
For details, see these Wiki articles:

* https://community.openvpn.net/openvpn/wiki/Contributing
* https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation

---

I updated the articles so that they don't contradict what the above=20
PULL_REQUEST_TEMPLATE.rst would say.


--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

