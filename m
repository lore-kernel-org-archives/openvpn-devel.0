References: <1268242750.8679.0@...1207...> <4B97DCEC.9020108@...1114...>
	<1268244277.8679.3@...1207...>
	<9e0cf0bf1003101009kb323a2csccc86d7c148766f4@...278...>
Date: Sun, 14 Mar 2010 00:39:36 +0100
MIME-Version: 1.0
From: "Matthias Andree" <matthias.andree@...68...>
Message-ID: <op.u9i5cacs1e62zd@...1326...>
In-Reply-To: <9e0cf0bf1003101009kb323a2csccc86d7c148766f4@...278...>
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
To: "Karl O. Pinc" <kop@...1206...>, Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Alon Bar-Lev wrote on 2010-03-10:

> If you patch autoconf/automake stuff, you *MUST* add autoconf/automake
> dependency to your package, so you can regenerate the files. It is
> much simpler to patch also the generated files and avoid this
> dependency. But it is packager's call.

For distributions and packaging, hacking the outputs is often simpler  
unless the input had been expanded and/or copied around, because it waives  
and additional build requisites.  It sometimes happens that there are  
distribution-specific changes that aren't fit for upstream inclusion.  The  
FreeBSD ports repository is full of such stuff, and I'd usually patch  
outputs there -- and for the majority of packages, the patches for the  
output files aren't any less stable than those for input files would be,  
but they are so much easier on the end users.

> Please understand, in order to build a package you *DO NOT* need
> autoconf/automake/libtool installed *AT ALL*.

Careful with the wording here, as "build a package" is ambiguous:
(1) build a tarball distribution package (openvpn-2.1.X.tar.gz)
(2) build a openvpn.rpm or .deb from the tarball.

I'll reword: In order to build the binaries from a tarball generated with  
"make dist" (what the release manager uploads and the end user usually  
downloads from sourceforge or other distribution sites), no  
autoconf/automake/libtool are required.

-- 
Matthias Andree

