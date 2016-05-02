MIME-Version: 1.0
In-Reply-To: <5727056E.1000701@...515...>
References: <CAFHpkQENgyAaaWCsWOS1vj+9YR=Cc65muXmsYfmcKc8n09BkPQ@...278...>
	<5727056E.1000701@...515...>
From: Steffan Karger <steffan@...1856...>
Date: Mon, 2 May 2016 09:54:42 +0200
Message-ID: <CAA1Abx+hbUT6ZpdeCrYVEiRdQ+awA7woZyTm7DD=Lv8OyPDQ2Q@...278...>
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
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Mon, May 2, 2016 at 9:44 AM, Samuli Sepp=C3=A4nen <samuli@...515...> wro=
te:
>
>> 1) add travis-ci support (there are few tests in "t" and we can run
>> cppcheck)
>
> I assume cppcheck produces the same results regardless of the
> OS/distribution it is running on. If this is the case, then we should
> add cppcheck tests to Travis-CI.

Yes, I think this makes sense.  As a first step, someone could review
my patch from December to enable travis-ci on our repo:

https://sourceforge.net/p/openvpn/mailman/message/34709650/

-Steffan

