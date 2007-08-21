Message-ID: <46CB1C67.2080002@...41...>
Date: Tue, 21 Aug 2007 11:09:59 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <6c18a4f0705301137q3c63230en25dbd69f9b2f4061@...278...>
In-Reply-To: <6c18a4f0705301137q3c63230en25dbd69f9b2f4061@...278...>
Subject: Re: [Openvpn-devel] Possible bug in OpenVPN-2.0.9
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
To: Bernd Bartmann <bernd.bartmann@...277...>
Cc: Openvpn-devel@lists.sourceforge.net

Bernd Bartmann wrote:
> Hi,
>
> I'm running Centos 5 32bit and installed openvpn-2.0.9-1.el5.rf from
> Dag Wieers Repo. When OpenVPN is started during boot-up it just shows
> an SElinux related error message and does not start. When I start
> OpenVPN manually after
> the system has come up completely it works fine. Please have a look at
> the log extract at the end of this email for all SElinux related
> messages.
>
> I already reported this problem to the Centos and SElinux mailing
> lists. Daniel Walsh (SElinux guru) had the following suggestions:
>
>   

I am wondering why the SElinux warnings only occur when OpenVPN is 
started at boot-up.  OpenVPN's behavior with respect to touching things 
that might trigger SELinux errors shouldn't significantly change whether 
or not it is started on boot-up or later.

It would be nice if SELinux would produce more useful debug information 
such as stack trace (that could be gleaned by looking at the userspace 
stack and debug info from gcc -g) or at least indicate if the problem is 
in a shared object that's dynamically linked with OpenVPN at run time.  
As it is, I'm not aware of any reason why OpenVPN would need stack 
execution permission.

James


