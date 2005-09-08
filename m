From: Mathias Sundman <mathias@...454...>
Subject: Re: [Openvpn-devel] New subnet topology feature ready for testing
In-Reply-To: <1e6368e805090813104568d337@...278...>
Message-ID: <Pine.LNX.4.61.0509082239070.6467@...210...>
References: <Pine.LNX.4.58.0509062125110.12112@...41...> 
 <1e6368e805090804304b1d7ae9@...278...>  <Pine.LNX.4.58.0509081103120.12112@...41...>
  <1e6368e80509081126163dce34@...278...>  <Pine.LNX.4.58.0509081353010.12112@...41...>
 <1e6368e805090813104568d337@...278...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Sep  8 14:08:08 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: Leonard Isham <leonard.isham@...277...>
Cc: James Yonan <jim@...41...>, openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

On Thu, 8 Sep 2005, Leonard Isham wrote:

>> I plan to treat the "TO" (topology-supporting) branch as a beta series
>> until the 2.1 beta series formally begins -- that means it will be
>> updated, changes from the 2.0.x branch will get merged in, and when I make
>> releases, there will always be a .tar.gz, .zip, and Windows installer
>> .exe.
>
> OK than I have to decide if I'll use beta in production.  Don't get me
> wrong I respect the quality of your beta releases more than most
> others.  I have OpenVPN RCs in production, but I don't know about
> beta...

I'd just like to say that I think it's the right decision to leave a 
rather big new feature like this outside 2.0. A stable release is called 
"stable" just because new features isn't added.

And a new feature is a "beta" feature regardless how well-written it is 
before it has been extensivly tested by a lot of people for some time. 
That's why we have beta releases.

But that won't stop me from putting this new beta into production long 
before it reaches a stable release. I'll start a new OpenVPN process with 
this beta release on my production servers as soon as I get time and start 
testing first on my own, and then in a small group. I recommend you todo 
the same, then after a few weeks when we are number of people here on the 
list that have been reporting it working flawless, I'll consider it stable 
enough to use in my production environments for all my users.

How long you want to wait is up to you, I'm just saying it's not getting 
more stable just because it changes name from beta->rc->stable, it will 
get more stable the sooner we start testing it. And here's the great thing 
with a userspace VPN like OpenVPN - You don't need to setup a whole new 
box to try it, you can run several diffrent versions of OpenVPN in 
parallell.

I will also support this beta release by creating Windows installation 
packages with OpenVPN GUI and the OpenVPN beta.

Cheers and good night // Mathias

-- 
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
OpenVPN GUI for Windows           X    NO HTML/RTF in e-mail
http://openvpn.se/               / \   NO Word docs in e-mail

