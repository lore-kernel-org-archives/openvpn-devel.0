MIME-Version: 1.0
In-Reply-To: <4746830.2MuuAeNMnA@...1526...>
References: <4F4CE4FE.3010009@...515...> <8191371.i5gkeDqFZM@...1526...>
	<CAOazyz0hEyD_ZaaJeNz25+8jkX-BNZHzXbs=umdyQv+T3ngk4Q@...278...>
	<4746830.2MuuAeNMnA@...1526...>
Date: Wed, 29 Feb 2012 16:21:46 +0200
Message-ID: <CAOazyz0qRcgWCEmHavO9L_hG8HVmEy5Tr=9dvZ4AVR25XUoyoA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Heiko Hund <heiko.hund@...1489...>
Cc: =?UTF-8?Q?Carsten_Kr=C3=BCger?= <C.Krueger@...448...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Wed, Feb 29, 2012 at 4:01 PM, Heiko Hund <heiko.hund@...1489...> wrote:
> On Wednesday 29 February 2012 13:45:49 Alon Bar-Lev wrote:
>> I don't understand you attitude, I am not trying to take anything from you,
>> and I don't think you can find anything in my record that had negative
>> impact on this (or any other) project. And I do know one or two things in
>> security and networking.
>
> I'm just trying to get a statement from you about the spotted complexity and
> how it can be reduced, but somehow there's still nothing coming from your
> direction.

And I trying to explain that complexity is derived by variants, at least:
1. Threat assessment and privatization.
2. User experience requirements.
3. Dependencies definition.
4. Desired complexity.
5. Maintenance and resource allocation.

Maybe (for this sake of argument) your solution is perfect, but what is
the cost? does it addresses the correct threats? If we reduce the
threats, can we provide simpler solutions with lower complexity and
resources?

These are important questions before you jump into implementation.

>> I only recommend the OpenVPN project manager to hold with this solution,
>> and manage a proper design process, there are people here who can help, if
>> the process is managed correctly.
>
> Alon, there is a process. It's just different from what you imagine it to be.
> If you're not keen to get on IRC then read the chat log that gets posted here
> the next day and comment on it. Comment and counter-propose on patches - as
> you do - and this project will go forward.

I disagree, open source project is not different than any other
software project.
when you reach to the point of writing code (hence patches), it is way
too late to
discuss requirements and design. And the emotional impact of rejecting people
work at this stage is huge, especially when these involves in great effort.

Also please keep in mind we are not being payed for openvpn, nor payed to keep
project alive, we donate our time and our experience.

If you force people to follow meetings, you may lose experience of people who
might be busy at that specific time in their day work.

Because of this a proper roadmap and design of significant changes should be
published and discussed over time, leveraging the overall experience of the
community.

Anyway, I am not managing this project, it is up to him to decide how
to progress.

However, OpenVPN is already very fat monolithic implementation that grow over
time with a lot of niche features, the code is so complex and
conditional that it
is almost impossible to maintain. It is about time to setup up a direction, and
maybe work toward modular approach first, solving the Windows major issues with
as minimal effort as possible for the time being.

Alon.

