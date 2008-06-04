Message-ID: <48464467.8050108@...41...>
Date: Wed, 04 Jun 2008 01:29:43 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <483DA4E4.1030308@...1104...> <483ED0A6.5030708@...1104...>
In-Reply-To: <483ED0A6.5030708@...1104...>
Subject: Re: [Openvpn-devel] Memory of server keeps increasing
	with	key	negotiations
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
To: Martin Gadbois <martin.gadbois@...1104...>
Cc: openvpn-devel@lists.sourceforge.net

Martin Gadbois wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Martin Gadbois wrote:
>
>   
>> Using OpenVPN 2.0.5 and 2.0.9, I notice that an somewhat idle connection
>> increases the RSS of the server process linearly with time.
>>
>>     
>
> Here is my patch to fix this issue. It does create (according to
> valgrind) a memory leak, but it does not increase with time. Feel free
> to fix it better...
>
> I short, environments values were allocated using gc*(), and every key
> change the environement list changes, but the allocated values stayed in
> the context's gc.
>
> I modified the environement values to always allocate using malloc() and
> always free() values when the env list changes.
>
>
>   

I've committed a fix for this issue:

------------------------------------------------------------------------
r2981 | james | 2008-06-04 01:23:20 -0600 (Wed, 04 Jun 2008) | 6 lines
Changed paths:
   M /branches/BETA21/openvpn/debug/valgrind-suppress
   M /branches/BETA21/openvpn/doval
   M /branches/BETA21/openvpn/openvpn.c

Fixed unbounded memory growth bug in
environmental variable code that could
have caused long-running OpenVPN sessions
with many TLS renegotiations to incrementally
increase memory usage over time.

------------------------------------------------------------------------

James


