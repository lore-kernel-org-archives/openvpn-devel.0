References: <20190812134513.20758-1-arne@...1227...>
 <a1b2525b-fb00-4d8d-d877-797305c6ec2f@...2181...>
 <038d3040-5133-9841-ca28-d433ca228f0c@...2080...>
 <a214be99-8c20-56e0-7dcd-3a8425129dfb@...2181...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <2d7656f6-319b-c667-7e1c-e67800995bd4@...1856...>
Date: Tue, 13 Aug 2019 23:46:38 +0200
MIME-Version: 1.0
In-Reply-To: <a214be99-8c20-56e0-7dcd-3a8425129dfb@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/2] Fix check if iface name is set
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 13-08-19 23:31, Antonio Quartulli wrote:
> On 13/08/2019 23:26, David Sommerseth wrote:
>> wouldn't it be better to
>> do 'if (rgi6->iface[0])' instead?  Since the buffer should be NULL terminated
>> and has to be NULL terminted for strlen() to function anyhow.  But the
>> compiled code would be a bit more efficient (even though, this isn't
>> necessarily a performance critical code section).
> 
> In my opinion strlen() is more readable for the casual developer
> checking this code. Behind iface[0] we may hide other ambiguous
> assumptions (even though this is not the case here, but we won't
> remember in some months from now).

Antionio's answer is of course the real reason to use strlen(), but you
nerd-sniped me by saying "compiled code would be a bit more efficient".
As you said, that wouldn't matter here, but still: compilers nowadays do
optimize calls to strlen, memset, memcpy, etc.

The following code

#include <string.h>

int test(const char *buf) {
    return (strlen(buf) > 0);
}

for example compiles with -O3 on my GCC 8.3 to

0000000000000000 <test>:
   0:	31 c0                	xor    %eax,%eax
   2:	80 3f 00             	cmpb   $0x0,(%rdi)
   5:	0f 95 c0             	setne  %al
   8:	c3                   	retq

which indeed just compares the first byte of the buffer against zero.

So, unless there are important performance constraints, let's optimize
code for readability, rather than performance :)

FOOOOM [0]

-Steffan

[0] https://xkcd.com/356/

