MIME-Version: 1.0
In-Reply-To: <4F4519E2.8000108@...1114...>
References: <CAOazyz21EEqHhEabEY_L-ve5JFnuZoE8fgqLVJjEYTjfpBSq9w@...278...>
	<7281371.PNMm8PBGWv@...1526...> <4F4519E2.8000108@...1114...>
Date: Wed, 22 Feb 2012 18:40:37 +0200
Message-ID: <CAOazyz0AnK+q2bqp2nZ5iLYg3_NAbv_8ZXh09PdCQCVJyBemvg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [RFC][windows] gettimeofday()
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
Cc: James Yonan <james@...515...>, openvpn-devel@lists.sourceforge.net

On Wed, Feb 22, 2012 at 6:37 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 22/02/12 17:27, Heiko Hund wrote:
>> On Wednesday 22 February 2012 16:12:24 Alon Bar-Lev wrote:
>>> In windows there is own implementation of gettimeofday(). In the
>>> past there was no gettimeofday(), so we used performance counters,
>>> then James optimize it to reduce CPU consumption.
>>>
>>> Unlike in the past, mingw does provide this function these days. The
>>> question is if it is good enough.
>>
>> Since there's no gettimeofday() in MSVC this will break building with
>> the python build system. Not sure if we're in the process of getting
>> rid of it, which I would welcome, so this is just for additional
>> information.
>
> That's a valid point ... But it makes me think. =C2=A0What about to put J=
ames'
> old code in compat.[ch] for platforms without gettimeofday. =C2=A0Would t=
hat
> be an appropriate middle-road?
>
> I too would like to see MSVC go away. =C2=A0Very much. =C2=A0But again, l=
et's not
> decide that without James approval for it.

Again,
There is nothing written about not supporting the proprietary gettimeofday
implementation in MSVC.
What exactly is the problem?
You compile on *NIX you get system gettimeofday.
You compile on mingw you get library gettimeofday.
You compile on msvc you get own implementation.

Wasn't I clear?

Alon.

