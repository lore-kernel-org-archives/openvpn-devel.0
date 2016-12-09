References: <20160911185153.GS78279@...1296...>
From: Alexander Pyhalov <alp@...1937...>
Message-ID: <25eee84b-324f-2d7a-8f3f-85adcab6b2e0@...1937...>
Date: Fri, 9 Dec 2016 13:51:43 +0300
MIME-Version: 1.0
In-Reply-To: <20160911185153.GS78279@...1296...>
Subject: Re: [Openvpn-devel] help wanted: OpenSolaris building
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?Adam_=c5=a0tevko?= <adam.stevko@...277...>

On 09/11/16 09:51 PM, Gert Doering wrote:
> Hi,
>
> as you might know, we try to build everything we commit to git on all
> supported platforms (using buildbot).  This works quite well and has
> helped us keep things consistently working across all platforms, at least
> as far as we have tests for each feature...
>
> One of my problem childs is (Open)Solaris, though.  I have a VM that is
> fairly old and has the GNU toolchain on it, but we have no access to
> a current system, using the Sun/Oracle C compiler.
>
> So, I'm looking for pointers :-)
>
>  - is there an (easy to install and maintain) OpenSource variant of
>    "Solaris" still around?
>
>  - is there a developer program at Oracle, where one can get access to
>    a current Solaris version plus Oracle C compiler, free of charge
>    (a hosted build environment is only partially usable, because we
>    run VM tests from buildbot, and those need root access...)

Hi.

I was looking through openvpn-devel archives and found this message.
Do you still need any help with illumos build bot? Like dedicated zone? 
Or do you have some technical issues?
-- 
Best regards,
Alexander Pyhalov,
system administrator of Southern Federal University IT department

