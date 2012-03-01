Message-ID: <4F4F5260.2040807@...515...>
Date: Thu, 01 Mar 2012 12:41:36 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4F4CE4FE.3010009@...515...> <8191371.i5gkeDqFZM@...1526...>
	<CAOazyz0hEyD_ZaaJeNz25+8jkX-BNZHzXbs=umdyQv+T3ngk4Q@...278...>
	<4746830.2MuuAeNMnA@...1526...>
	<CAOazyz0qRcgWCEmHavO9L_hG8HVmEy5Tr=9dvZ4AVR25XUoyoA@...278...>
In-Reply-To: <CAOazyz0qRcgWCEmHavO9L_hG8HVmEy5Tr=9dvZ4AVR25XUoyoA@...278...>
Subject: [Openvpn-devel] Project management and direction (WAS: Re: OpenVPN
 2.3-alpha1 released)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: =?ISO-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Changing the topic line to something more descriptive. Hope nobody minds.
>>> I only recommend the OpenVPN project manager to hold with this solution,
>>> and manage a proper design process, there are people here who can help,=
 if
>>> the process is managed correctly.
>> Alon, there is a process. It's just different from what you imagine it t=
o be.
>> If you're not keen to get on IRC then read the chat log that gets posted=
 here
>> the next day and comment on it. Comment and counter-propose on patches -=
 as
>> you do - and this project will go forward.
> I disagree, open source project is not different than any other
> software project.
> when you reach to the point of writing code (hence patches), it is way
> too late to
> discuss requirements and design. And the emotional impact of rejecting pe=
ople
> work at this stage is huge, especially when these involves in great effor=
t.
I agree. That said, the same applies to the buildsystem work you did:
the requirements were vague and there was a lack of design discussion.
Therefore the emotional impact on other developers was identical.

So, in the future, we all should put our major new ideas on the table
(=3Dthis mailing list) to

a) figure out the requirements
b) discuss design

After this we can move on to the implementation more safely, without
excluding anyone. I think the early negative comments on some of your
buildsystem patches were indirectly caused by lack of a) and b). Or, in
other words, other developers did not see the big picture because it had
not been presented to them clearly.

Of course, there are occasions when this consensus-process gets us
nowhere due to arguing. In those cases  somebody just needs to move on
to implementation to prove the design. This should not happen often, and
never without a) and b).

> Also please keep in mind we are not being payed for openvpn, nor payed to=
 keep
> project alive, we donate our time and our experience.
>
> If you force people to follow meetings, you may lose experience of people=
 who
> might be busy at that specific time in their day work.
I also much prefer the mailing list for this reason. The original reason
for the IRC meetings was James: he simply didn't have time to read the
emails on openvpn-devel and we needed his advise on some things. The
problem with timezones and people not being able to attend was known
from the beginning, though. That's why the meetings had a specific process:

1) Preliminary topic list is sent to openvpn-devel ml
2) The actual meeting (fully open)
3) The meeting summary + complete chatlog is sent to openvpn-devel ml

The idea was to minimize the negative impact of the meetings as much as
possible. Also, we haven't had that many meetings in a long while:

<https://community.openvpn.net/openvpn/wiki/IrcMeetings>

The dangerous aspect of the IRC is it's more personal nature, and the
fact that it's far quicker to get feedback from there than from the
mailing list. The problem is that only a subset of developers and
community members hang out on the IRC. This is fine, as long as the
people on the mailing lists are not excluded from the discussion. This
is where we need to be really careful and not get too comfortable on the
IRC channel.
> Because of this a proper roadmap and design of significant changes should=
 be
> published and discussed over time, leveraging the overall experience of t=
he
> community.
Very good point, again I agree.

>
> Anyway, I am not managing this project, it is up to him to decide how
> to progress.
And the decisions should be made so that as few people are excluded as
possible.

>
> However, OpenVPN is already very fat monolithic implementation that grow =
over
> time with a lot of niche features, the code is so complex and
> conditional that it
> is almost impossible to maintain. It is about time to setup up a directio=
n, and
> maybe work toward modular approach first, solving the Windows major issue=
s with
> as minimal effort as possible for the time being.
This is probably long overdue, just as the buildsystem overhaul was.
Some plans for OpenVPN 3.0 were made a while ago:

<https://community.openvpn.net/openvpn/wiki/RoadMap>

We should probably reopen this discussion once 2.3 (final) is out.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


