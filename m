Message-ID: <46CB16E4.30801@...41...>
Date: Tue, 21 Aug 2007 10:46:28 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <001501c7bf18$fb69e550$16ada8c0@...576...>
In-Reply-To: <001501c7bf18$fb69e550$16ada8c0@...576...>
Subject: Re: [Openvpn-devel] Building new TAP driver (tap0901) on windows
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
To: Dave <dev@...575...>
Cc: openvpn-devel@lists.sourceforge.net

Dave wrote:
>> Hi,
>>
>>    Can anybody tell me the procedure of building tap driver 
>> on windows? I'm 
>> able to build tap0801 using WINDDK 3790, but tap0901 build is 
>> failing. It 
>> says autodefs/defs.h file is missing? The folder autodefs is 
>> not in the 
>> current directory. What should i do to get the defs.h header file?
>>     
> ...
>
> That's not a DDK problem, but rather that file is generated when initially
> configuring the code for make.  I can't remember just where, but I think
> when you run the configure.ac.  The autodefs directory will be created, and
> the defs.h will be in it (along with some other stuff).
>
>   

See the ./domake-win script.  This script will autogenerate autodefs/defs.h.

I'm currently using the Vista RC1 DDK (I think it's build 5600) to build 
the TAP driver.  3790 had trouble building a TAP driver + tapinstall 
that would work on Vista.

James


