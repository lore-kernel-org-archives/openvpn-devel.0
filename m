Message-ID: <4F63664B.50400@...1030...>
Date: Fri, 16 Mar 2012 16:11:55 +0000
From: Mr Dash Four <mr.dash.four@...1030...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>	<1330546342-17794-36-git-send-email-alon.barlev@...277...>	<4F588784.300@...515...>	<CAOazyz3OzNYscLd01QY_wopFkH9zctixQNhJr-PyoPmTBvrwTw@...278...>
	<CAP+U6tJx_xNbEHfhENcJKEpgE1WMf-03ez=nKo2zEwUQEEe7Xw@...278...>
In-Reply-To: <CAP+U6tJx_xNbEHfhENcJKEpgE1WMf-03ez=nKo2zEwUQEEe7Xw@...278...>
Subject: Re: [Openvpn-devel] [PATCH 35/52] build: proper selinux detection
 and usage
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
To: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>


> Are you referring to the configure code? I might be missing something
> obvious, but
>
> AC_CHECK_LIB([selinux], [setcon], [SELINUX_LIBS="-lselinux"])
>
> versus
>
> AC_CHECK_HEADER([selinux/selinux.h], [
>     AC_CHECK_LIB([selinux], [setcon], [SELINUX_LIBS="-lselinux"],
>         [AC_MSG_RESULT([SELinux library not found.])]
>     )],  [AC_MSG_ERROR([SELinux headers not found.])]
> )
>
> doesn't really qualify as "very complex" to me.
>   
Of course it isn't - and it is the better choice - by a mile! The 
primary function of configure has always been not only to find out what 
the build environment is like, but to also figure out a potential build 
problems/missing headers/libraries and _communicate_ those findings, so 
that potential errors down the line during the build process are easily 
discovered and removed at source.

The last thing I, as a person compiling/building OpenVPN, want is to 
debug a config.log and then the configure file itself to find out why a 
specific part of OpenVPN build has failed. The former - rather obscure - 
statement does not give me that option, while the latter discovers this 
and properly communicates it.

>> 2. Detect library only - you assume that if library is present, the
>> functionality exists, this is what important... no need to check for
>> header, most probably this exists as well. This makes the code
>> simpler, in the risk of compile failure if header is missing.
>>     
>
> Which is less convenient for the user who expects _configure_ to
> figure out those kinds of problems. My expectation would be: If
> configure thinks everything is fine, the build should normally compile
> without errors unless there's a bug in the lib / the program.
>
> Your two alternatives don't really sound like whether or not we want
> auto-detection but more like what kinds of problems to detect at
> configure time.
>   1. detect missing / misplaced libs and missing / misplaced headers
>   2. detect missing / misplaced libs
>
> Library auto-detection would IMHO be
>   a) to enable / disable features based on which libraries were found and/or
>   b) to search additional non-standard paths for the libraries and headers.
>
> Some projects implement b), but I wouldn't recommend it. I tend to
> also disagree with a), depending on the dependency. For example, I
> could see configure enabling/disabling selinux automatically, unless
> explicitly told to use a specific setting.
>   
Exactly - every single word of it!


