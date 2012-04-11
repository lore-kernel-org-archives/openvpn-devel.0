Message-ID: <4F85B343.6090207@...515...>
Date: Wed, 11 Apr 2012 19:37:23 +0300
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <4F7DA7EF.1010709@...515...>
	<CAOazyz2K0RDYv-zgVt+FUb9Egwykj0Aft9KvxUuQoF0WEf=xKw@...278...>
In-Reply-To: <CAOazyz2K0RDYv-zgVt+FUb9Egwykj0Aft9KvxUuQoF0WEf=xKw@...278...>
Subject: Re: [Openvpn-devel] ACK system review finished
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
Cc: James Yonan <james@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi all,
> My personal feeling based is that we should probably focus the ACK
> system to high-risk patches, e.g.
>
> - patches touching critical parts of the code (rationale: better safe
> than sorry)
> - patches from new contributors (rationale: fix stylistic issues and
> errors, ensure usefulness, educate)
I might add that James wanted to mandate a review on all patches - or at
least those that have capability to create security issues. That said,
we could probably use a  "experimental/testing" tree to host
patches/patchsets that make sense, but have not yet been properly
reviewed. This would have a couple of nice benefits compared to working
with stable master + external trees/patches:

- We could (easily) run build/connectivity tests against this
"experimental" tree using our build farm
- We could build snapshot binary packages based on this tree, and
publish them using apt/yum/website

This would allow patches to be reviewed by developers_and_ (easily)
tested by users at the same time.  The stable tree would still be the
basis for official releases, and would pull stuff from "experimental" as
it matures.

Does this make sense?
>>
>> Question3: When patch series is merged into tree?
>>
>> General note: In no way do I see the fast responsive of
>> submit-ack-commit a goal! It can take week or a month, depending on
>> need/complexity/quality. The goal is to merge mature patchsets that we
>> feel comfortable with.
If it takes time for the patchset to be polished, that's fine. However,
if improving patch throughput helps making releases more often, I think
it's worth the effort; most people will be running the latest stable, so
getting the code to that phase a.s.a.p. helps to get the bugs ironed out.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


