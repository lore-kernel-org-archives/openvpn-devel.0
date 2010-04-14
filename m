MIME-Version: 1.0
In-Reply-To: <4BC580D8.5040304@...515...>
References: <1269951178-30419-1-git-send-email-dazo@...384...>
	<4BBE3205.1040303@...1114...>
	<p2w9e0cf0bf1004100005u819d4b3l97c269272e2604ab@...278...>
	<4BC47655.10101@...1114...>
	<t2o9e0cf0bf1004130659l5c4a8dc2o6eab22db336078be@...278...>
	<4BC580D8.5040304@...515...>
Date: Wed, 14 Apr 2010 12:06:16 +0300
Message-ID: <t2x9e0cf0bf1004140206le76279b1wfacc47a227ddce2f@...278...>
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
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

2010/4/14 Samuli Sepp=C3=A4nen <samuli@...515...>:
>
>> First of all, let's bring in the history. =C2=A0This feature was discuss=
ed in
>> the weekly meeting February 26, 2010. =C2=A0See the chat log at [1], aro=
und
>> the time stamp 20:45:15.
>>
>> > David, IRC is not a development tool, it is sync tool that require all
>> > to be available at the same time, which is never the case. I don't
>> > understand why you took this approach, but its down-side is that
>> > people discover such commits later on.
>>
> There are several good reasons why we do use IRC as a development tool.
> First, it's the best/only available way to get James' input into
> "testing" development. Second, many patches have fail to receive an
> ACK/NACK or even any comments in the mailing list discussions. It's this
> kind of patches which are discussed in the meetings and more often than
> not we've managed to get an ACK/NACK for them.
>
> As you say, there are problems with using IRC as a development tool,
> timezones being one big problem. That's why after every meeting I send a
> summary to openvpn-devel which documents every single patch ACK/NACK. A
> full chatlog is also attached to this mail. To make sure the summaries &
> chatlogs don't get lost in mailing list archives, they are also linked
> to from here:
>
> http://www.secure-computing.net/wiki/index.php/OpenVPN/IRC_meetings
>
> The preliminary meeting agenda / topic list is also visible prior the
> meeting so that people can choose whether to attend or not (if they can).
>
> However, I think there's definitely room for improvement. IRC is
> addictive, because it allows making decisions fast and easily. The
> downside is that not all people can attend the meetings and are thus
> unable to affect their outcome or provide valuable feedback. What we
> need to avoid is creating two classes of developers: those who can
> attend the IRC (and make the decisions) and those who can't (and don't
> decide).
>
> As a concrete measure I suggest that patches ACK'd in IRC meetings
> should not be merged until, say, Monday. That way people can review the
> chatlog and if they don't like what they see, they can provide their
> comments. I think that we should from now on "propose" rather than
> "decide" to include patches based on IRC discussions. Otherwise people
> might get the wrong impression that we don't want/need further comments.
> I also suggest that we really focus on using IRC only when the mailing
> list discussions have led nowhere, not just for it's convenience.
>
> What do you think?

I think that using IRC is much too chatty to begin with. Async
communication is much complete and atomic.

Also, your summary contains so much unrelated issues that it is harder to t=
rack.

Proper mailing list management proved themselves for a long time, the
LKML is a good example of such.

However, if you truly want to manage the change sets, install bugzilla
[or any other *DECENT* tracker except trac], and follow change request
from submittion to release.

This way you can track the full history of a single change, and not
follow several meeting logs, mail messages and other means of
discussion.

All relevant people [weather decision making or interest] may be CCed,
also the devel mailing list can be CCed so outsider can track the
status of changes.

Managing software is a complex task, the IRC session you conducting
does not make it more organize/simpler/complete.

Regards,
Alon.

