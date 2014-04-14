Message-ID: <534B8BF9.2060405@...1147...>
Date: Mon, 14 Apr 2014 09:19:21 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <1397366216-657-1-git-send-email-cernekee@...277...>	<20140413104705.GL16637@...1296...>	<CAJiQ=7DYg6PnTJ0piiUDKaT5wefVBxvPH3ZPHANQxOgWeDHjPg@...278...>	<534AAAEC.7050105@...1227...>
	<CAJiQ=7COCWVzV1pq+ek8zimj65CdB0UM8S+1om1k8p_75yDjRA@...278...>
In-Reply-To: <CAJiQ=7COCWVzV1pq+ek8zimj65CdB0UM8S+1om1k8p_75yDjRA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 0/3] Support non-root operation using
 ocproxy
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
To: Kevin Cernekee <cernekee@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi

Kevin Cernekee wrote:
> On Sun, Apr 13, 2014 at 8:19 AM, Arne Schwabe <arne@...1227...> wrote:
>   
>> You could look at the TARGET_ANDROID. That uses the management interface and
>> fds over unix socket to achieve something similar.
>>     
>
> Do you think it would be feasible to enable TARGET_ANDROID by default
> in the Linux OpenVPN builds, and change the logic so that if the user
> passes e.g. "--android" it will accept commands over the management
> socket instead of using the standard CLI?
>
>   
I'd vote against enabling TARGET_ANDROID by default - there's a reason 
the code is split into
  TARGET_LINUX
  TARGET_FREEBSD
  TARGET_SOLARIS
etc and I'd say you're asking for trouble if you enable two TARGETs on 
one platform.

> This would not work with ocproxy as-is, but I could write a wrapper program.
>
>   
I do like the idea of not needing root access to run openvpn - esp 
windows users could benefit from this, as they're not always allowed to 
install the tap-win adapter. Then again, it goes against the UNIX/Linux 
philosophy that each tool (e.g. openvpn) should do one thing and it 
should do it well. By adding patches like this left and right we're 
steering away from that philosophy.


cheers,

JJK


