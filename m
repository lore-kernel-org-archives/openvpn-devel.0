References: <20200717170942.227701-1-matthias.andree@...68...>
 <20200717171918.230727-1-matthias.andree@...68...>
 <36fd1330-3715-e5d4-bed0-8d80c40732c0@...2080...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <975ee9fe-ec2f-833c-d1b9-118310c4b98e@...68...>
Date: Fri, 17 Jul 2020 22:25:29 +0200
MIME-Version: 1.0
In-Reply-To: <36fd1330-3715-e5d4-bed0-8d80c40732c0@...2080...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Merge Makefile.am's AUTOMAKE_OPTIONS
 into configure.ac's AM_INIT_AUTOMAKE.
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
To: David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net

Am 17.07.20 um 22:15 schrieb David Sommerseth:
> On 17/07/2020 19:19, Matthias Andree wrote:
>> Else one location overwrites options from the other.
>>
>> Signed-off-by: Matthias Andree <matthias.andree@...68...>
>> ---
>>  Makefile.am  | 3 ---
>>  configure.ac | 4 +++-
>>  2 files changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/Makefile.am b/Makefile.am
>> index 439120e4..d1c10fc5 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -23,9 +23,6 @@
>>  #  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>>  #
>>
>> -# This option prevents autoreconf from overriding our COPYING and
>> -# INSTALL targets:
>> -AUTOMAKE_OPTIONS = foreign 1.9
>>  ACLOCAL_AMFLAGS = -I m4
>>
>>  MAINTAINERCLEANFILES = \
>> diff --git a/configure.ac b/configure.ac
>> index 45148892..8ed83bc2 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -54,7 +54,9 @@ m4_define([serial_tests], [
>>                  awk '{split ($NF,a,"."); if (a[1] == 1 && a[2] >= 12) { print "serial-tests" }}'
>>      ])
>>  ])
>> -AM_INIT_AUTOMAKE(foreign serial_tests) dnl NB: Do not [quote] this parameter.
>> +# This foreign option prevents autoreconf from overriding our COPYING and
>> +# INSTALL targets:
>> +AM_INIT_AUTOMAKE(foreign serial_tests 1.9) dnl NB: Do not [quote] this parameter.
>>  AC_CANONICAL_HOST
>>  AC_USE_SYSTEM_EXTENSIONS
>>
> Acked-By: David Sommerseth <davids@...515...>
>
> This works better than the previous attempt, this also passes 'make distcheck'.
>
> I see this patch does not have the subdir-objects flag in the automake
> options; which seems to be the reason why it failed on my RHEL-7 box last
> round.  I'll try to see if I can better understand why.
Without digging too deeply, to me it seems that subdir-objects doesn't
cope too well with the various places that code absolute source file
paths into Makefile.am, and I am always testing out-of-source builds but
figured that I received tons of .deps in the source directory even if
the build directory was outside... so I'll leave subdir-objects rest for
openvpn for now.

