MIME-Version: 1.0
In-Reply-To: <CAFHpkQFxYTwQhaSENzVQwuQCZLHvGWemh0Hdxtb9MmvQBeCEAA@...278...>
References: <CAFHpkQENgyAaaWCsWOS1vj+9YR=Cc65muXmsYfmcKc8n09BkPQ@...278...>
	<5727056E.1000701@...515...>
	<CAA1Abx+hbUT6ZpdeCrYVEiRdQ+awA7woZyTm7DD=Lv8OyPDQ2Q@...278...>
	<572716F5.5010909@...515...>
	<CAFHpkQFxYTwQhaSENzVQwuQCZLHvGWemh0Hdxtb9MmvQBeCEAA@...278...>
From: Steffan Karger <steffan@...1856...>
Date: Mon, 2 May 2016 13:33:21 +0200
Message-ID: <CAA1AbxKZrc7W8_an_-G3_BQdjPeTmOR5ORdCes9t46af9knu9A@...278...>
Subject: Re: [Openvpn-devel] CI for openvpn
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
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

HI,

On Mon, May 2, 2016 at 11:38 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:
> it is already running at "coverity_scan" branch:
> https://travis-ci.org/OpenVPN/openvpn/builds/120718429
>
> so, it definitely good

Well, "it seems to work" is one thing, but a review should also cover
whether some change or addition is doing the right thing and doing it
the right way.  Given your remark below, it seems that you just did
that.  So thanks for that.

> however, I would add (to make build running on ubuntu trusty)
>
> sudo: required
> dist: trusty

Running on Trusty would be nicer indeed (more recent compilers and
tools), but the Trusty environment is still in Beta. I'd suggest to
switch once travis-ci removes the 'beta' label.

(As a side note, please don't top-post in mailinglist conversations.)

-Steffan

