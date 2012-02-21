Message-ID: <4F4368C0.5080602@...515...>
Date: Tue, 21 Feb 2012 11:49:52 +0200
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <CAOazyz08kLGKyq-Wcd1KTQ9akdQCAYPP9b1aMVne-b9TArMKDQ@...278...>
	<1329749121-24501-1-git-send-email-alon.barlev@...277...>
	<4F426F81.6040201@...1114...>
	<CAOazyz1DhzxPf3GS1dqhYKXSkL5NeSDy03z340VYibKWBKxPRQ@...278...>
	<4F42CB9E.8060207@...1114...>
	<CAOazyz1xoNbT+T2y8C+Y72e1oDt2ZYXs_-shoK3x8g-vw4ZXVQ@...278...>
In-Reply-To: <CAOazyz1xoNbT+T2y8C+Y72e1oDt2ZYXs_-shoK3x8g-vw4ZXVQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] windows: do not use X_OK as it is
	unsupported
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> On Tue, Feb 21, 2012 at 12:39 AM, David Sommerseth
> <openvpn.list@...1114...> wrote:
>> But remember that all your patches *will* go through review as for
>> everyone else in the community.  That means either *1)* patch reviews on
>> the mailing list, or *2)* reviewed through a sprint review in a
>> developers meeting on the IRC.  You are free to choose between which
>> approach fits you best.  But I will not accept patches into the tree
>> unless it has been clearly ACKed publicly.
> David,
>
> I see I wasted three days of work.
>
> You agreed that you have a problem "Huston we have a problem, the
> build process of OpenVPN causes maintenance overhead".
>
> Nobody in this community maintains the build system so it became so
> complex and none intuitive that it is unusable.
Agreed. I would very much like to see what the alternative is. I'm not
interested in details, but the whole. The goal is to have a buildsystem
that sucks less.
>
> You won't be able to review all my changes as it is a revolution not
> evolution, I warned you guys ahead! It will touch almost all the
> sources.
I don't think reviewing individual patches is very productive at this
point. It makes perfect sense for incremental, small changes that we
want to go to the repository right away. In this case I'd prefer to see
a working prototype of the new buildsystem and review it as whole. If it
fulfils the basic requirements[1] then we can comment on the details.
And then we can start moving the code to the official repository - no
need to do it right now.

Could you (the other devs) take a look at Alon's Git tree as a whole and
see what you think, without getting into details? I can take a look to
see how the MSVC build (w.o. the TAP-driver build) would integrate with it.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



[1] We have not clearly specified these, and we should a.s.a.p.

