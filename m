Message-ID: <57E3DF38.7090802@...1147...>
Date: Thu, 22 Sep 2016 15:40:08 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <4e9afe58-f398-7163-18fe-9113bf0cdfbc@...277...>
In-Reply-To: <4e9afe58-f398-7163-18fe-9113bf0cdfbc@...277...>
Subject: Re: [Openvpn-devel] Linux: Use /tmp for log problem ?
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
To: debbie10t <debbie10t@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 22/09/16 15:07, debbie10t wrote:
> Hi
>
> posting in devel because I am asking for clarification of
> what the source code really does.
>
> Re: https://forums.openvpn.net/viewtopic.php?f=30&t=22485
>
> Config:
> |---
> server *normal stuff*
> log-append /tmp/openvpn.log
> ---
>
> I have just tried with Ubuntu1604 myself and observe that:
> (My basic config I added: --log /tmp/client1.log)
>
> 1. $ sudo systemctl start openvpn@...2166... = log file *not* created
> 2. $ sudo openvpn client1.conf = log file created normally in /tmp
>
> Obviously, systemctl start openvpn@...2166... appends more options when
> starting openvpn (in my hand written service the only addition is
> --daemon client1) So I presume that by daemonizing something changes
> with regard to writing the log file to /tmp ??
>
> Also note, in the forum post --daemon is used within the config file.
>
> I did grep -E "/tmp" src/openvpn/* and found some code in init.c
> (line 664) but it's all C, foo, bar to me (Sea food bar ;-) )
>
> Anyhoo, can anybody provide a brief and simple explanation ?
>
> Many thanks
most likely this , from 'man systemd.exec'

        PrivateTmp=
            Takes a boolean argument. If true, sets up a new file system 
namespace for the executed processes and
            mounts private /tmp and /var/tmp directories inside it, that 
are not shared by processes outside of the
            namespace. This is useful to secure access to temporary 
files of the process, but makes sharing between
            processes via /tmp or /var/tmp impossible. All temporary 
data created by service will be removed after
            service is stopped. Defaults to false.


thus, the output *is* logged to /tmp/openvpn.log but the problem is that 
it's not in the /tmp you'd expect.
There's nothing OpenVPN can do about this, it's one of those weird 
idiosyncracies of systemd.

HTH,

JJK


