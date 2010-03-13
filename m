References: <9e0cf0bf1003100919l307a653er7c619b5f2fc97dc@...278...>
	<1268242750.8679.0@...1207...>
	<9e0cf0bf1003100941y30780002qcd62ca2d9e9355f2@...278...>
	<1268243841.8679.2@...1207...>
Date: Sun, 14 Mar 2010 00:34:19 +0100
MIME-Version: 1.0
From: "Matthias Andree" <matthias.andree@...68...>
Message-ID: <op.u9i43hqp1e62zd@...1326...>
In-Reply-To: <1268243841.8679.2@...1207...>
Subject: Re: [Openvpn-devel] [PATCH] On TARGET_LINUX define _GNU_SOURCE if
 not defined
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Content-Transfer-Encoding: 8bit
To: Alon Bar-Lev <alon.barlev@...277...>, "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net

Karl O. Pinc wrote on 2010-03-10:

> On 03/10/2010 11:41:49 AM, Alon Bar-Lev wrote:
>> On Wed, Mar 10, 2010 at 7:39 PM, Karl O. Pinc <kop@...1206...> wrote:
>> > In other words ./configure is not expected to be run under normal
>> > circumstances.
>> >
>> > The whole point of autoconf is to produce something that can
>> > be made into a tarball that only requires "make; make install"
>> > to compile and install.
>>
>> You do not understand the tools. Nor the common use of them.
>>
>> You *MUST* run ./configure when compiling from sources.
>
> You are right, on all of the above.  I don't use them every
> day.
>
> But, you _don't_ have to run ./configure every time.  You

You do. Either explicitly, or after updating the source ("git pull")  
because the Makefiles figure that you need to and run config.status twice  
(once with options to re-trigger configure, then to regenerate its  
AC_OUTPUT files).

> yourself wrote that you do the ./configure on the _new_
> machine, and then move the tarball to the old machine
> and recompile.  This is often the situation, or at least
> I found so, when making rpm spec files.

You need to run ./configure on the _new_ (distributor's) machine so that  
there is a "Makefile" that you can run "make dist" (to generate a tarball)  
or "make distdir" (to rsync the dist' directory), and for no other  
purpose. None of the outputs so generated make it to the tarball. If they  
did, that would be a bug in Makefile.am or in automake (the latter I've  
never seen, or at least I don't recall having seen those).

> You are quite correct in pointing out that ./configure
> should be able to be run on the old machine, which
> means that it can be executed within the build portion
> of the spec file.

It's a requisite, but run in the RPM's "prep" section rather than "build".  
Most distros today would have %configure macros to feed their distribution  
default options in (directory layout, CFLAGS for hardening, and  
thereabouts).

HTH

-- 
Matthias Andree

