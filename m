MIME-Version: 1.0
In-Reply-To: <4F42CB9E.8060207@...1114...>
References: <CAOazyz08kLGKyq-Wcd1KTQ9akdQCAYPP9b1aMVne-b9TArMKDQ@...278...>
	<1329749121-24501-1-git-send-email-alon.barlev@...277...>
	<4F426F81.6040201@...1114...>
	<CAOazyz1DhzxPf3GS1dqhYKXSkL5NeSDy03z340VYibKWBKxPRQ@...278...>
	<4F42CB9E.8060207@...1114...>
Date: Tue, 21 Feb 2012 00:47:22 +0200
Message-ID: <CAOazyz1xoNbT+T2y8C+Y72e1oDt2ZYXs_-shoK3x8g-vw4ZXVQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, Feb 21, 2012 at 12:39 AM, David Sommerseth
<openvpn.list@...1114...> wrote:
> But remember that all your patches *will* go through review as for
> everyone else in the community. =C2=A0That means either *1)* patch review=
s on
> the mailing list, or *2)* reviewed through a sprint review in a
> developers meeting on the IRC. =C2=A0You are free to choose between which
> approach fits you best. =C2=A0But I will not accept patches into the tree
> unless it has been clearly ACKed publicly.

David,

I see I wasted three days of work.

You agreed that you have a problem "Huston we have a problem, the
build process of OpenVPN causes maintenance overhead".

Nobody in this community maintains the build system so it became so
complex and none intuitive that it is unusable.

You won't be able to review all my changes as it is a revolution not
evolution, I warned you guys ahead! It will touch almost all the
sources.

What I actually do is merge all environment into one single build
environment. So not overriding constant of different environment *IS*
important.

I just may stop now working.

Please start go over my patches in github[1] and mark your comments,
this way we know if it was a total waste of time.

Alon.

[1] https://github.com/alonbl/openvpn

