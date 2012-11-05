Message-ID: <5097DE86.7070103@...1777...>
Date: Mon, 05 Nov 2012 10:43:02 -0500
From: Adam McDougall <mcdouga9@...1777...>
MIME-Version: 1.0
References: <20121009185233.GS48053@...1777...> <3225194.uqCr5OXhPF@...1526...>
In-Reply-To: <3225194.uqCr5OXhPF@...1526...>
Subject: Re: [Openvpn-devel] Backslash in user/pass breaks OpenVPN-GUI
 management authentication
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
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

On 10/10/12 04:13, Heiko Hund wrote:
> Hi Adam
>
> On Tuesday 09 October 2012 14:52:33 Adam McDougall wrote:
>> This report concerns the OpenVPN-GUI application included with
>> 2.3-alpha3 and 2.3_beta1.  I am excited to see native support for the
>> Management Interface which I will ultimately need if I start deploying
>> the Windows client, but I discovered username/password authentication
>> chokes if either contain a backslash: \
>
> Thanks for the report. Currently "special" characters in username and password
> are not quoted. I've had a report about a double quote breaking auth as
> well... and forgot about fixing it. =) Expect this to be fixed in the next
> beta release. And again, thanks for testing!
>
> Heiko
>

I tested the recent rc1 build but it was not fixed, did it go in?  Thanks.

