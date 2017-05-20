References: <745143357771014FBD32EE04E1307B435E901E6F@...2271...>
	<6544ef6d-adee-030f-a252-7e3db161eae0@...2080...>
From: debbie10t <debbie10t@...277...>
Message-ID: <fe8df222-6381-d791-baff-baca2ca1ae04@...277...>
Date: Sat, 20 May 2017 01:18:24 +0100
MIME-Version: 1.0
In-Reply-To: <6544ef6d-adee-030f-a252-7e3db161eae0@...2080...>
Subject: Re: [Openvpn-devel] Question about easy-rsa
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net



On 19/05/17 23:56, David Sommerseth wrote:
> On 20/05/17 00:45, Mahawar, Sunil wrote:
>> Hi,
>>
>>      I loved easy-rsa tool and its user friendly interface. I am using
>> this tool for one of my project for OpenHPC (http://openhpc.community ).
>> However one my colleague pointed out that easy-rsa project is not an
>> active project, its last release was 2 year back, last commit was June
>> 2016, and there are multiple open issues on git hub (40), which are not
>> yet addressed. So there was concern that any security related
>> vulnerability (if found) will not be fixed in timely manner. Because of
>> that I was asked to reevaluate easy-rsa utility for my use.
>>
>> As per the documentation, easy-rsa development co-exists with OpenVPN, I
>> am assuming that openvpn community will take care of any vulnerability
>> in easy-rsa (if found). I will appreciate if someone on community
>> confirm my assumption that openvpn community will also be maintain
>> easy-rsa any vulnerability in this utility?
>>
>
> It might not look so active, but there are people who are engaged

There are "person" .. but engagement has not been forthcoming ..

> and
> who I am quite sure will step up if it is truly needed to act upon any
> security issues.
>
> The upstream project is hosted here:
> <https://github.com/OpenVPN/easy-rsa>
>
> That said, there are not too much security issues easy-rsa itself may
> introduce.  It is basically just a shell script providing a more easy
> user interface to the openssl command line.  So as long as your OpenSSL
> installation is safe and good, there is not too much this tool can do to
> reduce that.
>
> The primary thing in easy-rsa influencing the security is the OpenSSL
> configuration file (openssl-1.0.cnf), and the secondary is how the
> various openssl command line calls is handled.  Except of that, it is a
> fairly simple program logic and lots of somewhat more helpful text.
>
>

It is time Easy-RSA received some *much* needed attention.

nudge-nudge-wink-wink .. say-no-more (for now)


