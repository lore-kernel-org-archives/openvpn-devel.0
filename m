Message-ID: <4D1CF361.4070202@...1030...>
Date: Thu, 30 Dec 2010 21:02:25 +0000
From: Mr Dash Four <mr.dash.four@...1030...>
MIME-Version: 1.0
References: <4D177C14.4040300@...1030...>
	<4D1CA723.8060001@...1114...>
In-Reply-To: <4D1CA723.8060001@...1114...>
Subject: Re: [Openvpn-devel] [OpenVPN 2.1.4 BUG]: hard-coded values in
 Makefiles for down-root and auth-pam plugins prevent cross compilation
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Your patch removes -Wall completely.
No, it doesn't! "-Wall" is (normally) part of CFLAGS and is included "by 
default", so there is no need to be specified again here. If anything 
needs to be added, it has to be compile/link flags specific for this 
module and/or objects (like DLOPEN_PAM for example) - the rest of the 
"generic" flags should be and will be specified with CFLAGS/LDFLAGS as 
any well-designed make system uses them.

> So, I'd prefer that you don't remove CFLAGS completely, but rather 
> append the
> build platform CFLAGS with -Wall.  So you can then do it like this:
>
> ~  CLFAGS="$(CFLAGS) -Wall -DDLOPEN_PAM=$(DLOPEN_PAM)"
>
> This will be a smaller and easier patch, which will provide the features
> you're looking for.  Removing -O2 is less of an issue as that one 
> should more
> be defined by the build platform, and that one can cause more issues with
> cross-compilation.
As I already pointed out - -Wall is not "completely removed" - it is 
already part of CFLAGS (the environment variable set for compilation of 
the entire OpenVPN module). Same goes for -O2. I don't see why they have 
to be specified again here.

This, though, as I already pointed out, is not ideal. I would like to 
see this makefile auto generated with autogen so that the entire make 
process is more streamlined. Mathias's idea in his next post is a good 
start and this is what I was referring to in my original post. My patch 
only patches the problem and papers up over the cracks - more 
appropriate solution needs to be found so that when additional 
plugins/modules are added we don't face the same problem.

On a side note, could you let me know how to submit a bug with the Trac 
system - I spent a good couple of hours and still didn't manage to find 
a way to submit a bug?




