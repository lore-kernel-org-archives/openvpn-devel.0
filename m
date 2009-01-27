Message-ID: <497F7B70.9020106@...41...>
Date: Tue, 27 Jan 2009 14:24:00 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <20090127154806.GA38604@...33...>	<9e0cf0bf0901270831l72b16993p1037df311fb50c74@...278...>
	<20090127172957.GA90386@...33...>
In-Reply-To: <20090127172957.GA90386@...33...>
Subject: Re: [Openvpn-devel] [PATCH] Fix non-C89 comments
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

Matthias Andree wrote:
> On Tue, 27 Jan 2009, Alon Bar-Lev wrote:
> 
>> Sent this to James.
>> Did not apply.
>>
>> My queue is at:
>> http://svn.openvpn.net/projects/openvpn/contrib/alon
> 
> Perhaps the choice of version control system used for OpenVPN could
> deserve a second thought -- Mercurial or better Git might support such
> models or merge queues much better than Subversion does.

I'm on top of this -- Alon's queue including Jos Vos's [PATCH] Fix 
non-C89 comments has been merged:

------------------------------------------------------------------------
r3899 | james | 2009-01-27 12:22:42 -0700 (Tue, 27 Jan 2009) | 2 lines
Changed paths:
    M /branches/BETA21/openvpn/proto.h
    M /branches/BETA21/openvpn/route.c

Fixed some issues with C++ style comments that leaked into the code.

------------------------------------------------------------------------
r3900 | james | 2009-01-27 12:32:46 -0700 (Tue, 27 Jan 2009) | 2 lines
Changed paths:
    M /branches/BETA21/openvpn/error.c
    M /branches/BETA21/openvpn/ntlm.c
    M /branches/BETA21/openvpn/pkcs11.c
    M /branches/BETA21/openvpn/win32.h

Fixed some compile-time warnings.

------------------------------------------------------------------------
r3901 | james | 2009-01-27 13:05:48 -0700 (Tue, 27 Jan 2009) | 2 lines
Changed paths:
    M /branches/BETA21/openvpn/configure.ac

Updated configure.ac to work on MinGW.

------------------------------------------------------------------------
r3902 | james | 2009-01-27 13:10:49 -0700 (Tue, 27 Jan 2009) | 2 lines
Changed paths:
    M /branches/BETA21/openvpn/common.h

Updated common.h types for _WIN64.

------------------------------------------------------------------------
r3903 | james | 2009-01-27 14:18:51 -0700 (Tue, 27 Jan 2009) | 3 lines
Changed paths:
    M /branches/BETA21/openvpn/ssl.c

Fixed issue involving an #ifdef in a macro reference that breaks early gcc
compilers.

------------------------------------------------------------------------


James


