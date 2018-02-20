References: <20180201154521.7642-1-steffan@...1856...>
 <201802200941.w1K9f8NK054824@...2054...>
 <20180220100026.GI69387@...1296...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <81af546a-ae8e-62b1-9f47-54647dda0672@...1856...>
Date: Tue, 20 Feb 2018 20:40:31 +0100
MIME-Version: 1.0
In-Reply-To: <20180220100026.GI69387@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Enable stricter compiler
 warnings by default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 20-02-18 11:00, Gert Doering wrote:
> On Tue, Feb 20, 2018 at 10:41:08AM +0100, Gert Doering wrote:
>> Your patch has been applied to the master and release/2.4 branch.
>>
>> Tested on FreeBSD 10, Linux and, indeed, AIX 7 :-) - Linux/gcc is nicely
>> clean, FreeBSD/clang finds a few that are silly and want fixing...
> 
> Yeah.  Right.  And it blows up on centos-6 and opensolaris-10.
> 
> Now I can't claim that I understand this...  David double-checked this
> macro and m4/ stuff, so "everything should have been good", but it
> isn't.
> 
> CentOS 6:
> 
> checking lz4.h usability... no
> checking lz4.h presence... no
> checking for lz4.h... no
>                 usable LZ4 library or header not found, using version in src/com
> +pat/compat-lz4.*
> checking git checkout... yes
> ./configure: line 24067: syntax error near unexpected token `newline'
> ./configure: line 24067: `AX_CHECK_COMPILE_FLAG('
> make: *** [config.status] Error 2

They both already fail in the step before it seems:

> configure.ac:1295: error: Autoconf version 2.64 or higher is required

ContOS 6 ships with autoconf 2.63, I don't know what opensolaris-10 has.

We could revert to an older version of the macro we ship, or to a
simpler (though less clear) AC_CHECK_COMPILE-based check.

I'm tempted to ditch the macro and go for the AC_CHECK_COMPILE.

-Steffan

